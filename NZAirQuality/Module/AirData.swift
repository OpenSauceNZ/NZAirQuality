//
//  AirData.swift
//  NZAirQuality
//
//  Created by Liguo Jiao on 5/07/17.
//  Copyright © 2017 Liguo Jiao. All rights reserved.
//

import Foundation
import UIKit

struct AirData: Decodable {
    let status: String
    let data: Details
}

struct Details: Decodable {
    let aqi: String?
    let city: City?
    let variousIndex: VariousIndex?
    
    private enum CodingKeys : String, CodingKey {
        case aqi,city
        case variousIndex = "iaqi"
    }
}

struct VariousIndex: Decodable {
    let humidity: String?
    let no2: String?
    
    
    private enum CodingKeys : String, CodingKey {
        case humidity = ""
        case no2
    }
}

struct City: Decodable {
    let geo: String?
    let name: String?
    //let url: String?   This part doesnt need for this version
}
