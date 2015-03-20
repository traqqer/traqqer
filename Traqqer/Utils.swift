//
//  Utils.swift
//  Traqqer
//
//  Created by Steffan Chartrand on 3/19/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import Foundation

class Utils {
    class func createUIColor(red: Float, green: Float, blue: Float, alpha: Float) -> UIColor {
        return UIColor(red: CGFloat(red / 255), green: CGFloat(green / 255), blue: CGFloat(blue / 255), alpha: CGFloat(alpha))
    }
}