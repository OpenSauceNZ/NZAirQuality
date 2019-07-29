//
//  AQIViewDelegate.swift
//  NZAirQuality
//
//  Created by Liguo Jiao on 29/07/19.
//  Copyright © 2019 Liguo Jiao. All rights reserved.
//

import UIKit
import MapKit
import ScrollableGraphView

class AQIViewDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    var searchController: UISearchController?
    let searchResultController: UITableViewController
    var searchResultList: [MKMapItem]?
    var currentAirData: AirData?

    var fetchSearchCityData: ((_ cityName: String) -> Void)!

    //MARK: Extension variables -- ScrollableGraphViewDataSource
    var numberOfItems = 30

    //MARK: ScrollableGraphViewDataSource
//    var plotOneData: [Double]
//    var plotTwoData: [Double]

    init(searchResultVC: UITableViewController) {
//        self.searchController = searchVC
        self.searchResultController = searchResultVC
        super.init()

    }
    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == searchResultController.tableView {
            return 1
        } else {
            return 3
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == searchResultController.tableView {
            return searchResultList?.count ?? 0
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "Until \(Date())"
        case 2:
            return "In last 72 hours"
        default:
            return ""
        }
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "HelveticaNeue", size: 13)
        header.textLabel?.textColor = NZASectionTitle
        header.backgroundView?.backgroundColor = UIColor.clear
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == searchResultController.tableView {
            if let city = searchResultList?[indexPath.row].placemark.addressDictionary?["City"] as? String {
                fetchSearchCityData(city)
                searchController?.isActive = false
            }
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == searchResultController.tableView {
            let cell = UITableViewCell()
            searchResultCellSetup(indexPath, cell)
            return cell
        }
        switch indexPath.section {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as? AQIHeaderTableViewCell {
                headerCellSetup(cell)
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "AQIContentCell", for: indexPath) as? AQIContentTableViewCell {
                cell.airData = currentAirData
                cell.contentCollectionView.reloadData()
                return cell
            }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "GraphicCell", for: indexPath) as? AQIGraphicTableViewCell {
                cell.graphView.dataSource = self
                cell.graphView.delegate = self
                return cell
            }
        }
        return UITableViewCell()
    }

    fileprivate func searchResultCellSetup(_ indexPath: IndexPath, _ cell: UITableViewCell) {
        if let city = searchResultList?[indexPath.row].placemark.addressDictionary?["City"] as? String,
            let country = searchResultList?[indexPath.row].placemark.addressDictionary?["Country"] as? String {
            cell.textLabel?.text = "\(city), \(country)"
            cell.backgroundColor = UIColor.clear
            cell.textLabel?.textColor = UIColor.white
        }
    }

    fileprivate func headerCellSetup(_ cell: AQIHeaderTableViewCell) {
        if let airIndex = currentAirData?.data.aqi {
            cell.headerTitle.text = currentAirData?.data.city?.name
            if airIndex < 75 { // Good air quality
                cell.statusImage.image = cell.generateImageWithText(text: "AQI \r\n \(airIndex)", with: #imageLiteral(resourceName: "AQI-Good"), on: cell.statusImage)
            } else if airIndex < 200 {
                cell.statusImage.image = cell.generateImageWithText(text: "AQI \r\n \(airIndex)", with: #imageLiteral(resourceName: "AQI-Medium"), on: cell.statusImage)
            } else {
                cell.statusImage.image = cell.generateImageWithText(text: "AQI \r\n \(airIndex)", with: #imageLiteral(resourceName: "AQI-Bad"), on: cell.statusImage)
            }
        }
    }


}

extension AQIViewDelegate: ScrollableGraphViewDataSource {
    // MARKS: ScrollableGraphViewDataSource
    func value(forPlot plot: Plot, atIndex pointIndex: Int) -> Double {
        let plotOneData = self.generateRandomData(numberOfItems, max: 100, shouldIncludeOutliers: true)
        let plotTwoData = self.generateRandomData(numberOfItems, max: 80, shouldIncludeOutliers: false)
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

    fileprivate func generateRandomData(_ numberOfItems: Int, max: Double, shouldIncludeOutliers: Bool = true) -> [Double] {
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
