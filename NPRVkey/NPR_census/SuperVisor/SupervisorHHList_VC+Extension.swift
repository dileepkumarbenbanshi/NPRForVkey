//
//  SupervisorHHList_VC+Extension.swift
//  NPR-2020
//
//  Created by Dileep on 21/11/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation


extension SupervisorHHList_VC {
    
    @objc func onTapArrow(_ sender: UIButton){
//        self.navigateToController(identifier: "HouseholdMemberDetail_ViewController", storyBoardName: "NPR")
        
        let storyBoard = UIStoryboard.init(name: storyBoardName.superVisor, bundle: nil)
      let objController = storyBoard.instantiateViewController(withIdentifier:"SV_HHMemberDetail_VC") as? SV_HHMemberDetail_VC
       // objController?.arayMembersModel = arayMemberDetail
        objController?.hhModel = arayHHList[sender.tag]
       self.navigationController?.pushViewController(objController!, animated: true)
        
    }
    
    func handleRadioButtonSelection(tag:Int, placeHoder:String, selectedImage:UIImage, UnselectedImage:UIImage){
        if tag == 101 {
            self.imageViewCircleName.image = selectedImage
            self.imageViewCicleAadhaar.image = UnselectedImage
            self.imageViewCircleMobile.image = UnselectedImage
            self.imageViewCircleHead.image = UnselectedImage
            self.imageViewCircleDOB.image = UnselectedImage
            self.tfSearch.placeholder = placeHoder
        }
        if tag == 102 {
            self.imageViewCircleName.image = UnselectedImage
            self.imageViewCicleAadhaar.image = selectedImage
            self.imageViewCircleMobile.image = UnselectedImage
            self.imageViewCircleHead.image = UnselectedImage
            self.imageViewCircleDOB.image = UnselectedImage
            self.tfSearch.placeholder = placeHoder
        }
        if tag == 103 {
            self.imageViewCircleName.image = UnselectedImage
            self.imageViewCicleAadhaar.image = UnselectedImage
            self.imageViewCircleMobile.image = selectedImage
            self.imageViewCircleHead.image = UnselectedImage
            self.imageViewCircleDOB.image = UnselectedImage
            self.tfSearch.placeholder = placeHoder
        }
        if tag == 104 {
            self.imageViewCircleName.image = UnselectedImage
            self.imageViewCicleAadhaar.image = UnselectedImage
            self.imageViewCircleMobile.image = UnselectedImage
            self.imageViewCircleHead.image = selectedImage
            self.imageViewCircleDOB.image = UnselectedImage
            self.tfSearch.placeholder = placeHoder
        }
        if tag == 105 {
            self.imageViewCircleName.image = UnselectedImage
            self.imageViewCicleAadhaar.image = UnselectedImage
            self.imageViewCircleMobile.image = UnselectedImage
            self.imageViewCircleHead.image = UnselectedImage
            self.imageViewCircleDOB.image = selectedImage
            self.tfSearch.placeholder = placeHoder
        }
    }
 
   
    func serachMember(strSearch:String)  {
        
        let searchType = Utils.searchType.init(rawValue: btnSearchType?.tag ?? 0)
        
       
        var predicateHH = NSPredicate()
        
        switch searchType {
        case .head:
           
            let predicateHH = NSPredicate(format: "headName CONTAINS[c] %@ AND ebNumber =%@", strSearch,singleton().selectEBListModel.eb_number ?? "" )
           searchByHead_in_db(predicateHH: predicateHH)
            updateTblList()
            tfSearch.keyboardType = .namePhonePad
            tfSearch.returnKeyType = .default
            return
        case .name:
            //strSearchType = "name"
            predicateHH = NSPredicate(format: "name CONTAINS[c] %@ AND ebNumber =%@", strSearch,singleton().selectEBListModel.eb_number ?? "")
            tfSearch.keyboardType = .namePhonePad
            tfSearch.returnKeyType = .default
            break
            
        case .aadhar:
           // strSearchType = "aadhar"
            predicateHH = NSPredicate(format: "SELF.aadhar CONTAINS[c] %@ AND ebNumber =%@", strSearch,singleton().selectEBListModel.eb_number ?? "")
            tfSearch.keyboardType = .numberPad
            tfSearch.returnKeyType = .done
            break
        case .mobile:
            //strSearchType = "mobile"
            predicateHH = NSPredicate(format: "mobile CONTAINS[c] %@ AND ebNumber =%@", strSearch,singleton().selectEBListModel.eb_number ?? "")
            tfSearch.keyboardType = .numberPad
            tfSearch.returnKeyType = .done
            break
        
        case .dob:
            //strSearchType = "dob"
           // let strDob = strSearch.dateForSearch()
            
            predicateHH = NSPredicate(format: "dob CONTAINS[c] %@ AND ebNumber =%@", strSearch,singleton().selectEBListModel.eb_number ?? "")
           
            tfSearch.keyboardType = .numberPad
            tfSearch.returnKeyType = .done
            break
            
        case .none:
            AlertView().showAlertWithSingleButton( title: "", message: "Select Search Type")
            //arayHHList = arayTotalHHList.filter { ($0.headName?.contains(strSearch))!}
            return
        }
        searchMembers_in_db(predicateHH: predicateHH)
        
        
    }
   
    func searchMembers_in_db(predicateHH:NSPredicate)  {
        
        guard let  araySearchedMembers = DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data,predicate: predicateHH) as? [NPR2021MemberDetails] else {
            return
        }
        if araySearchedMembers.count == 0 {
               self.arayHHList.removeAll()
                self.updateTblList()
            
        }else
        {
            self.findHouseHold_onSearchMember(araySearchedMebers: araySearchedMembers)
        }
       
    }
    
    func   searchByHead_in_db(predicateHH:NSPredicate )  {
        
        guard let  araySearchedMembers = DataBaseManager().fetchDBData(entityName:EntityName.nprHHStats ,predicate: predicateHH) as? [NPR_2021hh_Details] else {
            return
        }
        if araySearchedMembers.count == 0 {
               self.arayHHList.removeAll()
                //self.updateTblList()
            
        }else{
            arayHHList = araySearchedMembers.filter({$0.hh_completed == HHCompletionStatusCode.completed || $0.hh_completed == HHCompletionStatusCode.uploaded})
            //self.arayHHList = araySearchedMembers
        }
        updateTblList()
        
    }
    
    func findHouseHold_onSearchMember(araySearchedMebers:[NPR2021MemberDetails])   {
        
        var araySearchedHH = [NPR_2021hh_Details]()
        
        for modelIndex in arayTotalHHList {
           
            
           let foundMembers = araySearchedMebers.filter({$0.hh_Number == modelIndex.houseHoldhNo})
            
            if foundMembers.count > 0 {
                araySearchedHH.append(modelIndex)
                
               // if modelIndex == arayTotalHHList.last {
                    
                arayHHList = araySearchedHH.filter({$0.hh_completed == HHCompletionStatusCode.completed || $0.hh_completed == HHCompletionStatusCode.uploaded})
                   // arayHHList = araySearchedHH
                    
                    self.updateTblList()
                    
                    self.updateTblList()
                    //
               // }
            }
            
        }
    }
    
    
}


@available(iOS 13.0, *)
extension SupervisorHHList_VC:UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //Format Date of Birth dd-MM-yyyy
        var txtAfterUpdate = ""
        var isvalid = true
        let searchType = Utils.searchType.init(rawValue: btnSearchType?.tag ?? 0)
        
        if let text = textField.text as NSString? {
                 txtAfterUpdate = text.replacingCharacters(in: range, with: string)
        }
        if txtAfterUpdate == "" {
            
        arayHHList = arayTotalHHList
       updateTblList()
                
         return true
        }

        switch searchType {
        case .name:
            // IF Special Charecter
            if !string.isValidAlphabetAndSpace(){
                AlertView().alertWithoutButton( message: LanguageModal.langObj.language_error, time: 3.0)
                return false
            }
             isvalid = !(textField.text!.count > 51 && (string.count ) > range.length)
            
            break
        case .aadhar:
            if !string.isValiNumberEntry(){
                return false
            }
            isvalid = !(textField.text!.count > 15 && (string.count ) > range.length)
            break
        case .mobile:
            if !string.isValiNumberEntry(){
                return false
            }
            isvalid = !(textField.text!.count > 9 && (string.count ) > range.length)
            break
        case .head:
            // IF Special Charecter
            if !string.isValidAlphabetAndSpace(){
                AlertView().alertWithoutButton( message: LanguageModal.langObj.language_error, time: 3.0)
                return false
            }
             isvalid = !(textField.text!.count > 51 && (string.count ) > range.length)
            break
        case .dob:
            if !string.isValiNumberEntry(){
                return false
            }
            if (textField.text?.count == 2) || (textField.text?.count == 5) {
                //Handle backspace being pressed
                if !(string == "") {
                    
                    textField.text = (textField.text)! + "-"
                    txtAfterUpdate = textField.text ?? ""
                }
            }
             isvalid = !(textField.text!.count > 9 && (string.count ) > range.length)
            break
        default:
            break
        }
        
        if isvalid {
            serachMember(strSearch: txtAfterUpdate)
        }
        return isvalid
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    
}
