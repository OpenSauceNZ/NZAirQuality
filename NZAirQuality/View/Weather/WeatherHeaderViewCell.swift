//
//  WeatherHeaderViewCell.swift
//  NZAirQuality
//
//  Created by Liguo Jiao on 27/07/17.
//  Copyright © 2017 Liguo Jiao. All rights reserved.
//

import UIKit

class WeatherHeaderViewCell: UITableViewCell {
    
    @IBOutlet weak var weatherStatusImage: UIImageView!
    @IBOutlet weak var conponentImage: UIImageView!
    @IBOutlet weak var montainImage: UIImageView!
    @IBOutlet weak var weatherInfoSection: WeatherInfoView!
    @IBOutlet weak var tempture: UILabel!
    
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var weatherStatus: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.backgroundColor = NZABackgroundColor
        
        self.weatherStatus.adjustsFontSizeToFitWidth = true
        self.weatherStatus.minimumScaleFactor = 0.2
        self.weatherStatus.numberOfLines = 0
        
        self.tempture.text = "25℃"
        
        tempture.backgroundColor = UIColor.clear
        tempture.textColor = UIColor.white
        
        tempture.textAlignment = .center
        tempture.numberOfLines = 1
        tempture.layer.shadowColor = UIColor.white.cgColor
        tempture.layer.shadowOffset = CGSize(width: 3, height: 3)
        tempture.layer.shadowOpacity = 0.8
        tempture.layer.shadowRadius = 6
        
    }
    override func layoutIfNeeded() {
        super.layoutIfNeeded()

    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
