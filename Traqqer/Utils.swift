//
//  Utils.swift
//  Traqqer
//
//  Created by Steffan Chartrand on 3/19/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import UIKit

class Utils {
    struct Color {
        static let backgroundColor = UIColor.whiteColor()
        static let secondaryBackgroundColor = Utils.createUIColor(177, green: 224, blue: 250, alpha: 1.0)
        static let sectionHeaderColor = Color.backgroundColor
        
        static let navColor = Utils.createUIColor(5, green: 3, blue: 95, alpha: 1.0)
        static let segmentControllerColor = Color.navColor
        static let navTextColor = Color.backgroundColor
        static let textColor = Utils.createUIColor(2, green: 1, blue: 61, alpha: 1.0)
        static let sectionHeaderTextColor = Color.textColor
        static let graphColor = Utils.createUIColor(136, green: 124, blue: 0, alpha: 1.0)
        static let selectedGraphColor = Utils.createUIColor(211, green: 122, blue: 0, alpha: 1.0)
        static let selectionGraphColor = Color.selectedGraphColor
    }

    struct Font {
        static let smallFont = UIFont(name: "HelveticaNeue", size: 12)
        static let primaryFont = UIFont(name: "HelveticaNeue", size: 16)
        static let bigFont = UIFont(name: "HelveticaNeue", size: 24)
        static let boldFont = UIFont(name: "HelveticaNeue-Bold", size: 16)
        static let largeBoldFont = UIFont(name: "HelveticaNeue-Bold", size: 30)
        static let appTimerFont = UIFont(name: "HelveticaNeue", size: 50)
    }
    
    class func createUIColor(red: Float, green: Float, blue: Float, alpha: Float) -> UIColor {
        return UIColor(red: CGFloat(red / 255), green: CGFloat(green / 255), blue: CGFloat(blue / 255), alpha: CGFloat(alpha))
    }
    
    class func intMin(values: [Int]) -> Int? {
        if values.isEmpty {
            return nil
        }
        
        return values.reduce(Int.max, { min($0, $1) })
    }
    
    class func doubleMin(values: [Double]) -> Double? {
        if values.isEmpty {
            return nil
        }
        
        return values.reduce(Double.infinity, { min($0, $1) })
    }
    
    class func intMax(values: [Int]) -> Int? {
        if values.isEmpty {
            return nil
        }
        
        return values.reduce(Int.min, { max($0, $1) })
    }
    
    class func doubleMax(values: [Double]) -> Double? {
        if values.isEmpty {
            return nil
        }
        
        return values.reduce(-Double.infinity, { max($0, $1) })
    }
    
    class func mean(values: [NSNumber]) -> Double? {
        if values.isEmpty {
            return nil
        }
        
        return values.reduce(0.0) { Double($0) + Double($1) } / Double(values.count)
    }
}