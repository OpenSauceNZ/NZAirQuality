//
//  API.swift
//  NZAirQuality
//
//  Created by Liguo Jiao on 5/07/17.
//  Copyright © 2017 Liguo Jiao. All rights reserved.
//

import Foundation

private let shareInstance = API()
private let server = ""


class API: NSObject {
    class var shared: API  {
        return shareInstance
    }
    
    
}
