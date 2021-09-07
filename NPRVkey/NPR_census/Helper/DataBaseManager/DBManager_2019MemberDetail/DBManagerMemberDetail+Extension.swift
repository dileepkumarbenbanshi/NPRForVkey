//
//  DBManagerMemberDetail+Extension.swift
//  NPR-2020
//
//  Created by Dileep on 15/01/21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation

extension DBManagerMemberDetail {
    
    func fetchPartucularMemberDetail(memberTin:String) -> [NPR2021MemberDetails] {
       
        let predicate = NSPredicate(format: "old_tin = %@",memberTin)
        
       let memberDetail = DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data, predicate: predicate) as? [NPR2021MemberDetails]
        
        return memberDetail ?? [NPR2021MemberDetails]()
    }
    
    
    func save2021HHMemberDetail(hhModel:NPRData2021ModelClassResult,Completion:@escaping(Bool) -> Void ){
         
        //DBManagerMemberDetail().
        if hhModel.relCode == "01" {
            DBManagerHousehold().save2021HHData(headDetalApiResponse: hhModel)
            
        }
        var nprData:NPR2021MemberDetails?
        
        let arayMemberModel = DBManagerMemberDetail().fetchPartucularMemberDetail(memberTin: hhModel.tin2019 ?? "")
        if arayMemberModel.count > 0 {
            nprData = arayMemberModel[0]
        }
        else{
            nprData = DataBaseManager().openDataBase(entityName: EntityName.npr2021Data) as? NPR2021MemberDetails
            
            //nprData = newNprData ?? NPR2021MemberDetails()
        }
        
 //       let oldFormatDate = hhModel.dob ?? ""
        
//        let strModifiedDate = oldFormatDate.convertDateFormater()
////        if !util.isEnumerator() {
////            nprData?.is_superVisor_login = true
////        }
//
        
        nprData?.name = hhModel.name ?? ""
        nprData?.nameSL = hhModel.namesl ?? ""
        nprData?.censusHouse_number = hhModel.censusHouseNo ?? ""
        nprData?.censusHH_number = hhModel.censusHhNo ?? ""
        nprData?.hh_Number = hhModel.slnohhd ?? ""
        nprData?.tin = hhModel.tin ?? ""
        nprData?.new_tin = hhModel.slnoMember.memberTin(hhNumber: hhModel.slnohhd)
        nprData?.old_tin = hhModel.tin2019 ?? ""
        nprData?.hh_tin = hhModel.slnohhd.hhTin()
        
        nprData?.name = hhModel.name ?? ""
 
        
        nprData?.marital_status = "\(hhModel.maritalStatus ?? 0)"
        
        nprData?.dob = hhModel.dob ?? ""
        nprData?.dob_type = hhModel.dobType
        
       
        nprData?.motherToungeode = hhModel.motherTongue ?? ""
        //nprData?.aadhar = hhModel.
        
      
        
        nprData?.address_line1 = hhModel.paddressline1 ?? ""
        nprData?.address_line1_sl = hhModel.paddressline1sl ?? ""
        //nprData?.address_line2 = hhModel.paddres
        nprData?.address_line2_sl = hhModel.paddressline2sl ?? ""
        nprData?.pinCode = hhModel.pincode
        
        nprData?.address_line1 = hhModel.paddressline1 ?? ""
        
        // Father Detail
        
        nprData?.father_name = hhModel.fatherName ?? ""
        nprData?.father_dob = hhModel.fatherDob ?? ""
       // nprData?.father_dobType = hhModel.fatherDob
        
        
        
        
        // Mother Detail
        
        nprData?.motherName = hhModel.motherName ?? ""
       // nprData?.motherName_sl = hhModel.motherName
        nprData?.mother_dob = hhModel.motherDob ?? ""
       // nprData?.father_dobType = hhModel.fatherDob
        
       
        
        //nprData?.spouseName = hhModel.spous
        
        
        // ID
        
        nprData?.aadhar = hhModel.aadhaar
        nprData?.mobile = hhModel.mobileNumber
       // nprData?.voter_id = hhModel.voter
        
      //  nprData?.driving_lincence = hhModel.dl
        nprData?.memberStatus = "\(hhModel.memberStatus ?? 0)"
        nprData?.member_completionStatus = MemberCompletionStatusCode.uploaded
        nprData?.is_HH_completed = true
       let memberStatus = MemberLivingStatusCode.init(rawValue: "\(hhModel.memberStatus ?? 0)")
        
        
        switch memberStatus {
        case .available,.newMember  :
            
           //Personal Detail
            
            nprData?.rel_code = hhModel.relCode  ?? ""
            //nprData?.relName = hhModel.relCode.
            nprData?.gender_id = "\(hhModel.genderid ?? 0)"
            nprData?.birthCountryCode = hhModel.birthCountry  ?? ""
            
            nprData?.birthStateCode = hhModel.birthStateCode
            nprData?.birthDistrictCode = hhModel.birthDistrictCode
            //nprData?.nationality = hhModel.nationality
            
            nprData?.edu_code = hhModel.eduCode
            nprData?.occu_code = "\(hhModel.occuCode ?? 0)"
            
            // Present Address
            nprData?.motherToungeode = hhModel.motherTongue ?? ""
            nprData?.address_stateCode = hhModel.statecode ?? ""
           // nprData?.address_state = hhModel.statename
            nprData?.address_district = hhModel.districtcode ?? ""
           // nprData?.address_district = hhModel.distric
            nprData?.address_subDistrictCode = hhModel.tehsilcode ?? ""
            nprData?.townCode = hhModel.towncode ?? ""
            
           
            
            
            nprData?.paddress_countryCode = hhModel.paddressCountry ?? ""
            nprData?.paddress_stateCode = hhModel.paddressState ?? ""
           // nprData?.address_state = hhModel.statename
            nprData?.paddre_district = hhModel.paddressDistrict ?? ""
           // nprData?.address_district = hhModel.distric
            nprData?.paddre_tahsilCode = hhModel.paddressTehsil  ?? ""
            nprData?.paddress_town = hhModel.towncode ?? ""
            
            // Parent Detail
            
            nprData?.fatherBirthCountryCode = hhModel.fatherBirthCountry
            nprData?.fatherBirthCountry = DBManager_CountryStateDistrict().getCountryName(countryCode: hhModel.fatherBirthCountry ?? "")//hhModel.fatherBirthCountry
            nprData?.fatherBirthStateCode = hhModel.fatherBirthState ?? ""
            nprData?.fatherBirthState = DBManager_CountryStateDistrict().getCountryName(countryCode: hhModel.fatherBirthState ?? "")
            
            nprData?.fatherBirthDistrictCode = hhModel.fatherBirthDistrict ?? ""
            nprData?.fatherBirthDistrict = DBManager_CountryStateDistrict().getDistrictName(stateCode: hhModel.fatherBirthState ?? "", districtCode: hhModel.fatherBirthDistrict ?? "")
            
            // Mother Detail
            
            nprData?.mother_birthCountryCode = hhModel.motherBirthCountry ?? ""
            nprData?.mother_birthCountry = DBManager_CountryStateDistrict().getCountryName(countryCode: hhModel.motherBirthCountry ?? "")//hhModel.fatherBirthCountry
            nprData?.mother_birthStateCode = hhModel.motherBirthState ?? ""
            nprData?.mother_birthState = DBManager_CountryStateDistrict().getCountryName(countryCode: hhModel.motherBirthState ?? "")
            
            nprData?.mother_birthDistrictCode = hhModel.motherBirthState ?? ""
            nprData?.mother_birthDistrict = DBManager_CountryStateDistrict().getDistrictName(stateCode: hhModel.motherBirthState ?? "", districtCode: hhModel.motherBirthState ?? "")
            
            
            break
            
        
        default:
            
             nprData?.relName = hhModel.oefRelName ?? ""
             let arayRelation = "\(hhModel.genderid ?? 0)".getRealtionShipAray()
            nprData?.rel_code = hhModel.oefRelName.getDropDownItem_id(aray: arayRelation)
            
            nprData?.marital_status = "\(hhModel.maritalStatus ?? 0)".getDropDownItem_id(aray: English().maritalStatusList())
            
            nprData?.birthCountryName = hhModel.oefBirthCountryName ?? ""
            nprData?.birthCountryCode = DBManager_CountryStateDistrict().getCountryCode(countryName: hhModel.oefBirthCountryName)
            nprData?.birthStateName = hhModel.oefBirthStateName ?? ""
            
            nprData?.birthStateCode = DBManager_CountryStateDistrict().getStateCode(stateName: nprData?.birthStateName ?? "")
            
            nprData?.birthDistrictName = hhModel.oefBirthDistrictName ?? ""
            
            nprData?.birthDistrictCode = DBManager_CountryStateDistrict().getDistrictCode(stateCode: nprData?.birthStateCode ?? "", districtName: hhModel.oefBirthDistrictName ?? "")
            
            
            nprData?.eduName = hhModel.oefEduName ?? ""
            nprData?.edu_code = hhModel.oefEduName.getDropDownItem_id(aray: English().education_qualification())
            
            nprData?.occuName = hhModel.oefOccuName  ?? ""
            nprData?.occu_code = hhModel.oefOccuName.getDropDownItem_id(aray: English().occupation())
            
           // nprData?.motherTounge = hhModel.mo
           // nprData?.occu_code = hhModel.oefOccuName.getDropDownItem_id(aray: English().occupation())
            
            nprData?.address_state = hhModel.oefPresentState ?? ""
            nprData?.address_stateCode = DBManager_CountryStateDistrict().getStateCode(stateName: hhModel.oefPresentState ?? "")
            
            nprData?.address_district = hhModel.oefPresentDistrict ?? ""
            nprData?.address_district_code = DBManager_CountryStateDistrict().getDistrictCode(stateCode: hhModel.oefPresentState ?? "", districtName: hhModel.oefPresentDistrict ?? "")
            
            nprData?.address_subDistrict = hhModel.oefPresentTehsil ?? ""
            nprData?.address_subDistrictCode = DBManager_CountryStateDistrict().getSubDistrictCode(districtCode: nprData?.address_district_code ?? "", tahsilName: hhModel.oefPresentTehsil ?? "")
            
            break
        }
        nprData?.member_completionStatus = MemberCompletionStatusCode.uploaded
        
        do {
           // context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
                           try context.save()
                           
                   Completion(true)
                   
            

                       } catch {
                           print("Member Detail Failed saving")
                        Completion(true)


                   }
            

    }
    
    
}
