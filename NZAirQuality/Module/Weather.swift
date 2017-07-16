//
//  Weather.swift
//  NZAirQuality
//
//  Created by Liguo Jiao on 10/07/17.
//  Copyright © 2017 Liguo Jiao. All rights reserved.
//

import Foundation

struct Weather: Decodable {
    let count: Int
    let requestCreate: String
    let data: YWData
    
    private enum CodingKeys : String, CodingKey {
        case count
        case requestCreate = "created"
        case data = "results"
    }
}

struct YWData: Decodable {
    let channel: YWChannel
}

struct YWChannel: Decodable {
    let astronomy: YWAstronomy?
    let atmosphere: YWAtmosphere?

    let location: YWLocation?
    let wind: YWWind?
    let units: YWUnit?
    let item: YWItem?
}

struct YWAstronomy: Decodable {
    let sunrise: String?
    let sunset: String?
}

struct YWAtmosphere: Decodable {
    let humidity: String? // In Doc shows it should be Number, not string ¯\_(ツ)_/¯
    let pressure: String? // In the JSON it return string of Int
    let rising: String?
    let visibility: String?  // same as here
}

struct YWLocation: Decodable {
    let city: String?
    let country: String?
    let region: String?
}

struct YWUnit: Decodable {
    let distance: String?
    let pressure: String?
    let speed: String?
    let temperature: String?
}

struct YWWind: Decodable {
    let chill: String?
    let direction: String?
    let speed: String?
}

struct YWItem: Decodable {
    let currentCondition: YWCondition?
    let forecast: [YWCondition]?
}

struct YWCondition: Decodable {
    let code: String?
    let date: String?
    let temp: String?
    let text: String?
    let day: String?
    let high: String?
    let low: String?
}

