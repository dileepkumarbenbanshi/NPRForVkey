//
//  State+CoreDataProperties.swift
//  NPR_census
//
//  Created by Dileep on 01/09/20.
//  Copyright © 2020 admin. All rights reserved.
//
//

import Foundation
import CoreData


extension State {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<State> {
        return NSFetchRequest<State>(entityName: "State")
    }

    @NSManaged public var id: String?
    @NSManaged public var code: String?
    @NSManaged public var name: String?
    @NSManaged public var stateName_in_nationalLangauge: String?
    @NSManaged public var stateName_in_stateLangauge: String?

}
