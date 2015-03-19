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
    
    class func lastDayOfCurrentMonth() -> NSDate {
        // Setup the calendar object
        let calendar = NSCalendar.currentCalendar()
        
        // Set up date object
        let date = NSDate()
        
        // Create an NSDate for the first and last day of the month
        //let components = calendar.components(NSCalendarUnit.CalendarUnitYear |
        //                                     NSCalendarUnit.CalendarUnitMonth |
        //                                     NSCalendarUnit.WeekdayCalendarUnit |
        //                                     NSCalendarUnit.WeekCalendarUnit |
        //                                     NSCalendarUnit.CalendarUnitDay,
        //                                     fromDate: date)
        
        // Create an NSDate for the last day of the month
        let components = NSCalendar.currentCalendar().components(NSCalendarUnit.CalendarUnitMonth, fromDate: date)
        
        // Getting the Last date of the month
        components.month  += 1
        components.day     = 0
        
        let lastDateOfMonth: NSDate = calendar.dateFromComponents(components)!
        return lastDateOfMonth
    }
    
    class func dayNumberFromDate(date: NSDate) -> Int {
        var components = NSCalendar.currentCalendar().components(NSCalendarUnit.DayCalendarUnit, fromDate: date)
        return components.day
    }
    
    class func formatTimeInterval(interval : NSTimeInterval) -> String {
        let s = interval % 60
        let m = (interval / 60) % 60
        let h = interval / 3600
        return String(format: "%02d:%02d:%05.2f", Int(h), Int(m), s)
    }
    
    class func formatDatetime(date : NSDate) -> String {
        return DateUtils.formatter.stringFromDate(date)
    }
}