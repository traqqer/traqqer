//
//  DetailsGraphsViewController.swift
//  Traqqer
//
//  Created by John Boggs on 3/11/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import UIKit

class DetailsGraphsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var timeSegments: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func onSegmentChanged(sender: UISegmentedControl) {
        tableView.reloadData()
    }
    
    var stat : Stat!
    var entries = [] as [Entry]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        Traqqer.registerNibAsCell(tableView, identifier: Constants.DASHBOARD_GRAPHS_CELL)
        Traqqer.registerNibAsCell(tableView, identifier: Constants.DETAILS_GRAPHS_SUMMARY_CELL)
        tableView.rowHeight = CGFloat(250)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(Constants.DASHBOARD_GRAPHS_CELL, forIndexPath: indexPath) as DashboardGraphCell
            cell.accessoryType = UITableViewCellAccessoryType.None
            cell.selectionStyle = UITableViewCellSelectionStyle.None;
            cell.timeSegment = TimeSegment(rawValue: timeSegments.selectedSegmentIndex)
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(Constants.DETAILS_GRAPHS_SUMMARY_CELL, forIndexPath: indexPath) as DetailsGraphsSummaryCell
            return cell
        }

    }
}
