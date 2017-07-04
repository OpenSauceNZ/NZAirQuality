//
//  AirData.swift
//  NZAirQuality
//
//  Created by Liguo Jiao on 5/07/17.
//  Copyright © 2017 Liguo Jiao. All rights reserved.
//

import Foundation
private let shareInstance = AirData()

class AirData: NSObject {
    class var shared: AirData  {
        return shareInstance
    }
    
    
}
