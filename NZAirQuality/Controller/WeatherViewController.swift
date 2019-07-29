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
    private var dataSourceProvider: WeatherViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSourceProvider = WeatherViewDelegate(searchVC: self.searchResultController)
        setSearchController()
        //fetchWeatherData(byCityName: "Auckland")
        self.tableView.backgroundColor = NZABackgroundColor
        
        let adjustForTabbarInsets: UIEdgeInsets = UIEdgeInsets.init(top: 20, left: 0, bottom: 0, right: 0) // 20 for search bar
        self.tableView.contentInset = adjustForTabbarInsets
        self.tableView.scrollIndicatorInsets = adjustForTabbarInsets
        self.tableView.tableHeaderView = self.searchController.searchBar
        self.tableView.separatorStyle = .none
        self.tableView.delegate = self.dataSourceProvider
        self.tableView.dataSource = self.dataSourceProvider
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        locManager.requestWhenInUseAuthorization()
//        if CLLocationManager.locationServicesEnabled() {
//            locManager.delegate = self
//            locManager.startUpdatingLocation()
//        }
        self.tableView.reloadData()
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
        guard searchController.searchBar.text != nil else {
            return
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let locValue = manager.location?.coordinate {
            fetchWeatherData(byCityName: "(\(locValue.latitude),\(locValue.longitude))")
        }
    }
    
    fileprivate func setSearchController() {
        searchResultController.tableView.delegate = self.dataSourceProvider
        searchResultController.tableView.dataSource = self.dataSourceProvider
        searchResultController.tableView.backgroundColor = NZABackgroundColor
        searchController = UISearchController(searchResultsController: searchResultController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchController.searchBar.backgroundImage = UIImage()
        searchController.searchBar.barTintColor = NZABackgroundColor
        searchController.searchBar.tintColor = NZATabBarTintColor

    }
    // MARK: - Table view data source
    
    
    
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
