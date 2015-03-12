//
//  Traqqer.swift
//  Traqqer
//
//  Created by John Boggs on 3/11/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import UIKit

class Traqqer {
    class func instantiateStoryboardVC(identifier : String) -> UIViewController {
        return UIStoryboard(
            name: identifier, bundle: nil
        ).instantiateViewControllerWithIdentifier(identifier) as UIViewController
    }
}

