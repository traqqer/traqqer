//
//  DateUtils.swift
//  Traqqer
//
//  Created by Steffan Chartrand on 3/15/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import Foundation

class DateUtils {
    class var formatter : NSDateFormatter {
        struct Static {
            static let formatter = NSDateFormatter()
        }
        Static.formatter.setLocalizedDateFormatFromTemplate("yyyy-MM-dd hh:mm:s")
        return Static.formatter
    }
    
    class func formatTimeInterval(interval : NSTimeInterval) -> String {
        let s = interval % 60
        let m = (interval / 60) % 60
        let h = interval / 3600
        return NSString(format: "%02d:%02d:%05.2f", Int(h), Int(m), s)
    }
    
    class func formatDatetime(date : NSDate) -> String {
        return DateUtils.formatter.stringFromDate(date)
    }
}