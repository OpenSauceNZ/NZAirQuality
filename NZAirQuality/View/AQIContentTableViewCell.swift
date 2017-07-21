//
//  AQIContentTableViewCell.swift
//  NZAirQuality
//
//  Created by Liguo Jiao on 19/07/17.
//  Copyright © 2017 Liguo Jiao. All rights reserved.
//

import UIKit
enum CollectionViewContentPosition {
    case Left
    case Center
}

class AQIContentTableViewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var contentCollectionView: UICollectionView!
    var collectionViewContentPosition: CollectionViewContentPosition = .Left
    var numberOfItems = 0
    
    var airData: AirData?
    private var airDataFormatArray: [String: Index?]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentCollectionView.delegate = self
        contentCollectionView.dataSource = self
        contentCollectionView.backgroundColor = UIColor.clear
        self.backgroundColor = NZABackgroundColor
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let variousIndex = airData?.data.variousIndex {
            airDataFormatArray = AQIContentTableViewCell.formatAirData(newData: variousIndex)
        }
        numberOfItems = airDataFormatArray?.count ?? 0
        return numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "indexCell", for: indexPath) as? AQIContentCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.contentTitleLabel.text = ""
        
        if let indexKeys = airDataFormatArray?.keys, let indexValue = airDataFormatArray?.values {
            let nameList = Array(indexKeys)
            let valueList = Array(indexValue)
            let value = Int(round(valueList[indexPath.row]?.index ?? 0.0))
            cell.contentImage.image = UIImage(named: "component_\(nameList[indexPath.row])")
            cell.contentTitleLabel.text = "\(nameList[indexPath.row].replacingOccurrences(of: "_", with: " "))"
            cell.contentSubtitleLabel.text = "Current: \(value)"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let cellCount = CGFloat(collectionView.numberOfItems(inSection: 0))
        //If the cell count is zero, there is no point in calculating anything.
        if cellCount > 0 {
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            let cellWidth = flowLayout.itemSize.width + flowLayout.minimumInteritemSpacing

            //20.00 was just extra spacing I wanted to add to my cell.
            let totalCellWidth = cellWidth * cellCount + 20.00 * (cellCount - 1)
            let contentWidth = collectionView.frame.size.width - collectionView.contentInset.left - collectionView.contentInset.right
            if (totalCellWidth < contentWidth) {
                let padding = (contentWidth - totalCellWidth) / 2.0
                return UIEdgeInsetsMake(0, padding, 0, padding)
            } else {
                return UIEdgeInsetsMake(0, 40, 0, 40)
            }
        }
        return UIEdgeInsets.zero
    }
    
    static func formatAirData(newData: VariousIndex) -> [String: Index?] {
        var new = newData.arrayOfIndex
        for each in newData.arrayOfIndex {
            if each.value?.index == 0.0 || each.value?.index == nil {
                new.removeValue(forKey: "\(each.key)")
            }
        }
        return new
    }
    
    static func contentItems(count data: VariousIndex?) -> CGFloat {
        if let newData = data {
            var new = formatAirData(newData: newData)
            return CGFloat((round(Double(new.count) / 2.0) * 70) + 20)
        }
        return 0
    }
    
}



