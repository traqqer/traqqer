//
//  DashboardGraphCell.swift
//  Traqqer
//
//  Created by Steffan Chartrand on 3/14/15.
//  Copyright (c) 2015 John Boggs. All rights reserved.
//

import UIKit

protocol DashboardGraphCellDelegate: class {
    func onExpandClicked(stat: Stat)
}

class DashboardGraphCell: UITableViewCell, JBLineChartViewDataSource, JBLineChartViewDelegate {
    
    @IBOutlet weak var lineChart: JBLineChartView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var expandButton: UIButton!
    
    var stat: Stat!
    var delegate: DashboardGraphCellDelegate!
    var toolTip: ToolTip
    var timeSegment: TimeSegment?

    @IBAction func onExpand(sender: UIButton) {
        // TODO fill in when we populate with real data
//        delegate.onExpandClicked(stat)
    }
    
    required init(coder aDecoder: NSCoder) {
        toolTip = ToolTip()
        
        super.init(coder: aDecoder)
        
        toolTip.hidden = true
        addSubview(toolTip)
    }

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
        lineChart.headerView = HeaderView(frame: CGRectMake(0, 0, lineChart.frame.width, 40))
        lineChart.footerView = FooterView(frame: CGRectMake(0, 0, lineChart.frame.width, 16), timeSegment: timeSegment!)
        
        lineChart.setState(.Collapsed, animated: false)
        lineChart.reloadData()
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: Selector("showChart"), userInfo: nil, repeats: false)
    }
    
    func setStat(stat: Stat?, delegate: DashboardGraphCellDelegate, enableExpand: Bool) {
        self.stat = stat
        self.delegate = delegate
        self.expandButton.hidden = enableExpand
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
        return CGFloat(arc4random_uniform(100))
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
    
    func lineChartView(lineChartView: JBLineChartView!, didSelectLineAtIndex lineIndex: UInt, horizontalIndex: UInt, touchPoint: CGPoint) {
        toolTip.hidden = false
        toolTip.setText(timeSegment!.getSegmentName(Int(horizontalIndex)))
        
        let originalTouchPoint = self.convertPoint(touchPoint, fromView:lineChartView)
        var convertedTouchPoint = originalTouchPoint
        
        let minChartX = (lineChart.frame.origin.x + ceil(toolTip.frame.size.width * 0.5));
        if (convertedTouchPoint.x < minChartX)
        {
            convertedTouchPoint.x = minChartX;
        }
        
        let maxChartX = (lineChartView.frame.origin.x + lineChartView.frame.size.width - ceil(toolTip.frame.size.width * 0.5));
        if (convertedTouchPoint.x > maxChartX)
        {
            convertedTouchPoint.x = maxChartX;
        }

        toolTip.frame = CGRectMake(convertedTouchPoint.x - ceil(toolTip.frame.size.width * 0.5), CGRectGetMaxY(lineChart.headerView.frame), toolTip.frame.size.width, toolTip.frame.size.height)
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
        toolTip.hidden = true
    }
    
    func showChart() {
        lineChart.setState(.Expanded, animated: true)
    }
}
