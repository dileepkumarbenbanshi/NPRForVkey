//
//  EB+CoreDataProperties.swift
//  NPR_census
//
//  Created by Dileep on 01/09/20.
//  Copyright © 2020 admin. All rights reserved.
//
//

import Foundation
import CoreData


extension EB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EB> {
        return NSFetchRequest<EB>(entityName: "EB")
    }

    @NSManaged public var eb_active: String?
    @NSManaged public var eb_block_number: String?
    @NSManaged public var eb_complition_date: String?
    @NSManaged public var eb_number: String?
    @NSManaged public var eb_sr: String?
    @NSManaged public var ebAgree: String?
    @NSManaged public var ebDistrict_code: String?
    @NSManaged public var ebDistrict_name: String?
    @NSManaged public var ebDistrict_nameSL: String?
    @NSManaged public var ebEnumeratorName_mobile: String?
    @NSManaged public var ebExpHHNO: String?
    @NSManaged public var ebEnumeratorStartTime: String?
    @NSManaged public var ebState_code: String?
    @NSManaged public var ebState_name: String?
    @NSManaged public var ebState_nameSL: String?
    @NSManaged public var ebSubEB_code: String?
    @NSManaged public var ebSupervisor: String?
    @NSManaged public var ebSupervisor_mibile: String?
    @NSManaged public var ebTahsil_code: String?
    @NSManaged public var ebTahsil_name: String?
    @NSManaged public var ebTahsil_nameSL: String?
    @NSManaged public var ebTown_code: String?
    @NSManaged public var ebTown_name: String?
    @NSManaged public var ebTown_nameSL: String?
    @NSManaged public var ebWard_code: String?
    @NSManaged public var ebWardName: String?
    @NSManaged public var ebWardNameSL: String?
    
    @NSManaged public var enumerator_name: String?
    @NSManaged public var enumerator_sign: Data?
    @NSManaged public var expectedHH_number: String?
    @NSManaged public var is_InHavitedEB: Bool
    
    @NSManaged public var is_eb_completed: Bool
    @NSManaged public var is_eb_downloaded: Bool
    @NSManaged public var superVisor_eb_comletion_date: String?
    @NSManaged public var supervisor_is_eb_completed: String?
    @NSManaged public var ebEnumerator: String?
       @NSManaged public var ebEnumStartOn: String?
    @NSManaged public var supervisor_sign: Data?

}
