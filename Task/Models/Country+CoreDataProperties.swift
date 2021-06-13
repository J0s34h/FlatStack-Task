//
//  Country+CoreDataProperties.swift
//  Task
//
//  Created by Josef on 12.06.2021.
//
//

import Foundation
import CoreData

class Country: NSManaged {
    
}

extension Country {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Country> {
        return NSFetchRequest<Country>(entityName: "Country")
    }

    @NSManaged public var name: String?
    @NSManaged public var continent: String?
    @NSManaged public var capital: String?
    @NSManaged public var population: Int64
    @NSManaged public var description_small: String?
    @NSManaged public var country_info: String?
    @NSManaged public var flag: String?
    @NSManaged public var id: UUID?

}

extension Country : Identifiable {

}
