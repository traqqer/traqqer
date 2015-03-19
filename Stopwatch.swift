//
//  StopwatchTimer.swift
//  Traqqer
//
//  Created by John Boggs on 3/15/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import Foundation
import UIKit

private var context = 0;

struct StopwatchConstants {
    static let REFRESH_INTERVAL = 0.01 // seconds
    static let TIME_FIELD = "time"
}

class Stopwatch : NSObject {
    dynamic var time : NSDate!
    
    class var instance : Stopwatch {
        struct Static {
            static let instance = Stopwatch()
        }
        return Static.instance
    }
    
    override class func initialize() {
        var onceToken : dispatch_once_t = 0
        dispatch_once(&onceToken) {
            println("initialize called")
            let updateStopwatch = NSTimer(timeInterval: StopwatchConstants.REFRESH_INTERVAL, target: Stopwatch.self, selector: "stopwatchTick", userInfo: nil, repeats: true)
            NSRunLoop.mainRunLoop().addTimer(updateStopwatch, forMode: NSRunLoopCommonModes)
        }
    }
    
    /*
    Start an NSTimer using the ObjectiveC load method, which should get called by 
    something than the UI thread. 
    load method: http://stackoverflow.com/questions/24137212/initialize-class-method-for-classes-in-swift
    timer off of UI thread: http://stackoverflow.com/questions/8304702/how-do-i-create-a-nstimer-on-a-background-thread
    */
//    override class func load() {
//        println("load called")
//        let updateStopwatch = NSTimer(timeInterval: StopwatchConstants.REFRESH_INTERVAL, target: Stopwatch.self, selector: "stopwatchTick", userInfo: nil, repeats: true)
//        NSRunLoop.mainRunLoop().addTimer(updateStopwatch, forMode: NSRunLoopCommonModes)
//    }
    
    /*
    Everytime the NSTimer fires, update the time field in the Stopwatch singleton.
    Other objects can use Key-Value observing on the time field to update themselves when it changes
    KeyValue observing: https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/KeyValueObserving/KeyValueObserving.html
    */
    class func stopwatchTick() {
        Stopwatch.instance.time = NSDate()
    }
}


class StopwatchListener : NSObject {
    var callback: NSDate -> ()
    var currentTime: NSDate
    
    init(callback: NSDate->()) {
        self.callback = callback
        self.currentTime = Stopwatch.instance.time
        super.init()
        Stopwatch.instance.addObserver(self, forKeyPath: StopwatchConstants.TIME_FIELD, options: .New, context: &context)
    }
    
    /*
    Listener setup taken from: https://developer.apple.com/library/prerelease/mac/documentation/Swift/Conceptual/BuildingCocoaApps/AdoptingCocoaDesignPatterns.html#//apple_ref/doc/uid/TP40014216-CH7-XID_8
    */
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject: AnyObject], context: UnsafeMutablePointer<Void>) {
        let newTime = change[NSKeyValueChangeNewKey] as! NSDate
        callback(newTime)
        self.currentTime = newTime
    }
    
    /*
    Stop getting notified of the stopwatch events if this object is deallocated
    */
    deinit {
        Stopwatch.instance.removeObserver(self, forKeyPath: StopwatchConstants.TIME_FIELD, context: &context)
    }
}