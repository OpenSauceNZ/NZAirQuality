//
//  AQIGraphicTableViewCell.swift
//  NZAirQuality
//
//  Created by Liguo Jiao on 21/07/17.
//  Copyright © 2017 Liguo Jiao. All rights reserved.
//

import UIKit


class AQIGraphicTableViewCell: UITableViewCell {

    @IBOutlet weak var graph: FSLineChart!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        var data: [Int] = []
        
        // Generate some dummy data
        for _ in 0...10 {
            data.append(Int(20 + (arc4random() % 100)))
        }
        
        graph.verticalGridStep = 5
        graph.horizontalGridStep = 9
        graph.labelForIndex = { "\($0)" }
        graph.labelForValue = { "$\($0)" }
        graph.setChartData(data)
        self.backgroundColor = NZABackgroundColor
        graph.backgroundColor = NZABackgroundColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
