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
    var stopwatchListener : StopwatchListener!

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
                self.numEntries = self.numEntries + 1
                self.setupView()
            })
        } else if stat.type == Constants.StatTypes.DURATION {
            if let startDate = startDate {
                let interval = stopwatchListener.currentTime.timeIntervalSinceDate(startDate)
                self.stopwatchListener = nil  // Timer will be stopped by deallocation
                ParseAPI.createEntry(stat, timestamp: nil, duration: interval, completion: {
                    // Reload the total count
                    self.numEntries = self.numEntries + 1
                    self.totalDuration = self.totalDuration + interval
                    self.setupView()
                    self.startDate = nil
                })
            } else {
                startDate = NSDate()
                stopwatchListener = StopwatchListener {currentTime in
                    let interval = currentTime.timeIntervalSinceDate(self.startDate)
                    self.duration.text = DateUtils.formatTimeInterval(interval)
                }
            }
        }
    }
}
