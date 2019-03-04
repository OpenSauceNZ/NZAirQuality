//
//  LocationServices.swift
//  NZAirQuality
//
//  Created by Liguo Jiao on 21/07/17.
//  Copyright © 2017 Liguo Jiao. All rights reserved.
//

import Foundation
import CoreLocation

class Location: NSObject, CLLocationManagerDelegate {
    enum Result <T> {
        case Success(T)
        case Failure(Error)
    }
    
    
    static let shared: Location = Location()
    
    typealias Callback = (Result<Location>) -> Void
    
    var requests: Array <Callback> = Array <Callback>()
    
    var location: CLLocation? { return sharedLocationManager.location  }
    
    lazy var sharedLocationManager: CLLocationManager = {
        let newLocationmanager = CLLocationManager()
        newLocationmanager.delegate = self
        return newLocationmanager
    }()
    
    // MARK: - Authorization
    
    class func authorize() { shared.authorize() }
    func authorize() { sharedLocationManager.requestWhenInUseAuthorization() }
    
    // MARK: - Helpers
    
    func locate(callback: @escaping Callback) {
        self.requests.append(callback)
        sharedLocationManager.startUpdatingLocation()
    }
    
    func reset() {
        self.requests = Array <Callback>()
        sharedLocationManager.stopUpdatingLocation()
    }
    
    // MARK: - Delegate
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        for request in self.requests { request(.Failure(error)) }
        self.reset()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: Array <CLLocation>) {
        for request in self.requests { request(.Success(self)) }
        self.reset()
    }
}
