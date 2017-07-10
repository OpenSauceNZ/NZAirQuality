//
//  ViewController.swift
//  NZAirQuality
//
//  Created by Liguo Jiao on 5/07/17.
//  Copyright © 2017 Liguo Jiao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        AirAPI.shared.getAirIndexDetailsByCityName(cityName: "auckland") { (airData, err) in
            if err == nil {
                print(airData?.data.aqi)
            } else {
                print(err?.localizedDescription)
            }
            
        }
    }
    

}

