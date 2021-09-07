//
//  File.swift
//  NPR-2020
//
//  Created by Dileep on 28/01/21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation
import CoreData

@objc protocol FormDataSavingManagementProtocoll {
    @objc optional func hhDataUpdated()
     func dataSavedInMemberTable()
    @objc optional func houseHolddataSaved()
}

class FormDataSavingManagement {
    
    
    var delegate:FormDataSavingManagementProtocoll?
   private var formClass:AddNewHouseHoldForm_TVC?
   private var modelMember :NPR2021MemberDetails?
    
   
   ///******************
   //MARK:Init
   ///******************
    init(formClass:AddNewHouseHoldForm_TVC) {
        self.formClass = formClass
        //self.modelMember = formClass!.modelMemberDetail
        
        
    }
//    
    deinit {
        modelMember = nil
        formClass = nil
    }
    
    
   //
    func prepareForSaveSave()  {
        
        if self.formClass == nil {
            return
        }
       
        
        switch formClass?.entryT {
        case .addNewMemberExitHH:
            if isMemberDataDuplicate()  {
                AlertView().alertWithoutButton( message:"Data Duplicacy for this member")
            }else{
                saveMemberFormData()

            }
            break
        case .editDetail:
            saveMemberFormData()
        break
        case .newHouseHold:
            if  self.formClass != nil {
            saveHHData(formClass: self.formClass!)
            }
            break
            
        
        default:
            break
        }
        
    }
    
    func isMemberDataDuplicate() -> Bool  {
      
        let dateAndType = FormDateMangement().prepareDObForUpload(type: .personal, formClass: formClass!)
       // let dateAndTypeForSearch = FormDateMangement().prepareDObForDataBase(type: .personal, formClass: formClass!)
        let relName  = formClass?.btn_pd_relationWithHead.titleLabel?.text
        let arayRel = "\(formClass!.genderId.rawValue)".getRealtionShipAray()
        
       // let relCode = relName?.getName_by_ID(aray: arayRel) ?? ""
        let relCode = relName?.getDropDownItem_id(aray: arayRel) ?? ""
       
        
        //let predicate = NSPredicate.init(format: "hh_tin = %@ AND name = %@ AND dob = %@ AND rel_code", formClass?.strHHNumber.hhTin() ?? "" , formClass?.tf_pd_Name.text ?? "" , dateAndType.date,relCode)
        let name = "\(formClass!.tf_pd_Name.text ?? "") \(formClass!.tf_pd_midleName.text ?? "") \(formClass!.tf_pd_lastName.text ?? "")"
        
        var namekey = ""
        
        if util.isSelectedLang_english() {
            namekey = "name"
            
        }else{
            
            namekey = "nameSL"
        }
        
        
        let predicate = NSPredicate.init(format: "hh_tin = %@ AND \(namekey) = %@", formClass?.strHHNumber.hhTin() ?? "" , name )
        let members = DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data, predicate: predicate) as? [NPR2021MemberDetails]
        
       
      let duplicateData = members?.filter({$0.dob == dateAndType.date && $0.rel_code == relCode})
       
        return  duplicateData?.count ?? 0 > 0
        
    }
    
    func saveMemberdataInNewHH()  {
        //saveMemberFormData(formClass:formClass!, objNprData1: creatememberMangedObject())
    }
    
    ///******************
    //MARK:Data Save
    ///******************
    func saveHHData(formClass:AddNewHouseHoldForm_TVC)  {
        
        let predicate = NSPredicate(format: "hh_tin = %@",formClass.strHHNumber.hhTin() )
        
        let availableHH = DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicate) as? [NPR_2021hh_Details]
        if availableHH?.count == 0 {
            
            
            DBManagerHousehold().saveNewHouseHold(formClass: self.formClass!, complete: {(isSaved) in


                self.saveMemberFormData()
            })
            
            
        }
    }
    
    
    func saveNewHouseHold()  {
       

       
        let nprHHData = DataBaseManager().openDataBase(entityName: EntityName.nprHHStats) as? NPR_2021hh_Details
        let ebDetailModel  = singleton().selectEBListModel
        
        nprHHData?.addressPinCode = formClass!.tf_ptAd_pinCode.text ?? ""
        nprHHData?.addressHNLocality = formClass!.tf_ptAd_houseNumber.text ?? ""
        if !util.isSelectedLang_english() {
            nprHHData?.addressHNLocality_sl = formClass!.tf_ptAd_houseNumber.text ?? ""
        }
        nprHHData?.block_no = singleton().selectEBListModel.eb_block_number
        nprHHData?.houseHoldhNo = formClass!.strHHNumber.hhNumber()
        
            nprHHData?.census_hhNo = formClass!.tf_pd_houseHoldNO.text?.censusHHNumber()
        
            nprHHData?.census_hNo = formClass!.pd_houseNo.text?.censusHouseNumber()
            nprHHData?.houseNo = nprHHData?.census_hNo
        
         nprHHData?.sub_eb = ebDetailModel.ebSubEB_code ?? ""
        nprHHData?.hh_tin = formClass!.strHHNumber.hhTin()
        nprHHData?.hh_completed = HHCompletionStatusCode.completed
        nprHHData?.hh_status = HHStatusCode.new
        if util.isSelectedLang_english() {
            nprHHData?.instituteName = formClass!.strInstituteName
            
        }else{
            nprHHData?.instituteName_sl = formClass!.strInstituteName
        }
       // nprHHData?.instituteName = formClass!.strInstituteName 
        
        
        nprHHData?.stateCode = ebDetailModel.ebState_code
         nprHHData?.townCode = ebDetailModel.ebTown_code
        nprHHData?.tahsil_code = ebDetailModel.ebTahsil_code
        nprHHData?.head_DOB = FormDateMangement().dateFormat(type: .personal, formClass: formClass!)
       
        if util.isSelectedLang_english() {
            nprHHData?.headName = formClass!.tf_pd_Name.text ?? ""
            nprHHData?.isInEnglish = true
        }else{
            nprHHData?.headName_sl = formClass!.tf_pd_Name.text ?? ""
            nprHHData?.isInEnglish = true
        }
        
        
        nprHHData?.headGenderID = "\(formClass!.genderId.rawValue)"
         nprHHData?.isOpen = false
         //nprHHData?.isUpdated
         nprHHData?.wardID = ebDetailModel.ebWard_code ?? ""
        nprHHData?.ebNumber     = singleton().selectEBListModel.eb_number
        
        
        nprHHData?.hhType = formClass!.hhType
         
         do {
           // context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
             try context.save()
            delegate?.houseHolddataSaved?()
            print("IndexSaved")
            
            
             } catch {
                                     print(" Household list Failed saving")
                 
         }
        
        
    }
    
    
    func saveMemberFormData()  {
        
        //let objNprData = DataBaseManager().openDataBase(entityName: EntityName.npr2021Data) as? NPR2021MemberDetails
       // let context = appDelegate.persistentContainer.viewContext
       
        let objNprData = creatememberMangedObject()
        // Genral Info
        objNprData.language = LanguageModal.currentLanguage.lanaugeCode()
        objNprData.hh_tin = formClass!.strHHNumber.hhTin()
        objNprData.new_tin = formClass!.strMemberNumber.memberTin(hhNumber: formClass!.strHHNumber)
        //objNprData.tin = objNprData.new_tin
        objNprData.ebNumber = singleton().selectEBListModel.eb_number
        objNprData.censusHH_number = formClass!.tf_pd_houseHoldNO.text?.censusHHNumber()//formClass!.tf_pd_houseHoldNO.text ?? ""
        objNprData.censusHouse_number = formClass!.tf_pd_houseHoldNO.text?.censusHouseNumber()
        objNprData.selfEnumerationRef_number = formClass!.tf_pd_SE_refrenceNO.text ?? ""
        objNprData.hh_Number = formClass!.strHHNumber.hhNumber()
        objNprData.hh_status = formClass!.hhStatus
        objNprData.hh_Copletionstatus = formClass!.hh_completionStatus
        objNprData.memberStatus = formClass!.memberStatus
        
        
        objNprData.member_completionStatus = MemberCompletionStatusCode.completed
        objNprData.sloMember = formClass!.strMemberNumber.memberSrNumber()
        objNprData.sloHHD = formClass!.strHHNumber.hhNumber()
        // Personal Data
        
        if util.isSelectedLang_english() {
            objNprData.first_name = formClass!.tf_pd_Name.text ?? ""
            
        }else{
            objNprData.first_name_sl = formClass!.tf_pd_Name.text ?? ""
            
        }
        
        if util.isSelectedLang_english() {
            objNprData.midle_name = formClass!.tf_pd_midleName.text ?? ""
            
        }else{
            objNprData.midle_name_sl = formClass!.tf_pd_midleName.text ?? ""
            
        }
        
        if util.isSelectedLang_english() {
            objNprData.last_name = formClass!.tf_pd_lastName.text ?? ""
            
        }else{
            objNprData.last_name_sl = formClass!.tf_pd_lastName.text ?? ""
            
        }
        
        if util.isSelectedLang_english() {
            objNprData.name = "\(formClass!.tf_pd_Name.text ?? "") \(formClass!.tf_pd_midleName.text ?? "") \(formClass!.tf_pd_lastName.text ?? "")"
            
        }else{
            objNprData.nameSL = "\(formClass!.tf_pd_Name.text ?? "") \(formClass!.tf_pd_midleName.text ?? "") \(formClass!.tf_pd_lastName.text ?? "")"
            
        }
        
        
        
        objNprData.gender_id = "\(formClass!.genderId.rawValue)"
        
        objNprData.marital_status = formClass!.maritalStatus.rawValue
        let relName = formClass!.btn_pd_relationWithHead.titleLabel?.text ?? ""
        
        if let arayDropList =  objNprData.gender_id?.getRealtionShipAray() {
            objNprData.rel_code = relName.getDropDownItem_id(aray: arayDropList)
        }
        let arayRelationComponent = relName.components(separatedBy: "-")
        objNprData.rel_code = arayRelationComponent.first?.trimWhiteSpace()
        
       // objNprData.marital_status = formClass!.ma
        // DOB and Dob Type
        let dateAndType = FormDateMangement().prepareDObForUpload(type: .personal, formClass: formClass!)
        let dateAndTypeForSearch = FormDateMangement().prepareDObForDataBase(type: .personal, formClass: formClass!)
        objNprData.dob = dateAndType.date
        objNprData.dobForSearch = dateAndTypeForSearch.date
        objNprData.dob_type = dateAndType.dobType.rawValue
        objNprData.birthCountryName = formClass!.btn_pd_birthPlaceCountry.titleLabel?.text ?? ""
        
        objNprData.birthCountryCode = DBManager_CountryStateDistrict().getCountryCode(countryName: objNprData.birthCountryName ?? "")
        if util.isCountryCodeIndia(countryCode: objNprData.birthCountryCode ?? "") {
           
            objNprData.birthStateName = formClass!.btn_pd_birthPlaceState.titleLabel?.text ?? ""
            objNprData.birthStateCode = DBManager_CountryStateDistrict().getStateCode(stateName: objNprData.birthStateName ?? "")
            
            objNprData.birthDistrictName = formClass!.btn_pd_birthPlaceDistrict.titleLabel?.text ?? ""
            
            objNprData.birthDistrictCode = DBManager_CountryStateDistrict().getDistrictCode(stateCode: objNprData.birthStateCode ?? "" , districtName: objNprData.birthDistrictName ?? "")
        }
        else{
            
            objNprData.birthStateName =  ""
            objNprData.birthStateCode =  ""
            
            objNprData.birthDistrictName =  ""
            
            objNprData.birthDistrictCode = "" 
        }
        
        
        
        objNprData.nationality_name = formClass!.btn_pd_Natinality.titleLabel?.text ?? ""
        objNprData.nationality = DBManager_CountryStateDistrict().getCountryCode(countryName: formClass!.btn_pd_Natinality.titleLabel?.text ?? "083")
        
        objNprData.passpord_id = formClass!.tf_passportNumber.text ?? ""
        
        
        
        //Education Qualification
        
        objNprData.eduName = formClass!.btn_ed_qualification.titleLabel?.text ?? ""
        let arayEduComponent = objNprData.eduName?.components(separatedBy: "-")
        
        if let eduCode = arayEduComponent?.first?.trimWhiteSpace() {
//            objNprData.edu_code = String(format: AppFormat.twodigitFormat, component.last ?? "")
            
            objNprData.edu_code = eduCode
        }
        
        
        objNprData.occuName = formClass!.btn_ed_occupation.titleLabel?.text ?? ""
        let arayOccuComponent = objNprData.occuName?.components(separatedBy: "-")
        
//        let ocuCode = arayOccuComponent?.first ?? "".trimWhiteSpace()
//        objNprData.occu_code = ocuCode
        if let ocuCode = arayOccuComponent?.first?.trimWhiteSpace(){
           
            objNprData.occu_code = ocuCode//String(format: AppFormat.twodigitFormat, ocuCode)
            
        }
        
       // objNprData.occu_code = objNprData.eduName?.getDropDownItem_id(aray: English().occupation())
        
        objNprData.motherTounge = formClass!.btn_ed_motherTounge.titleLabel?.text ?? ""
       
//        let arayLangugeComponent = objNprData.motherTounge?.components(separatedBy: "-")
        
        //let intMTCode = Int(arayLangugeComponent?[1] ?? "")
        if let mtCode = Int(objNprData.motherTounge?.getDropDownItem_id(aray: LanguageModal.langObj.mother_toungeArr) ?? "")  {
            objNprData.motherToungeode = String(format: AppFormat.threeDigitFormat, mtCode)
            
            
            if mtCode == Int(999) {
                objNprData.otherMotherTounge = formClass?.tf_edu_enterOtherMotherTongue.text ?? ""
            }
        }
       
        
        //Parents Detail
        
        
        
        if util.isSelectedLang_english() {
            objNprData.father_name = formClass!.parentDetail_fatherName.text ?? ""
        }else{
            objNprData.father_name_sl = formClass!.parentDetail_fatherName.text ?? ""
        }
        
        let dateAndTypeFather = FormDateMangement().prepareDObForUpload(type: .father, formClass: formClass!)
        
        objNprData.father_dob  = dateAndTypeFather.date
        objNprData.father_dobType = dateAndTypeFather.dobType.rawValue
        objNprData.fatherBirthCountry = formClass!.btn_parentDetail_BirthCountry.titleLabel?.text ?? ""
        objNprData.fatherBirthCountryCode = DBManager_CountryStateDistrict().getCountryCode(countryName: objNprData.fatherBirthCountry ?? "")
        
        objNprData.fatherBirthState = formClass!.btn_parentDeatil_BirthState.titleLabel?.text ?? ""
        objNprData.fatherBirthStateCode = DBManager_CountryStateDistrict().getStateCode(stateName: objNprData.fatherBirthState ?? "")
        
        objNprData.fatherBirthDistrict = formClass!.btn_parentDetail_birthDistrict.titleLabel?.text ?? ""
        objNprData.fatherBirthDistrictCode = DBManager_CountryStateDistrict().getDistrictCode(stateCode: objNprData.fatherBirthStateCode ?? "", districtName: objNprData.fatherBirthDistrict ?? "")
        
        // Mother Detail
        
        if util.isSelectedLang_english() {
            objNprData.motherName = formClass!.tf_ParentDetail_motherName.text ?? ""
        }else{
            objNprData.motherName_sl = formClass!.tf_ParentDetail_motherName.text ?? ""
        }
        
       
        let dateAndTypeMother = FormDateMangement().prepareDObForUpload(type: .mother, formClass: formClass!)
        
        objNprData.mother_dob = dateAndTypeMother.date
        
        objNprData.mother_dobType = dateAndTypeMother.dobType.rawValue
        
        //objNprData.mother_dobType = formClass!.
        objNprData.mother_birthCountry = formClass!.btn_ParentDetail_motherBirthCountry.titleLabel?.text ?? ""
        objNprData.mother_birthCountryCode = DBManager_CountryStateDistrict().getCountryCode(countryName: objNprData.mother_birthCountry ?? "")
        
       
        objNprData.mother_birthState = formClass!.btn_ParentDetail_motherBirthState.titleLabel?.text ?? ""
        objNprData.mother_birthStateCode = DBManager_CountryStateDistrict().getStateCode(stateName: objNprData.mother_birthState ?? "")
        
        objNprData.mother_birthDistrict = formClass!.btn_ParentDetail_motherBirthDistrict.titleLabel?.text ?? ""
        objNprData.mother_birthDistrictCode = DBManager_CountryStateDistrict().getDistrictCode(stateCode: objNprData.mother_birthStateCode ?? "", districtName: objNprData.mother_birthDistrict ?? "")
        
        
        
        if util.isSelectedLang_english() {
            objNprData.spouseName = formClass!.tf_ParentDetail_spouseName.text ?? ""
        }else{
            objNprData.spouseName_sl = formClass!.tf_ParentDetail_spouseName.text ?? ""
        }
       
        
        // Present address
        
        objNprData.address_state = formClass!.btn_ptAdd_State.titleLabel?.text ?? ""
        objNprData.address_stateCode = DBManager_CountryStateDistrict().getStateCode(stateName: objNprData.address_state ?? "")
        
        objNprData.address_district = formClass!.btn_ptAdd_District.titleLabel?.text ?? ""
        objNprData.address_district_code = DBManager_CountryStateDistrict().getDistrictCode(stateCode: objNprData.address_stateCode ?? "", districtName: objNprData.address_district ?? "")
        
        objNprData.address_subDistrict = formClass!.btn_ptAdd_subDistrict.titleLabel?.text ?? ""
        objNprData.address_subDistrictCode = DBManager_CountryStateDistrict().getSubDistrictCode( stateCode: objNprData.paddress_stateCode ?? "", tahsilName: objNprData.address_subDistrict ?? "")
        if util.isSelectedLang_english() {
            objNprData.address_line2 = formClass!.tf_ptAd_townVillage.text ?? ""
            objNprData.address_line1 = formClass!.tf_ptAd_houseNumber.text ?? ""
            objNprData.pinCode = formClass!.tf_ptAd_pinCode.text ?? ""
        }else{
            objNprData.address_line2_sl = formClass!.tf_ptAd_townVillage.text ?? ""
            objNprData.address_line1_sl = formClass!.tf_ptAd_houseNumber.text ?? ""
            
        }
        objNprData.pinCode = formClass!.tf_ptAd_pinCode.text ?? ""
        
        // Permanent Address
        
        objNprData.paddress_countryCode = DBManager_CountryStateDistrict().getCountryCode(countryName: formClass!.btn_PaddCountry.titleLabel?.text ?? "")
        if util.isCountryCodeIndia(countryCode: objNprData.paddress_countryCode ?? "") {
            
            objNprData.paddress_state = formClass!.btn_padState.titleLabel?.text ?? ""
            objNprData.paddress_stateCode = DBManager_CountryStateDistrict().getStateCode(stateName:  objNprData.paddress_state ?? "")
            
             objNprData.paddre_district = formClass!.btn_padDistrict.titleLabel?.text ?? ""
            objNprData.paddre_districtCode = DBManager_CountryStateDistrict().getDistrictCode(stateCode: objNprData.paddress_stateCode ?? "", districtName: objNprData.paddre_district ?? "")
            
             objNprData.paddre_tahsil = formClass!.btn_PadSubDistrict.titleLabel?.text ?? ""
            objNprData.paddre_tahsilCode = DBManager_CountryStateDistrict().getSubDistrictCode(stateCode: objNprData.paddress_stateCode ?? "", tahsilName:  objNprData.paddre_tahsil ?? "")
            
             objNprData.ppinCode = formClass!.tf_padPinCode.text ?? ""
            
            if util.isSelectedLang_english() {
                objNprData.paddress_town = formClass!.tf_padTownVillage.text ?? ""
                 //objNprData.address_line2 = formClass!.tf_ptAd_townVillage.text ?? ""
                 objNprData.paddre_line1 = formClass!.tf_padHouseNumber.text ?? ""
            }else{
                objNprData.paddress_town_sl = formClass!.tf_padTownVillage.text ?? ""
                 //objNprData.address_line2 = formClass!.tf_ptAd_townVillage.text ?? ""
                 objNprData.paddre_line1_sl = formClass!.tf_padHouseNumber.text ?? ""
                
            }
            
        }
        else{
            
            objNprData.paddress_state =  ""
            objNprData.paddress_stateCode = ""
            
             objNprData.paddre_district = ""
            objNprData.paddre_districtCode = ""
            
             objNprData.paddre_tahsil =  ""
            objNprData.paddre_tahsilCode = ""
            objNprData.paddress_town =  ""
             //objNprData.address_line2 = formClass!.tf_ptAd_townVillage.text ?? ""
             objNprData.paddre_line1 =  ""
             objNprData.ppinCode =  ""
            
        }
        
        
        // Stay Last Residency
        
        objNprData.staying_since_birthdate = formClass!.isStayPrensetAddSinceBirth ? "1":"0"
        objNprData.duration_inYear = formClass?.tf_staySameAddressYear.text ?? ""
        
        
        objNprData.lastResidencyCountry = DBManager_CountryStateDistrict().getCountryCode(countryName: formClass!.btnLastResidenceCountry.titleLabel?.text ?? "")
        
        objNprData.lastResidencyState = DBManager_CountryStateDistrict().getStateCode(stateName:  formClass?.btnLastResidenceState.titleLabel?.text ?? "")
        
        objNprData.lastResidencyDistrict = DBManager_CountryStateDistrict().getDistrictCode(stateCode: objNprData.lastResidencyState ?? "", districtName: formClass?.btnLastResidenceDistrict.titleLabel?.text ?? "")
        //objNprData.staying_since_birthdate
        
        // Identification Detail
        
        objNprData.aadhar = formClass!.tf_ID_adhar.text ?? ""
        objNprData.mobile = formClass!.tf_ID_mobile.text ?? ""
        objNprData.driving_lincence = formClass!.tf_ID_dL.text ?? ""
        objNprData.voter_id = formClass!.tf_ID_voter.text ?? ""
        
        if formClass!.entryT == .editDetail  {
            if formClass!.modelMemberDetail.memberStatus == MemberStatusCode.newMember {
                objNprData.memberStatus = MemberStatusCode.newMember
            }else{
                objNprData.memberStatus = MemberStatusCode.available
            }
            formClass?.modelHH.respondentName = ""
        }
      
        do {
            try context.save()
            self.afterSaveMemberData()
           
        } catch  {
            
        }
    }
        
       
    
    func creatememberMangedObject() -> NPR2021MemberDetails  {
        
       
        switch formClass?.entryT {
        
            
        case .editDetail:
            
            if let modelMember = formClass?.modelMemberDetail {
                return modelMember
            }
            
            break
            
        default:
            guard let objMangedObject = DataBaseManager().openDataBase(entityName: EntityName.npr2021Data) as? NPR2021MemberDetails else {
                return NPR2021MemberDetails()
            }
            return objMangedObject
            
        }
        return NPR2021MemberDetails()
    }
    
    
    ///******************
    //MARK:After Data Save
    ///******************
    
    
    func afterSaveMemberData()  {
        updateViewAfterSaveData()
        if formClass!.entryT == .newHouseHold {
            delegate?.dataSavedInMemberTable()
        }
        else  {
        updateHHTableAfterMemberadd()
        }
    }
   
    // Update HH completion status , census hhN etc
    func updateHHTableAfterMemberadd()  {
        if formClass?.isEditingDetail ?? false {
            
        }
        
        if let modelHH = formClass?.modelHH {
            
            DBManagerMemberDetail().updateMemberStatusSkipedHH(hhModel: modelHH)
        }
        
        formClass!.modelHH.census_hhNo = formClass!.tf_pd_houseHoldNO.text?.censusHHNumber()
        formClass!.modelHH.census_hNo = formClass!.pd_houseNo.text?.censusHouseNumber()
        if formClass?.modelHH.hh_status == HHStatusCode.old || formClass?.modelHH.hh_status == HHStatusCode.notAvailable || formClass?.modelHH.hh_status == HHStatusCode.migratedOut ||  formClass?.modelHH.hh_status == HHStatusCode.locked {
            formClass?.modelHH.hh_status = HHStatusCode.available
        }
        //formClass?.modelHH.hh_status = HHStatusCode.available
        formClass!.modelHH.houseHoldhNo = formClass!.strHHNumber.hhNumber()
        formClass!.modelHH.hh_tin = formClass!.modelHH.hh_tin
        
        formClass!.modelHH.addressBlockId = singleton().selectEBListModel.eb_block_number
        formClass!.modelHH.addressPinCode = formClass?.tf_ptAd_pinCode.text ?? ""
        formClass!.modelHH.wardID = singleton().selectEBListModel.ebWard_code
        formClass!.modelHH.addressHNLocality = formClass?.tf_ptAd_houseNumber.text ?? ""
        
       // formClass!.modelHH.addressHNLocality = formClass?.tf_ptAd_houseNumber.text ?? ""
        
       
        do {
            try context.save()
            hhUpdateForskipedHH()
            if formClass!.entryT == .editDetail || formClass!.entryT == .addNewMemberExitHH  {
                isCompletedHH()
            }else{
            delegate?.hhDataUpdated?()
            }
        } catch  {
            
        }
        
        
    }
    
    func hhUpdateForskipedHH()  {
        
        if formClass!.entryT == .editDetail || formClass!.entryT == .addNewMemberExitHH {
            
        // This Function will check Skiped and update
        DBManagerHousehold().updateSkipedHHDependONMember(houseHoldModel: formClass!.modelHH)
        }
    }
    
    func updateViewAfterSaveData()  {
        FormRefreshManagement().refreshForm(formClass: formClass!)
    
        
    }
func isCompletedHH()  {
    
        DBManagerHousehold().checkHHCompleted(houseHoldNumber: formClass!.strHHNumber, completionType: HHCompletionStatusCode.completed, Completion: { (isChecked) in
            
           // DBManagerMemberDetail().updateMemberStatusSkipedHH(hhModel: formClass?.modelHH)
            self.delegate?.hhDataUpdated?()
           
            
        })
    }
    
    
    
}
