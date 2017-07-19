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
    
    var numberOfItems = 6
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentCollectionView.delegate = self
        contentCollectionView.dataSource = self
        contentCollectionView.backgroundColor = UIColor.clear
        self.backgroundColor = NZABackgroundColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "indexCell", for: indexPath) as? AQIContentCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.contentImage.image = UIImage(named: "component_\(indexPath.row + 1)")
        
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
    
}



