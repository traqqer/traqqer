//
//  DetailsStatsCell.swift
//  Traqqer
//
//  Created by John Boggs on 3/17/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import UIKit

class DetailsStatsCell: UITableViewCell {
    @IBOutlet weak var timestampLabel: UILabel!
    
    @IBOutlet weak var durationLabel: UILabel!
    
    var entry : Entry!
    
    func setup() {
        timestampLabel.text = DateUtils.formatTime(entry.timestamp)
        if let duration = entry!.duration {
            durationLabel.text = DateUtils.formatTimeInterval(duration as Double, shortForm: true)
        } else {
            durationLabel.text = ""
        }
    }
}
