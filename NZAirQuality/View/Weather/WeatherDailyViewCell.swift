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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        infoDisplayCollectionView.delegate = self
        infoDisplayCollectionView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "infoCell", for: indexPath) as? WeatherDailyInfoCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.statuImage.image = #imageLiteral(resourceName: "component_Wind")
        
        return cell
        
    }
}
