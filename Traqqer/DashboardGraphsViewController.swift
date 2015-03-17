//
//  DashboardGraphsViewController.swift
//  Traqqer
//
//  Created by John Boggs on 3/11/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import UIKit

enum TimeSegment: Int {
    case Day = 0, Week, Month, Year
    
    func getSegmentCount() -> Int {
        switch self {
            case .Day:
                return 24
            case .Week:
                return 7
            case .Month:
                return 4
            case .Year:
                return 12
        }
    }
}

class DashboardGraphsViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var timeSegments: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func onSegmentChanged(sender: UISegmentedControl) {
        tableView.reloadData()
    }
    
    var detailsMode = false
    weak var navigationDelegate : NavigationDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.darkGrayColor()
        self.tableView.backgroundColor = UIColor.darkGrayColor()
        Traqqer.registerNibAsCell(tableView, identifier: Constants.DASHBOARD_GRAPHS_CELL)
        tableView.rowHeight = CGFloat(250)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.DASHBOARD_GRAPHS_CELL, forIndexPath: indexPath) as DashboardGraphCell
        cell.accessoryType = UITableViewCellAccessoryType.None
        cell.selectionStyle = UITableViewCellSelectionStyle.None;
        cell.timeSegment = TimeSegment(rawValue: timeSegments.selectedSegmentIndex)
        return cell
    }
}
