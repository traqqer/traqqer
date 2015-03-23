//
//  DetailsViewController.swift
//  Traqqer
//
//  Created by John Boggs on 3/11/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    var tabVC : UITabBarController!
    var detailsStatsVC : DetailsStatsViewController!
    var detailsGraphsVC : DetailsGraphsViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setup(stat: Stat) {
        navigationItem.title = stat.name
        
        detailsStatsVC = Traqqer.instantiateStoryboardVC(Constants.DETAILS_STATS) as DetailsStatsViewController
        detailsGraphsVC = Traqqer.instantiateStoryboardVC(Constants.DETAILS_GRAPHS) as DetailsGraphsViewController
        
        detailsStatsVC.tabBarItem!.title = "Stats"
        detailsStatsVC!.tabBarItem!.image = UIImage(named: "glyphicons-67-tags")
        
        detailsGraphsVC.tabBarItem!.title = "Graphs"
        detailsGraphsVC!.tabBarItem!.image = UIImage(named: "glyphicons-41-stats")
        
        tabVC = UITabBarController()
        
        tabVC.viewControllers = [detailsStatsVC, detailsGraphsVC]
        self.view.addSubview(tabVC.view)
        
        detailsStatsVC.stat = stat
        detailsGraphsVC.stat = stat
    }
}
