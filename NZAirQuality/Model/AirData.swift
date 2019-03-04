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
    let aqi: Int?
    let city: City?
    let variousIndex: VariousIndex?
    let timeInfo: TimeInfo?
    
    private enum CodingKeys : String, CodingKey {
        case aqi,city
        case timeInfo = "time"
        case variousIndex = "iaqi"
    }
}
// MARK: ---VariousIndex---
struct VariousIndex: Decodable {
    let humidity: Index?
    let no2: Index?
    let presure: Index?
    let pm10: Index?
    let pm25: Index? //PM2.5
    let temp: Index?
    let wind: Index?
    let co: Index?
    let o3: Index?
    let so2: Index?
    var arrayOfIndex: [String: Index?] {
        return ["Humidity": humidity,
                "NO_2": no2,
                "Presure": presure,
                "PM_10": pm10,
                "PM_2.5": pm25,
                "Temp": temp,
                "Wind": wind,
                "CO": co,
                "O_3": o3,
                "SO_2": so2
        ]
    }
    private enum CodingKeys : String, CodingKey {
        case humidity = "h"
        case presure = "p"
        case temp = "t"
        case wind = "w"
        case no2,pm10,pm25,co,o3,so2
    }
}
struct Index: Decodable {
    let index:Float
    private enum CodingKeys: String, CodingKey {
        case index = "v"
    }
}


// MARK: ---TimeInfo---
struct TimeInfo: Decodable {
    let time: String?
    let timestamp: Double?
    private enum CodingKeys: String, CodingKey {
        case time = "s"
        case timestamp = "v"
    }
}
// MARK: ---City---
struct City: Decodable {
    let geo: [Float]?
    let name: String?
    //let url: String?   This part doesnt need for this version
}
