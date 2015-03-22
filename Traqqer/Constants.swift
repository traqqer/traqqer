//
//  Constants.swift
//  Traqqer
//
//  Created by John Boggs on 3/11/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import Foundation
import UIKit

enum GoalType : String {
    case LessThan = "Less Than"
    case MoreThan = "More Than"
}

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
    static let DASHBOARD_GRAPHS_CELL = "DashboardGraphsCell"
    static let DETAILS_STATS_CELL = "DetailsStatsCell"
    static let DETAILS_GRAPHS_CELL = "DetailsGraphsCell"
    static let DETAILS_GRAPHS_SUMMARY_CELL = "DetailsGraphsSummaryCell"
    
    // Config
    static let PARSE_APPLICATION_ID = "fkila2DSXO9hpNsz5E5VcOenyU9kMEVDhOVewGfW"
    static let PARSE_CLIENT_KEY = "inRmC1kHZD2dKh3X2PoTbmJjTdRVqOP2XasVJc40"

    struct StatTypes {
        static let COUNT = "Count"
        static let DURATION = "Duration"
    }
    
    struct IntervalTypes {
        static let DAY = "Day"
    }
}