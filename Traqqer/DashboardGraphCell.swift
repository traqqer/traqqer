//
//  DashboardGraphCell.swift
//  Traqqer
//
//  Created by Steffan Chartrand on 3/14/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import UIKit

class DashboardGraphCell: UITableViewCell, JBLineChartViewDataSource, JBLineChartViewDelegate {
    
    @IBOutlet weak var lineChart: JBLineChartView!
    @IBOutlet weak var infoLabel: UILabel!
    
    var timeSegment: TimeSegment?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        backgroundColor = UIColor.darkGrayColor()
        infoLabel.textAlignment = .Center
        infoLabel.textColor = UIColor.whiteColor()
        
        lineChart.dataSource = self
        lineChart.delegate = self
        lineChart.minimumValue = 0
        lineChart.maximumValue = 500
        lineChart.backgroundColor = UIColor.darkGrayColor()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        lineChart.headerView = createHeaderView()
        lineChart.footerView = createFooterView()
        lineChart.setState(.Expanded, animated: true)
        lineChart.reloadData()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func numberOfLinesInLineChartView(lineChartView: JBLineChartView!) -> UInt {
        return 1
    }
    
    func lineChartView(lineChartView: JBLineChartView!, numberOfVerticalValuesAtLineIndex lineIndex: UInt) -> UInt {
        switch timeSegment! {
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
    
    func lineChartView(lineChartView: JBLineChartView!, verticalValueForHorizontalIndex horizontalIndex: UInt, atLineIndex lineIndex: UInt) -> CGFloat {
         //y-position (y-axis) of point at horizontalIndex (x-axis)
        return CGFloat(horizontalIndex * 100)
    }
    
    func lineChartView(lineChartView: JBLineChartView!, colorForLineAtLineIndex lineIndex: UInt) -> UIColor! {
        return UIColor.redColor()
    }
    
    func lineChartView(lineChartView: JBLineChartView!, colorForDotAtHorizontalIndex horizontalIndex: UInt, atLineIndex lineIndex: UInt) -> UIColor! {
        return UIColor.redColor()
    }
    
    func lineChartView(lineChartView: JBLineChartView!, widthForLineAtLineIndex lineIndex: UInt) -> CGFloat {
        return CGFloat(2.0)
    }
    
    func lineChartView(lineChartView: JBLineChartView!, didSelectLineAtIndex lineIndex: UInt, horizontalIndex: UInt) {
        infoLabel.text = String(horizontalIndex * 100)
    }
    
    func lineChartView(lineChartView: JBLineChartView!, smoothLineAtLineIndex lineIndex: UInt) -> Bool {
        return false
    }
    
    func lineChartView(lineChartView: JBLineChartView!, lineStyleForLineAtLineIndex lineIndex: UInt) -> JBLineChartViewLineStyle {
        return .Dashed
    }
    
    func lineChartView(lineChartView: JBLineChartView!, showsDotsForLineAtLineIndex lineIndex: UInt) -> Bool {
        return true
    }
    
    func lineChartView(lineChartView: JBLineChartView!, dotRadiusForDotAtHorizontalIndex horizontalIndex: UInt, atLineIndex lineIndex: UInt) -> CGFloat {
        return CGFloat(2 * 4)
    }
    
    func didDeselectLineInLineChartView(lineChartView: JBLineChartView!) {
        infoLabel.text = ""
    }
    
    func createHeaderView() -> UIView {
        var label = UILabel(frame: CGRectMake(0, 0, lineChart.frame.width, 20))
        label.textAlignment = .Center
        label.font = UIFont.systemFontOfSize(24)
        label.textColor = UIColor.whiteColor()
        label.text = "Coffee"
        return label
    }
    
    func createFooterView() -> UIView {
        var label1 = UILabel(frame: CGRectMake(0, 0, lineChart.frame.width/2, 16))
        label1.textColor = UIColor.whiteColor()
        label1.text = "Sun"
        
        var label2 = UILabel(frame: CGRectMake(lineChart.frame.width/2, 0, lineChart.frame.width/2, 16))
        label2.textAlignment = .Right
        label2.textColor = UIColor.whiteColor()
        label2.text = "Sat"
        
        let date = NSDate()
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.CalendarUnitHour | .CalendarUnitMinute, fromDate: date)
        let hour = components.hour
        let minutes = components.minute
        
        switch timeSegment! {
            case .Day:
                label1.text = "12 AM"
                label2.text = "12 AM"
            case .Week:
                label1.text = "Sun"
                label2.text = "Sat"
            case .Month:
                label1.text = "1"
                let lastDayOfCurrentMonth: NSDate = DateUtils.lastDayOfCurrentMonth()
                label2.text = String(DateUtils.dayNumberFromDate(lastDayOfCurrentMonth))
            case .Year:
                label1.text = "Jan"
                label2.text = "Dec"
        }
        
        var footerView = UIView(frame: CGRectMake(0, 0, lineChart.frame.width, 16))
        footerView.addSubview(label1)
        footerView.addSubview(label2)
        return footerView
    }
}
