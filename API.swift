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
    
    func getEntriesforStat(stat: Stat, completion: [Entry]->()) {
        let query = Entry.query().whereKey(EntryKeys.statRef, equalTo: stat)
        ParseAPI.runQueryAndCallCompletion(query, completion: completion)
    }
    
    func getStats(completion: [Stat] -> ()) {
        let query = Stat.query()
        ParseAPI.runQueryAndCallCompletion(query, completion: completion)
    }
}
