//
//  NPR_2021hh_Details+CoreDataProperties.swift
//  NPR-2021
//
//  Created by Dileep on 29/07/21.
//  Copyright © 2021 admin. All rights reserved.
//
//

import Foundation
import CoreData


extension NPR_2021hh_Details {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NPR_2021hh_Details> {
        return NSFetchRequest<NPR_2021hh_Details>(entityName: "NPR_2021hh_Details")
    }

    @NSManaged public var addressBlockId: String?
    @NSManaged public var addressContry: String?
    @NSManaged public var addressCountryName: String?
    @NSManaged public var addressCountryName_sl: String?
    @NSManaged public var addressDistrict: String?
    @NSManaged public var addressDistrictName: String?
    @NSManaged public var addressDistrictName_sl: String?
    @NSManaged public var addressHNLocality: String?
    @NSManaged public var addressHNLocality_sl: String?
    @NSManaged public var addressPinCode: String?
    @NSManaged public var addressState: String?
    @NSManaged public var addressStateName: String?
    @NSManaged public var addressStateName_sl: String?
    @NSManaged public var addressSubDistrict: String?
    @NSManaged public var addressSubDistrictName: String?
    @NSManaged public var addressSubDistrictName_sl: String?
    @NSManaged public var addressWardID: String?
    @NSManaged public var block_no: String?
    @NSManaged public var census_hhNo: String?
    @NSManaged public var census_hNo: String?
    @NSManaged public var discrictCode: String?
    @NSManaged public var ebNumber: String?
    @NSManaged public var first_name: String?
    @NSManaged public var first_name_sl: String?
    @NSManaged public var h_id: String?
    @NSManaged public var head_DOB: String?
    @NSManaged public var headGenderID: String?
    @NSManaged public var headName: String?
    @NSManaged public var headName_sl: String?
    @NSManaged public var hh_completed: String?
    @NSManaged public var hh_id: UUID?
    @NSManaged public var hh_status: String?
    @NSManaged public var hh_tin: String?
    @NSManaged public var hhType: String?
    @NSManaged public var houseHoldhNo: String?
    @NSManaged public var houseNo: String?
    @NSManaged public var instituteName: String?
    @NSManaged public var instituteName_sl: String?
    @NSManaged public var isInEnglish: Bool
    
    @NSManaged public var is_sign_updated: String?
    @NSManaged public var is_Splited: Bool
    @NSManaged public var is_superVisor_login: Bool
    @NSManaged public var isDownloaded: Bool
    @NSManaged public var isOpen: Bool
    @NSManaged public var languageSort: String?
    @NSManaged public var occuName_sl: String?
    @NSManaged public var originalHHNumberSplit: String?
    @NSManaged public var originalHHSplitInto: String?
    @NSManaged public var respondentName: String?
    @NSManaged public var respondentName_sl: String?
    @NSManaged public var respondentSign: Data?
    @NSManaged public var signByEnumBehalfRespondant: String?
    @NSManaged public var signRespondet: String?
    @NSManaged public var slNo_responded: String?
    @NSManaged public var slnohhd: String?
    @NSManaged public var slnoRespondent: String?
    @NSManaged public var splitedFrom: String?
    @NSManaged public var splitedTo: String?
    @NSManaged public var stateCode: String?
    @NSManaged public var sub_eb: String?
    @NSManaged public var superVisor_remrk: String?
    @NSManaged public var superVisor_remrkOn: String?
    @NSManaged public var tahsil_code: String?
    @NSManaged public var townCode: String?
    @NSManaged public var townName: String?
    @NSManaged public var townName_sl: String?
    @NSManaged public var wardID: String?
    @NSManaged public var language: String?
    @NSManaged public var midle_name: String?
    @NSManaged public var midle_name_sl: String?
    @NSManaged public var lastName: String?
    @NSManaged public var lastName_sl: String?
   
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

extension NPR_2021hh_Details : Identifiable {

}
