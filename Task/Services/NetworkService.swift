//
//  NetworkService.swift
//  Task
//
//  Created by Josef on 11.06.2021.
//

import CoreData
import Foundation
import UIKit

private var path: URL = URL(
    string: "https://rawgit.com/NikitaAsabin/799e4502c9fc3e0ea7af439b2dfd88fa/raw/7f5c6c66358501f72fada21e04d75f64474a7888/page1.json")!

class NetworkService {
    public func loadData(dataHandler: @escaping () -> Void) {
        URLSession.shared.dataTask(with: path.absoluteURL) { (data, response, error) -> Void in
            // Check if data was received successfully

            if error == nil && data != nil {
                do {
                    // Convert to dictionary where keys are of type String, and values are of any type
                    let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String: Any]

                    DispatchQueue.main.sync {
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        let context = appDelegate.persistentContainer.viewContext

                        for country in json["countries"]! as! [Any] {
                            let entity = NSEntityDescription.entity(forEntityName: "Country", in: context)
                            let newCountry = NSManagedObject(entity: entity!, insertInto: context)

                            let serverCountryDict = country as! [String: Any]

                            newCountry.setValue(serverCountryDict["capital"], forKey: "capital")
                            newCountry.setValue(serverCountryDict["name"], forKey: "name")
                            newCountry.setValue(serverCountryDict["population"], forKey: "population")
                            newCountry.setValue((serverCountryDict["country_info"] as! [String: Any])["flag"], forKey: "flag")
                            newCountry.setValue(serverCountryDict["continent"], forKey: "continent")
                            newCountry.setValue(serverCountryDict["description"], forKey: "description_big")
                            newCountry.setValue(serverCountryDict["description_small"], forKey: "description_small")

                            do {
                                try context.save()

                                let entity = NSEntityDescription.entity(forEntityName: "CountryInfo", in: context)

                                let country = serverCountryDict["name"] as! String
                                let images = (serverCountryDict["country_info"] as! [String: Any])["images"] as! [String]

                                var order = 0
                                for image in images {
                                    let newInfo = NSManagedObject(entity: entity!, insertInto: context)
                                    newInfo.setValue(country, forKey: "country")
                                    newInfo.setValue(image, forKey: "image")
                                    newInfo.setValue(order, forKey: "order")
                                    order += 1
                                    try context.save()
                                }
                            } catch {
                                print("Failed saving")
                            }
                        }

                        dataHandler()
                    }
                    // Access specific key with value of type String
                } catch {
                    print("Network Error")
                }
            }
        }.resume()
    }
}
