//
//  MainViewController.swift
//  NZAirQuality
//
//  Created by Liguo Jiao on 17/07/17.
//  Copyright © 2017 Liguo Jiao. All rights reserved.
//

import UIKit
import ScrollableGraphView
import CoreLocation
import MapKit

class AQIViewController: UITableViewController, UISearchBarDelegate, CLLocationManagerDelegate, ScrollableGraphViewDataSource {
    
    var contentCellHeight: CGFloat = 70
    var searchController: UISearchController!
    var searchResultController = UITableViewController()
    var searchResultList: [MKMapItem]?
    var currentAirData: AirData?
    
    //MARK: Location
    var locManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    //MARK: Extension variables -- ScrollableGraphViewDataSource
    var numberOfItems = 30
    lazy var plotOneData: [Double] = self.generateRandomData(self.numberOfItems, max: 100, shouldIncludeOutliers: true)
    lazy var plotTwoData: [Double] = self.generateRandomData(self.numberOfItems, max: 80, shouldIncludeOutliers: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = NZABackgroundColor
        UITabBar.appearance().barTintColor = NZATabBarBackgroundColor
        UITabBar.appearance().tintColor = NZATabBarTintColor
        
        setSearchController()
        
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
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == searchResultController.tableView {
            return 1
        } else {
            return 3
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == searchResultController.tableView {
            return searchResultList?.count ?? 0
        } else {
            return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "Until \(Date())"
        case 2:
            return "In last 72 hours"
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "HelveticaNeue", size: 13)
        header.textLabel?.textColor = NZASectionTitle
        header.backgroundView?.backgroundColor = UIColor.clear
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == searchResultController.tableView {
            return 45
        } else {
            switch indexPath.section {
            case 0:
                return 135
            case 1:
                return AQIContentTableViewCell.contentItems(count: currentAirData?.data.variousIndex)
            default:
                return 300
            }
        }
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == searchResultController.tableView {
            if let city = searchResultList?[indexPath.row].placemark.addressDictionary?["City"] as? String {
                fetchAirData(withCityName: city)
                searchController.isActive = false
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == searchResultController.tableView,
            let city = searchResultList?[indexPath.row].placemark.addressDictionary?["City"] as? String,
            let country = searchResultList?[indexPath.row].placemark.addressDictionary?["Country"] as? String {
                let cell = UITableViewCell()
                cell.textLabel?.text = "\(city), \(country)"
                cell.backgroundColor = UIColor.clear
                cell.textLabel?.textColor = UIColor.white
                return cell
        }
        switch indexPath.section {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as? AQIHeaderTableViewCell,
                let airIndex = currentAirData?.data.aqi {
                cell.headerTitle.text = currentAirData?.data.city?.name
                cell.statusImage.image = cell.generateImageWithText(text: "AQI \r\n \(airIndex)", on: cell.statusImage)
                return cell
            } else {
                return UITableViewCell()
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AQIContentCell", for: indexPath) as? AQIContentTableViewCell {
                cell.airData = currentAirData
                cell.contentCollectionView.reloadData()
                return cell
            } else {
                return UITableViewCell()
            }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "GraphicCell", for: indexPath) as? AQIGraphicTableViewCell {
                cell.graphView.dataSource = self
                cell.graphView.delegate = self
                return cell
            } else {
                return UITableViewCell()
            }
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
    func setSearchController() {
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
    
    func updateSearchResults(for searchController: UISearchController) {
        var localRegion: MKCoordinateRegion?
//        let distance: CLLocationDistance = 1200
//        let currentLocation = CLLocationCoordinate2D.init(latitude: 50.412165, longitude: -104.66087)
//        localRegion = MKCoordinateRegionMakeWithDistance(currentLocation, distance, distance)
        guard let searchBarText = searchController.searchBar.text else {
            return
        }
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = searchBarText
//        request.region = localRegion!
        let search = MKLocalSearch(request: request)
        search.start { response, _ in
            guard let response = response else {
                return
            }
            self.searchResultList = response.mapItems
            //self.matchingItems = response.mapItems
            self.searchResultController.tableView.reloadData()
        }
    }
}


// MARKS: Data Fetching/Updating

extension AQIViewController {
    func fetchAirData(withCoordinate lat: Double, long: Double) {
        AirAPI.shared.getAirIndexDetailsByGeolocation(latitude: lat, longitude: long, completed: { (airData, error) in
            self.currentAirData = airData
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.locManager.stopUpdatingLocation()
            }
        })
    }
    func fetchAirData(withCityName city: String) {
        AirAPI.shared.getAirIndexDetailsByCityName(cityName: city) { (airData, error) in
            self.currentAirData = airData
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.locManager.stopUpdatingLocation()
            }
        }
    }
}

// MARKS: ScrollableGraphViewDataSource

extension AQIViewController {
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        switch(plot.identifier) {
        case "multiBlue", "multiBlueDot":
            return plotOneData[pointIndex]
        case "multiOrange", "multiOrangeSquare":
            return plotTwoData[pointIndex]
        default:
            return 0
        }
    }
    
    func label(atIndex pointIndex: Int) -> String {
        return "FEB \(pointIndex)"
    }
    
    func numberOfPoints() -> Int {
        return numberOfItems
    }
    
    private func generateRandomData(_ numberOfItems: Int, max: Double, shouldIncludeOutliers: Bool = true) -> [Double] {
        var data = [Double]()
        for _ in 0 ..< numberOfItems {
            var randomNumber = Double(arc4random()).truncatingRemainder(dividingBy: max)
            
            if(shouldIncludeOutliers) {
                if(arc4random() % 100 < 10) {
                    randomNumber *= 3
                }
            }
            
            data.append(randomNumber)
        }
        return data
    }
}
