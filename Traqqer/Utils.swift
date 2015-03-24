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
        static let primaryColor = Utils.createUIColor(255, green: 204, blue: 255, alpha: 1.0)
        static let secondaryColor = Utils.createUIColor(255, green: 56, blue: 255, alpha: 1.0)
        static let tertiaryColor = Utils.createUIColor(204, green: 204, blue: 255, alpha: 1.0)
        static let backgroundColor = UIColor.whiteColor()
        static let navColor = Utils.createUIColor(5, green: 3, blue: 95, alpha: 1.0)
        static let textColor = Utils.createUIColor(2, green: 1, blue: 61, alpha: 1.0)
        static let graphColor = Utils.createUIColor(136, green: 124, blue: 0, alpha: 1.0)
        static let highlightGraphColor = UIColor.blackColor()
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