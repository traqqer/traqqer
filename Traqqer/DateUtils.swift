//
//  DateUtils.swift
//  Traqqer
//
//  Created by Steffan Chartrand on 3/15/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import Foundation

class DateUtils {
    
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
}