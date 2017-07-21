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

class AQIViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate, ScrollableGraphViewDataSource {
    
    var contentCellHeight: CGFloat = 70
    var searchController: UISearchController!
    var searchResultController = UITableViewController()
    
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
        fetchAirData()
        searchController = UISearchController(searchResultsController: searchResultController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.searchBarStyle = UISearchBarStyle.prominent
        searchController.searchBar.backgroundImage = UIImage()
        searchController.searchBar.barTintColor = NZABackgroundColor
        searchController.searchBar.tintColor = NZATabBarTintColor
        searchResultController.tableView.backgroundColor = NZABackgroundColor
        self.tableView.tableHeaderView = self.searchController.searchBar
    }
    
    func updateSearchResults(for searchController: UISearchController) {

    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
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
        switch indexPath.section {
        case 0:
            return 135
        case 1:
            return
            
        default:
            return 300
        }
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as? AQIHeaderTableViewCell {
                if let airIndex = currentAirData?.data.aqi {
                    cell.headerTitle.text = currentAirData?.data.city?.name
                    cell.statusImage.image = cell.generateImageWithText(text: "AQI \r\n \(airIndex)", on: cell.statusImage)
                }
                return cell
            } else {
                return UITableViewCell()
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AQIContentCell", for: indexPath) as? AQIContentTableViewCell {
                cell.airData = currentAirData
                contentCellHeight = CGFloat((round(Double(cell.numberOfItems) / 2.0) * 70) + 20)
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
}

// MARKS: Location service

extension AQIViewController {
    func fetchAirData() {
        getLocation()
        let lat = Float(currentLocation.coordinate.latitude)
        let long = Float(currentLocation.coordinate.longitude)
        AirAPI.shared.getAirIndexDetailsByGeolocation(latitude: lat, longitude: long, completed: { (airData, error) in
            self.currentAirData = airData
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    func getLocation() {
        locManager.requestWhenInUseAuthorization()
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            currentLocation = locManager.location
            print(currentLocation.coordinate.latitude)
            print(currentLocation.coordinate.longitude)
        default: break
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
