//
//  FormEducationQualificationManagement.swift
//  NPR-2020
//
//  Created by Dileep on 08/02/21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation




class FormEducationQualificationManagement:NSObject {
    var formClass:AddNewHouseHoldForm_TVC?
    
     init(formClass:AddNewHouseHoldForm_TVC) {
        self.formClass = formClass
    }
    
    var isOtherMotherTongue:Bool{
        
        let motherTongue = formClass?.btn_ed_motherTounge.titleLabel?.text ?? ""
       let motherTongueCode = motherTongue.getDropDownItem_id(aray: LanguageModal.langObj.mother_toungeArr)
        
        return motherTongueCode == util.otherMotherTongueCode
    }
    
    var isEnteredMotherTongueAlready:Bool {
        let motherTongue = formClass?.tf_edu_enterOtherMotherTongue.text ?? ""
       let motherTongueCode = motherTongue.getDropDownItem_id(aray: LanguageModal.langObj.mother_toungeArr)
        
        return motherTongueCode.count > 0
    }
    
    var strAlertMessage = ""
    
    
    func setEducationQualificationData(formClass:AddNewHouseHoldForm_TVC)  {
       
        
       let modelMember = formClass.modelMemberDetail
        
        let eduName = modelMember.edu_code?.getName_by_ID(aray: English().education_qualification())
        let eduCode_Name = modelMember.edu_code?.count ?? 0 > 0 ? "\(modelMember.edu_code ?? "") - \(eduName ?? "")" : ""
        
       
        
        formClass.btn_ed_qualification.setTitle(eduCode_Name, for: .normal)
        
       // let mt = modelMemberDetail.motherToungeode?.getName_by_ID(aray: English().education_qualification())
        
        let occuName = modelMember.occu_code?.getName_by_ID(aray: English().occupation())
        let ocuuCode_Name = modelMember.occu_code?.count ?? 0 > 0 ? "\(modelMember.occu_code ?? "") - \(occuName ?? "")" : ""
        
        formClass.btn_ed_occupation.setTitle(ocuuCode_Name, for: .normal)
        formClass.btn_ed_motherTounge.setTitle(modelMember.motherTounge ?? "", for: .normal)
        
        formClass.stackView_enterOtherMotherTongue.isHidden = !isOtherMotherTongue
        formClass.constraintHeight_enterOtherMotherTongue.constant = isOtherMotherTongue ? 50 : 0
        formClass.tf_edu_enterOtherMotherTongue.text = modelMember.otherMotherTounge ?? ""
        
       ed_setTagLabel(formClass: formClass)
    }
    
   
    func ed_setTagLabel(formClass:AddNewHouseHoldForm_TVC)  {
        formClass.btnEducationSection_title.setTitle(LanguageModal.langObj.education_details, for: .normal)
        formClass.btnEduQuali_title.setTitle(LanguageModal.langObj.education, for: .normal)
        formClass.tf_edu_enterOtherMotherTongue.placeholder = LanguageModal.langObj.enter_mother_tounge
        formClass.lblOtherMotherTongue_title.text = LanguageModal.langObj.enter_mother_tounge
        formClass.btnOccupation_title.setTitle(LanguageModal.langObj.occupation, for: .normal)
        formClass.btnMotherTongue_title.setTitle(LanguageModal.langObj.mother_tounge, for: .normal)
        
        formClass.tf_edu_enterOtherMotherTongue.delegate = self
    }
   
    
    func enableDisable_asSERefrence(formClass:AddNewHouseHoldForm_TVC)  {
        let isEnable = !(formClass.isValidSeRefrence )
        
        formClass.btn_ed_qualification .isEnabled = isEnable
        
        formClass.btn_ed_occupation .isEnabled = isEnable
        formClass.btn_ed_motherTounge .isEnabled = isEnable
        formClass.tf_edu_enterOtherMotherTongue.isEnabled = isEnable
        
    }
    
    
     func isValid_edu_occu()->Bool  {
         
     let formClass = self.formClass!
         if formClass.btn_ed_qualification.titleLabel?.text == "" || (formClass.btn_ed_qualification.titleLabel?.text == nil) {
            alertShow(message: English.AddNewMemberFormAlert.chooseEduQualification)
             return false
             
         }
         else if formClass.btn_ed_occupation.titleLabel?.text == "" || (formClass.btn_ed_occupation.titleLabel?.text == nil){
             alertShow(message: English.AddNewMemberFormAlert.chooseOccupation)
             return false
             
             
         }
         
         else if formClass.btn_ed_motherTounge.titleLabel?.text == "" || (formClass.btn_ed_motherTounge.titleLabel?.text == nil){
            
            alertShow(message: English.AddNewMemberFormAlert.chooseMotherTongue)
             return false
         }else if  isOtherMotherTongue{
           
                if formClass.tf_edu_enterOtherMotherTongue.text?.isEmpty ?? false  {
                   
                   
                    alertShow(message:  LanguageModal.langObj.validation_mother_tounge_1)
                    return false
                }else if formClass.tf_edu_enterOtherMotherTongue.text?.count ?? 0 < 3{
                    
                    alertShow(message:  LanguageModal.langObj.validation_mother_tounge_1)
                    return false
                    
                }else if isEnteredMotherTongueAlready {
                    
                   
                    alertShow(message:  LanguageModal.langObj.mother_tongue_already_present)
                    
                    return false
                }
                    
           
         }
        
         
             return true
         
        
     }
    func alertShow (message:String){
        
        AlertView().showAlertWithSingleButton(title: "", message: message)
        
    }
}


extension FormEducationQualificationManagement:UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        var txtAfterUpdate = ""
         let isValid = string.isValidAlphabetAndSpace()
        if !isValid {
            return false
        }
        
        if let text = textField.text as NSString? {
                 txtAfterUpdate = text.replacingCharacters(in: range, with: string)
               
            }
        
        
        if txtAfterUpdate.getDropDownItem_id(aray: LanguageModal.langObj.mother_toungeArr).count > 0 {
          alertShow(message: LanguageModal.langObj.mother_tongue_already_present)
            
            
        }
        
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}
