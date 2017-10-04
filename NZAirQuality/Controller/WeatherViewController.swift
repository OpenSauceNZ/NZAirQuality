//
//  WeatherViewController.swift
//  NZAirQuality
//
//  Created by Liguo Jiao on 17/07/17.
//  Copyright © 2017 Liguo Jiao. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UITableViewController, UISearchResultsUpdating, CLLocationManagerDelegate {
    var currentWeather: Weather?
    var searchController: UISearchController!
    var searchResultController = UITableViewController()
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchController()
        //fetchWeatherData(byCityName: "Auckland")
        self.tableView.backgroundColor = NZABackgroundColor
        
        let adjustForTabbarInsets: UIEdgeInsets = UIEdgeInsetsMake(20, 0, self.tabBarController?.tabBar.frame.height ?? 0, 0) // 20 for search bar
        self.tableView.contentInset = adjustForTabbarInsets
        self.tableView.scrollIndicatorInsets = adjustForTabbarInsets
        self.tableView.tableHeaderView = self.searchController.searchBar
        locManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locManager.delegate = self
            locManager.startUpdatingLocation()
        }
    }
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ colorTop, colorBottom]
        gradientLayer.locations = [ 0.0, 1.0]
        gradientLayer.frame = self.tableView.bounds
        
        self.tableView.layer.addSublayer(gradientLayer)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchBarText = searchController.searchBar.text else {
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let locValue = manager.location?.coordinate {
            fetchWeatherData(byCityName: "(\(locValue.latitude),\(locValue.longitude))")
        }
    }
    
    fileprivate func setSearchController() {
        searchResultController.tableView.delegate = self
        searchResultController.tableView.dataSource = self
        searchController = UISearchController(searchResultsController: searchResultController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.searchBarStyle = UISearchBarStyle.prominent
        searchController.searchBar.backgroundImage = UIImage()
        searchController.searchBar.barTintColor = NZABackgroundColor
        searchController.searchBar.tintColor = NZATabBarTintColor
        searchResultController.tableView.backgroundColor = NZABackgroundColor
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == searchResultController.tableView {
            let cell = UITableViewCell()
//            searchResultCellSetup(indexPath, cell)
            return cell
        }
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "WHeaderCell", for: indexPath) as? WeatherHeaderViewCell {
                if let city = currentWeather?.data.channel.location?.city, let _ = currentWeather?.data.channel.location?.country {
                    cell.location.text = "\(city)"
                }
                if let weatherCondition = currentWeather?.data.channel.item?.currentCondition?.text {
                    cell.weatherStatus.text = weatherCondition
                }
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "WDailyCell", for: indexPath) as? WeatherDailyViewCell {
                cell.backgroundColor = NZABackgroundColor
                cell.weatherData = currentWeather
                cell.infoDisplayCollectionView.reloadData()
                return cell
            }
            
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 230
        case 1:
            return 270
        default:
            return 45
        }
    }
    
    
    func fetchWeatherData(byCityName name: String) {
        WeatherAPI.shared.requestWeatherInfo(location: name) { (weather, error) in
            guard let currentData = weather else {
                // TODO: Error handling
                return
            }
            self.currentWeather = currentData
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

