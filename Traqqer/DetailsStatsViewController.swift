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
    var entries = [] as [Entry]
    
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
        cell.entry = entries[indexPath.row]
        cell.setup()
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entries.count
    }
    
    func refreshData() {
        ParseAPI.getEntriesforStat(stat, completion: {entries in
            self.entries = entries
            self.tableView.reloadData()
        })
    }
    
}