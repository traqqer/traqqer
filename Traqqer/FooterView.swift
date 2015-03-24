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
        labelLeft.textColor = Utils.Color.textColor
        labelLeft.font = UIFont (name: "HelveticaNeue-Bold", size: 16)
        
        labelRight.textAlignment = .Right
        labelRight.textColor = Utils.Color.textColor
        labelRight.font = UIFont (name: "HelveticaNeue-Bold", size: 16)
        let now = NSDate()
        switch self.timeSegment {
            case .Day:
                labelLeft.text = DateUtils.formatHHMM(now)
                labelRight.text = DateUtils.formatHHMM(now)
            case .Week:
                labelLeft.text = (now - 7.days).stringFromFormat("MMM d")
                labelRight.text = now.stringFromFormat("MMM d")
            case .Month:
                labelLeft.text = (now - 1.month).stringFromFormat("MMM d")
                labelRight.text = now.stringFromFormat("MMM d")
            case .Year:
                labelLeft.text = (now - 1.year).stringFromFormat("MMM YYYY")
                labelRight.text = now.stringFromFormat("MMM YYYY")
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