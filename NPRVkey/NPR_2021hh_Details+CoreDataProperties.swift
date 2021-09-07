//
//  NPR_2021hh_Details+CoreDataProperties.swift
//  NPR_census
//
//  Created by Dileep on 21/09/20.
//  Copyright © 2020 admin. All rights reserved.
//
//

import Foundation
import CoreData


extension NPR_2021hh_Details {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NPR_2021hh_Details> {
        return NSFetchRequest<NPR_2021hh_Details>(entityName: "NPR_2021hh_Details")
    }

    @NSManaged public var block_no: String?
    @NSManaged public var census_hhNo: String?
    @NSManaged public var census_hNo: String?
    @NSManaged public var expectedHH: String?
    @NSManaged public var discrictCode: String?
    @NSManaged public var ebNumber: String?
    
    @NSManaged public var head_DOB: String?
    @NSManaged public var headGenderID : String?
    @NSManaged public var headName: String?
    @NSManaged public var hh_completed: String?
    @NSManaged public var hhType: String?
    @NSManaged public var hh_status: String?
    @NSManaged public var hh_tin: String?
   // @NSManaged public var hh_tin_New: String?
    @NSManaged public var houseHoldhNo: String?
    @NSManaged public var houseNo: String?
    @NSManaged public var is_Splited: Bool
    @NSManaged public var is_sign_updated: String?
    @NSManaged public var isDownloaded: Bool
    @NSManaged public var isOpen: Bool
    @NSManaged public var isInHabited: Bool
    //@NSManaged public var is_superVisor_login: Bool
    @NSManaged public var respondentName: String?
    
    @NSManaged public var splitedFrom: String?
    @NSManaged public var splitedTo: String?
    @NSManaged public var stateCode: String?
    @NSManaged public var sub_eb: String?
    @NSManaged public var superVisor_remrk: String?
    @NSManaged public var tahsil_code: String?
    @NSManaged public var townCode: String?
    @NSManaged public var wardID: String?
    @NSManaged public var hh_id: UUID?
    @NSManaged public var toHH: NSSet?

}

// MARK: Generated accessors for toHH
extension NPR_2021hh_Details {

    @objc(addToHHObject:)
    @NSManaged public func addToToHH(_ value: NPR2021MemberDetails)

    @objc(removeToHHObject:)
    @NSManaged public func removeFromToHH(_ value: NPR2021MemberDetails)

    @objc(addToHH:)
    @NSManaged public func addToToHH(_ values: NSSet)

    @objc(removeToHH:)
    @NSManaged public func removeFromToHH(_ values: NSSet)

}
