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

protocol DashboardStatsCellDelegate: class {
    func onGoalReached(stat: Stat)
}

class DashboardStatsCell: UITableViewCell {
    
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var value: UILabel!
    @IBOutlet weak var goal: UILabel!
    @IBOutlet weak var timer: UILabel!
    
    var stat : Stat!
    var delegate : DashboardStatsCellDelegate?
    
    var remoteNumEntries = 0
    var remoteTotalDuration = 0.0
    
    var numEntries = 0
    var totalDuration = 0.0
    var startDate : NSDate!
    var stopwatchListener : StopwatchListener!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        hideTimer(false)

        icon.tintColor = Utils.Color.textColor
        
        name.textColor = Utils.Color.textColor
        name.font = Utils.Font.primaryFont
        value.textColor = Utils.Color.textColor
        value.font = Utils.Font.primaryFont
        goal.textColor = Utils.Color.textColor
        goal.font = Utils.Font.primaryFont
        timer.textColor = Utils.Color.textColor
        timer.font = Utils.Font.appTimerFont
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
            self.hideTimer(true)
        })
    }
    
    func setupView() {
        name.text = stat.name
        if stat.type == Constants.StatTypes.COUNT {
            value.text = String(format: "%d", numEntries + remoteNumEntries)
        } else if stat.type == Constants.StatTypes.DURATION {
            value.text = DateUtils.formatTimeIntervalPretty(totalDuration + remoteTotalDuration)
        }
        if let goalObj = stat.goalRef {
            let goalAmount = goalObj[GoalKeys.Amount.rawValue] as Int
            if stat.type == Constants.StatTypes.COUNT {
                goal.text = String(format: " / %d", goalAmount)
            } else if stat.type == Constants.StatTypes.DURATION {
                goal.text = " / " + DateUtils.formatTimeIntervalPretty(NSTimeInterval(goalAmount))
            }
        } else {
            goal.text = ""
        }
        
        self.backgroundColor = Utils.Color.backgroundColor
        self.contentView.backgroundColor = Utils.Color.backgroundColor
    }
    
    func clicked() {
        if stat.type == Constants.StatTypes.COUNT {
            ParseAPI.createEntry(stat, timestamp: NSDate(), duration: nil, completion: {
                // Reload the cell, so that the goal count increases
                println("complete")
                self.numEntries++
                self.setupView()
                self.checkIfGoalMet(1)
            })
        } else if stat.type == Constants.StatTypes.DURATION {
            if let startDate = startDate {
                hideTimer(true)
                let interval = stopwatchListener.currentTime.timeIntervalSinceDate(startDate)
                self.stopwatchListener = nil  // Timer will be stopped by deallocation
                ParseAPI.createEntry(stat, timestamp: nil, duration: interval, completion: {
                    // Reload the total count
                    self.numEntries++
                    self.totalDuration += interval
                    self.setupView()
                    self.checkIfGoalMet(interval)
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
                    return
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
    
    private func checkIfGoalMet(delta: NSNumber) {
        if stat.goalRef == nil {
            return
        }
        
        let goalObj = stat.goalRef!
        
        // If the goal is to minimize a value, incrementing can't help reach it
        let goalType = goalObj[GoalKeys.ComparisonType.rawValue] as? String
        if goalType == nil || goalType == GoalType.LessThan.rawValue {
            return
        }
        
        switch stat.type {
            
        case StatType.Count.rawValue:
            let newCount = self.numEntries + self.remoteNumEntries
            let previousCount = newCount - (delta as? Int ?? 1)
            let goalCount = goalObj[GoalKeys.Amount.rawValue] as Int
            
            if previousCount < goalCount && newCount >= goalCount {
                println("count goal reached!")
                delegate?.onGoalReached(stat)
            }
            
        case StatType.Duration.rawValue:
            let newDuration = self.totalDuration + self.remoteTotalDuration
            let previousDuration = newDuration - (delta as? Double ?? 1.0)
            let goalDuration = goalObj[GoalKeys.Amount.rawValue] as Double
            
            println(newDuration)
            println(previousDuration)
            println(goalDuration)
            
            if previousDuration < goalDuration && newDuration >= goalDuration {
                println("duration goal reached!")
                delegate?.onGoalReached(stat)
            }
            
        default:
            return
        }
    }
}
