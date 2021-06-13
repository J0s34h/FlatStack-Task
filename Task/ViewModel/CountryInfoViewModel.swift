//
//  CountryInfoViewModel.swift
//  Task
//
//  Created by Josef on 13.06.2021.
//

import CoreData
import Foundation
import UIKit

class CountryInfoViewModel {
    public func getCountries(for country: Country) -> [CountryInfo] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        var info: [CountryInfo] = []

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CountryInfo")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)

            for countryInfo in result as! [CountryInfo] {
                if countryInfo.country == country.name {
                    print(true)
                    info.append(countryInfo)
                }
            }

            info.sort { $0.order >= $1.order }
        } catch {
            print("Failed")
        }

        return info
    }

    public func getAll() -> [CountryInfo] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        var info: [CountryInfo] = []

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "CountryInfo")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            info = result as! [CountryInfo]
            info.sort { $0.order >= $1.order }
        } catch {
            print("Failed")
        }

        return info
    }
}
