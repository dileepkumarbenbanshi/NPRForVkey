//
//  HLOData+CoreDataProperties.swift
//  NPR_census
//
//  Created by Dileep on 01/09/20.
//  Copyright © 2020 admin. All rights reserved.
//
//

import Foundation
import CoreData


extension HLOData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HLOData> {
        return NSFetchRequest<HLOData>(entityName: "HLOData")
    }

    @NSManaged public var block_no: String?
    @NSManaged public var census_hh_no: String?
    @NSManaged public var census_house_no: String?
    @NSManaged public var eb_name: String?
    @NSManaged public var ebNumber: String?
    
    @NSManaged public var head_name: String?
    @NSManaged public var head_name_sl: String?
    @NSManaged public var id: String?

}
