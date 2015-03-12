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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    func setupTabViewController() {
        let detailsStatsVC = Traqqer.instantiateStoryboardVC(Constants.DETAILS_STATS)
        let detailsGraphsVC = Traqqer.instantiateStoryboardVC(Constants.DETAILS_GRAPHS)
        
        detailsStatsVC.tabBarItem!.title = "Stats"
        detailsGraphsVC.tabBarItem!.title = "Graphs"
        
        tabVC = UITabBarController()
        
        tabVC.viewControllers = [detailsStatsVC, detailsGraphsVC]
        self.view.addSubview(tabVC.view)
    }

}
