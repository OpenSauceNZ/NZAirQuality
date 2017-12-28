//
//  WeatherDetailsTableViewCell.swift
//  NZAirQuality
//
//  Created by Liguo Jiao on 29/12/17.
//  Copyright © 2017 Liguo Jiao. All rights reserved.
//

import UIKit

class WeatherDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var sendibleTempImage: UIImageView!
    @IBOutlet weak var sendibleLabel: UILabel!
    @IBOutlet weak var sendibleTemp: UILabel!
    
    @IBOutlet weak var sunriseImage: UIImageView!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunriseTime: UILabel!

    @IBOutlet weak var sunsetImage: UIImageView!
    @IBOutlet weak var sunsetLabel: UILabel!
    @IBOutlet weak var sunsetTime: UILabel!
    
    var weatherData: Weather?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = .clear
        setLabelStyle(self.sendibleTemp)
        setLabelStyle(self.sendibleLabel)
        setLabelStyle(self.sunriseTime)
        setLabelStyle(self.sunriseLabel)
        setLabelStyle(self.sunsetLabel)
        setLabelStyle(self.sunsetTime)
    }
    
    func setLabelStyle(_ label:UILabel) {
        label.textColor = NZAWhite
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 3.0
        label.layer.shadowOpacity = 1.0
        label.layer.shadowOffset = CGSize(width: 4, height: 4)
        label.layer.masksToBounds = false
    }
}
