//
//  DashboardStatsCell.swift
//  Traqqer
//
//  Created by John Boggs on 3/15/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import UIKit

// Part of setup to observe time changes on Stopwatch.instance
private var context = 0

class DashboardStatsCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var duration: UILabel!
    @IBOutlet weak var totalLabel: UILabel!

    var stat : Stat!
    var numEntries : NSInteger!
    var totalDuration : NSTimeInterval!
    var startDate : NSDate!
    
    
    func setupView() {
        nameLabel.text = stat.name
        if stat.type == Constants.StatTypes.COUNT {
            totalLabel.text = String(format: "%d", numEntries)
        } else if stat.type == Constants.StatTypes.DURATION {
            totalLabel.text = DateUtils.formatTimeInterval(totalDuration)
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func clicked() {
        if stat.type == Constants.StatTypes.COUNT {
            ParseAPI.createEntry(stat, timestamp: NSDate(), duration: nil, completion: {
                // Reload the cell, so that the goal count increases
                println("complete")
                
                self.setupView()
            })
        } else if stat.type == Constants.StatTypes.DURATION {
            let now = NSDate()
            if let startDate = startDate {
                // This is a race condition that might make our times "slightly" mismatch; fix later
                Stopwatch.instance.removeObserver(self, forKeyPath: "time")
                let interval = now.timeIntervalSinceDate(startDate)
                ParseAPI.createEntry(stat, timestamp: nil, duration: interval, completion: {
                    // Reload the total count
                    self.setupView()
                    self.startDate = nil
                })
            } else {
                startDate = now
                Stopwatch.instance.addObserver(self, forKeyPath: "time", options: .New, context: &context)
            }
        }
    }
    
    
    /*
    Listener setup taken from: https://developer.apple.com/library/prerelease/mac/documentation/Swift/Conceptual/BuildingCocoaApps/AdoptingCocoaDesignPatterns.html#//apple_ref/doc/uid/TP40014216-CH7-XID_8
    */
    override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject: AnyObject], context: UnsafeMutablePointer<Void>) {
            let interval = -1 * startDate.timeIntervalSinceNow
            self.duration.text = DateUtils.formatTimeInterval(interval)
    }
    deinit {
        Stopwatch.instance.removeObserver(self, forKeyPath: "time", context: &context)
    }
    
    
}
