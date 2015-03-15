//
//  API.swift
//  Traqqer
//
//  Created by John Boggs on 3/14/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import Foundation


class ParseAPI {
    class func runQueryAndCallCompletion<T:PFObject>(query : PFQuery, completion : [T] -> ()) {
        query.findObjectsInBackgroundWithBlock{
            (objects : [AnyObject]!, error : NSError!) in
            if error == nil {
                println(error)
            } else {
                let castObjects = objects as [T]
                completion(castObjects)
            }
        }
    }
    
    class func saveObjectAndCallCompletion<T:PFObject> (object: T, completion: () -> ()) {
        object.saveInBackgroundWithBlock {(success: Bool, error: NSError!) -> Void in
            if (!success) {
                println(error)
            } else {
                completion()
            }
        }
    }
    
    class func getEntriesforStat(stat: Stat, completion: [Entry]->()) {
        let query = Entry.query().whereKey(EntryKeys.statRef, equalTo: stat)
        ParseAPI.runQueryAndCallCompletion(query, completion: completion)
    }

    class func createEntry(stat: Stat, timestamp: NSDate?, duration: NSNumber?, completion: () -> ()?) {
        let entry = Entry()
        
        // Set the timestamp
        if let timestamp = timestamp {
            entry[EntryKeys.timestamp] = timestamp
        } else {
            // Use now
            entry[EntryKeys.timestamp] = NSDate()
        }
        
        // Maybe set the duration
        if let duration = duration {
            entry[EntryKeys.duration] = duration
        }
        
        // Maybe run a completion
        completion()?
        
    }

    class func getStats(completion: [Stat] -> ()) {
        let query = Stat.query()
        ParseAPI.runQueryAndCallCompletion(query, completion: completion)
    }
}
