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

class DashboardGraphCell: UITableViewCell, JBBarChartViewDataSource, JBBarChartViewDelegate {
    
    @IBOutlet weak var barChart: JBBarChartView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var expandButton: UIButton!
    
    var stat: Stat!
    var delegate: DashboardGraphCellDelegate!
    var toolTip: ToolTip
    var timeSegment: TimeSegment?
    var graphValues = [Double]()
    var lowValue = 0.0
    
    
    @IBAction func onExpand(sender: UIButton) {
        println("On expand")
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
        
        backgroundColor = Utils.Color.backgroundColor
        infoLabel.textAlignment = .Center
        infoLabel.textColor = Utils.Color.textColor
        infoLabel.font = Utils.Font.largeBoldFont
        
        barChart.dataSource = self
        barChart.delegate = self
        barChart.minimumValue = 0
        barChart.backgroundColor = Utils.Color.backgroundColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let headerView = HeaderView(frame: CGRectMake(0, 0, barChart.frame.width, 40))
        headerView.label.text = stat.name
        barChart.headerView = headerView
        barChart.footerView = FooterView(frame: CGRectMake(0, 0, barChart.frame.width, 16), timeSegment: timeSegment!)
        
        barChart.setState(.Collapsed, animated: false)
        barChart.reloadData()
    }
    
    func refreshGraph() {
        self.graphValues = []
        
        var endDate : NSDate
        switch self.timeSegment! {
        case .Day:
            endDate = DateUtils.getEndOfDay()
        case .Week:
            endDate = DateUtils.getEndOfWeek()
        case .Month:
            endDate = DateUtils.getEndOfMonth()
        case .Year:
            endDate = DateUtils.getEndOfYear()
        }
        
        StatAggregationUtils.graphSummaryForStat(self.stat, end: endDate, numberOfBuckets: self.timeSegment!.getSegmentCount(), bucketDuration: self.timeSegment!.getSegmentDuration(), completion: {(counts, durations) in
            switch StatType(rawValue: self.stat.type)! {
            case .Count:
                self.graphValues = counts.map({i in Double(i)})
            case .Duration:
                self.graphValues = durations!
            }
            self.lowValue = self.graphValues.reduce(Double(0.0), combine: {(first, second) in max(first, second)}) * 0.01
            
            self.barChart.reloadData()
            self.showChart()
        })
    }
    
    func getValueForIndex(horizontalIndex : UInt) -> CGFloat {
        if self.graphValues.count > 0 {
            let doubleValue = self.graphValues[Int(horizontalIndex)]
            let floatValue = CGFloat(doubleValue)
            return floatValue
        } else {
            return 0
        }
    }
    
    func setStat(stat: Stat?, delegate: DashboardGraphCellDelegate, enableExpand: Bool) {
        self.stat = stat
        self.delegate = delegate
        self.expandButton.hidden = enableExpand
    }
    
    func numberOfBarsInBarChartView(barChartView: JBBarChartView!) -> UInt {
        return UInt(self.timeSegment!.getSegmentCount())
    }
    
    func barChartView(barChartView: JBBarChartView!, heightForBarViewAtIndex index: UInt) -> CGFloat {
        let value = getValueForIndex(index)
        if value == 0 {
            return CGFloat(self.lowValue)
        } else {
            return value
        }
    }
    

    func barChartView(barChartView: JBBarChartView!, didSelectBarAtIndex index: UInt, touchPoint: CGPoint) {
        switch StatType(rawValue: self.stat.type)! {
        case .Count:
            infoLabel.text = String(format: "%d", Int(self.getValueForIndex(index)))
        case .Duration:
            let timeInterval = Double(self.getValueForIndex(index))
            infoLabel.text = DateUtils.formatTimeIntervalPretty(timeInterval)
        }
        
        toolTip.hidden = false
        
        toolTip.setText(getHorizontalDescription(index))
        
        let originalTouchPoint = self.convertPoint(touchPoint, fromView:barChartView)
        var convertedTouchPoint = originalTouchPoint
        
        let minChartX = (barChart.frame.origin.x + ceil(toolTip.frame.size.width * 0.5));
        if (convertedTouchPoint.x < minChartX)
        {
            convertedTouchPoint.x = minChartX;
        }
        
        let maxChartX = (barChartView.frame.origin.x + barChartView.frame.size.width - ceil(toolTip.frame.size.width * 0.5));
        if (convertedTouchPoint.x > maxChartX)
        {
            convertedTouchPoint.x = maxChartX;
        }
        
        toolTip.frame = CGRectMake(convertedTouchPoint.x - ceil(toolTip.frame.size.width * 0.5), CGRectGetMaxY(barChart.headerView.frame), toolTip.frame.size.width, toolTip.frame.size.height)
    }
    
    func barPaddingForBarChartView(barChartView: JBBarChartView!) -> CGFloat {
        return CGFloat(2.0)
    }
    
    func barChartView(barChartView: JBBarChartView!, colorForBarViewAtIndex index: UInt) -> UIColor! {
        return Utils.Color.graphColor
    }
    
    func barChartView(barChartView: JBBarChartView!, widthForLineAtLineIndex lineIndex: UInt) -> CGFloat {
        return CGFloat(2.0)
    }
    
    func barSelectionColorForBarChartView(barChartView: JBBarChartView!) -> UIColor! {
        return Utils.Color.selectionGraphColor
    }
    
    func getHorizontalDescription(horizontalIndex: UInt) -> String {
        let segment = self.timeSegment!
        let offset = segment.getSegmentCount() - Int(horizontalIndex)
        switch segment {
        case .Day:
            let point = DateUtils.getEndOfDay() - offset.hours
            return DateUtils.formatHHMM(point)
        case .Week:
            let point = DateUtils.getEndOfWeek() - offset.days
            return point.stringFromFormat("EEE")
        case .Month:
            let point = DateUtils.getEndOfMonth() - offset.days
            return point.stringFromFormat("MMM d")
        case .Year:
            let point = DateUtils.getEndOfYear() - offset.months
            return point.stringFromFormat("MMM")
        }
    }
    
    func barChartView(barChartView: JBBarChartView!, selectionColorForDotAtHorizontalIndex horizontalIndex: UInt, atLineIndex lineIndex: UInt) -> UIColor! {
        return Utils.Color.selectedGraphColor
    }
    
    func barChartView(barChartView: JBBarChartView!, smoothLineAtLineIndex lineIndex: UInt) -> Bool {
        return false
    }
    
    func barChartView(barChartView: JBBarChartView!, showsDotsForLineAtLineIndex lineIndex: UInt) -> Bool {
        return true
    }
    
    func barChartView(barChartView: JBBarChartView!, dotRadiusForDotAtHorizontalIndex horizontalIndex: UInt, atLineIndex lineIndex: UInt) -> CGFloat {
        return CGFloat(2 * 4)
    }
    
    func didDeselectBarChartView(barChartView: JBBarChartView!) {
        infoLabel.text = ""
        toolTip.hidden = true
    }
    
    func showChart() {
        barChart.setState(.Expanded, animated: true)
    }
}
