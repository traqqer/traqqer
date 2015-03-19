//
//  DashboardViewController.swift
//  Traqqer
//
//  Created by John Boggs on 3/11/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, NavigationDelegate {
    var tabVC : UITabBarController!
    var dashboardStatsVC : DashboardStatsViewController!
    var dashboardGraphsVC : DashboardGraphsViewController!
    var detailsMode = false
    
    
    @IBAction func addStatButtonPressed(sender: AnyObject) {
        let newStatFormVC = Traqqer.instantiateStoryboardVC(Constants.NEW_STAT_FORM)
        self.presentViewController(newStatFormVC, animated: true, completion: nil)

    }
    
    @IBAction func detailButtonPressed(sender: AnyObject) {
        // Flip the detailsMode on or off
        detailsMode = !detailsMode
        dashboardStatsVC.detailsMode = detailsMode
        dashboardGraphsVC.detailsMode = detailsMode
        navigationController?.navigationBar.barTintColor = detailsMode ? UIColor.blueColor() : UIColor.whiteColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabViewController()
        self.navigationController!.navigationBar.translucent = false
    }
    
    func setupTabViewController() {
        dashboardStatsVC = Traqqer.instantiateStoryboardVC(Constants.DASHBOARD_STATS) as? DashboardStatsViewController
        dashboardGraphsVC = Traqqer.instantiateStoryboardVC(Constants.DASHBOARD_GRAPHS) as? DashboardGraphsViewController
        
        // Set the tab bar items
        dashboardStatsVC!.tabBarItem!.title = "Stats"
        dashboardGraphsVC!.tabBarItem!.title = "Graphs"

        // Set self as the "NavigationDelegate"
        dashboardStatsVC!.navigationDelegate = self
        dashboardGraphsVC!.navigationDelegate = self
        
        // Put the views on a tab bar, and add the tab bar to the view
        tabVC = UITabBarController()
        tabVC.viewControllers = [dashboardStatsVC!, dashboardGraphsVC!]
        self.view.addSubview(tabVC.view)
    }
    
    func segueToDetail(forStats stat: Stat) {
        let detailsVC = Traqqer.instantiateStoryboardVC(Constants.DETAILS) as DetailsViewController
        detailsVC.setup(stat)
        navigationController!.pushViewController(detailsVC, animated: true)
    }
    
}

protocol NavigationDelegate : class {
    func segueToDetail(forStats stat: Stat)
}