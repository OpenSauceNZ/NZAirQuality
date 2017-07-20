//
//  MainViewController.swift
//  NZAirQuality
//
//  Created by Liguo Jiao on 17/07/17.
//  Copyright © 2017 Liguo Jiao. All rights reserved.
//

import UIKit
import MapKit

class AQIViewController: UITableViewController, UISearchResultsUpdating {
    
    
    var contentCellHeight: CGFloat = 70
    var searchController: UISearchController!
    var searchResultController = UITableViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = NZABackgroundColor
        UITabBar.appearance().barTintColor = NZATabBarBackgroundColor
        UITabBar.appearance().tintColor = NZATabBarTintColor
        
        self.searchController = UISearchController(searchResultsController: searchResultController)
        self.searchController.searchResultsUpdater = self
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
            return contentCellHeight
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
                return cell
            } else {
                return UITableViewCell()
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AQIContentCell", for: indexPath) as? AQIContentTableViewCell {
                contentCellHeight = CGFloat((round(Double(cell.numberOfItems)/2.0) * 70) + 20)
                return cell
            } else {
                return UITableViewCell()
            }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "GraphicCell", for: indexPath) as? AQIGraphicTableViewCell {
                
                return cell
            } else {
                return UITableViewCell()
            }
        }
    }
}
