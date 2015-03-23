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
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var goal: UILabel!
    @IBOutlet weak var timer: UILabel!
    
    var stat : Stat!
    
    var remoteNumEntries = 0
    var remoteTotalDuration = 0.0
    
    var numEntries = 0
    var totalDuration = 0.0
    var startDate : NSDate!
    var stopwatchListener : StopwatchListener!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        hideTimer(false)
        icon.tintColor = UIColor.whiteColor()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupIcon()
        setupView()
    }
    
    func loadRemoteData() {
        StatAggregationUtils.summaryForStat(stat, day: NSDate(), completion: {(numEntries, totalDuration) in
            self.remoteNumEntries = numEntries
            if let totalDuration = totalDuration {
                self.remoteTotalDuration = totalDuration
            }
            self.setupView()
        })
    }
    
    func setupView() {
        name.text = stat.name.uppercaseString
        if stat.type == Constants.StatTypes.COUNT {
            value.text = String(format: "%d", numEntries + remoteNumEntries).uppercaseString
        } else if stat.type == Constants.StatTypes.DURATION {
            value.text = DateUtils.formatTimeInterval(totalDuration + remoteTotalDuration, shortForm : true)
        }
        if let goalObj = stat.goalRef {
            let goalAmount = goalObj[GoalKeys.Amount.rawValue] as Int
            if stat.type == Constants.StatTypes.COUNT {
                goal.text = String(format: " / %d", goalAmount).uppercaseString
            } else if stat.type == Constants.StatTypes.DURATION {
                goal.text = String(format: " / %dmin", goalAmount)
            }
        } else {
            goal.text = ""
        }
        
        self.contentView.backgroundColor = Utils.Color.primaryColor
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
                hideTimer(true)
                let interval = stopwatchListener.currentTime.timeIntervalSinceDate(startDate)
                self.stopwatchListener = nil  // Timer will be stopped by deallocation
                ParseAPI.createEntry(stat, timestamp: nil, duration: interval, completion: {
                    // Reload the total count
                    self.numEntries = self.numEntries + 1
                    self.totalDuration = self.totalDuration + interval
                    self.setupView()
                })
                self.startDate = nil
            } else {
                showTimer()
                startDate = NSDate()
                stopwatchListener = StopwatchListener { [weak self] currentTime in
                    if let vc = self {
                        let interval = currentTime.timeIntervalSinceDate(vc.startDate)
                        vc.timer.text = DateUtils.formatTimeInterval(interval)
                    }
                    return ()
                }
            }
        }
    }
    
    func showTimer() {
        timer.hidden = false
        UIView.animateWithDuration(0.75, animations: {
            self.timer.alpha = 1.0
        })
    }
    
    func hideTimer(animate: Bool) {
        if animate {
            UIView.animateWithDuration(Double(0.05), animations: {
                self.timer.alpha = 0
                }, completion: {
                    (finished: Bool) in
                    self.timer.hidden = true
            })
        } else {
            timer.hidden = true
            timer.alpha = 0
        }
    }
    
    func setupIcon() {
        if stat.type == Constants.StatTypes.COUNT {
            icon.image = UIImage(named: "count-icon")
        } else if stat.type == Constants.StatTypes.DURATION {
            icon.image = UIImage(named: "glyphicons-56-stopwatch")
        }
    }
}
