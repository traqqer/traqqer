//
//  StatAggregationUtils.swift
//  Traqqer
//
//  Created by Nathan Shayefar on 3/19/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import UIKit

class StatAggregationUtils {
    class func summaryForStat(stat: Stat, day: NSDate, completion: (Int, NSTimeInterval?) -> ()) {
        StatAggregationUtils.summaryForStat(stat, start: day.beginningOfDay, end: day.endOfDay, completion: completion)
    }
    
    class func summaryForStat(stat: Stat, start: NSDate, end: NSDate, completion: ((Int, NSTimeInterval?) -> ())?) {
        let query = Entry.query()
        query.whereKey(EntryKeys.statRef, equalTo: stat)
        query.whereKey(EntryKeys.timestamp, greaterThan: start)
        query.whereKey(EntryKeys.timestamp, lessThan: end)
        
        ParseAPI.getEntriesForQuery(query) {
            (entries: [Entry]) in
            let count = entries.count
            
            switch stat.type {
                
            case Constants.StatTypes.COUNT:
                completion?(count, nil)
                
            case Constants.StatTypes.DURATION:
                var duration = entries.reduce(0.0) {
                    totalDuration, entry in
                    totalDuration + (entry.duration as Double)
                }
                completion?(count, duration)
                
            default:
                println("Unknown stat type: \(stat.type)")
                completion?(count, nil)
            }
        }
    }
    
    class func graphSummaryForStat(stat: Stat, start: NSDate, numberOfBuckets: Int, bucketDuration: Duration, completion: (([Int], [NSTimeInterval]?) -> ())?) {
        let end = start + numberOfBuckets * bucketDuration
        
        graphSummaryForStat(stat, start: start, end: end, numberOfBuckets: numberOfBuckets, completion: completion)
    }
    
    class func graphSummaryForStat(stat: Stat, end: NSDate, numberOfBuckets: Int, bucketDuration: Duration, completion: (([Int], [NSTimeInterval]?) -> ())?) {
        let start = end - numberOfBuckets * bucketDuration
        
        graphSummaryForStat(stat, start: start, end: end, numberOfBuckets: numberOfBuckets, completion: completion)
    }
    
    private class func graphSummaryForStat(stat: Stat, start: NSDate, end: NSDate, numberOfBuckets: Int, completion: (([Int], [NSTimeInterval]?) -> ())?) {
        let buckets = TimeBucket.makeBuckets(start, end: end, numberOfBuckets: numberOfBuckets)
        
        let query = Entry.query()
        query.whereKey(EntryKeys.statRef, equalTo: stat)
        query.whereKey(EntryKeys.timestamp, greaterThan: start)
        query.whereKey(EntryKeys.timestamp, lessThan: end)
        
        ParseAPI.getEntriesForQuery(query) {
            (entries: [Entry]) in
            var counts = [Int](count: buckets.count, repeatedValue: 0)
            
            switch stat.type {
                
            case Constants.StatTypes.COUNT:
                for entry in entries {
                    if let matchingIndex = self.indexForDateInTimeBuckets(entry.timestamp, timeBuckets: buckets) {
                        counts[matchingIndex]++
                    }
                }
                completion?(counts, nil)
                
            case Constants.StatTypes.DURATION:
                var durations = [NSTimeInterval](count: buckets.count, repeatedValue: 0.0)
                for entry in entries {
                    if let matchingIndex = self.indexForDateInTimeBuckets(entry.timestamp, timeBuckets: buckets) {
                        counts[matchingIndex]++
                        durations[matchingIndex] += entry.duration as Double
                    }
                }
                completion?(counts, durations)
                
            default:
                println("Unknown stat type: \(stat.type)")
            }
        }
    }
    
    private class func indexForDateInTimeBuckets(date: NSDate, timeBuckets: [Int : TimeBucket]) -> Int? {
        for (index, timeBucket) in timeBuckets {
            if timeBucket.contains(date) {
                return index
            }
        }
        
        return nil
    }
    
    class func detailSummaryForStat(stat: Stat, start: NSDate, numberOfBuckets: Int, bucketDuration: Duration, completion: ((countStats: (Int, Double, Int), durationStats: (NSTimeInterval, NSTimeInterval, NSTimeInterval)?) -> ())?) {
        let end = start + numberOfBuckets * bucketDuration
        
        detailSummaryForStat(stat, start: start, end: end, numberOfBuckets: numberOfBuckets, completion: completion)
    }
    
    class func detailSummaryForStat(stat: Stat, end: NSDate, numberOfBuckets: Int, bucketDuration: Duration, completion: ((countStats: (Int, Double, Int), durationStats: (NSTimeInterval, NSTimeInterval, NSTimeInterval)?) -> ())?) {
        let start = end - numberOfBuckets * bucketDuration
        
        detailSummaryForStat(stat, start: start, end: end, numberOfBuckets: numberOfBuckets, completion: completion)
    }
    
    private class func detailSummaryForStat(stat: Stat, start: NSDate, end: NSDate, numberOfBuckets: Int, completion: ((countStats: (Int, Double, Int), durationStats: (NSTimeInterval, NSTimeInterval, NSTimeInterval)?) -> ())?) {
    
        graphSummaryForStat(stat, start: start, end: end, numberOfBuckets: numberOfBuckets) {
            (counts: [Int], durations: [NSTimeInterval]?) in
            
            var countStats: (Int, Double, Int)
            countStats.0 = Utils.intMin(counts) ?? 0
            countStats.1 = Utils.mean(counts) ?? 0.0
            countStats.2 = Utils.intMax(counts) ?? 0
    
            if durations != nil {
                var durationStats: (NSTimeInterval, NSTimeInterval, NSTimeInterval)
                durationStats.0 = Utils.doubleMin(durations!) ?? 0.0
                durationStats.1 = Utils.mean(durations!) ?? 0.0
                durationStats.2 = Utils.doubleMax(durations!) ?? 0
                
                completion?(countStats: countStats, durationStats: durationStats)
            } else {
                completion?(countStats: countStats, durationStats: nil)
            }
        }
    }
}

private class TimeBucket {
    let start: NSDate!
    let end: NSDate!
    
    init(start: NSDate, end: NSDate) {
        self.start = start
        self.end = end
    }
    
    func contains(date: NSDate) -> Bool {
        return self.start <= date && self.start >= end
    }
    
    class func makeBuckets(start: NSDate, end: NSDate, numberOfBuckets: Int) -> [Int : TimeBucket] {
        var timeBuckets = [Int : TimeBucket]()
        
        // Second granularity is sufficient
        let bucketWidthSeconds = Int(end.timeIntervalSinceDate(start) / Double(numberOfBuckets))
        var bucketDuration = Duration(value: bucketWidthSeconds, unit: NSCalendarUnit.CalendarUnitSecond)
        
        var bucketIndex = 0
        var bucketStart: NSDate
        var bucketEnd: NSDate
        
        for bucketIndex in 0..<numberOfBuckets {
            bucketStart = start + bucketIndex * bucketDuration
            bucketEnd = start + bucketDuration
            timeBuckets[bucketIndex] = TimeBucket(start: bucketStart, end: bucketEnd)
        }
        
        return timeBuckets
    }
}
