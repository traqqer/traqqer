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
        
        UITabBar.appearance().barTintColor = Utils.Color.navColor
        UITabBar.appearance().selectedImageTintColor = Utils.Color.backgroundColor
        UITabBar.appearance().translucent = false
        
        detailsStatsVC.tabBarItem!.title = "Stats"
        var statsImage = UIImage(named: "glyphicons-67-tags")!
        statsImage.imageWithRenderingMode(.AlwaysTemplate)
        detailsStatsVC!.tabBarItem!.image = statsImage
        
        detailsGraphsVC.tabBarItem!.title = "Graphs"
        var graphsImage = UIImage(named: "glyphicons-41-stats")!
        graphsImage.imageWithRenderingMode(.AlwaysTemplate)
        detailsGraphsVC!.tabBarItem!.image = graphsImage
        
        tabVC = UITabBarController()
        
        tabVC.viewControllers = [detailsStatsVC, detailsGraphsVC]
        self.view.addSubview(tabVC.view)
        
        detailsStatsVC.stat = stat
        detailsGraphsVC.stat = stat
    }
}
