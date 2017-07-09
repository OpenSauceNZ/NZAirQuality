//
//  WeatherAPI.swift
//  NZAirQuality
//
//  Created by Liguo Jiao on 10/07/17.
//  Copyright © 2017 Liguo Jiao. All rights reserved.
//

import Foundation
import UIKit

/*
 Weather Server API will using different server in different region.
 The propuse of this is that local weather server provider usually provide
 more accurate data than worldwide server data.
 
 NZ/US/AU: MetService/Google weather?
 CN: pending... Couldnt find any perfect API providr atm ¯\_(ツ)_/¯
 JP: Yahoo JP?
*/

private let shareInstance = WeatherAPI()

class WeatherAPI: NSObject {
    class var shared: WeatherAPI  {
        return shareInstance
    }
    
}
