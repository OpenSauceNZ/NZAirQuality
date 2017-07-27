//
//  WeatherViewController.swift
//  NZAirQuality
//
//  Created by Liguo Jiao on 17/07/17.
//  Copyright © 2017 Liguo Jiao. All rights reserved.
//

import UIKit

class WeatherViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = NZABackgroundColor
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "WHeaderCell", for: indexPath) as? WeatherHeaderViewCell {
            return cell
        } else {
            return UITableViewCell()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
}
