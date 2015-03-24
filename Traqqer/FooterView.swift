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
        self.labelLeft = UILabel(frame: CGRectMake(0, 3, frame.width/2, 16))
        self.labelRight = UILabel(frame: CGRectMake(frame.width/2, 3, frame.width/2, 16))
        self.timeSegment = timeSegment
        
        super.init(frame: frame)
        
        labelLeft.textAlignment = .Left
        labelLeft.textColor = Utils.Color.textColor
        labelLeft.font = Utils.Font.smallFont
        
        labelRight.textAlignment = .Right
        labelRight.textColor = Utils.Color.textColor
        labelRight.font = Utils.Font.smallFont

        var endDate : NSDate
        switch self.timeSegment {
            case .Day:
                endDate = DateUtils.getEndOfDay()
                labelLeft.text = DateUtils.formatHHMM(endDate)
                labelRight.text = DateUtils.formatHHMM(endDate - 1.minute)
            case .Week:
                endDate = DateUtils.getEndOfWeek()
                labelLeft.text = (endDate - 7.days).stringFromFormat("MMM d")
                labelRight.text = (endDate - 1.minute).stringFromFormat("MMM d")
            case .Month:
                endDate = DateUtils.getEndOfMonth()
                labelLeft.text = (endDate - 1.month).stringFromFormat("MMM d")
                labelRight.text = (endDate - 1.minute).stringFromFormat("MMM d")
            case .Year:
                endDate = DateUtils.getEndOfYear()
                labelLeft.text = "Jan " + NSDate().stringFromFormat("yy")
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