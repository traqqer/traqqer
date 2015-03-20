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
        let query = Entry.query()
        query.whereKey(EntryKeys.statRef, equalTo: stat)
        query.whereKey(EntryKeys.timestamp, greaterThan: day.beginningOfDay)
        query.whereKey(EntryKeys.timestamp, lessThan: day.endOfDay)
        
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
    
    class func graphSummaryForStat() -> [Double] {
        return []
    }
    
    class func detailSummaryForStat() -> (Double, Double, Double) {
        return (1.2, 1.2, 1.2)
    }
}
