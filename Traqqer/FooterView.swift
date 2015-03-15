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
                labelLeft.text = "Sun"
                labelRight.text = "Sat"
            case .Month:
                labelLeft.text = "1"
                let lastDayOfCurrentMonth: NSDate = DateUtils.lastDayOfCurrentMonth()
                labelRight.text = String(DateUtils.dayNumberFromDate(lastDayOfCurrentMonth))
            case .Year:
                labelLeft.text = "Jan"
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