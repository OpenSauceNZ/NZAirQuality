//
//  WeatherDailyInfoCollectionViewCell.swift
//  NZAirQuality
//
//  Created by Liguo Jiao on 28/07/17.
//  Copyright © 2017 Liguo Jiao. All rights reserved.
//

import UIKit

class WeatherDailyInfoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var statuImage: UIImageView!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        lowTemp.textColor = NZALightGray
        // Initialization code
    }
}
