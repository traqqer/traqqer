//
//  StatAggregationUtils.swift
//  Traqqer
//
//  Created by Guy on 3/19/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import UIKit

class StatAggregationUtils {
    class func summaryForStat(stat: Stat, day: NSDate, completion: (Int, NSTimeInterval?) -> ()) {
        StatAggregationUtils.summaryForStat(stat, start: day.beginningOfDay, end: day.endOfDay, completion: completion)
    }
    
    class func summaryForStat(stat: Stat, start: NSDate, end: NSDate, completion: (Int, NSTimeInterval?) -> ()) {
        let query = Entry.query()
        query.whereKey(EntryKeys.statRef, equalTo: stat)
        query.whereKey(EntryKeys.timestamp, greaterThan: start)
        query.whereKey(EntryKeys.timestamp, lessThan: end)
        
        ParseAPI.getEntriesForQuery(query) {
            (entries: [Entry]) in
            let count = entries.count
            
            switch stat.type {
                
            case Constants.StatTypes.COUNT:
                completion(count, nil)
                
            case Constants.StatTypes.DURATION:
                var duration = entries.reduce(0.0) {
                    totalDuration, entry in
                    totalDuration + (entry.duration as Double)
                }
                completion(count, duration)
                
            default:
                completion(count, nil)
            }
            
        }
    }
    
    // eventually take a duration, but now we can just hardcode it to 1 day
    class func graphSummaryForStat(stat: Stat, start: NSDate, numberOfBuckets: Int) {
        let end = start + numberOfBuckets.days
        
        graphSummaryForStat(stat, start: start, end: end, numberOfBuckets: numberOfBuckets)
    }
    
    class func graphSummaryForStat(stat: Stat, end: NSDate, numberOfBuckets: Int) {
        let start = end - numberOfBuckets.days
        
        graphSummaryForStat(stat, start: start, end: end, numberOfBuckets: numberOfBuckets)
    }
    
    private class func graphSummaryForStat(stat: Stat, start: NSDate, end: NSDate, numberOfBuckets: Int) {
        var buckets: [TimeBucket]
        
        for x in 0..<numberOfBuckets {
            println("guy: \(x)")
        }
    }
    
    class func detailSummaryForStat() {
        // pass
    }
}

struct TimeBucket {
    var start: NSDate
    var end: NSDate
    
    func contains(date: NSDate) -> Bool {
        return self.start <= date && self.start >= end
    }
}
