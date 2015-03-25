//
//  Fixtures.swift
//  Traqqer
//
//  Created by Nathan Shayefar on 3/24/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import UIKit

class Fixtures {
    struct Static {
        static let secondsInDay = 60 * 60 * 24
        static let now = NSDate()
        static let beginningOfYear = now.beginningOfYear
    }
    
    class func cursing() {
        ParseAPI.createStat("Swearing", statType: StatType.Count.rawValue, goal: nil) {
            stat in
            
            var currentDay = Static.now - 2.months
            var cursesToday: Int!
            var timestamp: NSDate!
            
            while currentDay <= Static.now {
                cursesToday = self.randInRange(1, max: 4)
                println("currentDay: \(currentDay); curses: \(cursesToday)")
                for x in 1...cursesToday {
                    timestamp = self.randomTimeInDay(currentDay)
                    ParseAPI.createEntry(stat, timestamp: timestamp, duration: nil, completion: nil)
                }
                
                currentDay = currentDay + 1.day
            }
        }
    }
    
    class func studyingSwift() {
        ParseAPI.createStat("Studying Swift", statType: StatType.Duration.rawValue, goal: nil) {
            stat in
            
            var currentDay = Static.now - 2.months
            var studySessionsToday: Int!
            var studyDuration: Double!
            var timestamp: NSDate!
            
            while currentDay <= Static.now {
                studySessionsToday = self.randInRange(1, max: 2)
                for x in 1...studySessionsToday {
                    timestamp = self.randomTimeInDay(currentDay)
                    studyDuration = Double(self.randInRange(30 * 60, max: 70 * 60))
                    ParseAPI.createEntry(stat, timestamp: timestamp, duration: studyDuration, completion: nil)
                }
                
                currentDay = currentDay + 1.day
            }
        }
    }
    
    private class func randomTimeInDay(day: NSDate) -> NSDate {
        let randomTimeElapsed = randInRange(0, max: Static.secondsInDay)
        return day.beginningOfDay + randomTimeElapsed.seconds
    }
    
    private class func randInRange(min: Int, max: Int) -> Int {
        return min + (Int(arc4random()) % (max - min + 1))
    }
}
