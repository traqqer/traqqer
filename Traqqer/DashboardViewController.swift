//
//  DashboardViewController.swift
//  Traqqer
//
//  Created by John Boggs on 3/11/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    var tabVC : UITabBarController!
//    var viewControllers : NSArray!
    
    @IBAction func addStatButtonPressed(sender: AnyObject) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabViewController()
    }
    
    func setupTabViewController() {
        let dashboardStatsVC = Traqqer.instantiateStoryboardVC(Constants.DASHBOARD_STATS)
        let dashboardGraphsVC =
            Traqqer.instantiateStoryboardVC(Constants.DASHBOARD_GRAPHS)
        
        dashboardStatsVC.tabBarItem!.title = "Stats"
        dashboardGraphsVC.tabBarItem!.title = "Graphs"

        tabVC = UITabBarController()
        
        tabVC.viewControllers = [dashboardStatsVC, dashboardGraphsVC]
        self.view.addSubview(tabVC.view)
        
    }
}
