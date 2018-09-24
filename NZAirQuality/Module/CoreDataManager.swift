//
//  CoreDataManager.swift
//  NZAirQuality
//
//  Created by Liguo Jiao on 20/07/17.
//  Copyright © 2017 Liguo Jiao. All rights reserved.
//

import UIKit
import CoreData

struct country {
    var name: String?
    var city: String?
    
    init() {
        name = ""
        city = ""
    }
    
    init(name: String, city: String) {
        self.name = name
        self.city = city
    }
}

class CoreDataManager: NSObject {
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    ///store obj into core data
    class func storeObj(name: String, city: String) {
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Country", in: context)
        let managedObj = NSManagedObject(entity: entity!, insertInto: context)
        
        managedObj.setValue(name, forKey: "name")
        managedObj.setValue(city, forKey: "city")
        
        do {
            try context.save()
            print("saved!")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    ///fetch all the objects from core data
    class func fetchObj(selectedScopeIdx: Int? = nil,targetText: String? = nil) -> [country] {
        var aray = [country]()
        let fetchRequest:NSFetchRequest<Country> = Country.fetchRequest()
        
        if selectedScopeIdx != nil && targetText != nil{
            var filterKeyword = ""
            switch selectedScopeIdx! {
            case 0:
                filterKeyword = "name"
            default:
                filterKeyword = "city"
            }
            let predicate = NSPredicate(format: "\(filterKeyword) contains[c] %@", targetText!)
            fetchRequest.predicate = predicate
        }
        
        do {
            let fetchResult = try getContext().fetch(fetchRequest)
            for item in fetchResult {
                let newCountry = country(name: item.name ?? "", city: item.city ?? "")
                aray.append(newCountry)
                print("\(String(describing: newCountry.city)) \(String(describing: newCountry.name))")
            }
        } catch {
            print(error.localizedDescription)
        }
        
        return aray
    }
    
    ///delete all the data in core data
    class func cleanCoreData() {
        let fetchRequest:NSFetchRequest<Country> = Country.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest as! NSFetchRequest<NSFetchRequestResult>)
        
        do {
            print("deleting all contents")
            try getContext().execute(deleteRequest)
        }catch {
            print(error.localizedDescription)
        }
        
    }
}
