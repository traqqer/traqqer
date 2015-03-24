//
//  DashboardViewController.swift
//  Traqqer
//
//  Created by John Boggs on 3/11/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import UIKit

protocol NavigationDelegate : class {
    func segueToDetail(forStats stat: Stat)
}

class DashboardViewController: UIViewController, NavigationDelegate, UITabBarControllerDelegate {
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var detailsButton: UIButton!

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
        dashboardStatsVC.setDetailsMode(detailsMode)
        dashboardGraphsVC.detailsMode = detailsMode
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabViewController()
        navigationController!.navigationBar.translucent = false
        navigationController!.navigationBar.barTintColor = Utils.Color.navColor
        
        addButton.imageView!.image!.imageWithRenderingMode(.AlwaysTemplate)
        // Not respecting these colors
        addButton.imageView!.tintColor = Utils.Color.backgroundColor
        addButton.tintColor = Utils.Color.backgroundColor
    }
    
    override func viewWillAppear(animated: Bool) {
        detailsMode = false
        dashboardStatsVC.setDetailsMode(detailsMode)
    }
    
    func setupTabViewController() {
        // Set colors for all UITabBars in the app
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: Utils.Color.backgroundColor], forState:.Normal)
        UITabBar.appearance().selectedImageTintColor = Utils.Color.backgroundColor
        UITabBar.appearance().barTintColor = Utils.Color.navColor
        UITabBar.appearance().translucent = false
        
        dashboardStatsVC = Traqqer.instantiateStoryboardVC(Constants.DASHBOARD_STATS) as? DashboardStatsViewController
        dashboardGraphsVC = Traqqer.instantiateStoryboardVC(Constants.DASHBOARD_GRAPHS) as? DashboardGraphsViewController
        
        // Set the tab bar items
        dashboardStatsVC!.tabBarItem!.title = "Stats"
        dashboardStatsVC!.tabBarItem!.image = UIImage(named: "glyphicons-67-tags")
        
        dashboardGraphsVC!.tabBarItem!.title = "Graphs"
        dashboardGraphsVC!.tabBarItem!.image = UIImage(named: "glyphicons-41-stats")

        // Set self as the "NavigationDelegate"
        dashboardStatsVC!.navigationDelegate = self
        dashboardGraphsVC!.navigationDelegate = self
        
        // Put the views on a tab bar, and add the tab bar to the view
        tabVC = UITabBarController()
        tabVC.viewControllers = [dashboardStatsVC!, dashboardGraphsVC!]
        tabVC.delegate = self
        self.view.addSubview(tabVC.view)
    }
    
    func segueToDetail(forStats stat: Stat) {
        let detailsVC = Traqqer.instantiateStoryboardVC(Constants.DETAILS) as DetailsViewController
        detailsVC.setup(stat)
        
        navigationController!.pushViewController(detailsVC, animated: true)
    }
    
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        addButton.hidden = false
        detailsButton.hidden = false
        if viewController is DashboardGraphsViewController {
            addButton.hidden = true
            detailsButton.hidden = true
        }
    }
}
