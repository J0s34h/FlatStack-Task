//
//  CountryInfo+CoreDataProperties.swift
//  Task
//
//  Created by Josef on 12.06.2021.
//
//

import Foundation
import CoreData


extension CountryInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CountryInfo> {
        return NSFetchRequest<CountryInfo>(entityName: "CountryInfo")
    }

    @NSManaged public var images: String?
    @NSManaged public var country_id: UUID?
    @NSManaged public var order: Int16
    @NSManaged public var country_dependency: Country?

}

extension CountryInfo : Identifiable {

}
