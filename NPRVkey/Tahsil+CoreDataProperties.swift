//
//  Tahsil+CoreDataProperties.swift
//  NPR_census
//
//  Created by Dileep on 01/09/20.
//  Copyright © 2020 admin. All rights reserved.
//
//

import Foundation
import CoreData


extension Tahsil {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tahsil> {
        return NSFetchRequest<Tahsil>(entityName: "Tahsil")
    }

    @NSManaged public var district_code: String?
    @NSManaged public var statahsilName_in_nationalLangauge: String?
    @NSManaged public var statahsilName_in_stateLangauge: String?
    @NSManaged public var state_code: String?
    @NSManaged public var id: String?
    @NSManaged public var name: String?

}
