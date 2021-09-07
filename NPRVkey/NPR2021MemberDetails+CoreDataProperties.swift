//
//  NPR2021MemberDetails+CoreDataProperties.swift
//  NPR-2021
//
//  Created by Dileep on 01/09/21.
//  Copyright © 2021 admin. All rights reserved.
//
//

import Foundation
import CoreData


extension NPR2021MemberDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<NPR2021MemberDetails> {
        return NSFetchRequest<NPR2021MemberDetails>(entityName: "NPR2021MemberDetails")
    }

    @NSManaged public var aadhar: String?
    @NSManaged public var address_district: String?
    @NSManaged public var address_district_code: String?
    @NSManaged public var address_district_sl: String?
    @NSManaged public var address_districtName_sl: String?
    @NSManaged public var address_line1: String?
    @NSManaged public var address_line1_sl: String?
    @NSManaged public var address_line2: String?
    @NSManaged public var address_line2_sl: String?
    @NSManaged public var address_line3: String?
    @NSManaged public var address_line3_sl: String?
    @NSManaged public var address_line4: String?
    @NSManaged public var address_line4_sl: String?
    @NSManaged public var address_line5: String?
    @NSManaged public var address_line5_sl: String?
    @NSManaged public var address_state: String?
    @NSManaged public var address_stateCode: String?
    @NSManaged public var address_stateName_sl: String?
    @NSManaged public var address_subDistrict: String?
    @NSManaged public var address_subDistrict_sl: String?
    @NSManaged public var address_subDistrictCode: String?
    @NSManaged public var addressCountry_sl: String?
    @NSManaged public var age: String?
    @NSManaged public var available: String?
    @NSManaged public var birth_country_sl: String?
    @NSManaged public var birth_district_sl: String?
    @NSManaged public var birth_state_sl: String?
    @NSManaged public var birthAddress: String?
    @NSManaged public var birthAddress_sl: String?
    @NSManaged public var birthCountryCode: String?
    @NSManaged public var birthCountryName: String?
    @NSManaged public var birthDistrictCode: String?
    @NSManaged public var birthDistrictName: String?
    @NSManaged public var birthStateCode: String?
    @NSManaged public var birthStateName: String?
    @NSManaged public var birthVillageName: String?
    @NSManaged public var bithDistrictName: String?
    @NSManaged public var block_no: String?
    @NSManaged public var censusHH_number: String?
    @NSManaged public var censusHouse_number: String?
    @NSManaged public var count_formNumber: String?
    @NSManaged public var countryName_sl: String?
    @NSManaged public var dbFile_name: String?
    @NSManaged public var died: String?
    @NSManaged public var districtCode: String?
    @NSManaged public var districtName: String?
    @NSManaged public var districtName_sl: String?
    @NSManaged public var dob: String?
    @NSManaged public var dob_type: String?
    @NSManaged public var dobForSearch: String?
    @NSManaged public var document1: Data?
    @NSManaged public var document2: Data?
    @NSManaged public var document3: Data?
    @NSManaged public var document4: String?
    @NSManaged public var driving_lincence: String?
    @NSManaged public var duration_inYear: String?
    @NSManaged public var ebNumber: String?
    @NSManaged public var edu_code: String?
    @NSManaged public var eduName: String?
    @NSManaged public var eduName_sl: String?
    @NSManaged public var enumerated_on: String?
    @NSManaged public var enumerator: String?
    @NSManaged public var father_code: String?
    @NSManaged public var father_dob: String?
    @NSManaged public var father_dobType: String?
    @NSManaged public var father_name: String?
    @NSManaged public var father_name_sl: String?
    @NSManaged public var fatherBirth_country_sl: String?
    @NSManaged public var fatherBirth_district_sl: String?
    @NSManaged public var fatherBirth_state_sl: String?
    @NSManaged public var fatherBirthCountry: String?
    @NSManaged public var fatherBirthCountryCode: String?
    @NSManaged public var fatherBirthDistrict: String?
    @NSManaged public var fatherBirthDistrictCode: String?
    @NSManaged public var fatherBirthPlace: String?
    @NSManaged public var fatherBirthState: String?
    @NSManaged public var fatherBirthStateCode: String?
    @NSManaged public var fatherBirthSubDistrict: String?
    @NSManaged public var fatherBirthSubDistrictCode: String?
    @NSManaged public var fatherVillage_towen: String?
    @NSManaged public var first_name: String?
    @NSManaged public var first_name_sl: String?
    @NSManaged public var form_number: String?
    @NSManaged public var gender_id: String?
    @NSManaged public var genderID_enu: String?
    @NSManaged public var hh_Copletionstatus: String?
    @NSManaged public var hh_id: UUID?
    @NSManaged public var hh_Number: String?
    @NSManaged public var hh_status: String?
    @NSManaged public var hh_tin: String?
    @NSManaged public var hh_type: String?
    @NSManaged public var id: String?
    @NSManaged public var imei: String?
    @NSManaged public var institution_name: String?
    @NSManaged public var institution_name_sl: String?
    @NSManaged public var ipAddress: String?
    @NSManaged public var is_HH_completed: Bool
    @NSManaged public var is_signUpdated: String?
    @NSManaged public var isUpdatedMemberStatus: Bool
    
    @NSManaged public var isCompleted: Bool
    @NSManaged public var isStarted: String?
    @NSManaged public var language: String?
    @NSManaged public var last_name: String?
    @NSManaged public var last_name_sl: String?
    @NSManaged public var last_resident_country_sl: String?
    @NSManaged public var last_resident_district_sl: String?
    @NSManaged public var last_resident_state_sl: Bool
    @NSManaged public var lastResidencyCountry: String?
    @NSManaged public var lastResidencyDistrict: String?
    @NSManaged public var lastResidencyState: String?
    @NSManaged public var latest_master: String?
    @NSManaged public var lattitude: String?
    @NSManaged public var longitute: String?
    @NSManaged public var m_id: String?
    @NSManaged public var marital_status: String?
    @NSManaged public var member_completionStatus: String?
    @NSManaged public var memberStatus: String?
    @NSManaged public var memberStatus_prev_exercise: String?
    @NSManaged public var midle_name: String?
    @NSManaged public var midle_name_sl: String?
    @NSManaged public var migrated: String?
    @NSManaged public var mobile: String?
    @NSManaged public var mother_birthCountry: String?
    @NSManaged public var mother_birthCountryCode: String?
    @NSManaged public var mother_birthDistrict: String?
    @NSManaged public var mother_birthDistrictCode: String?
    @NSManaged public var mother_birthPlace: String?
    @NSManaged public var mother_birthState: String?
    @NSManaged public var mother_birthStateCode: String?
    @NSManaged public var mother_code: String?
    @NSManaged public var mother_dob: String?
    @NSManaged public var mother_dobType: String?
    @NSManaged public var motherBirth_country_sl: String?
    @NSManaged public var motherBirth_district_sl: String?
    @NSManaged public var motherBirth_state_sl: String?
    @NSManaged public var motherName: String?
    @NSManaged public var motherName_sl: String?
    @NSManaged public var motherTounge: String?
    @NSManaged public var motherToungeode: String?
    @NSManaged public var name: String?
    @NSManaged public var name_instant_langauge: String?
    @NSManaged public var name_on_cardSL: String?
    @NSManaged public var name_responded: String?
    @NSManaged public var nameSL: String?
    @NSManaged public var nationality: String?
    @NSManaged public var nationality_name: String?
    @NSManaged public var nationality_sl: String?
    @NSManaged public var new_tin: String?
    @NSManaged public var occu_code: String?
    @NSManaged public var occuName: String?
    @NSManaged public var occuName_sl: String?
    @NSManaged public var old_tin: String?
    @NSManaged public var orginalHHN: String?
    @NSManaged public var otherMotherTounge: String?
    @NSManaged public var paddre_district: String?
    @NSManaged public var paddre_districtCode: String?
    @NSManaged public var paddre_line1: String?
    @NSManaged public var paddre_line1_sl: String?
    @NSManaged public var paddre_line2: String?
    @NSManaged public var paddre_line2_sl: String?
    @NSManaged public var paddre_tahsil: String?
    @NSManaged public var paddre_tahsil_sl: String?
    @NSManaged public var paddre_tahsilCode: String?
    @NSManaged public var paddress_block_code: String?
    @NSManaged public var paddress_country: String?
    @NSManaged public var paddress_countryCode: String?
    @NSManaged public var paddress_line2: String?
    @NSManaged public var paddress_line2_sl: String?
    @NSManaged public var paddress_line3: String?
    @NSManaged public var paddress_line3_sl: String?
    @NSManaged public var paddress_line4: String?
    @NSManaged public var paddress_line4_sl: String?
    @NSManaged public var paddress_line5: String?
    @NSManaged public var paddress_line5_sl: String?
    @NSManaged public var paddress_state: String?
    @NSManaged public var paddress_stateCode: String?
    @NSManaged public var paddress_town: String?
    @NSManaged public var paddress_town_sl: String?
    @NSManaged public var panCard_number: String?
    @NSManaged public var passpord_id: String?
    @NSManaged public var phone_responded: String?
    @NSManaged public var pinCode: String?
    @NSManaged public var ppinCode: String?
    @NSManaged public var primaryLangauge: String?
    @NSManaged public var rationCard_number: String?
    @NSManaged public var rel_code: String?
    @NSManaged public var relName: String?
    @NSManaged public var relNameSL: String?
    @NSManaged public var resident_id: String?
    @NSManaged public var secondaryLangauge: String?
    @NSManaged public var selfEnumerationRef_number: String?
    @NSManaged public var sign_by_enum_onBehalf_of_responded: String?
    @NSManaged public var sign_responded: String?
    @NSManaged public var slNo_responded: String?
    @NSManaged public var sloHHD: String?
    @NSManaged public var sloMember: String?
    @NSManaged public var sper_sync_on: String?
    @NSManaged public var splitFrom: String?
    @NSManaged public var splitInto: String?
    @NSManaged public var spouseBirthPlace: String?
    @NSManaged public var spouseCode: String?
    @NSManaged public var spouseName: String?
    @NSManaged public var spouseName_sl: String?
    @NSManaged public var stateName_sl: String?
    @NSManaged public var staying_since_birthdate: String?
    @NSManaged public var sub_eb: String?
    @NSManaged public var super_ok: String?
    @NSManaged public var super_remark: String?
    @NSManaged public var super_remark_on: String?
    @NSManaged public var superVisor: String?
    @NSManaged public var tin: String?
    @NSManaged public var townCode: String?
    @NSManaged public var uploded_by: String?
    @NSManaged public var userID: String?
    @NSManaged public var villageName_sl: String?
    @NSManaged public var voter_id: String?
    @NSManaged public var wardCode: String?
    @NSManaged public var wardName: String?
    @NSManaged public var mothersrNumber: String?
    @NSManaged public var fatherSrNumber: String?

}

extension NPR2021MemberDetails : Identifiable {

}
