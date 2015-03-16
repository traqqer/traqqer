//
//  Constants.swift
//  Traqqer
//
//  Created by John Boggs on 3/11/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    // VCs
    static let DASHBOARD = "Dashboard"
    static let DASHBOARD_STATS = "DashboardStats"
    static let DASHBOARD_GRAPHS = "DashboardGraphs"
    static let DETAILS = "Details" // No Custom Controlller
    static let DETAILS_STATS = "DetailsStats"
    static let DETAILS_GRAPHS = "DetailsGraphs"
    static let NEW_STAT = "NewStat"
    static let NEW_STAT_FORM = "NewStatForm"

    // Cells
    static let DASHBOARD_STATS_CELL = "DashboardStatsCell"
    
    // Config
    static let PARSE_APPLICATION_ID = "fkila2DSXO9hpNsz5E5VcOenyU9kMEVDhOVewGfW"
    static let PARSE_CLIENT_KEY = "inRmC1kHZD2dKh3X2PoTbmJjTdRVqOP2XasVJc40"

    struct StatTypes {
        static let COUNT = "Count"
        static let DURATION = "Duration"
    }
    
    struct GoalTypes {
        static let AT_LEAST = "At Least"
        static let LESS_THAN = "Less Than"
        static let MORE_THAN = "More Than"
        static let AT_MOST = "At Most"
    }
    
    struct IntervalTypes {
        static let DAY = "Day"
    }    
}