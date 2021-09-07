//
//  AddNewHouseholdForm_ViewModel.swift
//  NPR_census
//
//  Created by = "" on 02/09/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
protocol formDetailProtocol {
    

    
    func personalDetailFill()
    func educationDetailFill()
    func presentAddressDetailFill()
    func permanentAddressDetailFill()
    func fatherDetailAddressDetailFill()
    func morthrDetailAddressDetailFill()
     
}

protocol  AddNewHouseholdForm_ViewModelDelegate{
    func dataSavedSucessFully()
   
}

class AddNewHouseholdForm_ViewModel {
    
    var formClass = AddNewHouseHoldForm_TVC()
    var modelHH = NPR_2021hh_Details()
    var modelMemberDetail = NPR2021MemberDetails()
    
    var delgate:AddNewHouseholdForm_ViewModelDelegate?
    var alertView = AlertView()
    let presentAddProtocoll:FormPresentAddressProtocol? = nil
    let permanentAddProtocoll:FormPermanentAddressProtocol? = nil
    
    
    
    
    //MARK:Fill Form Detail
    
    //MARK:Fill Personal Detail
    
    //MARK:Fill Education Detail
    
    //MARK:Fill Present Address Detail
    
    func presentAddressMember(memberDetal:NPR2021MemberDetails,formClass:AddNewHouseHoldForm_TVC)  {
      
        PresentAddressDetailFill().memberPresentAddressFill(modelHH: memberDetal, formClass: formClass)
        
    }
    
    func presentAddressHead(hhModel:NPR_2021hh_Details,formClass:AddNewHouseHoldForm_TVC)  {
       
        //PresentAddressDetailFill().headPresentAddressFill(modelHH: hhModel, formClass: formClass)
        
    }
    
    //MARK:Fill Permanent Address Detail
    
    
    
    func permanentAddressMember(memberDetal:NPR2021MemberDetails,formClass:AddNewHouseHoldForm_TVC)  {
      
        //PermanentAddressDetailFill().memberPermanentAddressFill(modelMember: memberDetal, formClass: formClass)
        
    }
    
    func permanentAddressHead(hhModel:NPR_2021hh_Details,formClass:AddNewHouseHoldForm_TVC)  {
       
        
        
       // PermanentAddressDetailFill().headPermanentAddressFill(modelHH: hhModel, formClass: formClass)
        
    }
    
    func btnStaySinceBirthTap(sender:UIButton , formClass:AddNewHouseHoldForm_TVC)  {
        
        PermanentAddressDetailFill().staySinceBirth(sender: sender, formClass: formClass)
    }
    
    
    
    
    
    //MARK:Validation
    func validate(formClass:AddNewHouseHoldForm_TVC)  {
        // && isvalid_fatherDetail(formClass: formClass) && isvalid_motherDetail(formClass: formClass)
      // Personal Detail
        if isValid_personalDetail(formClass: formClass) && isValid_edu_occu(formClass: formClass)  && isValid_presentAddress(formClass: formClass) && isValid_permanentAdd(formClass: formClass) && isValid_ID(formClass: formClass) {
            
            checkHouseAndInsert(formClass: formClass)
        
        }
        
    }
    
    func isValid_personalDetail(formClass:AddNewHouseHoldForm_TVC) -> Bool {
        
        if formClass.pd_houseNo.text == "" {
            alertShow(message: English.AddNewMemberFormAlert.hNEmpty, formClass: formClass)
             return false
            
        }
       
        else if formClass.tf_pd_houseHoldNO.text == "" {
            alertShow(message: English.AddNewMemberFormAlert.hhEmpty, formClass: formClass)
            return false
            
        }
//        else if !DBManagerHousehold().is_censusHouseholdExist(strCensusHHNo: formClass.tf_pd_houseHoldNO.text ?? ""){
//            alertShow(message: English.AddNewMemberFormAlert.censusHHNoExist, formClass: formClass)
//            return false
//        }
        else if formClass.tf_pd_Name.text == "" && formClass.tf_pd_Name.text?.count ?? 0 < 3 {
            alertShow(message: English.AddNewMemberFormAlert.nameValidation, formClass: formClass)
            return false
            
        }
        else if formClass.genderId.rawValue == 0{
            alertShow(message: English.AddNewMemberFormAlert.gender, formClass: formClass)
            return false 
            
        }
        else if formClass.maritalStatus == .none{
            alertShow(message: English.AddNewMemberFormAlert.maritalStatusMiss, formClass: formClass)
            return false
            
        }
        else if formClass.btn_pd_relationWithHead.titleLabel?.text == "" {
            alertShow(message: English.AddNewMemberFormAlert.relationEmpty, formClass: formClass)
            return false
            
        }
        else if formClass.genderId.rawValue  <= 0{
            alertShow(message: English.AddNewMemberFormAlert.gender, formClass: formClass)
            return false
            
        }
        else if (formClass.tf_pd_Dob_date.text?.count ?? 0 < 2)||(formClass.tf_pd_Dob_month.text?.count ?? 0 < 2)||(formClass.tf_pd_Dob_year.text?.count ?? 0 < 4) || !FormDateMangement().dateFormat(type: .personal, formClass: formClass).isValidDOB(){
           
            alertShow(message: English.AddNewMemberFormAlert.memberDOBEmpty, formClass: formClass)
            
            return false
            
        }
        else if formClass.tf_pd_Dob_month.text  == ""{
            alertShow(message: English.AddNewMemberFormAlert.memberDob_monthEmpty, formClass: formClass)
            return false
            
        }
        else if formClass.tf_pd_Dob_year.text  == ""{
            alertShow(message: English.AddNewMemberFormAlert.memberDob_yearEmpty, formClass: formClass)
            return false
            
        }
        
        else if formClass.btn_pd_birthPlaceCountry.titleLabel?.text == ""  || (formClass.btn_pd_birthPlaceCountry.titleLabel?.text == nil) {
            alertShow(message: English.AddNewMemberFormAlert.memberBirthCountry, formClass: formClass)
            return false
            
        }
       else if (formClass.btn_pd_birthPlaceState.titleLabel?.text == "") || (formClass.btn_pd_birthPlaceState.titleLabel?.text == nil)  {
            alertShow(message: English.AddNewMemberFormAlert.memberBirthState, formClass: formClass)
            return false
            
        }
        else if formClass.btn_pd_birthPlaceDistrict.titleLabel?.text == ""  || (formClass.btn_pd_birthPlaceDistrict.titleLabel?.text == nil) {
            alertShow(message: English.AddNewMemberFormAlert.memberBirthDistrict, formClass: formClass)
            return false
            
        }
        
        else if formClass.btn_pd_Natinality.titleLabel?.text == "" || (formClass.btn_pd_Natinality.titleLabel?.text == nil) {
            alertShow(message: English.AddNewMemberFormAlert.chooseNationality, formClass: formClass)
            return false
            
        }
        
        else {
            return true
        }
        
    }
    
    
    func isValid_edu_occu(formClass:AddNewHouseHoldForm_TVC)->Bool  {
        
        if formClass.btn_ed_qualification.titleLabel?.text == "" || (formClass.btn_ed_qualification.titleLabel?.text == nil) {
            alertShow(message: English.AddNewMemberFormAlert.chooseEduQualification, formClass: formClass)
            return false
            
        }
        else if formClass.btn_ed_occupation.titleLabel?.text == "" || (formClass.btn_ed_occupation.titleLabel?.text == nil){
            alertShow(message: English.AddNewMemberFormAlert.chooseOccupation, formClass: formClass)
            return false
            
            
        }
        else if formClass.btn_ed_motherTounge.titleLabel?.text == "" || (formClass.btn_ed_motherTounge.titleLabel?.text == nil){
            alertShow(message: English.AddNewMemberFormAlert.chooseMotherTongue, formClass: formClass)
            return false
           
            
        }
       
        else {
            return true
        }
       
    }
    
    
    func isvalid_fatherDetail(formClass:AddNewHouseHoldForm_TVC) ->Bool  {
        
        let textCount = formClass.parentDetail_fatherName.text?.count ?? 0
        
        if ( textCount < 3 && textCount > 0)  {
            alertShow(message: English.AddNewMemberFormAlert.fatherNameInvalid, formClass: formClass)
            return false
            
        }
        else if (formClass.tf_ParentDetail_dob_date.text?.count ?? 0 < 2)||(formClass.tf_ParentDetail_dob_month.text?.count ?? 0 < 2)||(formClass.tf_ParentDetail_dob_year.text?.count ?? 0 < 4) || !FormDateMangement().dateFormat(type: .father, formClass: formClass).isValidDOB(){
            let strDOB = FormDateMangement().dateFormat(type: .father, formClass: formClass)
            if !strDOB.isValidDOB(){
            alertShow(message: English.AddNewMemberFormAlert.fatherDob_invalid, formClass: formClass)
            }
            return false
            
        }
        
        
//         if formClass.btn_parentDeatil_BirthState.titleLabel?.text == "" || (formClass.btn_parentDeatil_BirthState.titleLabel?.text == nil){
//            alertShow(message: English.AddNewMemberFormAlert.chooseFatherDob_state, formClass: formClass)
//
//            return false
//
//        }
//        else if formClass.btn_parentDetail_birthDistrict.titleLabel?.text == "" || (formClass.btn_parentDetail_birthDistrict.titleLabel?.text == nil) {
//
//            alertShow(message: English.AddNewMemberFormAlert.chooseFatherDob_district, formClass: formClass)
//            return false
//        }
            
       
        else {
            return true
        }
        
        
    }
    
    
    func isvalid_motherDetail(formClass:AddNewHouseHoldForm_TVC) ->Bool  {
        
        let textCount = formClass.tf_ParentDetail_motherName.text?.count ?? 0
        
        if textCount < 3 && textCount > 0 {
            
            alertShow(message: English.AddNewMemberFormAlert.motherNameInvalid, formClass: formClass)
            return false
            
        }
        else if (formClass.tf_ParentDetail_motherDob_date.text?.count ?? 0 < 2)||(formClass.tf_ParentDetail_motherDob_month.text?.count ?? 0 < 2)||(formClass.tf_ParentDetail_motherDob_year.text?.count ?? 0 < 4) || !FormDateMangement().dateFormat(type: .mother, formClass: formClass).isValidDOB(){
            
            
            
            alertShow(message: English.AddNewMemberFormAlert.motherDob_invalid, formClass: formClass)
                
          
            return false
            
        }
//        else if formClass.btn_ParentDetail_motherBirthCountry.titleLabel?.text == "" || (formClass.btn_ParentDetail_motherBirthCountry.titleLabel?.text == nil) {
//
//            alertShow(message: English.AddNewMemberFormAlert.chooseMotherDob_country, formClass: formClass)
//        }
        
//        if formClass.btn_ParentDetail_motherBirthState.titleLabel?.text == "" || (formClass.btn_ParentDetail_motherBirthState.titleLabel?.text == nil) {
//            alertShow(message: English.AddNewMemberFormAlert.chooseMotherDob_state, formClass: formClass)
//            return false
//
//        }
//        else if formClass.btn_ParentDetail_motherBirthDistrict.titleLabel?.text == "" || (formClass.btn_ParentDetail_motherBirthDistrict.titleLabel?.text == nil) {
//
//            alertShow(message: English.AddNewMemberFormAlert.chooseMotherDob_district, formClass: formClass)
//
//            return false
//        }
            
        
        else {
            return true
        }
        
        
    }
    
    
    func isValid_presentAddress(formClass:AddNewHouseHoldForm_TVC) -> Bool {
        
          if formClass.btn_ptAdd_Country.titleLabel?.text == "" || (formClass.btn_ptAdd_Country.titleLabel?.text == nil) {
            
            alertShow(message: English.AddNewMemberFormAlert.choosePresentAddress_country, formClass: formClass)
            
            return false
        }
       
           
            
        
        else if formClass.btn_ptAdd_State.titleLabel?.text == "" || (formClass.btn_ptAdd_State.titleLabel?.text == nil) {
            alertShow(message: English.AddNewMemberFormAlert.choosePresentAddress_state, formClass: formClass)
            
            return false
            
        }
        else if formClass.btn_ptAdd_District.titleLabel?.text == "" || (formClass.btn_ptAdd_District.titleLabel?.text == nil) {
            alertShow(message: English.AddNewMemberFormAlert.choosePresentAddress_district, formClass: formClass)
            return false
        }
        else if formClass.btn_ptAdd_subDistrict.titleLabel?.text == "" || (formClass.btn_ptAdd_subDistrict.titleLabel?.text == nil) {
            
            alertShow(message: English.AddNewMemberFormAlert.choosePresentAddress_subDistrict, formClass: formClass)
            
            return false
        }
        else if formClass.tf_ptAd_townVillage.text? .count ?? 0 < 2 {
            
            alertShow(message: English.AddNewMemberFormAlert.checkPresentAddress_town_village, formClass: formClass)
           return false
        }
        else if formClass.tf_ptAd_pinCode.text? .count ?? 0 < 6 {
            
            alertShow(message: English.AddNewMemberFormAlert.checkPresentAddress_pinCode, formClass: formClass)
           return false
            
        }
        else {
            return true
        }
            
        
        
       
    }
    
    func isValid_permanentAdd(formClass:AddNewHouseHoldForm_TVC) -> Bool {
        
          if formClass.btn_PaddCountry.titleLabel?.text == "" || (formClass.btn_PaddCountry.titleLabel?.text == nil) {
            
            alertShow(message: English.AddNewMemberFormAlert.choosePermanentAddress_country, formClass: formClass)
            return false
        }
       
           
            
        
        else if formClass.btn_padState.titleLabel?.text == "" || (formClass.btn_padState.titleLabel?.text == nil) {
            alertShow(message: English.AddNewMemberFormAlert.choosePermanentAddress_state, formClass: formClass)
            
            return false
            
        }
        else if formClass.btn_padDistrict.titleLabel?.text == "" || (formClass.btn_padDistrict.titleLabel?.text == nil) {
            alertShow(message: English.AddNewMemberFormAlert.choosePermanentAddress_district, formClass: formClass)
            return false
        }
        else if formClass.btn_PadSubDistrict.titleLabel?.text == "" || (formClass.btn_PadSubDistrict.titleLabel?.text == nil) {
            
            alertShow(message: English.AddNewMemberFormAlert.choosePermanentAddress_subDistrict, formClass: formClass)
            
            return false
        }
        else if formClass.tf_padTownVillage.text? .count ?? 0 < 2 {
            alertShow(message: English.AddNewMemberFormAlert.checkPermanentAddress_town_village, formClass: formClass)
           return false
        }
        else if formClass.tf_padPinCode.text? .count ?? 0 < 5 {
            
            alertShow(message: English.AddNewMemberFormAlert.checkPermanentAddress_pinCode, formClass: formClass)
           return false
            
        }
        else {
            return true
        }
            
        
        
       
    }
    
    func isValid_ID(formClass:AddNewHouseHoldForm_TVC) -> Bool {
        
        if !(Verhoeff.validateVerhoeff(for: formClass.tf_ID_adhar.text ?? "")) {
            alertShow(message: English.AddNewMemberFormAlert.inValidAadharNumber, formClass: formClass)
            return false
        }else if formClass.tf_ID_mobile.text?.count ?? 0 > 0 {
            if !(formClass.tf_ID_mobile.text?.isValidMobileNumber() ?? true)  {
                alertShow(message: English.AddNewMemberFormAlert.inValidMobilerNumber, formClass: formClass)
            }
            
            return false
        }
//        else if (formClass.tf_ID_voter.text?.count != 10){
//            alertShow(message: English.AddNewMemberFormAlert.inValidVoterID, formClass: formClass)
//            return false
//        }
        
//        else if formClass.tf_ID_dL.text?.count ?? 0 >= 16  {
//            alertShow(message: English.AddNewMemberFormAlert.inValidDL, formClass: formClass)
//            return false
//        }
    return true
//
//        if !(Verhoeff.validateVerhoeff(for: formClass.tf_ID_adhar.text ?? "")) || !(formClass.tf_ID_adhar.text?.count == 0){
//            alertShow(message: English.AddNewMemberFormAlert.inValidAadharNumber, formClass: formClass)
//            return false
//        }else if !(formClass.tf_ID_mobile.text?.isValidMobileNumber() ?? true) || !(formClass.tf_ID_mobile.text?.count == 0) {
//            alertShow(message: English.AddNewMemberFormAlert.inValidMobilerNumber, formClass: formClass)
//            return false
//        }else if (formClass.tf_ID_voter.text?.count != 10) || !(formClass.tf_ID_voter.text?.count == 0){
//            alertShow(message: English.AddNewMemberFormAlert.inValidVoterID, formClass: formClass)
//            return false
//        }else if formClass.tf_ID_dL.text?.count ?? 0 >= 16 || !(formClass.tf_ID_dL.text?.count == 0) {
//            alertShow(message: English.AddNewMemberFormAlert.inValidVoterID, formClass: formClass)
//            return false
//        }
//    return true
        
    }
    
    
    
    func refreshDobField(type:dobType,formClass:AddNewHouseHoldForm_TVC) {
        
      
        switch type {
        case .personal:
             formClass.tf_pd_Dob_date.text =  ""
             formClass.tf_pd_Dob_month.text = ""
             formClass.tf_pd_Dob_year.text = ""
            AlertView().alertWithoutButton(vc: formClass, message: English.AddNewMemberFormAlert.dob_invalid)
           break
        
        case .father:
            
            formClass.tf_ParentDetail_dob_date.text =  ""
            formClass.tf_ParentDetail_dob_month.text = ""
            formClass.tf_ParentDetail_dob_year.text = ""
            AlertView().alertWithoutButton(vc: formClass, message: English.AddNewMemberFormAlert.fatherDob_invalid)
             
            break
           
       
        case .mother:
            
            formClass.tf_ParentDetail_motherDob_date.text =  ""
            formClass.tf_ParentDetail_motherDob_month.text = ""
            formClass.tf_ParentDetail_motherDob_year.text = ""
            AlertView().alertWithoutButton(vc: formClass, message: English.AddNewMemberFormAlert.motherDob_invalid)
           break

        }
        
      
    }
    
    
    
    func alertShow (message:String,formClass:AddNewHouseHoldForm_TVC){
        
        alertView.showAlertWithSingleButton(vc: formClass, title: "", message: message)
        
    }
    
    
    
    
    
}


extension AddNewHouseholdForm_ViewModel {
    
    func checkHouseAndInsert(formClass: AddNewHouseHoldForm_TVC)  {
        
        let formDataSaveObj = FormDataSavingManagement()
        
        formDataSaveObj.delegate = self
        
        guard let objNprData = DataBaseManager().openDataBase(entityName: EntityName.npr2021Data) as? NPR2021MemberDetails else {
            return
        }
        let predicate = NSPredicate(format: "hh_tin = %@",formClass.strHHNumber.hhTin() )
        
        let availableHH = DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicate) as? [NPR_2021hh_Details]
        if availableHH?.count == 0 {
            
            
            DBManagerHousehold().saveNewHouseHold(formClass: formClass, complete: {(isSaved) in
                
                
                formDataSaveObj.saveMemberFormData(formClass: formClass, objNprData: objNprData)
            })
            
        }
        else{
            
            if formClass.entryT == .editDetail {
                formDataSaveObj.saveMemberFormData(formClass: formClass, objNprData: formClass.modelMemberDetail)
                
                
            }
            else{
                
                formDataSaveObj.saveMemberFormData(formClass: formClass, objNprData: objNprData)
                
                
            }
            
        }
    }
    
    
}


extension AddNewHouseholdForm_ViewModel:FormDataSavingManagementProtocoll  {
    func hhDataUpdated () {
        delgate?.dataSavedSucessFully()
    }
    
    func dataSavedInMemberTable() {
        delgate?.dataSavedSucessFully()
    }
    
    
}

