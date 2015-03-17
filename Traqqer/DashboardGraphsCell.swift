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
    }
    
    func numberOfLinesInLineChartView(lineChartView: JBLineChartView!) -> UInt {
        return 1
    }
    
    func lineChartView(lineChartView: JBLineChartView!, numberOfVerticalValuesAtLineIndex lineIndex: UInt) -> UInt {
        return UInt(timeSegment!.getSegmentCount())
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
        return HeaderView(frame: CGRectMake(0, 0, lineChart.frame.width, 20))
    }
    
    func createFooterView() -> UIView {
        return FooterView(frame: CGRectMake(0, 0, lineChart.frame.width, 16), timeSegment: timeSegment!)
    }
}