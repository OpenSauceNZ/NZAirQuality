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
 
 Yahoo weather atm
*/

private let shareInstance = WeatherAPI()

class WeatherAPI: NSObject {
    class var shared: WeatherAPI  {
        return shareInstance
    }
    
    func requestWeatherInfo(location: String, completed: ()->()) {
        let newYQL = YQL()
        let queryString = "select * from weather.forecast where woeid in (select woeid from geo.places(1) where text=\"\(location)\")"
        newYQL.query(queryString) { jsonDict in
            // With the resulting jsonDict, pull values out
            // jsonDict["query"] results in an Any? object
            // to extract data, cast to a new dictionary (or other data type)
            // repeat this process to pull out more specific information
            let queryDict = jsonDict["query"] as! [String: Any]
//            print(queryDict)
            print(jsonDict)
//            print(queryDict["count"]!)
//            print(queryDict["results"]!)
        }
        RunLoop.main.run()
    }
    
    
    
    //https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22nome%2C%20ak%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys
}
