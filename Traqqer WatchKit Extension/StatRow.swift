//
//  StatRow.swift
//  Traqqer
//
//  Created by Steffan Chartrand on 3/21/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import UIKit
import WatchKit

class StatRow: NSObject {
   
    @IBOutlet weak var icon: WKInterfaceImage!
    @IBOutlet weak var name: WKInterfaceLabel!
    @IBOutlet weak var valueGoal: WKInterfaceLabel!
    @IBOutlet weak var timer: WKInterfaceLabel!
    
    var stat: Stat!
    var remoteNumEntries = 0
    var remoteTotalDuration = 0.0
    var numEntries: Int! = 0
    var startDate : NSDate!
    var totalDuration : NSTimeInterval! = 0.0
    var stopwatchListener : StopwatchListener!
    
    func setStat(stat: Stat) {
        self.stat = stat
        if stat.type == Constants.StatTypes.COUNT {
            icon.setImage(UIImage(named: "count-icon-white"))
        } else if stat.type == Constants.StatTypes.DURATION {
            icon.setImage(UIImage(named: "glyphicons-56-stopwatch-white"))
        }
        
        StatAggregationUtils.summaryForStat(stat, day: NSDate(), completion: {count, duration in
            self.remoteNumEntries = count
            if let duration = duration {
                self.remoteTotalDuration = duration
            }
            self.refreshView()
        })
    }
    
    func refreshView() {
        name.setText(stat.name)
        let goalAmount = (stat.goalRef?[GoalKeys.Amount.rawValue]) as? Int
        if stat.type == Constants.StatTypes.COUNT {
            var value = String(numEntries + remoteNumEntries)
            if let goalAmount = goalAmount {
                value = value + String(format: " / %d", goalAmount)
            }
            valueGoal.setText(value)

        } else if stat.type == Constants.StatTypes.DURATION {
            var value = DateUtils.formatTimeIntervalPretty(totalDuration + remoteTotalDuration)
            if let goalAmount = goalAmount {
                value = value + " / " + DateUtils.formatTimeIntervalPretty(NSTimeInterval(goalAmount))
            }
            valueGoal.setText(value)
        }
    }
    
    func click() {
        if stat.type == Constants.StatTypes.COUNT {
            self.numEntries = self.numEntries + 1
            self.refreshView()
            ParseAPI.createEntry(stat, timestamp: NSDate(), duration: nil, completion: {})
        } else if stat.type == Constants.StatTypes.DURATION {
            if let startDate = startDate {
                hideTimer(true)
                let interval = stopwatchListener.currentTime.timeIntervalSinceDate(startDate)
                self.stopwatchListener = nil  // Timer will be stopped by deallocation
                ParseAPI.createEntry(stat, timestamp: nil, duration: interval, completion: {
                    // Reload the total count
                    self.numEntries = self.numEntries + 1
                    self.totalDuration = self.totalDuration + interval
                    self.refreshView()
                })
                self.startDate = nil
            } else {
                showTimer()
                startDate = NSDate()
                var updateInterval = 0.0
                var lastUpdate = NSDate()
                stopwatchListener = StopwatchListener { [weak self] currentTime in
                    if let vc = self {
                        let interval = currentTime.timeIntervalSinceDate(vc.startDate)
                        updateInterval = currentTime.timeIntervalSinceDate(lastUpdate)
                        if updateInterval >= 1.0 {
                            vc.timer.setText(DateUtils.formatTimeIntervalHMS(interval))
                            lastUpdate = NSDate()
                        }
                    }
                    return ()
                }
            }
        }
    }
    
    func showTimer() {
        timer.setHidden(false)
    }
    
    func hideTimer(animate: Bool) {
        timer.setText("00:00:00")
        timer.setHidden(true)
    }
}
