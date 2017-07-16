//
//  YQL.swift
//  NZAirQuality
//
//  Created by Liguo Jiao on 16/07/17.
//  Copyright © 2017 Liguo Jiao. All rights reserved.
//

import Foundation
public class YQL {
    private class var prefix: String {
        return "http://query.yahooapis.com/v1/public/yql?q="
    }
    
    private class var suffix: String {
        return "&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=";
    }
    
    public func query(_ statement:String, completion: @escaping ([String: Any]) -> Void) {
        let url = URL(string: "\(YQL.prefix)\(statement.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)\(YQL.suffix)")
        
        let task = URLSession.shared.dataTask(with: url!) {
            (data, response, error) in
            if error != nil {
                assertionFailure(error?.localizedDescription ?? "nil")
            } else {
                do {
                    let dataDict = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any]
                    let results:[String: Any] = dataDict!
                    completion(results)
                } catch {
                    assertionFailure(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}
