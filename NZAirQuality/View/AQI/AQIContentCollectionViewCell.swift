//
//  AQIContentCollectionViewCell.swift
//  NZAirQuality
//
//  Created by Liguo Jiao on 20/07/17.
//  Copyright © 2017 Liguo Jiao. All rights reserved.
//

import UIKit

class AQIContentCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var contentImage: UIImageView!
    @IBOutlet weak var contentTitleLabel: UILabel!
    @IBOutlet weak var contentSubtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        contentTitleLabel.textColor = NZADetailsTitleColor
        contentSubtitleLabel.textColor = NZADetailsSubTitleColor
    }
}
