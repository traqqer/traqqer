//
//  DashboardStatsCell.swift
//  Traqqer
//
//  Created by John Boggs on 3/15/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import UIKit

class DashboardStatsCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var goalNumerator: UILabel!
    @IBOutlet weak var goalDemoninator: UILabel!

    var stat : Stat!
    var startDate : NSDate!
    
    
    func setupView() {
        nameLabel.text = stat.name
        goalNumerator.text = "12"
        goalDemoninator.text = "15"
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
                let interval = now.timeIntervalSinceDate(startDate)
                ParseAPI.createEntry(stat, timestamp: nil, duration: interval, completion: {
                    // Reload the cell, so that the goal count increases
                    println("complete")
            
                    self.setupView()
                    self.startDate = nil
                })
            } else {
                startDate = now
            }
        }
    }
    
}
