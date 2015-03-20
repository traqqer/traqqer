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
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var goal: UILabel!
    
    var stat : Stat!
    var numEntries : NSInteger!
    var totalDuration : NSTimeInterval!
    var startDate : NSDate!
    var stopwatchListener : StopwatchListener!
    var detailMode = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }
    
    func setupView() {
        name.text = stat.name.uppercaseString
        if stat.type == Constants.StatTypes.COUNT {
            value.text = String(format: "%d", numEntries).uppercaseString
        } else if stat.type == Constants.StatTypes.DURATION {
            value.text = DateUtils.formatTimeInterval(totalDuration)
        }
        goal.text = String(100)
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
                stopwatchListener = StopwatchListener { [weak self] currentTime in
                    if let vc = self {
                        let interval = currentTime.timeIntervalSinceDate(vc.startDate)
                        vc.value.text = DateUtils.formatTimeInterval(interval)
                    }
                    return ()
                }
            }
        }
    }
}
