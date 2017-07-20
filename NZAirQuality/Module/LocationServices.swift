//
//  LocationServices.swift
//  NZAirQuality
//
//  Created by Liguo Jiao on 21/07/17.
//  Copyright © 2017 Liguo Jiao. All rights reserved.
//

import Foundation
import MapKit

typealias JSONDictionary = [String:Any]

class LocationServices {
    
    let shared = LocationServices()
    let locManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    let authStatus = CLLocationManager.authorizationStatus()
    let inUse = CLAuthorizationStatus.authorizedWhenInUse
    let always = CLAuthorizationStatus.authorizedAlways
    
    func getAdress(completion: @escaping (_ address: JSONDictionary?, _ error: Error?) -> ()) {
        switch self.authStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            self.currentLocation = locManager.location
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(self.currentLocation) { placemarks, error in
                
                if let e = error {
                    completion(nil, e)
                } else {
                    guard let placeArray = placemarks else {
                        return
                    }
                    var placeMark: CLPlacemark!
                    placeMark = placeArray[0]
                    guard let address = placeMark.addressDictionary as? JSONDictionary else {
                        return
                    }
                    completion(address, nil)
                }
            }
        default:
            self.locManager.requestWhenInUseAuthorization()
        }
    }
}
