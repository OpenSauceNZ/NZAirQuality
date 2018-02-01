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
    var humidity: String {
        return weatherData?.data.channel.atmosphere?.humidity ?? "0"
    }
    var windSpeed: String {
        return weatherData?.data.channel.wind?.speed ?? "0"
    }
    var tempture: String {
        return weatherData?.data.channel.item?.currentCondition?.temp ?? "0"
    }
    
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
        sunriseLabel.text = "Sunrise"
        sunsetLabel.text = "Sunset"
        sendibleLabel.text = "Feels Like"
        sunriseImage.image = #imageLiteral(resourceName: "sunrise")
        sunsetImage.image = #imageLiteral(resourceName: "sunset")
        sendibleTempImage.image = #imageLiteral(resourceName: "feellike")
        self.selectionStyle = .none
        
    }
    
    func setLabelStyle(_ label:UILabel) {
        label.textColor = NZAWhite
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 3.0
        label.layer.shadowOpacity = 1.0
        label.layer.shadowOffset = CGSize(width: 4, height: 4)
        label.layer.masksToBounds = false
    }
    
    func loadContent() {

        
        sunriseTime.text = weatherData?.data.channel.astronomy?.sunrise
        sunsetTime.text = weatherData?.data.channel.astronomy?.sunset
        
        //According to wiki: https://en.wikipedia.org/wiki/Apparent_temperature
        if let humidtyFloat = Float(humidity), let windSpeedFloat = Float(windSpeed), let tempFloat = Float(tempture) {
            let windSpeedMeterPerSecond = windSpeedFloat * 0.44704
            let e = (humidtyFloat/100) * 6.105 * exp((17.27 * windSpeedMeterPerSecond)/(237.7 + windSpeedMeterPerSecond))
            let AT = 1.07 * tempFloat + 0.2 * e - 0.65 * windSpeedMeterPerSecond - 2.7
            sendibleTemp.text = String(format: "%.0f°C", fahrenheitToCelsius(feh: AT))
        }

        
    }
}
