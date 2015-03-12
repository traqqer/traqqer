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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabViewController()
    }
    
    func setupTabViewController() {
        let dashboardStatsVC = UIStoryboard(
            name: Constants.StoryboardIdentifiers.DASHBOARD_STATS,
            bundle: nil
        ).instantiateViewControllerWithIdentifier(
            Constants.ViewControllerIdentifiers.DASHBOARD_STATS
        ) as DashboardStatsViewController

        let dashboardGraphsVC = UIStoryboard(
            name: Constants.StoryboardIdentifiers.DASHBOARD_GRAPHS, bundle: nil
        ).instantiateViewControllerWithIdentifier(
            Constants.ViewControllerIdentifiers.DASHBOARD_GRAPHS
        ) as DashboardGraphsViewController
        
        dashboardStatsVC.tabBarItem!.title = "Stats"
        dashboardGraphsVC.tabBarItem!.title = "Graphs"

        tabVC = UITabBarController()
        
        tabVC.viewControllers = [dashboardStatsVC, dashboardGraphsVC]
        self.view.addSubview(tabVC.view)
        
    }
}
