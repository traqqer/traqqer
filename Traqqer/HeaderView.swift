//
//  HeaderView.swift
//  Traqqer
//
//  Created by Steffan Chartrand on 3/15/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import Foundation

class HeaderView: UIView {
    
    var label: UILabel
    
    override init(frame: CGRect) {
        label = UILabel(frame: frame)
        
        super.init(frame: frame)
        
        label.textAlignment = .Center
        label.font = UIFont (name: "HelveticaNeue-Bold", size: 24)
        label.textColor = UIColor.whiteColor()
        label.text = "Coffee".uppercaseString
        addSubview(label)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}