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
    
    //var formClass = AddNewHouseHoldForm_TVC()
//    var modelHH = NPR_2021hh_Details()
//    var modelMemberDetail = NPR2021MemberDetails()
    
    // Personal Detail
    
    var objPersonalDetail : FormPersonalDetailManagement?
    var objEduDetail:FormEducationQualificationManagement?
    
    var objPermanentAddressDetail : FormPermanentAddressDetailFill?
    var objPresentAddressDetail : FormPresentAddressDetailFill?
    var objIDManagement : FormIDManagement?
    
    
    var delgate:AddNewHouseholdForm_ViewModelDelegate?
    var alertView = AlertView()
    //let presentAddProtocoll:FormPresentAddressProtocol? = nil
   // let permanentAddProtocoll:FormPermanentAddressProtocol? = nil
    
    private var formClass:AddNewHouseHoldForm_TVC?
   // var objPermanentAffress = FormPresentAddressDetailFill()
    
    
    
    init(formClass:AddNewHouseHoldForm_TVC) {
        self.formClass = formClass
        objPermanentAddressDetail = FormPermanentAddressDetailFill.init(formClass: formClass)
        objPresentAddressDetail = FormPresentAddressDetailFill(formClass: formClass)
        objEduDetail = FormEducationQualificationManagement.init(formClass: formClass)
        objIDManagement = FormIDManagement.init(formClass: formClass)
    }
    
    deinit {
        self.formClass = nil
    }
    
   
    func viewPrepareForAllCondition()  {
    
        
      let objFormPD =  FormPersonalDetailManagement.init(formClass: formClass!)
        objFormPD.pd_setLabelTagAcordingSL()
        objEduDetail?.ed_setTagLabel(formClass: formClass!)
        let farmClassPresentAdd = FormPresentAddressDetailFill.init(formClass: formClass!)
        farmClassPresentAdd.presentAdd_setTagLabel()
        
        let farmClassPermanentAdd = FormPermanentAddressDetailFill.init(formClass: formClass!)
        farmClassPermanentAdd.permanentAdd_setTagLabel()
        
        let formClassParentsDetail = ParentDataManagementClass.init(formClass: formClass!)
        formClassParentsDetail.fatherDetail_setTaglabel()
        formClassParentsDetail.motherDetail_setTaglabel()
        
        let formIDDetail = FormIDManagement.init(formClass: formClass!)
        formIDDetail.setTagLabel()
        
       // let formPtAdd = presentad
        var strPrevPageName = ""
        var strPageTitle = ""
        
        formClass!.btn_parentDetail_BirthCountry.setTitle("India", for: .normal)
        formClass!.btn_ParentDetail_motherBirthCountry.setTitle("India", for: .normal)
        
        switch  formClass!.entryT{
        case .newHouseHold:
           
            //formClass!.memberStatus = MemberStatusCode.newMemberformClass!
            formClass!.strMemberNumber = DBManagerMemberDetail().getNewMemberSerialNumber(hhNumber: formClass!.strHHNumber)
            formClass!.basicInfo_Member(hhN: formClass!.strHHNumber , headName: formClass!.strMemberName )
            formClass!.memberStatus = MemberStatusCode.newMember
            formClass!.tf_pd_Name.text = formClass!.strMemberName
            formClass!.hh_completionStatus = HHCompletionStatusCode.completed
            formClass!.stackViewSamePresentAddAsHead.isHidden = true
            formClass!.stackViewSamePermanentAddAsHead.isHidden = true
            formClass!.stackViewSamePermanentAddAsPerticularMember.isHidden = true
            //formModelClass?.presentAddressHead(hhModel: <#T##NPR_2021hh_Details#>, formClass: <#T##AddNewHouseHoldForm_TVC#>)
            objPresentAddressDetail?.presentAddreesForNewMember()
            strPageTitle = LanguageModal.langObj.hh_member_form
            strPrevPageName = LanguageModal.langObj.hh_summary
            break
            
        case .addNewMemberExitHH:
            formClass!.strHHNumber = formClass!.modelHH.houseHoldhNo ?? ""
            
            formClass!.strMemberNumber = DBManagerMemberDetail().getNewMemberSerialNumber(hhNumber: formClass!.strHHNumber)
            formClass!.lblPageTitle.text = "Household Member Detail"
            formClass!.basicInfo_Member(hhN: formClass!.strHHNumber, headName: English.AddNewMemberFormAlert.newMember)
            formClass!.memberStatus = MemberStatusCode.newMember
            
            
            formClass?.selectedHouseType = HouseType.init(rawValue: formClass!.modelHH.hhType ?? "1" )
            formClass!.hhAlreadyExist()
            formClass!.stackViewSamePresentAddAsHead.isHidden = true
            formClass!.stackViewSamePermanentAddAsHead.isHidden = false
            formClass!.stackViewSamePermanentAddAsPerticularMember.isHidden = false
            objPresentAddressDetail?.presentAddreesForNewMember()
            
            strPageTitle = LanguageModal.langObj.hh_member_form
            strPrevPageName = LanguageModal.langObj.hh_member_details
            break
            
        case .editDetail:
            
            formClass!.strHHNumber = formClass!.modelHH.houseHoldhNo ?? ""
            formClass!.viewPrepareEditMember()
            formClass!.strMemberNumber = formClass!.modelMemberDetail.sloMember ?? ""
            formClass!.basicInfo_Member(hhN: formClass!.modelMemberDetail.hh_Number ?? "", headName: formClass!.modelMemberDetail.name ?? "")
            formClass!.tf_ptAd_houseNumber.text = formClass!.modelMemberDetail.censusHouse_number
           // personalDetail()
            //educationDetail()
            
            
            formClass?.selectedHouseType = HouseType.init(rawValue: formClass!.modelHH.hhType ?? "1" )
            formClass!.fatherDetail(modelMember: formClass!.modelMemberDetail, modelType: .personal)
            formClass!.motherDetail(modelMember: formClass!.modelMemberDetail, modelType: .personal)
            formClass!.stackViewSamePermanentAddAsPerticularMember.isHidden = false
            //idDetail()
            formClass!.lblPageTitle.text = "Household Member Detail"
            
           
            
            //personalDetail()
            //formClass!.memberStatus = MemberStatusCode.available
            if formClass!.entryT == .editDetail  {
                if formClass!.modelMemberDetail.memberStatus == MemberStatusCode.newMember {
                    formClass!.memberStatus = MemberStatusCode.newMember
                }else{
                    formClass!.memberStatus = MemberStatusCode.available
                }
            }
            
            formClass!.hhAlreadyExist()
            
            
            
            setMemberDetailData()
            
            strPageTitle = LanguageModal.langObj.hh_member_updation_form
            strPrevPageName = LanguageModal.langObj.hh_member_details
            
            break
        
        }
        
        formClass?.lblPrevPageName.text = strPrevPageName
        formClass?.lblPageTitle.text = strPageTitle
       textFieldDelegateConnection()
    }
    
    //MARK:TextFiled Delegate Connection
    
    func textFieldDelegateConnection()  {
        
        formClass?.tf_staySameAddressYear.delegate = objPermanentAddressDetail
    }
    
    //MARK:Fill Form Validation
    
    func submitFormData()  {
        if self.formClass == nil {
            return
        }
        //validate()
    }
    

    
    //MARK:Fill Form Detail
    
    
    
    //MARK:Fill Personal Detail
    
    //MARK:Fill Education Detail
    
    //MARK:Fill Present Address Detail
    
 
    
    ///******************
    //MARK:Primaries Method
    ///******************
    
    
    
    
    
    func presentAddressMember()  {
      
        objPresentAddressDetail?.presentAddreesForNewMember()
        
    }
    
    func presentAddressHead(hhModel:NPR_2021hh_Details,formClass:AddNewHouseHoldForm_TVC)  {
       
        objPresentAddressDetail?.headPresentAddressFill(modelHH: hhModel)
        
    }
    
    
    //MARK:Member Edit
    
    func setMemberDetailData()  {
        
        objPersonalDetail = FormPersonalDetailManagement.init(formClass: formClass!)
        objPersonalDetail?.personalDataFill()
        
        if let memberData = formClass?.modelMemberDetail {
            objPresentAddressDetail?.memberPresentAddressFill(modelMember: memberData)
            
            objPermanentAddressDetail?.memberPermanentAddressFill(modelMember: memberData)
             
            objEduDetail?.setEducationQualificationData(formClass: formClass!)
            let objFormId = FormIDManagement(formClass: formClass!)
            objFormId.setIDDetail()
        
        }
    }
    
    //MARK:Fill Permanent Address Detail
    
    
    
    func permanentAddressMember(memberDetal:NPR2021MemberDetails,formClass:AddNewHouseHoldForm_TVC)  {
      
        objPermanentAddressDetail?.memberPermanentAddressFill(modelMember: memberDetal)
        
    }
    
    func permanentAddressHead(formClass:AddNewHouseHoldForm_TVC)  {
        
        
        
        objPermanentAddressDetail?.headPermanentAddressFill(formClass: formClass)
        
    }
    
    func btnStaySinceBirthTap(sender:UIButton)  {
        
        objPermanentAddressDetail?.staySinceBirth(sender: sender, formClass: formClass!)
    }
    
    
    
    
    
    //MARK:Validation
    func validate() {
       
        if ((formClass?.tf_pd_SE_refrenceNO.text?.isValidSENumber()) != nil) {
            checkHouseAndInsert()
        }else if isValid_personalDetail() && isValid_edu_occu()  && isValid_presentAddress() && objPermanentAddressDetail?.isValidPermanentAddress ?? false && isvalid_fatherDetail() && isvalid_motherDetail() && isValid_ID() {
            checkHouseAndInsert()
        }

    }
    
   private func isValid_personalDetail() -> Bool {
    let formClass = self.formClass!
    let isBirthCountryIndia = util.isCountryIndia(countryName: formClass.btn_pd_birthPlaceCountry.titleLabel?.text ?? "")
    let isBirthSateNotKnown = DBManager_CountryStateDistrict().getStateCode(stateName: formClass.btn_pd_birthPlaceState.titleLabel?.text ?? "") == util.notKnownStateCode
    
    
    if (formClass.pd_houseNo.text == "" || Int(formClass.pd_houseNo.text ?? "0") == 0) && (formClass.selectedHouseType != HouseType.houseLess){
            alertShow(message: English.AddNewMemberFormAlert.hNEmpty, formClass: formClass)
             return false
            
        }
       
        else if formClass.tf_pd_houseHoldNO.text == "" || Int(formClass.tf_pd_houseHoldNO.text ?? "0") == 0{
            alertShow(message: English.AddNewMemberFormAlert.hhEmpty, formClass: formClass)
            return false
            
        }
        else if DBManagerHousehold().is_censusHouseholdExist(strCensusHHNo: formClass.tf_pd_houseHoldNO.text ?? "".censusHHNumber()) && formClass.entryT == .newHouseHold &&  (formClass.selectedHouseType != HouseType.institute) {
            alertShow(message: English.AddNewMemberFormAlert.censusHHNoExist, formClass: formClass)
            return false
        }
        else if (formClass.entryT == .addNewMemberExitHH || formClass.entryT == .editDetail) && (formClass.modelHH.census_hhNo != formClass.tf_pd_houseHoldNO.text?.censusHHNumber() && DBManagerHousehold().is_censusHouseholdExist(strCensusHHNo: formClass.tf_pd_houseHoldNO.text ?? "".censusHHNumber())) {
            
            //if (formClass.modelHH.census_hhNo != formClass.tf_pd_houseHoldNO.text?.censusHHNumber() && DBManagerHousehold().is_censusHouseholdExist(strCensusHHNo: formClass.tf_pd_houseHoldNO.text ?? "".censusHHNumber())) {
                
                alertShow(message: English.AddNewMemberFormAlert.censusHHNoExist, formClass: formClass)
                
                return false
           // }
            
        }

        else if formClass.tf_pd_Name.text == "" || formClass.tf_pd_Name.text?.count ?? 0 == 0 {
            alertShow(message: LanguageModal.langObj.first_name_can_not_be_empty, formClass: formClass)
            return false
              
        }
        
            
//            if (formClass.tf_pd_midleName.text?.count == 1 && formClass.tf_pd_lastName.text?.count == 1) || (formClass.tf_pd_midleName.text?.count == 2 || formClass.tf_pd_lastName.text?.count == 2) {
//
//            }
//
            else if formClass.tf_pd_Name.text?.count ?? 0 == 1 && (formClass.tf_pd_midleName.text?.isEmpty ?? false && formClass.tf_pd_lastName.text?.isEmpty ?? false) {
                alertShow(message: LanguageModal.langObj.validation_first_name, formClass: formClass)
                return false
                
            }else if formClass.tf_pd_Name.text?.count ?? 0 == 1 && (formClass.tf_pd_midleName.text?.count ?? 0 < 2  && formClass.tf_pd_lastName.text?.count == 0)  {
                alertShow(message: LanguageModal.langObj.first_middle_name_should_be_2_char_length, formClass: formClass)
                return false
                
            }else if formClass.tf_pd_Name.text?.count ?? 0 == 1 && (formClass.tf_pd_midleName.text?.count == 0 && formClass.tf_pd_lastName.text?.count == 1)  {
                alertShow(message: LanguageModal.langObj.first_last_name_should_be_2_char_length, formClass: formClass)
                return false
            }
            else if formClass.tf_pd_Name.text?.count ?? 0 == 1 && (formClass.tf_pd_midleName.text?.count == 1 && formClass.tf_pd_lastName.text?.count == 1)  {
                alertShow(message: LanguageModal.langObj.first_middle_last_name_should_be_2_char_length, formClass: formClass)
                return false
            }
           
          
        else if formClass.genderId == .notSelect{
            alertShow(message: English.AddNewMemberFormAlert.gender, formClass: formClass)
            return false 
            
        }
        else if formClass.btn_pd_relationWithHead.titleLabel?.text == "" || formClass.btn_pd_relationWithHead.titleLabel?.text?.count == 0 || formClass.btn_pd_relationWithHead.titleLabel?.text == nil {
            alertShow(message: English.AddNewMemberFormAlert.relationEmpty, formClass: formClass)
            return false
            
        }
        else if formClass.maritalStatus == .none{
            alertShow(message: English.AddNewMemberFormAlert.maritalStatusMiss, formClass: formClass)
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
       else if ((formClass.btn_pd_birthPlaceState.titleLabel?.text == "") || (formClass.btn_pd_birthPlaceState.titleLabel?.text == nil)) && isBirthCountryIndia  {
            alertShow(message: English.AddNewMemberFormAlert.memberBirthState, formClass: formClass)
            return false
            
        }
        else if (formClass.btn_pd_birthPlaceDistrict.titleLabel?.text == ""  || (formClass.btn_pd_birthPlaceDistrict.titleLabel?.text == nil)) && ( isBirthCountryIndia && !isBirthSateNotKnown) {
            alertShow(message: English.AddNewMemberFormAlert.memberBirthDistrict, formClass: formClass)
            return false
            
        }
        
        else if formClass.btn_pd_Natinality.titleLabel?.text == "" || (formClass.btn_pd_Natinality.titleLabel?.text == nil) {
            alertShow(message: English.AddNewMemberFormAlert.chooseNationality, formClass: formClass)
            return false
            
        }
        else if formClass.tf_passportNumber.text?.count ?? 0 > 0 {
            if !(formClass.tf_passportNumber.text?.isValidPassport() ?? true)  {
                alertShow(message: English.AddNewMemberFormAlert.invalidPassportVlidation, formClass: formClass)
                return false
            }
            
           // return true
        }
        
        else {
            return true
        }
      return true
    }
    
    
   private func isValid_edu_occu()->Bool  {
        
    return objEduDetail?.isValid_edu_occu() ?? false
       
    }
    
    
    private func isvalid_fatherDetail() ->Bool  {
        
        let isValidContry = DBManager_CountryStateDistrict().getCountryCode(countryName: formClass?.btn_parentDetail_BirthCountry.titleLabel?.text ?? "") == util.countryCode
        let isValidState = DBManager_CountryStateDistrict().getStateCode(stateName: formClass?.btn_parentDeatil_BirthState.titleLabel?.text ?? "") != util.notKnownStateCode && formClass?.btn_parentDeatil_BirthState.titleLabel?.text?.count ?? 0 > 0
        
        let textCount = formClass?.parentDetail_fatherName.text?.count ?? 0
        
        
        
        if ( textCount < 2 && textCount > 0)  {
            alertShow(message: English.AddNewMemberFormAlert.fatherNameInvalid, formClass: formClass!)
            return false
            
        }
        
//        else if formClass?.btn_parentDetail_BirthCountry.titleLabel?.text?.count == 0 || formClass?.btn_parentDetail_BirthCountry.titleLabel?.text == nil {
//            alertView.alertWithoutButton( message: LanguageModal.langObj.validation_father_birth_country)
//            return false
//        }
//        else if (formClass?.btn_parentDeatil_BirthState.titleLabel?.text?.count == 0 || formClass?.btn_parentDeatil_BirthState.titleLabel?.text == nil) && isValidContry  {
//            alertView.alertWithoutButton( message: LanguageModal.langObj.validation_father_birth_state)
//            return false
//        }
        else if (formClass?.btn_parentDetail_birthDistrict.titleLabel?.text?.count == 0 || formClass?.btn_parentDetail_birthDistrict.titleLabel?.text == nil) && (isValidContry && isValidState) {
            alertView.alertWithoutButton( message: LanguageModal.langObj.validation_father_birth_district)
            return false
        }
        
        
        
        else if (formClass?.tf_ParentDetail_dob_date.text?.count ?? 0 > 1) {
            var parentDobAlertMessage = ""
            
            if (formClass?.tf_ParentDetail_dob_month.text?.count ?? 0 < 2) {
                parentDobAlertMessage = English.AddNewMemberFormAlert.fatherDob_monthEmpty
                //FormDateMangement().dateFormat(type: .father, formClass: formClass!).isValidParentDOB()
            }else{
                if (formClass?.tf_ParentDetail_dob_year.text?.count ?? 0 < 4) {
                    parentDobAlertMessage = English.AddNewMemberFormAlert.fatherDob_yearEmpty
                }else {
                   
                    let strDOB = FormDateMangement().dateFormat(type: .father, formClass: formClass!)
                    if !strDOB.isValidDOB(){
                        parentDobAlertMessage = English.AddNewMemberFormAlert.fatherDob_invalid
                    }else{
                        return true
                    }
                }
            }
            alertShow(message: parentDobAlertMessage, formClass: formClass!)
            return false

        }
 
        
        
        return true
    }
    
    
  private  func isvalid_motherDetail() ->Bool  {
        
    let isValidContry = DBManager_CountryStateDistrict().getCountryCode(countryName: formClass?.btn_ParentDetail_motherBirthCountry.titleLabel?.text ?? "") == util.countryCode
    let isValidState = DBManager_CountryStateDistrict().getStateCode(stateName: formClass?.btn_ParentDetail_motherBirthState.titleLabel?.text ?? "") != util.notKnownStateCode && formClass?.btn_ParentDetail_motherBirthState.titleLabel?.text?.count ?? 0 > 0
    
        let textCount = formClass!.tf_ParentDetail_motherName.text?.count ?? 0
        let spouseNameTextCount = formClass?.tf_ParentDetail_spouseName.text?.count ?? 0
        if textCount < 2 && textCount > 0 {
            
            alertShow(message: English.AddNewMemberFormAlert.motherNameInvalid, formClass: formClass!)
            return false
            
        }
//    else if formClass?.btn_ParentDetail_motherBirthCountry.titleLabel?.text?.count == 0 || formClass?.btn_ParentDetail_motherBirthCountry.titleLabel?.text == nil {
//        alertView.alertWithoutButton( message: LanguageModal.langObj.validation_mother_birth_country)
//        return false
//    }
//    else if (formClass?.btn_ParentDetail_motherBirthState.titleLabel?.text?.count == 0 || formClass?.btn_ParentDetail_motherBirthState.titleLabel?.text == nil) && isValidContry  {
//        alertView.alertWithoutButton( message: LanguageModal.langObj.validation_mother_birth_state)
//        return false
//    }
    else if (formClass?.btn_ParentDetail_motherBirthDistrict.titleLabel?.text?.count == 0 || formClass?.btn_ParentDetail_motherBirthDistrict.titleLabel?.text == nil) && (isValidContry && isValidState) {
        alertView.alertWithoutButton( message: LanguageModal.langObj.validation_mother_birth_district)
        return false
    }
    else if (formClass?.tf_ParentDetail_motherDob_date.text?.count ?? 0 > 1) {
        var parentDobAlertMessage = ""
        
        if (formClass?.tf_ParentDetail_motherDob_month.text?.count ?? 0 < 2) {
            parentDobAlertMessage = English.AddNewMemberFormAlert.motherDob_monthEmpty
            //FormDateMangement().dateFormat(type: .father, formClass: formClass!).isValidParentDOB()
        }else{
            if (formClass?.tf_ParentDetail_motherDob_year.text?.count ?? 0 < 4) {
                parentDobAlertMessage = English.AddNewMemberFormAlert.motherDob_yearEmpty
            }else {
               
                let strDOB = FormDateMangement().dateFormat(type: .mother, formClass: formClass!)
                if !strDOB.isValidDOB(){
                    parentDobAlertMessage = English.AddNewMemberFormAlert.motherDob_invalid
                }else{
                    return true
                }
            }
        }
        alertShow(message: parentDobAlertMessage, formClass: formClass!)
        return false

    }

    

   else if spouseNameTextCount < 2 && spouseNameTextCount > 0 {
        
        alertShow(message: English.AddNewMemberFormAlert.spouseNameInvalid, formClass: formClass!)
        return false
        
    }
        
        
    
    
    
    return true
}

        
        
    
    
    
   private func isValid_presentAddress() -> Bool {
        
    let formClass = self.formClass!
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
        else if formClass.tf_ptAd_townVillage.text?.count ?? 0 < 3 {
            
            alertShow(message: English.AddNewMemberFormAlert.checkPresentAddress_town_village, formClass: formClass)
           return false
        }
        else if formClass.tf_ptAd_houseNumber.text?.count ?? 0  < 3 &&  formClass.tf_ptAd_houseNumber.text?.count ?? 0 > 0 {
            
            alertShow(message: LanguageModal.langObj.address1, formClass: formClass)
           return false
        }
        else if formClass.tf_ptAd_pinCode.text?.count ?? 0  < 6 &&  formClass.tf_ptAd_pinCode.text?.count ?? 0 > 0 {
            
            alertShow(message: English.AddNewMemberFormAlert.checkPresentAddress_pinCode, formClass: formClass)
           return false
            
        }
        else {
            return true
        }

    }
  
   private func isValid_ID() -> Bool {
        
    let formClass = self.formClass!
        if !(Verhoeff.validateVerhoeff(for: formClass.tf_ID_adhar.text ?? "")) {
            alertShow(message: English.AddNewMemberFormAlert.inValidAadharNumber, formClass: formClass)
            return false
        }else if formClass.tf_ID_mobile.text?.count ?? 0 > 0 {
            if !(formClass.tf_ID_mobile.text?.isValidMobileNumber() ?? true)  {
                alertShow(message: English.AddNewMemberFormAlert.inValidMobilerNumber, formClass: formClass)
                return false
            }
            
            return true
        }
    if formClass.tf_ID_adhar.text?.count == 0 || formClass.tf_ID_adhar.text == "" || formClass.tf_ID_adhar.text == nil {
        if formClass.alertFor != .aadhar {
            let alertView = AlertView()
            formClass.alertFor = .aadhar
            alertView.delegate = formClass
            alertView.showAlert( title: "", message: English.AddNewMemberFormAlert.proceedWithoutAadhar)
            return false
//            alertView.showAlertWithSingleButton( title:"" , message:English.AddNewMemberFormAlert.proceedWithoutAadhar )
        }
        
    }
//        else if (formClass.tf_ID_voter.text?.count != 10){
//            alertShow(message: English.AddNewMemberFormAlert.inValidVoterID, formClass: formClass)
//            return false
//        }
        
//        else if formClass.tf_ID_dL.text?.count ?? 0 >= 16  {
//            alertShow(message: English.AddNewMemberFormAlert.inValidDL, formClass: formClass)
//            return false
//        }
    
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
    return true
        
    }
    
    
    
    func refreshDobField(type:dobType,formClass:AddNewHouseHoldForm_TVC) {
        
      
        switch type {
        case .personal:
             formClass.tf_pd_Dob_date.text =  ""
             formClass.tf_pd_Dob_month.text = ""
             formClass.tf_pd_Dob_year.text = ""
            AlertView().alertWithoutButton( message: LanguageModal.langObj.validation_member_dob_not_valid)
           break
        
        case .father:
            
            formClass.tf_ParentDetail_dob_date.text =  ""
            formClass.tf_ParentDetail_dob_month.text = ""
            formClass.tf_ParentDetail_dob_year.text = ""
            AlertView().alertWithoutButton( message: LanguageModal.langObj.validation_father_dob_not_valid)
             
            break
           
       
        case .mother:
            
            formClass.tf_ParentDetail_motherDob_date.text =  ""
            formClass.tf_ParentDetail_motherDob_month.text = ""
            formClass.tf_ParentDetail_motherDob_year.text = ""
            AlertView().alertWithoutButton( message: LanguageModal.langObj.validation_mother_dob_not_valid)
           break

        }
        
      
    }
    
    
    
    func alertShow (message:String,formClass:AddNewHouseHoldForm_TVC){
        
        alertView.showAlertWithSingleButton( title: "", message: message)
        
    }
  
    
    
    // Mark: disable all field if SERefrence Number is invalid
    
    func setForm_asRefrenceNumber()  {
        guard let formClass = formClass else {
            return
        }
        
        let personalD = FormPersonalDetailManagement.init(formClass: formClass )
        personalD.setPersonalDetail_asSERefrence()
        
        objEduDetail?.enableDisable_asSERefrence(formClass: formClass)
       
        let presentAdd = FormPresentAddressDetailFill.init(formClass: formClass )
        presentAdd.enableDisable_asSERefrence()
        
        let permanentAdd = FormPermanentAddressDetailFill.init(formClass: formClass )
        permanentAdd.enableDisable_asSERefrence()
        
        let parentAdd = FormPermanentAddressDetailFill.init(formClass: formClass )
        parentAdd.enableDisable_asSERefrence()
        
        let idDetail = FormIDManagement.init(formClass: formClass )
        idDetail.enableDisable_asSERefrence()
    }
}


extension AddNewHouseholdForm_ViewModel {
    
    func checkHouseAndInsert()  {
    
    let formClass = self.formClass!
    
        let formDataSaveObj = FormDataSavingManagement(formClass: formClass)
        
        formDataSaveObj.delegate = self
        
        formDataSaveObj.prepareForSaveSave()
        

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

