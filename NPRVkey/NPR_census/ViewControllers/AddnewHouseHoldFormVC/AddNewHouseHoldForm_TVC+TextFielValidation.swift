//
//  AddNewHouseHoldForm_TVC+TextFielValidation.swift
//  NPR-2020
//
//  Created by Dileep on 18/12/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation


    
    extension AddNewHouseHoldForm_TVC :UITextFieldDelegate{
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
        
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
            var txtAfterUpdate = ""
            
            if ((textField == tf_pd_Dob_date)||(textField == tf_pd_Dob_month)||(textField == tf_pd_Dob_year)) || ((textField == tf_ParentDetail_dob_date) || (textField == tf_ParentDetail_dob_month) || (textField == tf_ParentDetail_dob_year)) || ((textField == tf_ParentDetail_motherDob_date) || (textField == tf_ParentDetail_motherDob_month) || (textField == tf_ParentDetail_motherDob_year  )   ||    (textField == pd_houseNo) || (textField == tf_pd_houseHoldNO) || (textField == tf_ID_mobile) || (textField == tf_ID_adhar)) || ((textField == tf_padPinCode) || (textField == tf_ptAd_pinCode) || textField == tf_pd_SE_refrenceNO ){
                
                if !string.isValiNumberEntry() {
                    return false
                }
            
            
            }
            
            
           else if textField == tf_pd_Name || textField == tf_ParentDetail_motherName || textField == parentDetail_fatherName || textField == tf_ParentDetail_spouseName || textField == tf_padTownVillage || textField == tf_ptAd_townVillage || textField == tf_pd_midleName || textField == tf_pd_lastName || textField == tf_edu_enterOtherMotherTongue {
                if !string.isValidAlphabetAndSpace() {
                    
                    AlertView().alertWithoutButton( message: LanguageModal.langObj.language_error, time: 3.0)
                    return false
                }
                
                    
                }
            
            else if textField == tf_padHouseNumber || textField == tf_ptAd_houseNumber {
                if !string.isValidAddressEntry() {
                    return false
                }
            }
            if let text = textField.text as NSString? {
                     txtAfterUpdate = text.replacingCharacters(in: range, with: string)
                   
                }
            
            if ((textField == tf_pd_Dob_date)||(textField == tf_pd_Dob_month)||(textField == tf_pd_Dob_year)) || ((textField == tf_ParentDetail_dob_date) || (textField == tf_ParentDetail_dob_month) || (textField == tf_ParentDetail_dob_year)) || ((textField == tf_ParentDetail_motherDob_date) || (textField == tf_ParentDetail_motherDob_month) || (textField == tf_ParentDetail_motherDob_year)){
                
                dobManageTextField(textField: textField, string: txtAfterUpdate)
            
            
            }else if textField == tf_pd_Name || textField == tf_ParentDetail_motherName || textField == tf_ParentDetail_spouseName || textField == parentDetail_fatherName {
                return tf_NameEntry(strText: txtAfterUpdate)
            }
            
            else if textField == tf_ID_adhar {
             let isEnter = tf_aadharEntry(strText: txtAfterUpdate)
                return isEnter
            }else if textField == tf_ID_mobile {
                let isEnter = tf_mobileEntry(strText: txtAfterUpdate)
                   return isEnter
               }
            else if textField == tf_passportNumber {
             let isEnter = tf_passportIDEntry(strText: txtAfterUpdate)
                return isEnter
            }else if textField == tf_ID_voter {
                let isEnter = tf_voterIDEntry(strText: txtAfterUpdate)
                   return isEnter
               }else if textField == tf_ID_dL {
                let isEnter = tf_dlIDEntry(strText: txtAfterUpdate)
                   return isEnter
               }
               else if textField == tf_ptAd_pinCode {
                let isEnter = tf_PinCode(strText: txtAfterUpdate)
                   return isEnter
               }
               else if textField == tf_padPinCode {
               
                let isEnter = tf_PinCodePermanentAdd(strText: txtAfterUpdate)
                if isEnter {
                    btnCkeck_permanentSameasHead.isSelected = false
                    btnCkeck_permanentSameasPresentAdd.isSelected = false
                }
                
                   return isEnter
               }
               else if textField == tf_padHouseNumber  || textField == tf_padTownVillage{
                btnCkeck_permanentSameasHead.isSelected = false
                btnCkeck_permanentSameasPresentAdd.isSelected = false
               }
               
               else if textField == tf_pd_houseHoldNO {
               // let isEnter = tf_censusHouseHoldNo(strText: txtAfterUpdate)
//                if isEnter {
//                    btnCkeck_permanentSameasHead.isSelected = false
//                    btnCkeck_permanentSameasPresentAdd.isSelected = false
//                }
                
                
               return tf_censusHouseHoldNo(strText: txtAfterUpdate)
               }
               else if textField == pd_houseNo {
               return tf_censusHouseNo(strText: txtAfterUpdate)
               }
               else if textField == tf_pd_SE_refrenceNO {
               return tf_seRefrenceNumberEntry(strText: txtAfterUpdate)
               }
            
           return true
        }
        
        
        func dobManageTextField(textField:UITextField,string:String)  {
           
    //        let textRange = Range(range, in: string) {
    //                   let updatedText = text.replacingCharacters(in: textRange,
            //textField.text = string
             let strText = string
            if strText.isEmpty {
               
                if (textField == tf_pd_Dob_date) || (textField == tf_ParentDetail_dob_date) || (textField == tf_ParentDetail_motherDob_date){
                   
                    if strText >= "31" {
                        textField.text = strText
                    }else{
                        AlertView().alertWithoutButton( message: LanguageModal.langObj.validation_member_dob)
                    }
                    
                        
                       // tf_pd_Dob_month.becomeFirstResponder()
                    
                } else if (textField == tf_pd_Dob_month) || (textField == tf_ParentDetail_dob_month) || (textField == tf_ParentDetail_motherDob_month) {
                    
                    if strText.count == 0{
                        textField.text = strText
                        let prevTextField = view.viewWithTag(textField.tag-1)
                        
                        prevTextField?.becomeFirstResponder()
                                    }
                    
                     
                 }else if (textField == tf_pd_Dob_year) || (textField == tf_ParentDetail_dob_year) || (textField == tf_ParentDetail_motherDob_year) {
                    
                    if strText.count == 0{
                        textField.text = strText
                        let prevTextField = view.viewWithTag(textField.tag-1)
                        
                        prevTextField?.becomeFirstResponder()
                        
                                    }
                        
                    
                        
                 }  } else {
               
                    if (textField == tf_pd_Dob_date) || (textField == tf_ParentDetail_dob_date) || (textField == tf_ParentDetail_motherDob_date) {
                   
                    if strText.count == 2 {
                        textField.text = strText
                        let nextTextField = view.viewWithTag(textField.tag+1)
                        
                        
                        if strText <= "31" {
                            textField.text = strText
                            nextTextField?.becomeFirstResponder()
                        }else{
                            textField.text = ""
                            AlertView().alertWithoutButton( message: LanguageModal.langObj.validation_member_dob)
                        }
                    }else {
                        textField.text = ""
                    }
                }  else if (textField == tf_pd_Dob_month) || (textField == tf_ParentDetail_dob_month) || (textField == tf_ParentDetail_motherDob_month){
                    
                    if strText.count == 2 {
                        textField.text = strText
                        let nextTextField = view.viewWithTag(textField.tag+1)
                        
                        if strText <= "12" {
                            textField.text = strText
                            nextTextField?.becomeFirstResponder()
                        }else{
                            textField.text = ""
                            AlertView().alertWithoutButton( message: "Please enter a valid Month")
                        }
                       
                    }else {
                        textField.text = ""
                    }
                    
                 }else if (textField == tf_pd_Dob_year) || (textField == tf_ParentDetail_dob_year) || (textField == tf_ParentDetail_motherDob_year) {
                    var dobT =  dobType.personal
                    
                    if strText.count <= 4 {
                        
                        
                        if strText.count == 4 {
                            textField.text = strText
                            textField.resignFirstResponder()
                            var isValidDOB = true
                            
                            switch textField {
                            case tf_pd_Dob_year:
                                isValidDOB = FormDateMangement().dateFormat(type: .personal, formClass: self).isValidDOB()
                                dobT = .personal
                               break
                            case tf_ParentDetail_dob_year:
                                isValidDOB = FormDateMangement().dateFormat(type: .father, formClass: self).isValidParentDOB()
                                dobT = .father
                               break
                            case tf_ParentDetail_motherDob_year:
                                isValidDOB = FormDateMangement().dateFormat(type: .mother, formClass: self).isValidParentDOB()
                                dobT = .mother
                               break
                           
                                
                            default:
                                break
                            }
                            if  !isValidDOB {
                               
                                formModelClass!.refreshDobField(type: dobT, formClass: self)
                            }
                        }
                       
                        
                    }else{
                        textField.text = ""
                    }
                 }
                
                
            }
        }
        
        func tf_NameEntry(strText:String)->Bool {
            return strText.count < 50
            
            
        }
        func tf_aadharEntry(strText:String)->Bool {
            tf_ID_adhar.isSecureTextEntry = false
             if strText.count == 12{
               let isValid = Verhoeff.validateVerhoeff(for: strText)
                tf_ID_adhar.text = strText
                
                if !isValid {
                    AlertView().alertWithoutButton( message:English.AddNewMemberFormAlert.inValidAadharNumber )
                }
                formModelClass?.objIDManagement?.checkAAdharDuplicacy()
                tf_ID_adhar.isSecureTextEntry = true
                return false
             }else if strText.count > 12 {
                return false
             }
            
            return true
            
        }
      
        func tf_mobileEntry(strText:String)->Bool {
             if strText.count == 10{
                let isValid = strText.isValidMobileNumber()
                if !isValid {
                    AlertView().alertWithoutButton( message:English.AddNewMemberFormAlert.inValidMobilerNumber )
                }
                tf_ID_mobile.text = strText
                return false
             }else if strText.count > 10 {
                return false
             }
            
            return true
        }
        func tf_voterIDEntry(strText:String)->Bool {
             if strText.count == 30{
//                
               //let isValid = Verhoeff.validateVerhoeff(for: strText)
                tf_ID_voter.text = strText
                return false
             }else if strText.count > 30 {
                return false
             }
            
            return true
        }
        
        func tf_dlIDEntry(strText:String)->Bool {
             if strText.count == 30{
               //let isValid = Verhoeff.validateVerhoeff(for: strText)
                tf_ID_dL.text = strText
                return false
             }else if strText.count > 30 {
                return false
             }
            
            return true
        }
        func tf_passportIDEntry(strText:String)->Bool {
             if strText.count == 8{
                let isValid = strText.isValidPassport()
                if !isValid {
                    AlertView().alertWithoutButton( message:English.AddNewMemberFormAlert.invalidPassportVlidation )
                }
                tf_passportNumber.text = strText
                return false
             }else if strText.count > 8 {
                return false
             }
            
            return true
        }
        
       
        func tf_PinCode(strText:String)->Bool {
             if strText.count == 0{
               //let isValid = Verhoeff.validateVerhoeff(for: strText)
                tf_ptAd_pinCode.text = strText
                return false
             }else if strText.count > 6 {
                return false
             }
            
            return true
        }
        func tf_PinCodePermanentAdd(strText:String)->Bool {
             if strText.count == 0{
               //let isValid = Verhoeff.validateVerhoeff(for: strText)
                tf_padPinCode.text = strText
                return false
             }else if strText.count > 6 {
                return false
             }
            
            return true
        }
        
        
        
        
        func tf_censusHouseHoldNo(strText:String)->Bool {
            var textInFormat = ""

             let intHHN = Int(strText) ?? 0
                textInFormat = String(format: AppFormat.threeDigitFormat, intHHN )
            
            if strText.count > 0 {
                let strEnteredHH = strText.censusHHNumber()


                if DBManagerHousehold().is_censusHouseholdExist(strCensusHHNo: strEnteredHH){
                   // AlertView().alertWithoutButton( message: English.AddNewMemberFormAlert.censusHHNoExist)
                    AlertView().alertWithoutButton(message:English.AddNewMemberFormAlert.censusHHNoExist,time:1.0)
                    tf_pd_houseHoldNO.layer.borderWidth = 0.5
                    tf_pd_houseHoldNO.layer.borderColor = UIColor.red.cgColor
                   
                   // tf_pd_houseHoldNO.text = strText
                }
                else{
                    tf_pd_houseHoldNO.layer.borderColor = UIColor.gray.cgColor
                }

            }
            
           
             if strText.count == 0{
               //let isValid = Verhoeff.validateVerhoeff(for: strText)
                
                tf_pd_houseHoldNO.text = strText
                return false
             }else if strText.count > 5 {
                return false
             }
            
            return true
        }
        
        func tf_censusHouseNo(strText:String)->Bool {
          //  var textInFormat = ""
            
//            let intHHN = Int(strText) ?? 0
//                textInFormat = String(format: AppFormat.fourdigitFormat, intHHN)
            
             if strText.count == 0{
               //let isValid = Verhoeff.validateVerhoeff(for: strText)
                
                pd_houseNo.text = strText
                return false
             }else if strText.count > 4 {
                return false
             }
            
            return true
        }
        
        func dateFormat() -> String {
            
           return ""
        }
        
        
        func tf_seRefrenceNumberEntry(strText:String)->Bool {
             if strText.count == 10{
                let isValid = strText.isValidSENumber()
                if !isValid {
                    AlertView().alertWithoutButton( message:LanguageModal.langObj.incorrect_SE )
                }
                isValidSeRefrence = isValid
                formModelClass?.setForm_asRefrenceNumber()
                
                tf_pd_SE_refrenceNO.text = strText
                return isValid
             }else if strText.count > 10 {
                return false
             }
            
            return true
        }
        func checkSpecialCharecterINAlphabeticEntry(textField:UITextField,lastEntry:String) -> Bool {
            if textField == tf_pd_Name || textField == tf_ParentDetail_motherName || textField == parentDetail_fatherName {
               return lastEntry.isValidAlphabetAndSpace()
                
            }
            return true
        }
        
    }
        



extension AddNewHouseHoldForm_TVC {
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        var strMessage = ""
        
        switch textField {
        case tf_pd_Name:
            if textField.text?.count ?? 0 < 3 {
                strMessage = English.AddNewMemberFormAlert.nameValidation
            }
            break
            
        case tf_ParentDetail_motherName:
            if textField.text?.count ?? 0 < 3 {
                strMessage = English.AddNewMemberFormAlert.fatherNameInvalid
            }
            
            break
        case parentDetail_fatherName:
            if textField.text?.count ?? 0 < 3 {
                strMessage = English.AddNewMemberFormAlert.motherNameInvalid
            }
            
            break
        case tf_ParentDetail_spouseName:
            if textField.text?.count ?? 0 < 3 {
                strMessage = English.AddNewMemberFormAlert.spouseNameInvalid
            }
            
            break
        case tf_ID_adhar:
            if textField.text?.count ?? 0 < 12 {
                strMessage = English.AddNewMemberFormAlert.inValidAadharLenth
            }
            
            break
           
        case tf_ID_mobile:
            if textField.text?.count ?? 0 < 10 {
                strMessage = English.AddNewMemberFormAlert.inValidMobileLenth
            }
            
            break
        default:
            break
        }
        
        //AlertView().showAlertWithSingleButton( title: "", message: strMessage)
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
            if action == #selector(paste(_:)) ||
                action == #selector(cut(_:)) ||
                action == #selector(copy(_:)) ||
                action == #selector(select(_:)) ||
                action == #selector(selectAll(_:)) ||
                action == #selector(delete(_:)) ||
                action == #selector(makeTextWritingDirectionLeftToRight(_:)) ||
                action == #selector(makeTextWritingDirectionRightToLeft(_:)) ||
                action == #selector(toggleBoldface(_:)) ||
                action == #selector(toggleItalics(_:)) ||
                action == #selector(toggleUnderline(_:)) {
                return false
            }
            return super.canPerformAction(action, withSender: sender)
        }
    
}
