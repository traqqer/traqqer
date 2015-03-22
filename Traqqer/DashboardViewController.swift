//
//  DashboardViewController.swift
//  Traqqer
//
//  Created by John Boggs on 3/11/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, NavigationDelegate {
    
    @IBOutlet weak var addButton: UIButton!

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
        addButton.imageView!.image!.imageWithRenderingMode(.AlwaysTemplate)
        addButton.imageView!.tintColor = UIColor.whiteColor()
        addButton.tintColor = UIColor.whiteColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        detailsMode = false
        dashboardStatsVC.setDetailsMode(detailsMode)
    }
    
    func setupTabViewController() {
        // Set colors for all UITabBars in the app
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState:.Normal)
        UITabBar.appearance().selectedImageTintColor = UIColor.whiteColor()
        UITabBar.appearance().barTintColor = Utils.createUIColor(50, green: 70, blue: 90, alpha: 1)
        
        dashboardStatsVC = Traqqer.instantiateStoryboardVC(Constants.DASHBOARD_STATS) as? DashboardStatsViewController
        dashboardGraphsVC = Traqqer.instantiateStoryboardVC(Constants.DASHBOARD_GRAPHS) as? DashboardGraphsViewController
        
        // Set the tab bar items
        dashboardStatsVC!.tabBarItem!.title = "STATS"
        dashboardStatsVC!.tabBarItem!.image = UIImage(named: "glyphicons-31-pencil")
        
        dashboardGraphsVC!.tabBarItem!.title = "GRAPHS"
        dashboardGraphsVC!.tabBarItem!.image = UIImage(named: "glyphicons-41-stats")

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
        
//        StatAggregationUtils.summaryForStat(stat, day: NSDate()) {
//            (count: Int, duration: NSTimeInterval?) in
//            
//            println("guy: \(count), \(duration)")
//        }
        
//        StatAggregationUtils.graphSummaryForStat(stat, start: NSDate(), numberOfBuckets: 10)
        
        navigationController!.pushViewController(detailsVC, animated: true)
    }
}

protocol NavigationDelegate : class {
    func segueToDetail(forStats stat: Stat)
}