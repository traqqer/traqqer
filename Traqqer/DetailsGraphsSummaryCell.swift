//
//  DetailsGraphsSummaryCell.swift
//  Traqqer
//
//  Created by John Boggs on 3/17/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import UIKit

class DetailsGraphsSummaryCell: UITableViewCell {

    @IBOutlet weak var content: UIView!
    @IBOutlet weak var statName: UILabel!
    @IBOutlet weak var statValue: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        content.backgroundColor = Utils.Color.backgroundColor
        statName.textColor = Utils.Color.textColor
        statName.font = Utils.Font.primaryFont
        statValue.textColor = Utils.Color.textColor
        statValue.font = Utils.Font.primaryFont
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setStat(name: String, value: String) {
        statName.text = name
        statValue.text = value
    }
}
