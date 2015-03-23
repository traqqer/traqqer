//
//  InterfaceController.swift
//  Traqqer WatchKit Extension
//
//  Created by Steffan Chartrand on 3/21/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import WatchKit
import Foundation
import Parse

class InterfaceController: WKInterfaceController {

    @IBOutlet weak var table: WKInterfaceTable!
    
    var stats : [Stat] = []
    var numberOfRows = 0
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        Parse.enableLocalDatastore()
        Parse.setApplicationId(Constants.PARSE_APPLICATION_ID, clientKey: Constants.PARSE_CLIENT_KEY)
        
        fetchData()
    }
    
    func updateTable() {
        for i in 0 ..< stats.count {
            var row = table.rowControllerAtIndex(i) as StatRow
            row.setStat(stats[i])
        }
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        (table.rowControllerAtIndex(rowIndex) as StatRow).click()
    }
    
    func fetchData() {
        ParseAPI.getStats {stats in
            self.stats = stats
            if self.numberOfRows != self.stats.count {
                self.table.setNumberOfRows(self.stats.count, withRowType: "StatRow")
            }
            self.updateTable()
        }
    }
}
