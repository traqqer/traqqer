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
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let row = indexPath.row
        if row == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier(Constants.DASHBOARD_GRAPHS_CELL, forIndexPath: indexPath) as DashboardGraphCell
            cell.accessoryType = UITableViewCellAccessoryType.None
            cell.selectionStyle = UITableViewCellSelectionStyle.None;
            cell.timeSegment = TimeSegment(rawValue: timeSegments.selectedSegmentIndex)
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(Constants.DETAILS_GRAPHS_SUMMARY_CELL, forIndexPath: indexPath) as DetailsGraphsSummaryCell
            if row == 1 {
                cell.setStat("Total", value: "100")
            } else if row == 2 {
                cell.setStat("Average", value: "200")
            } else if row == 3 {
                cell.setStat("Standard Deviation", value: "300")
            }
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let row = indexPath.row
        if row == 0 {
            return 250
        } else {
            return 50
        }
    }
}
