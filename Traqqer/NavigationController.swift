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
        
        self.navigationBar.barTintColor = Utils.Color.navColor
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: Utils.Color.navTextColor]
    }
}