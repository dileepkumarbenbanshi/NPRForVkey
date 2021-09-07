//
//  FormPermanentAddressProtocol.swift
//  NPR-2020
//
//  Created by Dileep on 25/01/21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation



class FormPermanentAddressDetailFill:NSObject {
    
    var formClass:AddNewHouseHoldForm_TVC?
    
    var isValidPermanentAddress: Bool {
    return isValid_permanentAdd()
        
    }
    
   private var isCountryIndiaPad:Bool {
        return util.isCountryIndia(countryName: formClass?.btn_PaddCountry.titleLabel?.text ?? "")
    }
    
//    private var formClass:AddNewHouseHoldForm_TVC?
//    init(formClass:AddNewHouseHoldForm_TVC) {
//        self.formClass = formClass
//    }
    
    init(formClass:AddNewHouseHoldForm_TVC) {
        self.formClass = formClass
         
    }
    func initialPrepare()  {
        
        self.setTextFieldDelrgationForermanentSection()
    }
    
     func headPermanentAddressFill(formClass: AddNewHouseHoldForm_TVC) {
        
        DBManagerMemberDetail().fetchedHHMembers(modelSelectedHH: formClass.modelHH) { (arayMembers) in
            
            let modelHead = arayMembers.filter({$0.rel_code == "01"})
            if modelHead.count > 0 {
            self.permanentAddressFill(modelMemberDetail: modelHead[0])
            //return modelHead
        }
        }
    }
    
    func memberPermanentAddressFill(modelMember: NPR2021MemberDetails) {
        if formClass == nil {
            return
        }
        permanentAddressFill(modelMemberDetail: modelMember)
        formClass?.isStayPrensetAddSinceBirth = false
        
        if modelMember.staying_since_birthdate == "1" {
            formClass?.isStayPrensetAddSinceBirth = true
            staySinceBirhthSectionHideShow(isTapedYes: true)
        }else{
           
            guard let stayYear = modelMember.duration_inYear  else {
                return
            }
            if stayYear.count > 0 {
                staySinceBirhthSectionHideShow(isTapedYes: false)
                }
            
        }
       setValueOnLastResidency()
        permanentAdd_setTagLabel()
    }

    
    func setTextFieldDelrgationForermanentSection()  {
        if formClass == nil {
            return
        }
        let formClass = self.formClass!
        
        formClass.tf_staySameAddressYear.delegate = self
    }
    
    
    //Mark:Refresh aff Filled Value
    func refreshPermanentAddressDetail() {
        
        
        
    }
    
    
func permanentAddressFill(modelMemberDetail:NPR2021MemberDetails ) {
        
    if formClass == nil {
        return
    }
    let formClass = self.formClass!
    
         
if formClass.entryT == .editDetail {
             formClass.tf_padTownVillage.text = modelMemberDetail.paddress_town  ?? ""
             formClass.tf_padHouseNumber.text = modelMemberDetail.address_line1 ?? ""
             formClass.tf_padPinCode.text = modelMemberDetail.pinCode ?? ""
         }
         
    let strContryCode = modelMemberDetail.paddress_countryCode ?? "083"
    let isContryIndia = util.isCountryCodeIndia(countryCode:strContryCode)
    
         formClass.btn_pd_birthPlaceState.isUserInteractionEnabled = isContryIndia
         //btn_ptAdd_State.isUserInteractionEnabled = true
         formClass.btn_padState.isUserInteractionEnabled = isContryIndia
         formClass.btn_padDistrict.isUserInteractionEnabled = isContryIndia
         formClass.btn_PadSubDistrict.isUserInteractionEnabled = isContryIndia
         formClass.btn_pd_Natinality.isUserInteractionEnabled = isContryIndia
         formClass.tf_padTownVillage.isUserInteractionEnabled = isContryIndia
         formClass.tf_padHouseNumber.isUserInteractionEnabled = isContryIndia
         formClass.tf_padPinCode.isUserInteractionEnabled = isContryIndia
    
    
    let subDistrictName = DBManager_CountryStateDistrict().getSubDistrictName(stateCode: modelMemberDetail.paddress_stateCode ?? "", districtCode: modelMemberDetail.paddre_districtCode ?? "", tahsilCode:modelMemberDetail.paddre_tahsilCode ?? "" )
         formClass.btn_PadSubDistrict.setTitle(subDistrictName, for: .normal)
         
     let districtName = DBManager_CountryStateDistrict().getDistrictName(stateCode: modelMemberDetail.paddress_stateCode ?? "", districtCode: modelMemberDetail.paddre_districtCode ?? "")
         formClass.btn_padDistrict.setTitle(districtName, for: .normal)
    
    
    let stateName = DBManager_CountryStateDistrict().getStateName(stateCode: modelMemberDetail.paddress_stateCode ?? "")
     
    let contryName = DBManager_CountryStateDistrict().getCountryName(countryCode: strContryCode)
    
         formClass.btn_padState.setTitle(stateName , for: .normal)
    
    formClass.btn_PaddCountry.setTitle(contryName, for: .normal)
         
         //tf_ptAd_pinCode.text = singleton().selectEBListModel.
    formClass.tf_padTownVillage.text = isContryIndia ? modelMemberDetail.paddress_town : ""
    formClass.tf_padHouseNumber.text = isContryIndia ? modelMemberDetail.paddre_line1 : ""
    formClass.tf_padPinCode.text = isContryIndia ? modelMemberDetail.ppinCode : ""
    
}
  
    
    func countryOtherThanIndia()  {
       
        
        
    }
    
    func setValueOnLastResidency()  {
        
        let modelMember = formClass?.modelMemberDetail
        guard let stayYear = modelMember?.duration_inYear  else {
            return
        }
        
        var strCountryCode = modelMember?.lastResidencyCountry ?? "083"
        
        var lastResStateName = ""
        var lastResDistrictName = ""
        var isLastResidencyIndia = true
        
        // Check Have Always ContryName Or Empty
        if modelMember?.lastResidencyCountry?.count ?? 0 > 0 {
           
            strCountryCode = modelMember?.lastResidencyCountry ?? ""
            if util.isCountryCodeIndia(countryCode:strCountryCode) {
             
              
             lastResStateName = DBManager_CountryStateDistrict().getStateName(stateCode: modelMember?.lastResidencyState ?? "")
             lastResDistrictName = DBManager_CountryStateDistrict().getDistrictName(stateCode: modelMember?.lastResidencyState ?? "", districtCode: modelMember?.lastResidencyDistrict ?? "")
             isLastResidencyIndia = true
             
            }else{
                isLastResidencyIndia = false
            }
            
        }else{
            
            isLastResidencyIndia = true
        }
        
        let strCountryName = DBManager_CountryStateDistrict().getCountryName(countryCode: strCountryCode)
        
        formClass?.btnLastResidenceCountry.setTitle(strCountryName, for: .normal)
        formClass?.btnLastResidenceState.isEnabled = isLastResidencyIndia
        formClass?.btnLastResidenceDistrict.isEnabled = isLastResidencyIndia
        
        formClass?.tf_staySameAddressYear.text = stayYear
        
        formClass?.btnLastResidenceCountry.setTitle(strCountryName, for: .normal)
        formClass?.btnLastResidenceState.setTitle(lastResStateName, for: .normal)
        formClass?.btnLastResidenceDistrict.setTitle(lastResDistrictName, for: .normal)
    }
    
    func staySinceBirth(sender:UIButton , formClass:AddNewHouseHoldForm_TVC) {
       
        var isTapedYes = false
        
        isTapedYes = sender == formClass.btn_padYes ? true : false

        staySinceBirhthSectionHideShow(isTapedYes: isTapedYes)
    }
    
   private func staySinceBirhthSectionHideShow(isTapedYes:Bool)  {
    if formClass == nil {
        return
    }
    let formClass = self.formClass!
        formClass.stackViewLastResidence.isHidden = isTapedYes
        formClass.btn_padYes.isSelected = isTapedYes
        formClass.btn_padNo.isSelected = !isTapedYes
        formClass.isStayPrensetAddSinceBirth = isTapedYes
    if isTapedYes {
        formClass.tf_staySameAddressYear.text = ""
        formClass.btnLastResidenceState.setTitle("", for: .normal)
        formClass.btnLastResidenceDistrict.setTitle("", for: .normal)
    
    }
        
        formClass.updatecellSize()
    if formClass.entryT == .editDetail {
        
    }
    }
    
   private func getHeadDeatil(modelHH:NPR_2021hh_Details) -> [NPR2021MemberDetails] {
        var  modelHead = [NPR2021MemberDetails]()
        
        DBManagerMemberDetail().fetchedHHMembers(modelSelectedHH: modelHH) { (arayMembers) in
            
             modelHead = arayMembers.filter({$0.rel_code == "01"})
            //return modelHead
        }
        
        return modelHead
        
    }
    
    
    
    func openDropDownList()  {
       
        
    }
    
    // MARK:Validation
    
    private func isValid_permanentAdd() -> Bool {
     
        if formClass == nil {
            return false
        }
        let formClass = self.formClass!
        let isCountryIndia = util.isCountryIndia(countryName: formClass.btn_PaddCountry.titleLabel?.text ?? "")
        let stateCode = DBManager_CountryStateDistrict().getStateCode(stateName: formClass.btn_padState.titleLabel?.text ?? "")
        let districtCode = DBManager_CountryStateDistrict().getDistrictCode(stateCode: stateCode, districtName: formClass.btn_padDistrict.titleLabel?.text ?? "")
        let subDistrictCode = DBManager_CountryStateDistrict().getSubDistrictCode(stateCode: stateCode, tahsilName: formClass.btn_PadSubDistrict.titleLabel?.text ?? "")
        
        
        
        let isValidState = stateCode != util.notKnownStateCode
        
        
        let isValidDistrict = districtCode != util.notKnownDistrictCode
        let isValidSubDistrict = subDistrictCode != util.notKnownSubDistrictCode
        
    
           if formClass.btn_PaddCountry.titleLabel?.text == "" || (formClass.btn_PaddCountry.titleLabel?.text == nil) {
             
             alertShow(message: English.AddNewMemberFormAlert.choosePermanentAddress_country)
             return false
         }
        
            
        else if (formClass.btn_padState.titleLabel?.text == "" || (formClass.btn_padState.titleLabel?.text == nil)) && isCountryIndia {
             alertShow(message: English.AddNewMemberFormAlert.choosePermanentAddress_state)
             
             return false
             
         }
         else if formClass.btn_padDistrict.titleLabel?.text == "" || (formClass.btn_padDistrict.titleLabel?.text == nil) &&  ( isCountryIndia && isValidState ) {
             alertShow(message: English.AddNewMemberFormAlert.choosePermanentAddress_district)
             return false
         }
         else if formClass.btn_PadSubDistrict.titleLabel?.text == "" || (formClass.btn_PadSubDistrict.titleLabel?.text == nil) && ( isCountryIndia && (isValidState && isValidDistrict) ) {
             
             alertShow(message: English.AddNewMemberFormAlert.choosePermanentAddress_subDistrict)
             
             return false
         }
         else if (( isCountryIndia && isValidState && isValidDistrict && isValidSubDistrict  ) && formClass.tf_padTownVillage.text?.count ?? 0 < 3 ){
             alertShow(message: English.AddNewMemberFormAlert.checkPermanentAddress_town_village)
            return false
         }
         else if  (( isCountryIndia && isValidState && isValidDistrict && isValidSubDistrict ) && formClass.tf_padHouseNumber.text?.count ?? 0  < 3 &&  formClass.tf_padHouseNumber.text?.count ?? 0 > 0 ) {
             
             
            alertShow(message: LanguageModal.langObj.address1)
            
            return false
         }
         else if (( isCountryIndia && isValidState && isValidDistrict && isValidSubDistrict ) && formClass.tf_padPinCode.text?.count ?? 0  < 6 &&  formClass.tf_padPinCode.text?.count ?? 0 > 0 ){
            
            
             alertShow(message: English.AddNewMemberFormAlert.checkPermanentAddress_pinCode)
            return false
             
         }
         else  if !isValidStaySinceBirth() {
             
            return false
             
         }
         
        return true
     }
    
    
    func isValidStaySinceBirth() -> Bool {
        
        
        if formClass == nil {
            return false
        }
        let formClass = self.formClass!
        
        if !(formClass.btn_padYes.isSelected)  && !(formClass.btn_padNo.isSelected) {
            alertShow(message: English.AddNewMemberFormAlert.chooseStaySinceBirth)
            return false
        }
        
        if formClass.isStayPrensetAddSinceBirth {
            return true
        }else {
            if isValidStayYear() && isvalidLastResidencySate() && isvalidLastResidencyDistrict(){
               return true
            }
            
        }
        
        return false
    }
    
    
   private func isValidStayYear() -> Bool {
        
        if formClass == nil {
            return false
        }
        let formClass = self.formClass!
    
   let year = Int(formClass.tf_staySameAddressYear.text ?? "" ) ?? 0
    if (year < 1)  {
        alertShow(message: English.AddNewMemberFormAlert.stayYearCanNotEmpty)
        
        return false
    }
        
    return passYearToCheckValidation(strYear: formClass.tf_staySameAddressYear.text ?? "")
    }
    
  private func passYearToCheckValidation(strYear:String) -> Bool {
    
    let strDOB = FormDateMangement().prepareDObForUpload(type: .personal, formClass: formClass!).date
        
       let date = strDOB.stringToDate()
        let isValidYearEnter = date.age > Int(strYear) ?? 0
        
        if isValidYearEnter {
            return true
        }
        formClass!.tf_staySameAddressYear.text = ""
        alertShow(message: English.AddNewMemberFormAlert.stayYearMorethanAge)
        
        return false
    }
    func isvalidLastResidencySate() -> Bool {
       let isLastResidencyCountryIndia = util.isCountryIndia(countryName: formClass?.btnLastResidenceCountry.titleLabel?.text ?? "")
        // If Country name is not india then no need State Name 
        if !isLastResidencyCountryIndia {
           return true
        }
        
        if (formClass?.btnLastResidenceState.titleLabel?.text?.count ?? 0 == 0  || formClass?.btnLastResidenceState.titleLabel?.text == nil) && isCountryIndiaPad{
            alertShow(message: English.AddNewMemberFormAlert.chooseLastResidencyState)
            return false
        }
        
       return true
    }
    
    func isvalidLastResidencyDistrict() -> Bool {
        
        let isValidContry = DBManager_CountryStateDistrict().getCountryCode(countryName: formClass?.btnLastResidenceCountry.titleLabel?.text ?? "") == util.countryCode
        let isValidState = DBManager_CountryStateDistrict().getStateCode(stateName: formClass?.btnLastResidenceState.titleLabel?.text ?? "") != util.notKnownStateCode
        
        
        if (formClass?.btnLastResidenceDistrict.titleLabel?.text?.count ?? 0 == 0 || formClass?.btnLastResidenceDistrict.titleLabel?.text == nil) && (isValidContry && isValidState ) {
            alertShow(message: LanguageModal.langObj.validation_last_residence_district)
            return false
        }
        
       
           return true
       
       
        
    }
    
    
    //MARK:Alert
    
    func alertShow (message:String){
        if formClass == nil {
            return
        }
        let alertView = AlertView()
        alertView.showAlertWithSingleButton(title: "", message: message)
        
    }
}


extension FormPermanentAddressDetailFill :UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        var txtAfterUpdate = ""
        
        if let text = textField.text as NSString? {
                 txtAfterUpdate = text.replacingCharacters(in: range, with: string)
               
            }
        return tfStayYear(strYear: txtAfterUpdate)
    }
    
    func tfStayYear(strYear:String)->Bool {
        
         if strYear.count <= 2{
           let valid =  passYearToCheckValidation(strYear: strYear)
            print("Valid Year" , valid)
            return strYear.count <= 2
            
         }else if strYear.count > 2 {
            return false
         }
        
        return true
        
    }
   
    func permanentAdd_setTagLabel()  {
        
        formClass?.btnPermaAdd_title.setTitle(LanguageModal.langObj.permanent_address_details, for: .normal)
        formClass?.btnPermaAddSameAsHead_title.setTitle(LanguageModal.langObj.same_as_head, for: .normal)
        formClass?.btnPermaAddSameAsPresentAdd_title.setTitle(LanguageModal.langObj.same_as_present_address, for: .normal)
        
        formClass?.btnPermaAddSameAsParticularMember_title.setTitle(LanguageModal.langObj.permanent_address_same_as_member, for: .normal)
        formClass?.btnPermaAddCountry_title.setTitle(LanguageModal.langObj.country, for: .normal)
        formClass?.btnPermaAddState_title.setTitle(LanguageModal.langObj.state, for: .normal)
        formClass?.btnPermaAddDistrict_title.setTitle(LanguageModal.langObj.district, for: .normal)
        formClass?.btnPermaAddSubDistrict_title.setTitle(LanguageModal.langObj.sub_district, for: .normal)
        formClass?.lblPermaTownVillage_title.text = LanguageModal.langObj.town_village
        formClass?.tf_padTownVillage.placeholder = LanguageModal.langObj.town_village
        formClass?.lblPermaHouseNumber_title.text = LanguageModal.langObj.address1
        formClass?.tf_padHouseNumber.placeholder = LanguageModal.langObj.address1
        formClass?.lblPermaPin_title.text = LanguageModal.langObj.pincode
        formClass?.tf_padPinCode.placeholder = LanguageModal.langObj.pincode
        
        formClass?.lblStayingPresentAdd_title.text = LanguageModal.langObj.wheater_staying_at_present_addres_since_birth
        formClass?.btnYes_title.setTitle(LanguageModal.langObj.button_yes, for: .normal)
        formClass?.btnNo_title.setTitle(LanguageModal.langObj.button_no, for: .normal)
        
        formClass?.lblStayingYear_title.text = LanguageModal.langObj.years_of_staying
        formClass?.tf_staySameAddressYear.placeholder = LanguageModal.langObj.years_of_staying
        formClass?.btnLastStayingCountry_title.setTitle(LanguageModal.langObj.place_of_last_residence, for: .normal)
        formClass?.btnLastStayingState_title.setTitle(LanguageModal.langObj.place_of_last_residence2, for: .normal)
        formClass?.btnLastStayingDistrict_title.setTitle(LanguageModal.langObj.place_of_last_residence3, for: .normal)
        
        enableDisable_asSERefrence()
    }
    
    //MARK:Should Hide Variable
    
    func stateShouldHide(btn:UIButton)->Bool  {
        
        let stateCode = DBManager_CountryStateDistrict().getCountryCode(countryName: btn.titleLabel?.text ?? "")
        let isHidable = stateCode.count == 0 || stateCode == util.notKnownStateCode
        
       return isHidable
        
    }
    
    func districtShouldHide(btn:UIButton) -> Bool {
         let stateCode = DBManager_CountryStateDistrict().getStateCode(stateName: btn.titleLabel?.text ?? "")
        let isHidable = (stateCode.count == 0 || (stateCode == util.notKnownStateCode && isCountryIndiaPad)) || !isCountryIndiaPad
        
        return isHidable
        
    }
    func subDistrictShouldHide(btn:UIButton) -> Bool {
        
        let tag = btn.tag
        let countryButton = formClass?.findNextORPrevButton(sender: btn, tagToFind: tag - 2) ?? UIButton()
        let stateButton = formClass?.findNextORPrevButton(sender: btn, tagToFind: tag - 1) ?? UIButton()
        
        let stateCode = DBManager_CountryStateDistrict().getStateCode(stateName: stateButton.titleLabel?.text ?? "")
        
        let districtCode = DBManager_CountryStateDistrict().getDistrictCode(stateCode: stateCode, districtName: btn.titleLabel?.text ?? "")
        
        let isHideState = stateShouldHide(btn: countryButton)
        
        let isHideDistrict = districtShouldHide(btn: stateButton)
        
        let isHideSubDist = districtCode.count == 0 || (districtCode == util.notKnownDistrictCode && isCountryIndiaPad )
        
        
        let isHidable = isHideDistrict || isHideState || isHideSubDist || !isCountryIndiaPad
        
        return isHidable
        
    }
    
    func houseNumberPinShouldHide(btn:UIButton) -> Bool {
        
        let tag = btn.tag
        
        let stateButton = formClass?.findNextORPrevButton(sender: btn , tagToFind: tag - 1)
        
        let stateCode = DBManager_CountryStateDistrict().getStateCode(stateName: stateButton?.titleLabel?.text ?? "")
        
        let subDistrictCode =  DBManager_CountryStateDistrict().getSubDistrictCode(stateCode: stateCode, tahsilName: btn.titleLabel?.text ?? "")
        
        let isHidable = ((stateCode.count == 0 || stateCode == util.notKnownStateCode) || (subDistrictCode.count == 0 || subDistrictCode == util.notKnownDistrictCode)) && !isCountryIndiaPad
        
        
       
        return isHidable
        
    }
    
    
   //MARK:Set Permanent Address
    
    func aftercCountrySelected()  {
        
       
       
        
       
        
        formClass?.btn_padState.titleLabel?.text = !isCountryIndiaPad ? "" : formClass?.btn_padState.titleLabel?.text ?? ""
        
        formClass?.btn_padState.isEnabled = isCountryIndiaPad
        formClass?.btn_padState.isUserInteractionEnabled = isCountryIndiaPad
        formClass?.btn_padState.setTitle("", for: .normal)
        afterStateSelected()
        
        formClass?.btn_padDistrict.setTitle("", for: .normal)
       
        formClass?.btn_PadSubDistrict.setTitle("", for: .normal)
       
        textFieldShouldRefresh(willRefresh: isCountryIndiaPad)
    }
    
    func afterStateSelected()  {
         
        formClass?.btn_padDistrict.setTitle("", for: .normal)
        
        formClass?.btn_PadSubDistrict.setTitle("", for: .normal)
        let isStateNotKnown = DBManager_CountryStateDistrict().getStateCode(stateName: formClass?.btn_padState.titleLabel?.text ?? "") != util.notKnownStateCode
        
        formClass?.btn_padDistrict.isUserInteractionEnabled = isStateNotKnown
        formClass?.btn_PadSubDistrict.isUserInteractionEnabled = isStateNotKnown
        formClass?.tf_padTownVillage.isUserInteractionEnabled = isStateNotKnown
        formClass?.tf_padHouseNumber.isUserInteractionEnabled = isStateNotKnown
        formClass?.tf_padPinCode.isUserInteractionEnabled = isStateNotKnown
        
        textFieldShouldRefresh(willRefresh: !isStateNotKnown)
    }
    
    func afterDistrictSelected()  {
         
        
       
        
        formClass?.btn_PadSubDistrict.setTitle("", for: .normal)
        
        let stateCode = DBManager_CountryStateDistrict().getStateCode(stateName: formClass?.btn_padState.titleLabel?.text ?? "")
        let isDistrictNotKnown = DBManager_CountryStateDistrict().getDistrictCode(stateCode: stateCode, districtName: formClass?.btn_padDistrict.titleLabel?.text ?? "") != util.notKnownDistrictCode
        
        
       
        formClass?.btn_PadSubDistrict.isEnabled = isDistrictNotKnown
        
        formClass?.tf_padTownVillage.isEnabled = isDistrictNotKnown
        formClass?.tf_padHouseNumber.isEnabled = isDistrictNotKnown
        formClass?.tf_padPinCode.isEnabled = isDistrictNotKnown
        
        formClass?.btn_PadSubDistrict.isUserInteractionEnabled = isDistrictNotKnown
        
        formClass?.tf_padTownVillage.isUserInteractionEnabled = isDistrictNotKnown
        formClass?.tf_padHouseNumber.isUserInteractionEnabled = isDistrictNotKnown
        formClass?.tf_padPinCode.isUserInteractionEnabled = isDistrictNotKnown
        
        textFieldShouldRefresh(willRefresh: !isDistrictNotKnown)
        
    }
    
    
    func textFieldShouldRefresh(willRefresh:Bool)  {
        
            formClass?.tf_padHouseNumber.text = ""
            formClass?.tf_padTownVillage.text = ""
            
            formClass?.tf_padPinCode.text = ""
        
        
    }
    
    
    func afterSubDistrictSelected()  {
         
        let stateCode = DBManager_CountryStateDistrict().getStateCode(stateName: formClass?.btn_padState.titleLabel?.text ?? "" )
        
        let isSubDistrictNotKnown = DBManager_CountryStateDistrict().getSubDistrictCode(stateCode: stateCode, tahsilName: formClass?.btn_PadSubDistrict.titleLabel?.text ?? "") == util.notKnownStateCode
        
        textFieldShouldRefresh(willRefresh: isSubDistrictNotKnown)
    }
    
    
    func afterSelectCountry_lastResidense()  {
//        formClass?.stackView_lastResidenseState.isHidden = stateShouldHide(btn: formClass?.btnLastResidenceCountry ?? UIButton())
//        formClass?.btnLastResidenceState.setTitle("", for: .normal)
        
        
      //  afterSelectState_lastResidense()
        
        let isIndia = DBManager_CountryStateDistrict().getCountryCode(countryName: formClass?.btnLastResidenceCountry.titleLabel?.text ?? "") == util.countryCode
        formClass?.btnLastResidenceState.isEnabled = isIndia
        formClass?.btnLastResidenceDistrict.isEnabled = isIndia
        formClass?.btnLastResidenceState.isUserInteractionEnabled = isIndia
        formClass?.btnLastResidenceDistrict.isUserInteractionEnabled = isIndia
        
        if !isIndia {
            formClass?.btnLastResidenceState.titleLabel?.text = ""
            formClass?.btnLastResidenceState.setTitle("", for: .normal)
            formClass?.btnLastResidenceDistrict.titleLabel?.text = ""
            formClass?.btnLastResidenceDistrict.setTitle("", for: .normal)
            
        }
        
    }
    
    func afterSelectState_lastResidense()  {
       
//        let isHideState = stateShouldHide(btn: formClass?.btnLastResidenceState ?? UIButton())
//
//        let stateCode = DBManager_CountryStateDistrict().getStateCode(stateName: formClass?.btnLastResidenceState.titleLabel?.text ?? "")
//
//
//        formClass?.stackView_lastResidenseDistrict.isHidden = (stateCode.count == 0 || stateCode == util.notKnownStateCode || isHideState)
//
//        formClass?.btnLastResidenceDistrict.setTitle("", for: .normal)
//
//        formClass?.updatecellSize()
        
        
        let isNotNownState = DBManager_CountryStateDistrict().getStateCode(stateName: formClass?.btnLastResidenceState.titleLabel?.text ?? "") != util.notKnownStateCode
        
        formClass?.btnLastResidenceDistrict.isEnabled = isNotNownState
        
       
           
            formClass?.btnLastResidenceDistrict.titleLabel?.text = ""
            formClass?.btnLastResidenceDistrict.setTitle("", for: .normal)
            
        
    }
    
    func enableDisable_asSERefrence()  {
        let isEnable = !(formClass?.isValidSeRefrence ?? false)
        //formClass?.sameas .isEnabled = isEnable
        formClass?.btn_PaddCountry .isEnabled = isEnable
        
        formClass?.btn_padState .isEnabled = isEnable
        formClass?.btn_padDistrict .isEnabled = isEnable
        
        
        formClass?.btn_PadSubDistrict.isEnabled = isEnable
        formClass?.tf_padTownVillage.isEnabled = isEnable
        formClass?.tf_padHouseNumber.isEnabled = isEnable
        formClass?.tf_padPinCode.isEnabled = isEnable
        
        formClass?.btn_padNo.isEnabled = isEnable
        formClass?.btn_padYes.isEnabled = isEnable
        formClass?.btnCkeck_permanentSameasHead.isEnabled = isEnable
        formClass?.btnCkeck_permanentSameasPresentAdd.isEnabled = isEnable
        
        
        formClass?.btn_PaddCountry .isUserInteractionEnabled = isEnable
        
        formClass?.btn_padState .isUserInteractionEnabled = isEnable
        formClass?.btn_padDistrict .isUserInteractionEnabled = isEnable
        
        
        formClass?.btn_PadSubDistrict.isUserInteractionEnabled = isEnable
        formClass?.tf_padTownVillage.isUserInteractionEnabled = isEnable
        formClass?.tf_padHouseNumber.isUserInteractionEnabled = isEnable
        formClass?.tf_padPinCode.isUserInteractionEnabled = isEnable
        
        formClass?.btn_padNo.isUserInteractionEnabled = isEnable
        formClass?.btn_padYes.isUserInteractionEnabled = isEnable
        formClass?.btnCkeck_permanentSameasHead.isUserInteractionEnabled = isEnable
        formClass?.btnCkeck_permanentSameasPresentAdd.isUserInteractionEnabled = isEnable
        
        
    }
}



extension FormPermanentAddressDetailFill:PickerViewCommonDelegate {
    func didPickComponent(component: String) {
       
        formClass?.tapedButton.setTitle(component, for: .normal)
        formClass?.tapedButton.titleLabel?.text = component
        formClass?.btnCkeck_permanentSameasPresentAdd.isSelected = false
        formClass?.btnCkeck_permanentSameasHead.isSelected = false
        switch formClass?.tapedButton {
        case formClass?.btn_PaddCountry:
            aftercCountrySelected()
            break
            
        case formClass?.btn_padState:
            afterStateSelected()
            break
        case formClass?.btn_padDistrict:
            afterDistrictSelected()
            break
            
        case formClass?.btn_PadSubDistrict:
            afterSubDistrictSelected()
            break
            
        case formClass?.btnLastResidenceCountry:
            afterSelectCountry_lastResidense()
            break
            
        case formClass?.btnLastResidenceState:
            afterSelectState_lastResidense()
            break
        case formClass?.btnLastResidenceDistrict:
            break
            
        
            
        default:
            
            break
            
        }
    }
    
    func cancelPicker() {
        
    }
    
    
    
    
}
