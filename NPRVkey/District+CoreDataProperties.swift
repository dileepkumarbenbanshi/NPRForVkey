//
//  District+CoreDataProperties.swift
//  NPR_census
//
//  Created by Dileep on 01/09/20.
//  Copyright © 2020 admin. All rights reserved.
//
//

import Foundation
import CoreData


extension District {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<District> {
        return NSFetchRequest<District>(entityName: "District")
    }

    @NSManaged public var code: String?
    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var districtName_in_nationalLangauge: String?
    @NSManaged public var districtName_in_stateLangauge: String?
    @NSManaged public var stateCode: String?

}
