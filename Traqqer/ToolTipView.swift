//
//  ToolTip.swift
//  Traqqer
//
//  Created by Steffan Chartrand on 3/19/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import Foundation

class ToolTip: UIView {
    
    var label: UILabel
    
    override init() {
        self.label = UILabel()
        
        super.init(frame: CGRectMake(0, 0, 50, 25))
        
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true
        
        label.font = Utils.Font.smallFont
        label.backgroundColor = Utils.Color.backgroundColor
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.textAlignment = .Center
        
        addSubview(label)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setText(text: String) {
        label.text = text
        self.setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = self.bounds
    }
}
