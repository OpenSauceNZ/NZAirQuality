//
//  Style.swift
//  NZAirQuality
//
//  Created by Liguo Jiao on 17/07/17.
//  Copyright © 2017 Liguo Jiao. All rights reserved.
//

import Foundation
import UIKit

let NZABackgroundColor = UIColor(rgb: 0x141212)
let NZANavBarColor = UIColor(rgb: 0xFFFFFF).withAlphaComponent(0.07)
let NZATabBarBackgroundColor = UIColor(rgb: 0x1B1B1B)
let NZATabBarTintColor = UIColor(rgb: 0xBB490B)
let NZAYellow = UIColor(rgb: 0xFFBA00)
let NZAPurple = UIColor(rgb: 0x5D3F86)


let NZATitleColor = UIColor(rgb: 0x9BDCFF)
let NZASubTitleColor = UIColor.white

let NZASectionTitle = UIColor(rgb: 0xA8CEFF)

let NZADetailsTitleColor = UIColor(rgb: 0xE3EFFF)
let NZADetailsSubTitleColor = UIColor(rgb: 0xA8CEFF)
let NZATintColor = UIColor(rgb: 0xB3470C)



extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}


