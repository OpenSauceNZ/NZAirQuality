//
//  MainViewController.swift
//  NZAirQuality
//
//  Created by Liguo Jiao on 17/07/17.
//  Copyright © 2017 Liguo Jiao. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class AQIViewController: UITableViewController, UISearchBarDelegate, CLLocationManagerDelegate {
    
//    var contentCellHeight: CGFloat = 70
    var searchController: UISearchController!
    var searchResultController = UITableViewController()
    var searchResultList: [MKMapItem]?
    

    var dataProviderDelegate: AQIViewDelegate?
    
    //MARK: Location
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!

    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchController()
        self.tableView.delegate = self.dataProviderDelegate
        self.tableView.dataSource = self.dataProviderDelegate
        self.tableView.backgroundColor = NZABackgroundColor

        self.dataProviderDelegate?.fetchSearchCityData = { [weak self] (city) -> Void in
            self?.fetchAirData(withCityName: city)
        }

        UITabBar.appearance().barTintColor = NZATabBarBackgroundColor
        UITabBar.appearance().tintColor = NZATabBarTintColor

        locManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locManager.delegate = self
            locManager.startUpdatingLocation()
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let locValue = manager.location?.coordinate {
            fetchAirData(withCoordinate: locValue.latitude, long: locValue.longitude)
            print("locations = \(locValue.latitude) \(locValue.longitude)")
        }
    }
}

extension AQIViewController : UISearchResultsUpdating {
    fileprivate func setSearchController() {
        self.dataProviderDelegate = AQIViewDelegate(searchResultVC: searchResultController)

        searchResultController.tableView.delegate = self.dataProviderDelegate
        searchResultController.tableView.dataSource = self.dataProviderDelegate
        searchResultController.tableView.backgroundColor = NZABackgroundColor
//        self.dataProviderDelegate?.searchResultController = self.searchResultController

        self.dataProviderDelegate?.searchController = UISearchController(searchResultsController: searchResultController)
        self.dataProviderDelegate?.searchController?.searchResultsUpdater = self
        self.dataProviderDelegate?.searchController?.searchBar.searchBarStyle = UISearchBar.Style.prominent
        self.dataProviderDelegate?.searchController?.searchBar.backgroundImage = UIImage()
        self.dataProviderDelegate?.searchController?.searchBar.barTintColor = NZABackgroundColor
        self.dataProviderDelegate?.searchController?.searchBar.tintColor = NZATabBarTintColor

        let adjustForTabbarInsets: UIEdgeInsets = UIEdgeInsets.init(top: 20, left: 0, bottom: self.tabBarController?.tabBar.frame.height ?? 0, right: 0) // 20 for search bar
        self.tableView.contentInset = adjustForTabbarInsets
        self.tableView.scrollIndicatorInsets = adjustForTabbarInsets
        self.tableView.tableHeaderView = self.dataProviderDelegate?.searchController?.searchBar

    }
    
    internal func updateSearchResults(for searchController: UISearchController) {
//        var localRegion: MKCoordinateRegion?
//        let distance: CLLocationDistance = 1200
//        let currentLocation = CLLocationCoordinate2D.init(latitude: 50.412165, longitude: -104.66087)
//        localRegion = MKCoordinateRegionMakeWithDistance(currentLocation, distance, distance)
        guard let searchBarText = searchController.searchBar.text else {
            return
        }
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchBarText
//        request.region = localRegion!
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.dataProviderDelegate?.searchResultList = response.mapItems
//            self.matchingItems = response.mapItems
            self.dataProviderDelegate?.searchResultController.tableView.reloadData()
        }
    }
}

// MARKS: Data Fetching/Updating

extension AQIViewController {
    fileprivate func fetchAirData(withCoordinate lat: Double, long: Double) {
        AirAPI.shared.getAirIndexDetailsByGeolocation(latitude: lat, longitude: long, completed: { (airData, error) in
            DispatchQueue.main.async {
                self.dataProviderDelegate?.currentAirData = airData
                self.tableView.reloadData()
                self.locManager.stopUpdatingLocation()
            }
        })
    }
    fileprivate func fetchAirData(withCityName city: String) {
        AirAPI.shared.getAirIndexDetailsByCityName(cityName: city) { (airData, error) in
            DispatchQueue.main.async {
                self.dataProviderDelegate?.currentAirData = airData
                self.tableView.reloadData()
                self.locManager.stopUpdatingLocation()
            }
        }
    }
}

