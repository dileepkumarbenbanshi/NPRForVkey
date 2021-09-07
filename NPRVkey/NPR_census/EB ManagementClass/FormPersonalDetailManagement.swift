//
//  PersonalDetailManagement.swift
//  NPR-2020
//
//  Created by Dileep on 05/02/21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation
import SwiftQRScanner
class FormPersonalDetailManagement {
    
    
    
    enum maritalStatus:Int {
        case naverMarried = 10 , currentalyMarried , widowed , seprated , divorced
    }
    
    
    
    enum marritalStaus:String {
        
        case neverMarried = "1"
        case curentlyMarried = "2"
        case widowed = "3"
        case seprated = "4"
        case divorced = "5"
        case none = ""
    }
    
    private var formClass:AddNewHouseHoldForm_TVC?
    private var modelMemberDetail:NPR2021MemberDetails?
    
    init(formClass:AddNewHouseHoldForm_TVC) {
        self.formClass = formClass
    }
    
    
    
    
    //MARK:Personal Data Fill
    
    func personalDataFill()  {
        
        modelMemberDetail = formClass?.modelMemberDetail
        if formClass == nil || modelMemberDetail == nil {
            return
        }
        setMaritalStatus(status: modelMemberDetail!.marital_status ?? "1")
        formClass!.strHHNumber = modelMemberDetail!.hh_Number ?? ""
               // tf_pd_houseHoldNO.isUserInteractionEnabled = false
                //Peronal Detail
        var name = ""
        
        if formClass!.modelMemberDetail.language?.IsSelectedLangauge_nonEnglish ?? false {
            name = ((modelMemberDetail?.first_name_sl?.count != 0) ? modelMemberDetail?.first_name_sl ?? "" : modelMemberDetail?.first_name) ?? ""
        }else{
            name = ((modelMemberDetail?.first_name?.count != 0) ? modelMemberDetail?.first_name ?? "" : modelMemberDetail?.first_name_sl) ?? ""
        }
        
        formClass!.tf_pd_Name.text = name
        
       
        var midleName = ""
        
        if formClass!.modelMemberDetail.language?.IsSelectedLangauge_nonEnglish ?? false {
            midleName = ((modelMemberDetail?.midle_name_sl?.count != 0) ? modelMemberDetail?.midle_name_sl ?? "" : modelMemberDetail?.midle_name) ?? ""
        }else{
            midleName = ((modelMemberDetail?.midle_name?.count != 0) ? modelMemberDetail?.midle_name ?? "" : modelMemberDetail?.midle_name_sl) ?? ""
        }
        
        formClass!.tf_pd_midleName.text = midleName
        
        
        var lastName = ""
        
        if formClass!.modelMemberDetail.language?.IsSelectedLangauge_nonEnglish ?? false {
            lastName = ((modelMemberDetail?.last_name_sl?.count != 0) ? modelMemberDetail?.last_name_sl ?? "" : modelMemberDetail?.last_name) ?? ""
        }else{
            lastName = ((modelMemberDetail?.last_name?.count != 0) ? modelMemberDetail?.last_name ?? "" : modelMemberDetail?.last_name_sl) ?? ""
        }
        
        formClass!.tf_pd_lastName.text = lastName
        
        
        formClass!.tf_pd_SE_refrenceNO.text = modelMemberDetail!.selfEnumerationRef_number ?? ""
        formClass!.tf_pd_houseHoldNO.text = formClass!.modelHH.census_hhNo ?? "" //modelMemberDetail.censusHH_number ?? ""
        formClass!.tf_ptAd_houseNumber.text = formClass!.modelHH.census_hNo ?? ""
        
        let dob = FormDateMangement().updateDobByStatus(strStatus:modelMemberDetail!.dob_type ?? "", strDate: modelMemberDetail!.dob ?? "")
        let dateComponent = dob.splitDateString()
        
        formClass!.tf_pd_Dob_date.text = dateComponent.date
        formClass!.tf_pd_Dob_month.text = dateComponent.month
        formClass!.tf_pd_Dob_year.text = dateComponent.year
        guard let arayRelation = modelMemberDetail?.gender_id?.getRealtionShipAray() else { return  }
        
        let relName = modelMemberDetail?.rel_code?.getName_by_ID(aray: arayRelation)
        
        let relCode_name = modelMemberDetail?.rel_code?.count ?? 0 > 0 ? "\(modelMemberDetail?.rel_code ?? "") - \(relName ?? "")" : ""
        
        formClass!.btn_pd_relationWithHead.setTitle(relCode_name, for: .normal)
        formClass!.btn_pd_birthPlaceDistrict.setTitle(modelMemberDetail!.birthDistrictName ?? "", for: .normal)
        formClass!.btn_pd_birthPlaceState.setTitle(modelMemberDetail!.birthStateName ?? "", for: .normal)
        
        let strContryCode = modelMemberDetail?.birthCountryCode ?? util.countryCode
        let strContryName = DBManager_CountryStateDistrict().getCountryName(countryCode: strContryCode)
        let isBirthCountryIndia = util.isCountryCodeIndia(countryCode: strContryCode)
        let strNationalityCode = modelMemberDetail?.nationality ?? util.countryCode
        let strNationalityName = DBManager_CountryStateDistrict().getCountryName(countryCode: strNationalityCode)
        
        
        formClass?.btn_pd_birthPlaceState.isUserInteractionEnabled = isBirthCountryIndia
        formClass?.btn_pd_birthPlaceDistrict.isUserInteractionEnabled = isBirthCountryIndia
        
        
        formClass!.btn_pd_birthPlaceCountry.setTitle(strContryName, for: .normal)
        
        setMaritalStatus(status: modelMemberDetail!.marital_status ?? "1")
        
        formClass!.btn_pd_Natinality.setTitle(strNationalityName, for: .normal)
        
        
        
        var spouseName = ""
        
        if formClass!.modelMemberDetail.language?.IsSelectedLangauge_nonEnglish ?? false {
            spouseName = ((modelMemberDetail?.spouseName_sl?.count != 0) ? modelMemberDetail?.spouseName_sl ?? "" : modelMemberDetail?.spouseName) ?? ""
        }else{
            spouseName = ((modelMemberDetail?.spouseName?.count != 0) ? modelMemberDetail?.spouseName ?? "" : modelMemberDetail?.spouseName_sl) ?? ""
        }
        
        formClass!.tf_ParentDetail_spouseName.text = spouseName
        
        if formClass!.modelMemberDetail.rel_code == "01" || formClass!.modelMemberDetail.sloMember?.memberSrNumber() == "001".memberSrNumber() {
            formClass!.btn_pd_relationWithHead.isUserInteractionEnabled = false
            formClass!.stackViewSamePresentAddAsHead.isHidden = true
            formClass!.stackViewSamePermanentAddAsHead.isHidden = true
            
            formClass!.btn_pd_relationWithHead.setTitle(relCode_name, for: .normal)
        }else{
            formClass!.btn_pd_relationWithHead.isUserInteractionEnabled = true
            formClass!.stackViewSamePresentAddAsHead.isHidden = true
            formClass!.stackViewSamePermanentAddAsHead.isHidden = false
            
        }
        
        formClass!.tf_passportNumber.text = modelMemberDetail?.passpord_id ?? ""
        formClass!.btn_pd_Natinality.isUserInteractionEnabled = true
        formClass!.btnSave.setTitle(LanguageModal.langObj.button_update, for: .normal)
       
        guard let seRefrenceNumber = modelMemberDetail?.selfEnumerationRef_number else {
            return
        }
        
        setFormAsHouseType(houseType: formClass?.modelHH.hhType ?? "")
        formClass!.tf_pd_SE_refrenceNO.text = seRefrenceNumber
        
        formClass?.isValidSeRefrence = seRefrenceNumber.isValidSENumber()
    }
    
    
    func pd_setLabelTagAcordingSL()  {
        
        formClass!.btnPD_title.setTitle(LanguageModal.langObj.personal_details, for: .normal)
        formClass!.tf_search.placeholder = LanguageModal.langObj.search_head_name_from_hlo
        formClass!.lblCensusHNTitle.text = LanguageModal.langObj.census_house_no
        formClass!.pd_houseNo.placeholder = LanguageModal.langObj.census_house_no
        formClass!.lblCensusHHNOTitle.text = LanguageModal.langObj.census_household_no
        formClass!.tf_pd_houseHoldNO.placeholder = LanguageModal.langObj.census_household_no
        formClass!.lblSERefrenceTitle.text = LanguageModal.langObj.self_enu_ref_no
        formClass!.tf_pd_SE_refrenceNO.placeholder = LanguageModal.langObj.self_enu_ref_no
        formClass!.lblNameTitle.text = LanguageModal.langObj.first_name
        formClass!.middleNameTitle.text = LanguageModal.langObj.middle_name
        formClass!.lastNameTitle.text = LanguageModal.langObj.last_name
        formClass!.tf_pd_Name.placeholder = LanguageModal.langObj.first_name
        formClass!.tf_pd_midleName.placeholder = LanguageModal.langObj.middle_name
        formClass!.tf_pd_lastName.placeholder = LanguageModal.langObj.last_name
        
        formClass!.lblSexTitle.text = LanguageModal.langObj.sex
        formClass!.btnMaleTitle.setTitle(LanguageModal.langObj.Male, for: .normal)
        formClass!.btnFemaleTitle.setTitle(LanguageModal.langObj.Female, for: .normal)
        formClass!.btnTransgenderTitle.setTitle(LanguageModal.langObj.trans_gender, for: .normal)
        formClass!.btnRelationWithHeadTitle.setTitle(LanguageModal.langObj.relationship, for: .normal)
        formClass!.lblMaritalStatusTitle.text = LanguageModal.langObj.marital_status
        formClass!.btnNeverMarried.setTitle(LanguageModal.langObj.never_married, for: .normal)
        formClass!.btnCurrentalyMarriedTitle.setTitle(LanguageModal.langObj.married, for: .normal)
        formClass!.btnWidowedTitle.setTitle(LanguageModal.langObj.widowed, for: .normal)
        formClass!.btnSepratedTitle.setTitle(LanguageModal.langObj.seprated, for: .normal)
        formClass!.btnDivorcedTitle.setTitle(LanguageModal.langObj.divorced, for: .normal)
        
        formClass!.lblDOBTitle.text = LanguageModal.langObj.dob
        formClass!.btnDOBCountry_title.setTitle(LanguageModal.langObj.birth_address1, for: .normal)
        formClass!.btnDOBState_title.setTitle(LanguageModal.langObj.birth_address2, for: .normal)
        
        formClass!.btnDOBDistrict_title.setTitle(LanguageModal.langObj.birth_address3, for: .normal)
        
        formClass!.lblNationality_title.setTitle(LanguageModal.langObj.nationality, for: .normal)
       // formClass!.lblHavingPassport_title.text = LanguageModal.langObj.
        formClass!.lbl_pd_messageNote.text = LanguageModal.langObj.nationality_declaratation
        
       
    }
    
    func selectMaritalStatus(sender:UIButton)  {
        
        let gap = 9
        let strStatus = "\(sender.tag-gap)"
        formClass?.maritalStatus = Utils.marritalStaus.init(rawValue: strStatus) ?? .none
        
        resetMaritalStatusSelection(sender: sender)
        setMaritalStatus(status: strStatus)
        sender.isSelected = true
        
        spouseOptionOnMaritalstatus()
        
    }
    
    func spouseOptionOnMaritalstatus()  {
        
        var isSpouseHide = true
        if formClass!.maritalStatus != .neverMarried {
             isSpouseHide = false
        }
       
        formClass?.stackViewSpouseName.isHidden = isSpouseHide
    }
    
   private func resetMaritalStatusSelection(sender:UIButton)  {
        
        deSelectButton(sender: sender, tag: 10)
        deSelectButton(sender: sender, tag: 11)
        deSelectButton(sender: sender, tag: 12)
        deSelectButton(sender: sender, tag: 13)
        deSelectButton(sender: sender, tag: 14)
    }
    
    
    func setFormAsHouseType(houseType:String)  {
        
       let houseT = HouseType.init(rawValue: houseType)
        
        switch houseT {
        
            
        case .institute:
            formClass?.tf_pd_houseHoldNO.isUserInteractionEnabled = false
            formClass?.pd_houseNo.isUserInteractionEnabled = true
            break
            
        case .houseLess:
            formClass?.tf_pd_houseHoldNO.isUserInteractionEnabled = true
            formClass?.pd_houseNo.isUserInteractionEnabled = false
            break
        default:
            formClass?.tf_pd_houseHoldNO.isUserInteractionEnabled = true
            formClass?.pd_houseNo.isUserInteractionEnabled = true
            break
        }
    }
    
    func setMaritalStatus(status:String)  {
        
        if status.count > 0 {
        let tag = (Int(status) ?? 1 )+9
        let button = getButtonOnTagButton(sender: formClass!.btnNeverMarried, tag: tag)
        button.isSelected = true
        formClass?.maritalStatus = Utils.marritalStaus.init(rawValue: status) ?? .none
            
        }
    }
    
   private func deSelectButton(sender:UIButton,tag:Int)  {
        
        let buttonMale = sender.superview?.superview?.viewWithTag(tag) as? UIButton
        buttonMale?.isSelected = false
        
    }
    
   private func getButtonOnTagButton(sender:UIButton,tag:Int)->UIButton  {
        
        guard let button = sender.superview?.superview?.viewWithTag(tag) as? UIButton else {
            return UIButton()
        }
       
        return button
    }
    
    func isValidSENumber(strSENumber:String) -> Bool {
      
        if strSENumber.count < 9 {
            return false
        }
        guard var value = Int(strSENumber ) else { return false }
        var sum = 0
        let lastDigit =  value%10
        
        while value > 0 {
          sum += value%10
            value = value/10
        }
        
        let ciDigit = (81-sum)%9
        
        return ciDigit == lastDigit
        
        
    }
    
    
    func setPersonalDetail_asSERefrence()  {
        
        let isEnable = !(formClass?.isValidSeRefrence ?? false)
        
        formClass?.btnCheckMale .isEnabled = isEnable
        
        formClass?.btn_pd_relationWithHead .isEnabled = isEnable
        
        formClass?.btnCheckFemale.isEnabled = isEnable
        formClass?.btnCheckTransgender.isEnabled = isEnable
        formClass?.btnCheckNeverMarried.isEnabled = isEnable
        formClass?.btnCheckCurrentlyMarried.isEnabled = isEnable
        formClass?.btnCheckSeprated.isEnabled = isEnable
        formClass?.btnCheckWidowed.isEnabled = isEnable
        formClass?.btncheckDivorce.isEnabled = isEnable
        formClass?.tf_pd_Dob_date .isEnabled = isEnable
        formClass?.tf_pd_Dob_month .isEnabled = isEnable
        formClass?.tf_pd_Dob_year .isEnabled = isEnable
        
        formClass?.btn_pd_birthPlaceCountry .isEnabled = isEnable
        formClass?.btn_pd_birthPlaceState .isEnabled = isEnable
        formClass?.btn_pd_birthPlaceDistrict .isEnabled = isEnable
        formClass?.btn_pd_Natinality.isEnabled = isEnable
        formClass?.tf_passportNumber.isEnabled = isEnable
    }
    
    
    func isValidForSeRefrence() -> Bool {
        
    
    return( formClass!.isValidSeRefrence  && isValidForSeRefrence())
    
    
    }
    
   private func isValidPersonalDetail_seNumber() -> Bool {
      
        let formClass = self.formClass!
        
        
        if (formClass.pd_houseNo.text == "" || Int(formClass.pd_houseNo.text ?? "0") == 0) && (formClass.selectedHouseType != HouseType.houseLess){
            
            alertShow(message: English.AddNewMemberFormAlert.hNEmpty, formClass: formClass)
                 return false
                
            }
           
            else if formClass.tf_pd_houseHoldNO.text == "" || Int(formClass.tf_pd_houseHoldNO.text ?? "0") == 0{
                alertShow(message: English.AddNewMemberFormAlert.hhEmpty, formClass: formClass)
                return false
                
            }
            else if DBManagerHousehold().is_censusHouseholdExist(strCensusHHNo: formClass.tf_pd_houseHoldNO.text ?? "".censusHHNumber()) && formClass.entryT == .newHouseHold{
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
                alertShow(message: LanguageModal.langObj.validation_first_name, formClass: formClass)
                return false
                  
            }
            else if formClass.tf_pd_Name.text?.count ?? 0 < 2 {
                
                if (formClass.tf_pd_midleName.text?.count == 1 && formClass.tf_pd_lastName.text?.count == 1) || (formClass.tf_pd_midleName.text?.count == 2 || formClass.tf_pd_lastName.text?.count == 2) {
                    return true
                }
                
                else if formClass.tf_pd_midleName.text?.isEmpty ?? false && formClass.tf_pd_lastName.text?.isEmpty ?? false {
                    alertShow(message: LanguageModal.langObj.validation_first_name, formClass: formClass)
                    
                }else if (formClass.tf_pd_midleName.text?.count == 1 && formClass.tf_pd_lastName.text?.count == 0)  {
                    alertShow(message: LanguageModal.langObj.first_middle_name_should_be_2_char_length, formClass: formClass)
                    
                }else if (formClass.tf_pd_midleName.text?.count == 0 && formClass.tf_pd_lastName.text?.count == 1)  {
                    alertShow(message: LanguageModal.langObj.first_last_name_should_be_2_char_length, formClass: formClass)
                }
                
                return false
                  
            }
      return true
    }
   private func alertShow (message:String,formClass:AddNewHouseHoldForm_TVC){
        
        AlertView().showAlertWithSingleButton( title: "", message: message)
        
    }
}


extension FormPersonalDetailManagement:QRScannerCodeDelegate {
    func qrScanner(_ controller: UIViewController, scanDidComplete result: String) {
        print("Scan Result", result)
        
        var strSENuber = ""
        var seNumber = 0
        
    let araySepratedString = result.components(separatedBy: "/")
        
        if araySepratedString.count > 2 {
          
            strSENuber = araySepratedString[araySepratedString.count-2] 
            seNumber = Int(strSENuber) ?? 0
            if seNumber > 0 {
                strSENuber.isValidSENumber() ? formClass?.tf_pd_SE_refrenceNO.text = strSENuber : inVaildSENumberAlert()
                
                if strSENuber.isValidSENumber() {
                    formClass?.isValidSeRefrence = true
                    formClass?.formModelClass?.setForm_asRefrenceNumber()
                }
            }
            else {
                inVaildSENumberAlert()
            }
        }
        else{
            inVaildSENumberAlert()
        }
      
        
    }
    
    
    func qrScannerDidFail(_ controller: UIViewController, error: String) {
        
    }
    
    func qrScannerDidCancel(_ controller: UIViewController) {
        
    }
    
    
    func openQRCodeScanner()  {
        
        let scanner = QRCodeScannerController()
        
        //QRCode with Camera switch and Torch
        //let scanner = QRCodeScannerController(cameraImage: UIImage(named: "camera"), cancelImage: UIImage(named: "cancel"), flashOnImage: UIImage(named: "flash-on"), flashOffImage: UIImage(named: "flash-off"))
        scanner.delegate = self
        formClass?.present(scanner, animated: true, completion: nil)
    }
    
    func inVaildSENumberAlert()  {
        singleton().Alert.show(title: "", message: LanguageModal.langObj.invalid_selfenurefno, delay: 3.0)
    }
}
