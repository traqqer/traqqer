//
//  Models.swift
//  Traqqer
//
//  Created by John Boggs on 3/14/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import Foundation
import Parse

struct StatKeys {
    static let name = "name"
    static let type = "type"
}

class Stat : PFObject, PFSubclassing {
    @NSManaged var name : String!
    @NSManaged var type : String!
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
    class func parseClassName() -> String! {
        return "Stat"
    }
    
    func getEntries(completion: [Entry]->()) {
        return ParseAPI.getEntriesforStat(self, completion: completion)
    }
    
    func createEntry(stat: Stat, timestamp: NSDate?, duration: NSTimeInterval?, completion: (() -> ())?) {
        return ParseAPI.createEntry(self, timestamp: timestamp, duration: duration, completion: completion)
    }
    
}

struct EntryKeys {
    static let statRef = "statRef"
    static let timestamp = "timestamp"
    static let duration = "duration"
}

class Entry : PFObject, PFSubclassing {
    @NSManaged var statRef : Stat!
    @NSManaged var timestamp : NSDate!
    @NSManaged var duration : NSNumber!
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
    class func parseClassName() -> String! {
        return "Entry"
    }
}

class Goal : PFObject, PFSubclassing {
    @NSManaged var statRef : Stat!
    @NSManaged var type : String!
    @NSManaged var amount : NSNumber!
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0;
        dispatch_once(&onceToken) {
            self.registerSubclass()
        }
    }
    class func parseClassName() -> String! {
        return "Goal"
    }
}

enum GoalKeys : String {
    case Type = "type"
    case Amount = "amount"
}