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
   // let city: City?
    let variousIndex: VariousIndex?
    let timeInfo: TimeInfo?
    
    private enum CodingKeys : String, CodingKey {
        case aqi//,city
        case timeInfo = "time"
        case variousIndex = "iaqi"
    }
}
//------------------------------------------------------------------
struct VariousIndex: Decodable {
    let humidity: humidity?
    let no2: no2?
    let presure: presure?
    let pm10: pm10?
    let pm25: pm25? //PM2.5
    let temp: temp?
    let wind: wind?
    private enum CodingKeys : String, CodingKey {
        case humidity = "h"
        case presure = "p"
        case temp = "t"
        case wind = "w"
        case no2,pm10,pm25
    }
}

struct humidity: Decodable {
    let index:Float
    private enum CodingKeys: String, CodingKey {
        case index = "v"
    }
}
struct no2: Decodable {
    let index:Float
    private enum CodingKeys: String, CodingKey {
        case index = "v"
    }
}
struct presure: Decodable {
    let index:Float
    private enum CodingKeys: String, CodingKey {
        case index = "v"
    }
}
struct pm10: Decodable {
    let index:Float
    private enum CodingKeys: String, CodingKey {
        case index = "v"
    }
}
struct pm25: Decodable {
    let index:Float
    private enum CodingKeys: String, CodingKey {
        case index = "v"
    }
}
struct temp: Decodable {
    let index:Float
    private enum CodingKeys: String, CodingKey {
        case index = "v"
    }
}

struct wind: Decodable {
    let index:Float
    private enum CodingKeys: String, CodingKey {
        case index = "v"
    }
}
//--------------------------------------------------------------


struct TimeInfo: Decodable {
    let time: String?
    let timestamp: Double?
    private enum CodingKeys: String, CodingKey {
        case time = "s"
        case timestamp = "v"
    }
}

struct City: Decodable {
    let geo: [Float]?
    let name: String?
    //let url: String?   This part doesnt need for this version
}
