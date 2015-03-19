//
//  DetailsGraphsSummaryCell.swift
//  Traqqer
//
//  Created by John Boggs on 3/17/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import UIKit

class DetailsGraphsSummaryCell: UITableViewCell {

    @IBOutlet weak var statName: UILabel!
    @IBOutlet weak var statValue: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setStat(name: String, value: String) {
        statName.text = name
        statValue.text = value
    }
}
