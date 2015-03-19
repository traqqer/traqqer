//
//  FooterView.swift
//  Traqqer
//
//  Created by Steffan Chartrand on 3/15/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import Foundation

class FooterView: UIView {
    
    var labelLeft: UILabel
    var labelRight: UILabel
    var timeSegment: TimeSegment
    
    init(frame: CGRect, timeSegment: TimeSegment) {
        self.labelLeft = UILabel(frame: CGRectMake(0, 0, frame.width/2, 16))
        self.labelRight = UILabel(frame: CGRectMake(frame.width/2, 0, frame.width/2, 16))
        self.timeSegment = timeSegment
        
        super.init(frame: frame)
        
        labelLeft.textAlignment = .Left
        labelLeft.textColor = UIColor.whiteColor()
        
        labelRight.textAlignment = .Right
        labelRight.textColor = UIColor.whiteColor()
        
        switch self.timeSegment {
            case .Day:
                labelLeft.text = "12 AM"
                labelRight.text = "12 AM"
            case .Week:
                labelLeft.text = NSDate().stringFromFormat("MMM") + " " + String(NSDate().change(weekday: 1).day)
                labelRight.text = String(NSDate().change(weekday: 7).day)
            case .Month:
                labelLeft.text = NSDate().stringFromFormat("MMM") + " 1"
                labelRight.text = String(NSDate().endOfMonth.day)
            case .Year:
                labelLeft.text = "Jan " + NSDate().stringFromFormat("YY")
                labelRight.text = "Dec"
        }
        
        addSubview(labelLeft)
        addSubview(labelRight)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
    }
}