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
    
    func requestWeatherInfo(location: String, completed: @escaping (_ weatherData: Weather?, _ error: Error?)->()) {
        let newYQL = YQL()
        let queryString = "select * from weather.forecast where woeid in (select woeid from geo.places(1) where text=\"\(location)\")"
        newYQL.query(queryString) { jsonDict in
            let queryDict = jsonDict["query"]
            let data = try! JSONSerialization.data(withJSONObject: queryDict, options: .prettyPrinted)
            
            do {
                let weatherData = try JSONDecoder().decode(Weather.self, from: data)
                
                completed(weatherData, nil)
            } catch let newError {
                completed(nil, newError)
            }
//            print(queryDict)
//            print(queryDict["count"]!)
//            print(queryDict["results"]!)
        }
        RunLoop.main.run()
    }
}
