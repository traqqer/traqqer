//
//  API.swift
//  Traqqer
//
//  Created by John Boggs on 3/14/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import Foundation
import Parse

class ParseAPI {
    class func runQueryAndCallCompletion<T:PFObject>(query : PFQuery, completion : [T] -> ()) {
        query.findObjectsInBackgroundWithBlock{
            (objects : [AnyObject]!, error : NSError!) in
            
            if error != nil {
                println(error)
            } else {
                let castObjects = objects as [T]
                completion(castObjects)
            }
        }
    }
    
    class func saveObjectAndCallCompletion<T:PFObject> (object: T, completion: (() -> ())?) {
        object.saveInBackgroundWithBlock {(success: Bool, error: NSError!) -> Void in
            if (!success) {
                println(error)
            } else {
                // Run completion if it was supplied
                completion?()
            }
        }
    }
    
    class func getEntriesforStat(stat: Stat, completion: [Entry]->()) {
        let query = Entry.query().whereKey(EntryKeys.statRef, equalTo: stat)
        query.orderByDescending(EntryKeys.timestamp)
        query.limit = 1000
        ParseAPI.runQueryAndCallCompletion(query, completion: completion)
    }
    
    class func getEntriesForQuery(query: PFQuery, completion: [Entry]->()) {
        ParseAPI.runQueryAndCallCompletion(query, completion: completion)
    }

    class func createStat(name: NSString, statType: String, goal: Goal?, completion: (Stat -> ())?) {
        let stat = Stat()
        stat.name = name
        stat.type = statType
        if let goal = goal {
            stat.goalRef = goal
        }
        ParseAPI.saveObjectAndCallCompletion(stat, completion: {
            completion?(stat)
            return ()
        })
    }
    
    class func createEntry(stat: Stat, timestamp: NSDate?, duration: NSTimeInterval?, completion: (() -> ())?) {
        let entry = Entry()
        entry.statRef = stat
        entry.timestamp = timestamp ?? NSDate() // Nil Coalescing Operator
        entry.duration = duration
        ParseAPI.saveObjectAndCallCompletion(entry, completion: completion)
    }
    
    class func createGoal(type: GoalType, amount: Int, completion: (Goal -> ())?) {
        let goal = Goal()
        goal.comparisonType = type.rawValue
        goal.amount = amount
        ParseAPI.saveObjectAndCallCompletion(goal, completion: {
            completion?(goal)
            return ()
        })
    }

    class func getStats(completion: [Stat] -> ()) {
        let query = Stat.query().includeKey(StatKeys.goalRef)
        ParseAPI.runQueryAndCallCompletion(query, completion: completion)
    }
}
