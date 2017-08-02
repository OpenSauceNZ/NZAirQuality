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
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherData?.data.channel.item?.forecast?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "infoCell", for: indexPath) as? WeatherDailyInfoCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.statuImage.image = #imageLiteral(resourceName: "component_Wind")
        cell.backgroundColor = NZABackgroundColor
        cell.day.text = weatherData?.data.channel.item?.forecast?[indexPath.row].day
        return cell
        
    }
}
