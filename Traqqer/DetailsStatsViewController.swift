//
//  DetailsStatsViewController.swift
//  Traqqer
//
//  Created by John Boggs on 3/11/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import UIKit

class DetailsStatsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var stat : Stat!
    var days = [] as [String]
    var entriesByDay = Dictionary() as Dictionary<String, [Entry]>
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        Traqqer.registerNibAsCell(tableView, identifier: Constants.DETAILS_STATS_CELL)
    }
    
    override func viewWillAppear(animated: Bool) {
        refreshData()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(Constants.DETAILS_STATS_CELL) as DetailsStatsCell
        cell.entry = self.entryForIndexPath(indexPath)
        cell.setup()
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // One row for each entry in this section's day
        let day = self.days[section]
        let entries = self.entriesByDay[day]!
        return entries.count
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let text = self.days[section]
        let header = UILabel()
        header.text = text
        header.textAlignment = .Center
        header.backgroundColor = Utils.Color.sectionHeaderColor
        header.textColor = Utils.Color.sectionHeaderTextColor
        header.font = Utils.Font.boldFont
        return header
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
        // One section for each day
        return self.days.count
    }
    
    func refreshData() {
        ParseAPI.getEntriesforStat(stat, completion: {entries in
            for entry in reverse(entries) {
                let day = DateUtils.formatDate(entry.timestamp)
                if self.entriesByDay[day] != nil {
                    var entries = self.entriesByDay[day]! // var in this line is to make the array mutable
                    entries.append(entry)
                    self.entriesByDay[day] = entries
                } else {
                    var entries = [entry] // var so that it's a mutable array
                    self.entriesByDay[day] = entries
                    self.days.append(day)
                }

            }
            self.tableView.reloadData()
        })
    }
    
    func entryForIndexPath(indexPath: NSIndexPath) -> Entry {
        let day = self.days[indexPath.section]
        let entries = self.entriesByDay[day]!
        return entries[indexPath.row]
    }
    
}