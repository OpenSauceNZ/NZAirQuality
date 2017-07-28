//
//  WeatherViewController.swift
//  NZAirQuality
//
//  Created by Liguo Jiao on 17/07/17.
//  Copyright © 2017 Liguo Jiao. All rights reserved.
//

import UIKit

class WeatherViewController: UITableViewController, UISearchResultsUpdating {
    
    var searchController: UISearchController!
    var searchResultController = UITableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSearchController()
        self.tableView.backgroundColor = NZABackgroundColor
        self.tableView.tableHeaderView = self.searchController.searchBar
        
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
    
//    fileprivate func searchResultCellSetup(_ indexPath: IndexPath, _ cell: UITableViewCell) {
//        if let city = searchResultList?[indexPath.row].placemark.addressDictionary?["City"] as? String,
//            let country = searchResultList?[indexPath.row].placemark.addressDictionary?["Country"] as? String {
//            cell.textLabel?.text = "\(city), \(country)"
//            cell.backgroundColor = UIColor.clear
//            cell.textLabel?.textColor = UIColor.white
//        }
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == searchResultController.tableView {
            let cell = UITableViewCell()
//            searchResultCellSetup(indexPath, cell)
            return cell
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "WHeaderCell", for: indexPath) as? WeatherHeaderViewCell {
                return cell
            } else {
                return UITableViewCell()
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
}
