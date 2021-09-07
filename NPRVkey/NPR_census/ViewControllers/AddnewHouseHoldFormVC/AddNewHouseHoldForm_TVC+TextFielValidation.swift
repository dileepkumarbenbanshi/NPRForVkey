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
            
            if let text = textField.text as NSString? {
                     txtAfterUpdate = text.replacingCharacters(in: range, with: string)
                   
                }
            
            if ((textField == tf_pd_Dob_date)||(textField == tf_pd_Dob_month)||(textField == tf_pd_Dob_year)) || ((textField == tf_ParentDetail_dob_date) || (textField == tf_ParentDetail_dob_month) || (textField == tf_ParentDetail_dob_year)) || ((textField == tf_ParentDetail_motherDob_date) || (textField == tf_ParentDetail_motherDob_month) || (textField == tf_ParentDetail_motherDob_year)){
                
                dobManageTextField(textField: textField, string: txtAfterUpdate)
            
            
            }else if textField == tf_ID_adhar {
             let isEnter = tf_aadharEntry(strText: txtAfterUpdate)
                return isEnter
            }else if textField == tf_ID_mobile {
                let isEnter = tf_mobileEntry(strText: txtAfterUpdate)
                   return isEnter
               }else if textField == tf_ID_voter {
                let isEnter = tf_voterIDEntry(strText: txtAfterUpdate)
                   return isEnter
               } else if textField == tf_ptAd_pinCode {
                let isEnter = tf_PinCode(strText: txtAfterUpdate)
                   return isEnter
               }
               else if textField == tf_padPinCode {
                let isEnter = tf_PinCode(strText: txtAfterUpdate)
                   return isEnter
               }
               else if textField == tf_pd_houseHoldNO {
               return tf_censusHouseHoldNo(strText: txtAfterUpdate)
               }
               else if textField == pd_houseNo {
               return tf_censusHouseNo(strText: txtAfterUpdate)
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
                        AlertView().alertWithoutButton(vc: self, message: "Please enter a valid date")
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
                            AlertView().alertWithoutButton(vc: self, message: "Please enter a valid date")
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
                            AlertView().alertWithoutButton(vc: self, message: "Please enter a valid Month")
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
                                isValidDOB = FormDateMangement().dateFormat(type: .father, formClass: self).isValidDOB()
                                dobT = .father
                               break
                            case tf_ParentDetail_motherDob_year:
                                isValidDOB = FormDateMangement().dateFormat(type: .mother, formClass: self).isValidDOB()
                                dobT = .mother
                               break
                           
                                
                            default:
                                break
                            }
                            if  !isValidDOB {
                                //AlertView().alertWithoutButton(vc: self, message: "Please enter a valid DOB")
                                AddNewHouseholdForm_ViewModel().refreshDobField(type: dobT, formClass: self)
                            }
                        }
                       
                        
                    }else{
                        textField.text = ""
                    }
                 }
                
                
            }
        }
        
        
        func tf_aadharEntry(strText:String)->Bool {
             if strText.count == 12{
               let isValid = Verhoeff.validateVerhoeff(for: strText)
                tf_ID_adhar.text = strText
                if !isValid {
                    AlertView().alertWithoutButton(vc: self, message:English.AddNewMemberFormAlert.inValidAadharNumber )
                }
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
                    AlertView().alertWithoutButton(vc: self, message:English.AddNewMemberFormAlert.inValidMobilerNumber )
                }
                tf_ID_mobile.text = strText
                return false
             }else if strText.count > 10 {
                return false
             }
            
            return true
        }
        func tf_voterIDEntry(strText:String)->Bool {
             if strText.count == 16{
               //let isValid = Verhoeff.validateVerhoeff(for: strText)
                tf_ID_voter.text = strText
                return false
             }else if strText.count > 16 {
                return false
             }
            
            return true
        }
        
        func tf_passportIDEntry(strText:String)->Bool {
             if strText.count == 12{
               //let isValid = Verhoeff.validateVerhoeff(for: strText)
                tf_passportNumber.text = strText
                return false
             }else if strText.count > 12 {
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
        
        func tf_censusHouseHoldNo(strText:String)->Bool {
//            var textInFormat = ""
//
//             let intHHN = Int(strText) ?? 0
//                textInFormat = String(format: AppFormat.threeDigitFormat, intHHN )
            
            if strText.count > 0 {
                let strEnteredHH = strText.censusHHNumber()
                
                
                if DBManagerHousehold().is_censusHouseholdExist(strCensusHHNo: strEnteredHH){
                    AlertView().alertWithoutButton(vc: self, message: English.AddNewMemberFormAlert.censusHHNoExist)
                }
                
            }
            
           
             if strText.count == 0{
               //let isValid = Verhoeff.validateVerhoeff(for: strText)
                
                tf_pd_houseHoldNO.text = strText
                return false
             }else if strText.count > 3 {
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
        
        //AlertView().showAlertWithSingleButton(vc: self, title: "", message: strMessage)
    }
    
}
