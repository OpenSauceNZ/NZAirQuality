//
//  AQIGraphicTableViewCell.swift
//  NZAirQuality
//
//  Created by Liguo Jiao on 21/07/17.
//  Copyright © 2017 Liguo Jiao. All rights reserved.
//

import UIKit
import ScrollableGraphView

class AQIGraphicTableViewCell: UITableViewCell {
    @IBOutlet weak var graphView: ScrollableGraphView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
        self.backgroundColor = NZABackgroundColor
        setup(on: graphView)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}

extension AQIGraphicTableViewCell {
    func setup(on newGraphView: ScrollableGraphView) {
        // Setup the first plot.
        let blueLinePlot = LinePlot(identifier: "multiBlue")
        
        blueLinePlot.lineColor = UIColor(rgb: 0x16aafc)
        blueLinePlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        
        // dots on the line
        let blueDotPlot = DotPlot(identifier: "multiBlueDot")
        blueDotPlot.dataPointType = ScrollableGraphViewDataPointType.circle
        blueDotPlot.dataPointSize = 5
        blueDotPlot.dataPointFillColor = UIColor(rgb: 0x16aafc)
        
        blueDotPlot.adaptAnimationType = ScrollableGraphViewAnimationType.elastic
        
        // Setup the second plot.
        let orangeLinePlot = LinePlot(identifier: "multiOrange")
        
        orangeLinePlot.lineColor = UIColor(rgb: 0xff7d78)
        orangeLinePlot.adaptAnimationType = ScrollableGraphViewAnimationType.easeOut
        
        // squares on the line
        let orangeSquarePlot = DotPlot(identifier: "multiOrangeSquare")
        orangeSquarePlot.dataPointType = ScrollableGraphViewDataPointType.square
        orangeSquarePlot.dataPointSize = 5
        orangeSquarePlot.dataPointFillColor = UIColor(rgb: 0xff7d78)
        orangeSquarePlot.adaptAnimationType = ScrollableGraphViewAnimationType.easeOut
        
        // Setup the reference lines.
        let referenceLines = ReferenceLines()
        
        referenceLines.referenceLineLabelFont = UIFont.boldSystemFont(ofSize: 8)
        referenceLines.referenceLineColor = UIColor.white.withAlphaComponent(0.2)
        referenceLines.referenceLineLabelColor = UIColor.white
        referenceLines.relativePositions = [0, 0.2, 0.4, 0.6, 0.8, 1]
        
        referenceLines.dataPointLabelColor = UIColor.white.withAlphaComponent(1)
        
        // Setup the graph
        newGraphView.backgroundFillColor = UIColor(rgb: 0x333333)
        
        newGraphView.dataPointSpacing = 80
        
        newGraphView.shouldAnimateOnStartup = true
        newGraphView.shouldAdaptRange = true
        newGraphView.shouldRangeAlwaysStartAtZero = true
        
        // Add everything to the graph.
        newGraphView.addReferenceLines(referenceLines: referenceLines)
        newGraphView.addPlot(plot: blueLinePlot)
        newGraphView.addPlot(plot: blueDotPlot)
        newGraphView.addPlot(plot: orangeLinePlot)
        newGraphView.addPlot(plot: orangeSquarePlot)
    }
}
