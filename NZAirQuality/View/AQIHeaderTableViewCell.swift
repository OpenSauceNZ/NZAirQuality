//
//  AQIHeaderTableViewCell.swift
//  NZAirQuality
//
//  Created by Liguo Jiao on 17/07/17.
//  Copyright © 2017 Liguo Jiao. All rights reserved.
//

import UIKit

class AQIHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    var statusIndex = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = NZABackgroundColor
        headerTitle.textColor = NZATitleColor
        headerTitle.text = "Beijing"
        statusImage.image = #imageLiteral(resourceName: "AQI-Good")
        statusImage.image = generateImageWithText(text: "hello", on: statusImage)
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func generateImageWithText(text: String, on imageView: UIImageView) -> UIImage {
        
        let imageView = imageView
        imageView.backgroundColor = UIColor.clear
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: (imageView.layer.bounds.width), height: (imageView.layer.bounds.height)))
        
        label.backgroundColor = UIColor.clear
        
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.text = text
        label.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        
        
        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0);
        imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        label.layer.render(in: UIGraphicsGetCurrentContext()!)
        let imageWithText = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        return imageWithText!
    }

}
