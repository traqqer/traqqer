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
        return 5
    }
    
    func lineChartView(lineChartView: JBLineChartView!, verticalValueForHorizontalIndex horizontalIndex: UInt, atLineIndex lineIndex: UInt) -> CGFloat {
         //y-position (y-axis) of point at horizontalIndex (x-axis)
        return CGFloat(horizontalIndex * 100)
    }
    
    func lineChartView(lineChartView: JBLineChartView!, colorForLineAtLineIndex lineIndex: UInt) -> UIColor! {
        return UIColor.whiteColor()
    }
    
    func lineChartView(lineChartView: JBLineChartView!, widthForLineAtLineIndex lineIndex: UInt) -> CGFloat {
        return CGFloat(1.0)
    }
    
    func lineChartView(lineChartView: JBLineChartView!, didSelectLineAtIndex lineIndex: UInt, horizontalIndex: UInt) {
        infoLabel.text = String(horizontalIndex * 100)
    }
    
    func didDeselectLineInLineChartView(lineChartView: JBLineChartView!) {
        infoLabel.text = ""
    }
    
    func createHeaderView() -> UIView {
        var label = UILabel(frame: CGRectMake(0, 0, lineChart.frame.width, 50))
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
        
        var footerView = UIView(frame: CGRectMake(0, 0, lineChart.frame.width, 16))
        footerView.addSubview(label1)
        footerView.addSubview(label2)
        return footerView
    }
}
