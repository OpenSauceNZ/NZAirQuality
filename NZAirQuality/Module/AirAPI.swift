//
//  API.swift
//  NZAirQuality
//
//  Created by Liguo Jiao on 5/07/17.
//  Copyright © 2017 Liguo Jiao. All rights reserved.
//

import Foundation

private let shareInstance = AirAPI()
private let server = "https://api.waqi.info"
private let token = "3ac5f237074a1b6b37ee24548b965a807862d89c"


class AirAPI: NSObject {
    class var shared: AirAPI  {
        return shareInstance
    }
    func getAirIndexDetailsByCityName(cityName:String, completed: @escaping (_ airData:AirData?, _ error: Error?)->()) {
        guard let serverUrl = URL(string: "\(server)/feed/\(cityName)/?token=\(token)") else {
            return
        }
        URLSession.shared.dataTask(with: serverUrl) { (data, response, err) in
            guard let newData = data else {
                completed(nil, err)
                return
            }
            do {
                let airData = try JSONDecoder().decode(AirData.self, from: newData)
                print(airData)
                completed(airData, nil)
            } catch let newError {
                completed(nil, newError)
            }
        }.resume()
    }
    
}
