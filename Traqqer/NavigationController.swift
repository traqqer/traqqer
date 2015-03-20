//
//  NavigationViewController.swift
//  Traqqer
//
//  Created by Steffan Chartrand on 3/19/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import Foundation

class NavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.barTintColor = Utils.createUIColor(50, green: 70, blue: 90, alpha: 1)
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
    }
}