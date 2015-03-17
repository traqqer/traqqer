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
    
    var entry : Entry!
    
    func setup() {
        timestampLabel.text = DateUtils.formatDatetime(entry.timestamp)
    }
}
