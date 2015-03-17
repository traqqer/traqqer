//
//  DashboardStatsViewController.swift
//  Traqqer
//
//  Created by John Boggs on 3/11/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import UIKit

class DashboardStatsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!

    var detailsMode = false
    var stats : [Stat] = []
    weak var navigationDelegate : NavigationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        // Setup the tableview
        tableView.delegate = self; tableView.dataSource = self
        Traqqer.registerNibAsCell(tableView, identifier: Constants.DASHBOARD_STATS_CELL)
        tableView.rowHeight = CGFloat(80)
        fetchData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.DASHBOARD_STATS_CELL) as DashboardStatsCell
        cell.stat = stats[indexPath.row]
        cell.numEntries = 0 // For now, should be set via Parse aggregation
        cell.totalDuration = 0.0 // Dito
        cell.setupView()
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stats.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = self.tableView.cellForRowAtIndexPath(indexPath) as DashboardStatsCell
        if detailsMode {
            // Segue to detail view
            navigationDelegate?.segueToDetail(forStats: cell.stat)
        } else {
            // Trigger the event
            cell.clicked()
        }

    }
    
    func fetchData() {
        ParseAPI.getStats {stats in
            self.stats = stats
            self.tableView.reloadData()
        }
    }
}
