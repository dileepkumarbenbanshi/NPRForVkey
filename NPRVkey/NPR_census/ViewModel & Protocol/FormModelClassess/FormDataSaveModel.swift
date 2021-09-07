//
//  File.swift
//  NPR-2020
//
//  Created by Dileep on 28/01/21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation

protocol FormDataSavingManagementProtocoll {
    func hhDataUpdated()
    func dataSavedInMemberTable()
}

class FormDataSavingManagement {
    
    var delegate:FormDataSavingManagementProtocoll?
    var formClass:AddNewHouseHoldForm_TVC?
    var modelMember :NPR2021MemberDetails?
    
//    init(formClass:AddNewHouseHoldForm_TVC , modelMember:NPR2021MemberDetails) {
//        self.formClass = formClass
//        self.modelMember = modelMember
//    }
//    
//    deinit {
//        modelMember = nil
//        formClass = nil
//    }
    
    
    func saveMemberFormData(formClass:AddNewHouseHoldForm_TVC,objNprData:NPR2021MemberDetails)  {
        DispatchQueue.main.async {
        //let objNprData = DataBaseManager().openDataBase(entityName: EntityName.npr2021Data) as? NPR2021MemberDetails
        
        objNprData.hh_tin = formClass.strHHNumber.hhTin()
        objNprData.new_tin = formClass.strMemberNumber.memberTin(hhNumber: formClass.strHHNumber)
        objNprData.tin = objNprData.new_tin
        
        //"\(singleton().selectEBListModel.eb_number ?? "")\(formClass.strHHNumber)\(formClass.memberSerialNumber)"
        
       // objNprData.tin = formClass.memberSerialNumber.memberTin(hhNumber: formClass.strHHNumber)
        
            //"\(singleton().selectEBListModel.eb_number ?? "")\(formClass.strHHNumber)\(formClass.strMemberNumber)"
        
        objNprData.ebNumber = singleton().selectEBListModel.eb_number
        objNprData.censusHH_number = formClass.tf_pd_houseHoldNO.text?.censusHHNumber()//formClass.tf_pd_houseHoldNO.text ?? ""
        objNprData.censusHouse_number = formClass.tf_pd_houseHoldNO.text?.censusHouseNumber()
        objNprData.selfEnumerationRef_number = formClass.tf_pd_SE_refrenceNO.text ?? ""
        objNprData.hh_Number = formClass.strHHNumber.hhNumber()
        objNprData.hh_status = formClass.hhStatus
        objNprData.hh_Copletionstatus = formClass.hh_completionStatus
        objNprData.memberStatus = formClass.memberStatus
        objNprData.member_completionStatus = MemberCompletionStatusCode.completed
        objNprData.sloMember = formClass.strMemberNumber.memberSrNumber()
        
        objNprData.hh_Number = formClass.strHHNumber.hhNumber()
        objNprData.sloHHD = formClass.strHHNumber.hhNumber()
        // Personal Data
        
       
        
        objNprData.name = formClass.tf_pd_Name.text ?? ""
        objNprData.gender_id = "\(formClass.genderId.rawValue)"
        objNprData.relName = formClass.btn_pd_relationWithHead.titleLabel?.text ?? ""
        objNprData.marital_status = formClass.maritalStatus.rawValue
        let arayDropList = English().getRelationShipAray(gender: formClass.genderId)
        objNprData.rel_code = objNprData.relName?.getDropDownItem_id(aray: arayDropList)
                                                                       
       // objNprData.marital_status = formClass.ma
        objNprData.dob = FormDateMangement().dateFormat(type: .personal, formClass: formClass)
        // DOB Have To Change
        objNprData.dob_type = "A"
        objNprData.birthCountryName = formClass.btn_pd_birthPlaceCountry.titleLabel?.text ?? ""
        
        objNprData.birthCountryCode = DBManager_CountryStateDistrict().getCountryCode(countryName: objNprData.birthCountryName ?? "")
        
        objNprData.birthStateName = formClass.btn_pd_birthPlaceState.titleLabel?.text ?? ""
        objNprData.birthStateCode = DBManager_CountryStateDistrict().getStateCode(stateName: objNprData.birthStateName ?? "")
        
        objNprData.birthDistrictName = formClass.btn_pd_birthPlaceDistrict.titleLabel?.text ?? ""
        
        objNprData.birthDistrictCode = DBManager_CountryStateDistrict().getDistrictCode(stateCode: objNprData.birthStateCode ?? "" , districtName: objNprData.birthDistrictName ?? "")
        
        
        objNprData.nationality_name = formClass.btn_pd_Natinality.titleLabel?.text ?? ""
        objNprData.nationality = DBManager_CountryStateDistrict().getCountryCode(countryName: objNprData.nationality_name ?? "")
        
        objNprData.passpord_id = formClass.tf_passportNumber.text ?? ""
        
        //Education Qualification
        
        objNprData.eduName = formClass.btn_ed_qualification.titleLabel?.text ?? ""
        if let eduCode = Int(objNprData.eduName?.getDropDownItem_id(aray: English().education_qualification()) ?? "") {
            objNprData.edu_code = String(format: AppFormat.twodigitFormat, eduCode)
        }
        
        
        objNprData.occuName = formClass.btn_ed_occupation.titleLabel?.text ?? ""
        if let ocuCode = Int(objNprData.occuName?.getDropDownItem_id(aray: English().occupation()) ?? "") {
            objNprData.occu_code = "\(ocuCode)"//String(format: AppFormat.twodigitFormat, ocuCode)
        }
        
       // objNprData.occu_code = objNprData.eduName?.getDropDownItem_id(aray: English().occupation())
        
        objNprData.motherTounge = formClass.btn_ed_motherTounge.titleLabel?.text ?? ""
       
        let arayLangugeComponent = objNprData.motherTounge?.components(separatedBy: "-")
        
        //let intMTCode = Int(arayLangugeComponent?[1] ?? "")
        if let mtCode = Int(arayLangugeComponent?[1] ?? "") {
            objNprData.motherToungeode = String(format: AppFormat.threeDigitFormat, mtCode)
        }
        
       // objNprData.motherToungeode = String(format: AppFormat.threeDigitFormat, intMTCode! )
        
        
        //Parents Detail
        
        objNprData.father_name = formClass.parentDetail_fatherName.text ?? ""
        objNprData.father_dob  = FormDateMangement().dateFormat(type: .father, formClass: formClass)
       // objNprData.father_dobType =
        objNprData.fatherBirthCountry = formClass.btn_pd_birthPlaceCountry.titleLabel?.text ?? ""
        objNprData.fatherBirthCountryCode = DBManager_CountryStateDistrict().getCountryCode(countryName: objNprData.fatherBirthCountry ?? "")
        
        objNprData.fatherBirthState = formClass.btn_pd_birthPlaceState.titleLabel?.text ?? ""
        objNprData.fatherBirthStateCode = DBManager_CountryStateDistrict().getStateCode(stateName: objNprData.fatherBirthState ?? "")
        
        objNprData.fatherBirthDistrict = formClass.btn_pd_birthPlaceDistrict.titleLabel?.text ?? ""
        objNprData.fatherBirthDistrictCode = DBManager_CountryStateDistrict().getDistrictCode(stateCode: objNprData.fatherBirthStateCode ?? "", districtName: objNprData.fatherBirthDistrict ?? "")
        
        // Mother Detail
        
        objNprData.motherName = formClass.tf_ParentDetail_motherName.text ?? ""
        objNprData.mother_dob = FormDateMangement().dateFormat(type: .father, formClass: formClass)
        
        //objNprData.mother_dobType = formClass.
        objNprData.mother_birthCountry = formClass.btn_ParentDetail_motherBirthCountry.titleLabel?.text ?? ""
        objNprData.mother_birthCountryCode = DBManager_CountryStateDistrict().getCountryCode(countryName: objNprData.mother_birthCountry ?? "")
        
       
        objNprData.mother_birthState = formClass.btn_ParentDetail_motherBirthState.titleLabel?.text ?? ""
        objNprData.mother_birthStateCode = DBManager_CountryStateDistrict().getStateCode(stateName: objNprData.mother_birthState ?? "")
        
        objNprData.mother_birthDistrict = formClass.btn_ParentDetail_motherBirthDistrict.titleLabel?.text ?? ""
        objNprData.mother_birthDistrictCode = DBManager_CountryStateDistrict().getDistrictCode(stateCode: objNprData.mother_birthStateCode ?? "", districtName: objNprData.mother_birthDistrict ?? "")
        
        objNprData.spouseName = formClass.tf_ParentDetail_spouseName.text ?? ""
       // objNprData.spouseCode =
        
        // Present address
        
        objNprData.address_state = formClass.btn_ptAdd_State.titleLabel?.text ?? ""
        objNprData.address_stateCode = singleton().selectEBListModel.ebState_code//DBManager_CountryStateDistrict().getStateCode(stateName: objNprData.address_state ?? "")
        
        objNprData.address_district = formClass.btn_ptAdd_District.titleLabel?.text ?? ""
        objNprData.address_district_code = singleton().selectEBListModel.ebDistrict_code
        
        objNprData.address_subDistrict = singleton().selectEBListModel.ebTahsil_name
        objNprData.address_subDistrictCode = singleton().selectEBListModel.ebTahsil_code
        
        objNprData.wardCode = singleton().selectEBListModel.ebWard_code
        objNprData.wardName = singleton().selectEBListModel.ebWard_code
        objNprData.townCode = singleton().selectEBListModel.ebTown_code
        objNprData.address_line2 = singleton().selectEBListModel.ebTown_name
        objNprData.address_line1 = formClass.tf_ptAd_houseNumber.text ?? ""
        objNprData.pinCode = formClass.tf_ptAd_pinCode.text ?? ""
        
        // Permanent Address
        
        
        objNprData.paddress_state = formClass.btn_padState.titleLabel?.text ?? ""
        objNprData.paddress_stateCode = DBManager_CountryStateDistrict().getStateCode(stateName:  objNprData.paddress_state ?? "")
        
         objNprData.paddre_district = formClass.btn_padDistrict.titleLabel?.text ?? ""
        objNprData.paddre_districtCode = DBManager_CountryStateDistrict().getDistrictCode(stateCode: objNprData.paddress_stateCode ?? "", districtName: objNprData.paddre_district ?? "")
        
         objNprData.paddre_tahsil = formClass.btn_PadSubDistrict.titleLabel?.text ?? ""
        objNprData.paddre_tahsilCode = DBManager_CountryStateDistrict().getSubDistrictCode(districtCode: objNprData.paddress_stateCode ?? "", tahsilName:  objNprData.paddre_tahsil ?? "")
        
        objNprData.paddress_town = formClass.tf_padTownVillage.text ?? ""
         //objNprData.address_line2 = formClass.tf_ptAd_townVillage.text ?? ""
         objNprData.paddre_line1 = formClass.tf_padHouseNumber.text ?? ""
         objNprData.ppinCode = formClass.tf_padPinCode.text ?? ""
        
        //objNprData.staying_since_birthdate
        
        // Identification Detail
        
        objNprData.aadhar = formClass.tf_ID_adhar.text ?? ""
        objNprData.mobile = formClass.tf_ID_mobile.text ?? ""
        objNprData.driving_lincence = formClass.tf_ID_dL.text ?? ""
        objNprData.voter_id = formClass.tf_ID_voter.text ?? ""
        
        do {
            try context.save()
            
        
            self.afetrSaveMemberData(formClass: formClass)
           
        } catch  {
            print("Failed Save New hh MemberData")
        }
        
        
        }
       }
    
    func afetrSaveMemberData(formClass:AddNewHouseHoldForm_TVC)  {
        
        if formClass.entryT == .newHouseHold {
            delegate?.dataSavedInMemberTable()
        }
        else  {
        updateHHTableAfterMemberadd(formClass: formClass)
        }
    }
    
    func updateHHTableAfterMemberadd(formClass:AddNewHouseHoldForm_TVC)  {
        
        formClass.modelHH.census_hhNo = formClass.tf_pd_houseHoldNO.text?.censusHHNumber()
        formClass.modelHH.census_hNo = formClass.pd_houseNo.text?.censusHouseNumber()
        
        formClass.modelHH.houseHoldhNo = formClass.strHHNumber.hhNumber()
        formClass.modelHH.hh_tin = formClass.modelHH.hh_tin
       
        do {
            try context.save()
            if formClass.entryT == .editDetail {
                isCompletedHH(formClass: formClass)
            }else{
            delegate?.hhDataUpdated()
            }
        } catch  {
            
        }
    }
    
    
    func isCompletedHH(formClass: AddNewHouseHoldForm_TVC)  {
        
        DBManagerHousehold().checkHHCompleted(houseHoldNumber: formClass.strHHNumber, completionType: HHCompletionStatusCode.completed, Completion: { (isChecked) in
            
            
            self.delegate?.hhDataUpdated()
           
            
        })
    }
    
    
}
