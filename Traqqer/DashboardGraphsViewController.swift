//
//  DashboardGraphsViewController.swift
//  Traqqer
//
//  Created by John Boggs on 3/11/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import UIKit

let weekdays: Array<String> = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"]

enum TimeSegment: Int {
    case Day = 0, Week, Month, Year
    
    func getSegmentCount() -> Int {
        switch self {
            case .Day:
                return 24
            case .Week:
                return 7
            case .Month:
                return NSDate().endOfMonth.day
            case .Year:
                return 12
        }
    }
    
    func getSegmentDuration() -> Duration {
        switch self {
        case .Day:
            return 1.hours
        case .Week:
            return 1.days
        case .Month:
            return 1.days
        case .Year:
            return 1.month
        }
    }
    
    func getSegmentName(index: Int) -> String {
        switch self {
            case .Day:
                return NSDate().change(hour: index).stringFromFormat("hh a")
            case .Week:
                return weekdays[index]
            case .Month:
                return String(index+1)
            case .Year:
                return NSDate().change(month: index+1).stringFromFormat("MMM")
        }
    }
}

class DashboardGraphsViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate, DashboardGraphCellDelegate {
    
    @IBOutlet weak var timeSegments: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    var detailsMode = false
    var stats = [] as [Stat]
    
    weak var navigationDelegate : NavigationDelegate?
    
    @IBAction func onSegmentChanged(sender: UISegmentedControl) {
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Utils.Color.backgroundColor
        tableView.backgroundColor = Utils.Color.backgroundColor
        timeSegments.tintColor = Utils.Color.textColor
        tableView.rowHeight = CGFloat(250)
        Traqqer.registerNibAsCell(tableView, identifier: Constants.DASHBOARD_GRAPHS_CELL)
        
        ParseAPI.getStats({stats in
            self.stats = stats
            self.tableView.reloadData()
        })
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stats.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.DASHBOARD_GRAPHS_CELL, forIndexPath: indexPath) as DashboardGraphCell
        cell.accessoryType = UITableViewCellAccessoryType.None
        cell.selectionStyle = UITableViewCellSelectionStyle.None;
        cell.timeSegment = TimeSegment(rawValue: timeSegments.selectedSegmentIndex)
        let stat = self.stats[indexPath.row]
        cell.setStat(stat, delegate: self, enableExpand: true)
        cell.refreshGraph()
        return cell
    }
    
    func onExpandClicked(stat: Stat) {
        navigationDelegate?.segueToDetail(forStats: stat)
    }
}
