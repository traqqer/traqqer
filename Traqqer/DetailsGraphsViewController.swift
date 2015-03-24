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
        self.refreshData()
    }
    
    var stat : Stat!
    var summaryData : [String: String]!
    
    var entries = [] as [Entry]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        Traqqer.registerNibAsCell(tableView, identifier: Constants.DASHBOARD_GRAPHS_CELL)
        Traqqer.registerNibAsCell(tableView, identifier: Constants.DETAILS_GRAPHS_SUMMARY_CELL)

        tableView.scrollEnabled = false
        
        timeSegments.tintColor = Utils.Color.textColor
        self.view.backgroundColor = Utils.Color.backgroundColor
        self.tableView.backgroundColor = Utils.Color.backgroundColor
        
        refreshData()
    }
    
    func refreshData() {
        // Populate summary data
        let timeSegment = TimeSegment(rawValue: timeSegments.selectedSegmentIndex)!
        StatAggregationUtils.detailSummaryForStat(self.stat, end: NSDate(), numberOfBuckets: timeSegment.getSegmentCount(), bucketDuration: timeSegment.getSegmentDuration()) { (countStats, durationStats) -> () in
            self.summaryData = Dictionary()
            switch StatType(rawValue: self.stat.type)! {
            case .Count:
                let (min, avg, max) = countStats
                //TODO
                self.summaryData["min"] = String(format: "%d", min)
                self.summaryData["avg"] = String(format: "%5.2f", avg)
                self.summaryData["max"] = String(format: "%d", max)
            case .Duration:
                let (min, avg, max) = durationStats!
                //TODO
                self.summaryData["min"] = DateUtils.formatTimeInterval(min, shortForm: false)
                self.summaryData["avg"] = DateUtils.formatTimeInterval(avg, shortForm: false)
                self.summaryData["max"] = DateUtils.formatTimeInterval(max, shortForm: false)
            }
            self.tableView.reloadData()
        }

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
            cell.stat = self.stat
            cell.timeSegment = TimeSegment(rawValue: timeSegments.selectedSegmentIndex)
            cell.refreshGraph()
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(Constants.DETAILS_GRAPHS_SUMMARY_CELL, forIndexPath: indexPath) as DetailsGraphsSummaryCell
            cell.setStat("", value: "")
            if let summarydata = summaryData {
                if row == 1 {
                    cell.setStat("Min", value: summaryData["min"]!)
                } else if row == 2 {
                    cell.setStat("Average", value: summaryData["avg"]!)
                } else if row == 3 {
                    cell.setStat("Max", value: summaryData["max"]!)
                }
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
