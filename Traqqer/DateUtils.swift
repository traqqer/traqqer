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
    
    class var dateFormatter : NSDateFormatter {
        struct Static {
            static let dateFormatter = NSDateFormatter()
        }
        Static.dateFormatter.setLocalizedDateFormatFromTemplate("EEE d MMM")
        return Static.dateFormatter
    }
    
    class var timeFormatter : NSDateFormatter {
        struct Static {
            static let timeFormatter = NSDateFormatter()
        }
        Static.timeFormatter.setLocalizedDateFormatFromTemplate("hh:mm:s")
        return Static.timeFormatter
    }
    
    class func formatTimeInterval(interval : NSTimeInterval, shortForm : Bool = false) -> String {
        let s = interval % 60
        let m = (interval / 60) % 60
        let h = interval / 3600
        if shortForm {
            return NSString(format: "%02d:%02d:%02d", Int(h), Int(m), Int(s))
        } else {
            return NSString(format: "%02d:%02d:%05.2f", Int(h), Int(m), s)
        }
    }
    
    class func formatTimeIntervalHMS(interval : NSTimeInterval) -> String {
        let s = floor(interval % 60)
        let m = (interval / 60) % 60
        let h = interval / 3600
        return NSString(format: "%02d:%02d:%02d", Int(h), Int(m), Int(s))
    }
    
    class func formatDatetime(date : NSDate) -> String {
        return DateUtils.formatter.stringFromDate(date)
    }
    
    class func formatDate(date : NSDate) -> String {
        return DateUtils.dateFormatter.stringFromDate(date)
    }
    
    class func formatTime(date : NSDate) -> String {
        return DateUtils.timeFormatter.stringFromDate(date)
    }
}