
//
//  WeatherViewDelegate.swift
//  NZAirQuality
//
//  Created by Liguo Jiao on 29/07/19.
//  Copyright © 2019 Liguo Jiao. All rights reserved.
//

import UIKit


class WeatherViewDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    var searchResultController: UITableViewController
    var currentWeather: Weather?

    init(searchVC: UITableViewController) {
        self.searchResultController = searchVC
        super.init()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        let haha = CAKeyframeAnimation(keyPath: "dss")
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == searchResultController.tableView {
            let cell = UITableViewCell()
            //            searchResultCellSetup(indexPath, cell)
            return cell
        }
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "WHeaderCell", for: indexPath) as? WeatherHeaderViewCell {
                cell.weatherData = currentWeather
                cell.loadContent()
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "WDailyCell", for: indexPath) as? WeatherDailyViewCell {
                cell.backgroundColor = NZAGreen
                cell.weatherData = currentWeather
                cell.infoDisplayCollectionView.reloadData()
                //                let view = UIView(frame: CGRect(x: 0, y: 0, width: cell.frame.width, height: cell.frame.height))
                //                let gradient = CAGradientLayer()
                //
                //                gradient.frame = view.bounds
                //                gradient.colors = [NZAGreen.cgColor, UIColor(rgb: 0x79C9BB).cgColor, UIColor(rgb: 0xAFDFD7).cgColor, NZAWhite.cgColor]
                //                cell.layer.insertSublayer(gradient, at: 0)
                return cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: "WDetailsCell", for: indexPath) as? WeatherDetailsTableViewCell {
                cell.backgroundColor = NZAGreen
                cell.weatherData = currentWeather
                cell.loadContent()
                return cell
            }

        default:
            return UITableViewCell() //assert error
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 230
        case 1:
            return 150
        case 2:
            return 229
        default:
            return 45
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}
