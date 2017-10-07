//
//  WeatherDailyViewCell.swift
//  NZAirQuality
//
//  Created by Liguo Jiao on 28/07/17.
//  Copyright © 2017 Liguo Jiao. All rights reserved.
//

import UIKit

class WeatherDailyViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    @IBOutlet weak var infoDisplayCollectionView: UICollectionView!
    var weatherData: Weather?
    override func awakeFromNib() {
        super.awakeFromNib()
        infoDisplayCollectionView.delegate = self
        infoDisplayCollectionView.dataSource = self
        infoDisplayCollectionView.backgroundColor = NZABackgroundColor
        self.selectionStyle = .none
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherData?.data.channel.item?.forecast?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "infoCell", for: indexPath) as? WeatherDailyInfoCollectionViewCell else {
            return UICollectionViewCell()
        }
        if let yahooConditionCode = weatherData?.data.channel.item?.forecast?[indexPath.row].code,
            let iconName = XML.iconByName(name: "wi_yahoo_\(yahooConditionCode)") {
            cell.statuImage.text = String(utf8String: "\(iconName)")
        }
        cell.backgroundColor = NZABackgroundColor
        cell.day.text = weatherData?.data.channel.item?.forecast?[indexPath.row].day
        
        if let temperatureUnit = (Locale.current as NSLocale).object(forKey: .measurementSystem) {
            print(temperatureUnit)
        }
        cell.highTemp.text = convertToCelsius(input: weatherData?.data.channel.item?.forecast?[indexPath.row].high)
        cell.lowTemp.text = convertToCelsius(input: weatherData?.data.channel.item?.forecast?[indexPath.row].low)
        
        return cell
    }
    private func convertToCelsius(input: String?) -> String? {
        guard let value = input, let temp = Double(value) else {
            return nil
        }
        let decimal = NumberFormatter()
        let formatter = MeasurementFormatter()
        let measurement = Measurement(value: temp, unit: UnitTemperature.fahrenheit)
        decimal.maximumFractionDigits = 1
        formatter.numberFormatter = decimal
        let temperature = formatter.string(from: measurement)
        return temperature
    }
}
