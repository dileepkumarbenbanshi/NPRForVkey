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
    
    
    func save2021HHDetail(hhModel:NPRData2021ModelClassResult,Completion:@escaping(Bool) -> Void ){
         
        //DBManagerMemberDetail().
        
        if hhModel.relCode == "01" {
            DBManagerHousehold().save2021HHData(headDetalApiResponse: hhModel) { (isSaved)in
            
                self.save2021MemberDetail(hhModel: hhModel) { (memberDetailSaved) in
                    Completion(true)
                    
                }
            }
            
        }else{
            self.save2021MemberDetail(hhModel: hhModel) { (memberDetailSaved) in
                Completion(true)
                
            }
            
        }
       // var nprData:NPR2021MemberDetails
        
       

    }
    
    
    
    func save2021MemberDetail (hhModel:NPRData2021ModelClassResult,Completion:@escaping(Bool) -> Void ) {
        
        var nprData = DataBaseManager().openDataBase(entityName: EntityName.npr2021Data) as? NPR2021MemberDetails
        if let oldTin = hhModel.tin2019 {
        let arayMemberModel = DBManagerMemberDetail().fetchPartucularMemberDetail(memberTin: oldTin)
         if arayMemberModel.count > 0 {
             nprData = arayMemberModel[0]
         }
        }else{
           
            let arayMemberModel = DBManagerMemberDetail().fetchPartucularMemberDetail(memberTin: hhModel.tin ?? "")
             if arayMemberModel.count > 0 {
                 nprData = arayMemberModel[0]
             }
        }
        
        nprData?.hh_tin = hhModel.slnohhd?.hhTin()
        nprData?.ebNumber     = singleton().selectEBListModel.eb_number
        nprData?.block_no = hhModel.blockno
        nprData?.districtCode = hhModel.districtcode ?? ""
        nprData?.censusHouse_number = hhModel.censusHouseNo ?? "".censusHHNumber()
        nprData?.censusHH_number = hhModel.censusHhNo ?? "".censusHHNumber()
        nprData?.hh_Number = hhModel.slnohhd ?? "".hhNumber()
        nprData?.pinCode = hhModel.pincode
        // Member Detail
        
         nprData?.name = hhModel.name ?? ""
         nprData?.nameSL = hhModel.namesl ?? ""
       
         nprData?.tin = hhModel.tin ?? ""
         nprData?.new_tin = hhModel.slnoMember.memberTin(hhNumber: hhModel.slnohhd ?? "")
         nprData?.old_tin = hhModel.tin2019 ?? ""
         
         nprData?.sloMember = hhModel.slnoMember.memberSrNumber()
         nprData?.name = hhModel.name ?? ""
         nprData?.marital_status = "\(hhModel.maritalStatus ?? 0)"
         let strDob =  FormDateMangement().updateDobByStatus(strStatus: hhModel.dobType, strDate: hhModel.dob)
         nprData?.dob =  strDob
         nprData?.dob_type = hhModel.dobType ?? ""
    
        
         nprData?.motherToungeode = hhModel.motherTongue ?? ""
         //nprData?.aadhar = hhModel.
         
       
         
         nprData?.address_line1 = hhModel.addressAddressline1 ?? ""
         nprData?.address_line1_sl = hhModel.addressAddressline1 ?? ""
         //nprData?.address_line2 = hhModel.paddres
         nprData?.address_line2_sl = hhModel.addressAddressline2sl ?? ""
         nprData?.pinCode = hhModel.pincode ?? ""
         
         nprData?.address_line1 = hhModel.addressAddressline1 ?? ""
        nprData?.address_district = hhModel.addressDistrict
        nprData?.address_subDistrict = hhModel.addressTehsilcode
        nprData?.address_state = hhModel.addressState ?? ""
        nprData?.address_stateCode = hhModel.addressState ?? ""
         // Father Detail
         
         nprData?.father_name = hhModel.fatherName ?? ""
         
        // let strFatherDob =  FormDateMangement().updateDobByStatus(strStatus: hhModel.dobType, strDate: hhModel.dob)
         nprData?.dob =  strDob
         nprData?.father_dob = hhModel.fatherDob ?? ""
        // nprData?.father_dobType = hhModel.fatherDob
         
        // permanent Address
        
        nprData?.duration_inYear = "\(hhModel.durationInyear ?? 0)"
         
         
         // Mother Detail
         
         nprData?.motherName = hhModel.motherName ?? ""
        // nprData?.motherName_sl = hhModel.motherName
         nprData?.mother_dob = hhModel.motherDob ?? ""
        // nprData?.father_dobType = hhModel.fatherDob
         
        
         
         //nprData?.spouseName = hhModel.spous
         
         
         // ID
         
         nprData?.aadhar = hhModel.aadhaar ?? ""
         nprData?.mobile = hhModel.mobileNumber ?? ""
         
         
       //  nprData?.driving_lincence = hhModel.dl
         nprData?.memberStatus = "\(hhModel.memberStatus ?? 0)"
         nprData?.member_completionStatus = MemberCompletionStatusCode.uploaded
         nprData?.is_HH_completed = true
        nprData?.voter_id = hhModel.voterid ?? ""
        nprData?.driving_lincence = hhModel.drivingLicence ?? ""
        
        let memberStatus = MemberLivingStatusCode.init(rawValue: "\(hhModel.memberStatus ?? 0)")
         
         
         switch memberStatus {
         case .available,.newMember  :
             
            //Personal Detail
             
             nprData?.rel_code = hhModel.relCode  ?? ""
             //nprData?.relName = hhModel.relCode.
             nprData?.gender_id = "\(hhModel.genderid ?? 0)"
             nprData?.birthCountryCode = hhModel.birthCountry  ?? ""
             
             nprData?.birthStateCode = hhModel.birthStateCode ?? ""
             nprData?.birthDistrictCode = hhModel.birthDistrictCode ?? ""
             nprData?.nationality = hhModel.nationality
           // nprData?.passpord_id = hhModel.pas
            
             nprData?.edu_code = hhModel.eduCode ?? ""
             nprData?.occu_code = "\(hhModel.occuCode ?? 0)"
            nprData?.motherToungeode = hhModel.motherTongue ?? ""
            let mtongue =  hhModel.motherTongue.getName_by_ID(aray: English().motherTongueList())
            nprData?.motherTounge = mtongue 
             // Present Address
             
             nprData?.address_stateCode = hhModel.statecode ?? ""
            // nprData?.address_state = hhModel.statename
             nprData?.address_district = hhModel.districtcode ?? ""
            // nprData?.address_district = hhModel.distric
             nprData?.address_subDistrictCode = hhModel.tehsilcode ?? ""
             nprData?.townCode = hhModel.towncode ?? ""
            nprData?.pinCode = hhModel.pincode ?? ""
            
             
             
             nprData?.paddress_countryCode = hhModel.paddressCountry ?? ""
             nprData?.paddress_stateCode = hhModel.paddressState ?? ""
            // nprData?.address_state = hhModel.statename
             nprData?.paddre_district = hhModel.paddressDistrict ?? ""
            nprData?.paddre_districtCode = hhModel.paddressDistrict ?? ""
            nprData?.paddre_tahsil = hhModel.paddressTehsil ?? ""
            // nprData?.address_district = hhModel.distric
             nprData?.paddre_tahsilCode = hhModel.paddressTehsil  ?? ""
             nprData?.paddress_town = hhModel.towncode ?? ""
            nprData?.ppinCode = hhModel.ppincode ?? ""
            nprData?.staying_since_birthdate = "\(hhModel.stayingSinceBirth ?? 0)"
            nprData?.lastResidencyCountry = hhModel.lastResidencyCountry
            nprData?.lastResidencyState = hhModel.lastResidencyState
            nprData?.lastResidencyDistrict = hhModel.lastResidencyDistrict ?? ""
             // Parent Detail
             
             nprData?.fatherBirthCountryCode = hhModel.fatherBirthCountry ?? ""
             nprData?.fatherBirthCountry = DBManager_CountryStateDistrict().getCountryName(countryCode: hhModel.fatherBirthCountry ?? "")//hhModel.fatherBirthCountry
             nprData?.fatherBirthStateCode = hhModel.fatherBirthState ?? ""
             nprData?.fatherBirthState = DBManager_CountryStateDistrict().getCountryName(countryCode: hhModel.fatherBirthState ?? "")
             
             nprData?.fatherBirthDistrictCode = hhModel.fatherBirthDistrict ?? ""
             nprData?.fatherBirthDistrict = DBManager_CountryStateDistrict().getDistrictName(stateCode: hhModel.fatherBirthState ?? "", districtCode: hhModel.fatherBirthDistrict ?? "")
            nprData?.father_dob = hhModel.fatherDob
            
             // Mother Detail
             
             nprData?.mother_birthCountryCode = hhModel.motherBirthCountry ?? ""
             nprData?.mother_birthCountry = DBManager_CountryStateDistrict().getCountryName(countryCode: hhModel.motherBirthCountry ?? "")//hhModel.fatherBirthCountry
             nprData?.mother_birthStateCode = hhModel.motherBirthState ?? ""
             nprData?.mother_birthState = DBManager_CountryStateDistrict().getCountryName(countryCode: hhModel.motherBirthState ?? "")
             
             nprData?.mother_birthDistrictCode = hhModel.motherBirthState ?? ""
             nprData?.mother_birthDistrict = DBManager_CountryStateDistrict().getDistrictName(stateCode: hhModel.motherBirthState ?? "", districtCode: hhModel.motherBirthState ?? "")
            nprData?.mother_dob = hhModel.motherDob
            nprData?.spouseName = hhModel.spouseName ?? ""
             
             break
             
         
         default:
             
              nprData?.relName = hhModel.oefRelName ?? ""
              let arayRelation = "\(hhModel.genderid ?? 0)".getRealtionShipAray()
             nprData?.rel_code = hhModel.oefRelName ?? "".getDropDownItem_id(aray: arayRelation)
             
             nprData?.marital_status = "\(hhModel.maritalStatus ?? 0)".getDropDownItem_id(aray: English().maritalStatusList())
             
             nprData?.birthCountryName = hhModel.oefBirthCountryName ?? ""
             nprData?.birthCountryCode = DBManager_CountryStateDistrict().getCountryCode(countryName: hhModel.oefBirthCountryName)
             nprData?.birthStateName = hhModel.oefBirthStateName ?? ""
             
             nprData?.birthStateCode = DBManager_CountryStateDistrict().getStateCode(stateName: nprData?.birthStateName ?? "")
             
             nprData?.birthDistrictName = hhModel.oefBirthDistrictName ?? ""
             
             nprData?.birthDistrictCode = DBManager_CountryStateDistrict().getDistrictCode(stateCode: nprData?.birthStateCode ?? "", districtName: hhModel.oefBirthDistrictName ?? "")
             
             
             nprData?.eduName = hhModel.oefEduName ?? ""
             nprData?.edu_code = hhModel.oefEduName ?? "".getDropDownItem_id(aray: English().education_qualification())
             
             nprData?.occuName = hhModel.oefOccuName  ?? ""
             nprData?.occu_code = hhModel.oefOccuName ?? "".getDropDownItem_id(aray: English().occupation())
             
            // nprData?.motherTounge = hhModel.mo
            // nprData?.occu_code = hhModel.oefOccuName.getDropDownItem_id(aray: English().occupation())
             
             nprData?.address_state = hhModel.oefPresentState ?? ""
             nprData?.address_stateCode = DBManager_CountryStateDistrict().getStateCode(stateName: hhModel.oefPresentState ?? "")
             
             nprData?.address_district = hhModel.oefPresentDistrict ?? ""
             nprData?.address_district_code = DBManager_CountryStateDistrict().getDistrictCode(stateCode: hhModel.oefPresentState ?? "", districtName: hhModel.oefPresentDistrict ?? "")
             
             nprData?.address_subDistrict = hhModel.oefPresentTehsil ?? ""
             nprData?.address_subDistrictCode = DBManager_CountryStateDistrict().getSubDistrictCode(stateCode: nprData?.address_stateCode ?? "", tahsilName: hhModel.oefPresentTehsil ?? "")
             
             break
         }
         nprData?.member_completionStatus = MemberCompletionStatusCode.uploaded
         
         do {
             //context.mergePolicy = nsmer
                            try context.save()
             print("Member \(nprData?.name ?? "") Detail saved")
                    Completion(true)
                    
             

                        } catch {
                            print("Member Detail Failed saving")
                         //Completion(true)


                    }
             
        
    }
}
