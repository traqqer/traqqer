//
//  DashboardStatsViewController.swift
//  Traqqer
//
//  Created by John Boggs on 3/11/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import UIKit

class DashboardStatsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, DashboardStatsCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    var detailsMode = false
    var stats : [Stat] = []
    var timers  = [String: NSDate]()
    var selected : [Bool] = []
    weak var navigationDelegate : NavigationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hud = MBProgressHUD.showHUDAddedTo(tableView, animated: true)
        hud.mode = MBProgressHUDMode.Indeterminate
        hud.labelText = "Loading"
        
        // Setup the tableview
        tableView.delegate = self; tableView.dataSource = self
        tableView.backgroundColor = Utils.Color.backgroundColor
        Traqqer.registerNibAsCell(tableView, identifier: Constants.DASHBOARD_STATS_CELL)
    }
    
    override func viewWillAppear(animated: Bool) {
        fetchData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.DASHBOARD_STATS_CELL) as DashboardStatsCell
        cell.delegate = self
        cell.stat = stats[indexPath.row]
        cell.loadRemoteData()
        cell.accessoryType = detailsMode
            ? UITableViewCellAccessoryType.DisclosureIndicator
            : UITableViewCellAccessoryType.None
        cell.startDate = timers[cell.stat.objectId]
        cell.setStopwatchListener()
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
            if cell.stat.type == Constants.StatTypes.DURATION {
                timers[cell.stat.objectId] = cell.startDate
                selected[indexPath.row] = !selected[indexPath.row]
                tableView.beginUpdates()
                tableView.endUpdates()
            }
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let stat = self.stats[indexPath.row]
        if timers[stat.objectId] != nil {
            return CGFloat(80) * 2
        } else {
            return CGFloat(80)
        }
    }
    
    func fetchData() {
        ParseAPI.getStats {stats in
            MBProgressHUD.hideAllHUDsForView(self.tableView, animated: true)
            self.stats = stats
            self.selected = Array<Bool>(count: stats.count, repeatedValue: false)
            self.tableView.reloadData()
        }
    }
    
    func setDetailsMode(detailsMode: Bool) {
        self.detailsMode = detailsMode
        tableView.reloadData()
    }
    
    // MARK: DashboardStatsCellDelegate
    
    func onGoalReached(stat: Stat) {
        GoalCompletion.performGoalAnimation(self.view)
    }
}
