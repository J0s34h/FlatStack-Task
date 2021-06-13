//
//  CountryViewModel.swift
//  Task
//
//  Created by Josef on 13.06.2021.
//

import CoreData
import Foundation
import UIKit

class CountryViewModel {
    public func getCountries(handler: @escaping ([Country]) -> Void) {
        let countries = self.loadCountries()

        if countries.isEmpty {
            NetworkService().loadData {
                handler(self.loadCountries())
            }
        } else {
            handler(countries)
        }
    }

    private func loadCountries() -> [Country] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        var countries: [Country] = []

        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Country")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            countries = result as! [Country]
        } catch {
            print("Failed")
        }

        return countries
    }
}
