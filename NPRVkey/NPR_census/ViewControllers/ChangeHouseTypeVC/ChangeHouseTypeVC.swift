//
//  ChangeHouseTypeVC.swift
//  NPR-2021
//
//  Created by Dileep on 25/05/21.
//  Copyright © 2021 admin. All rights reserved.
//

import UIKit

class ChangeHouseTypeVC: UIViewController {

    @IBOutlet weak var tf_censusHouseHoldNumber: UITextField!
    @IBOutlet weak var tf_censusHouseNumber: UITextField!
    @IBOutlet weak var lblAssignEB: UILabel!
    @IBOutlet weak var tf_nameOfInstitute: UITextField!
    @IBOutlet weak var tf_name: UITextField!
//    @IBOutlet weak var tf_houseHoldNumber: UITextField!
//    @IBOutlet weak var tf_numberOfMember: UITextField!
    @IBOutlet weak var btnHouseless: UIButton!
    @IBOutlet weak var btnnstitute: UIButton!
    @IBOutlet weak var btnNormal: UIButton!
    
    
   
    
    
    
    
    @IBOutlet var proceedButton: UIButton!
    @IBOutlet var nameOfHeadLabel: UILabel!
   
    @IBOutlet var nprHouseholdLabel: UILabel!
    @IBOutlet var houselessButton: UIButton!
    @IBOutlet var institutionalButton: UIButton!
    @IBOutlet var normalButton: UIButton!
    @IBOutlet var typeOfHouseholdLabel: UILabel!
    @IBOutlet var addNewHouseholdLabel: UILabel!
    @IBOutlet var backToIncompleteHouselholdLabel: UILabel!
    @IBOutlet var lblCensusHN: UILabel!
    @IBOutlet var lblInstituteName: UILabel!
    var isRadioButtonSelected:Bool = false
    
    var selectedHouseType:HouseType?
    var strCensusHouseHoldNumber = ""
    var strCensusHouseNumber = ""
    
    var hhModel: NPR_2021hh_Details?
    
    
    @IBOutlet weak var stackViewNameInstitute: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        // Do any additional setup after loading the view.
        viewPrepare()
        self.addKeyboardObserver()
    }
    
    func viewPrepare()  {
        
        self.tf_censusHouseNumber.delegate = self
        tf_censusHouseHoldNumber.delegate = self
       // tf_houseHoldNumber.text =  DBManagerHousehold().getNewHouseHoldNumber()
        
        lblAssignEB.text = "\(LanguageModal.langObj.assign_eb_number) \(singleton().activeEB)"
        tf_censusHouseNumber.addupDoneButton_TextFields()
        tf_censusHouseHoldNumber.addupDoneButton_TextFields()
        fillData()
        
        houselessButton.setTitle(LanguageModal.langObj.houseless, for: .normal)
        institutionalButton.setTitle(LanguageModal.langObj.institutional, for: .normal)
        normalButton.setTitle(LanguageModal.langObj.normal, for: .normal)
        
        nprHouseholdLabel.text = LanguageModal.langObj.census_household_no
        
        typeOfHouseholdLabel.text = LanguageModal.langObj.hh_type
        addNewHouseholdLabel.text = LanguageModal.langObj.ad_new_hh
       
        tf_censusHouseNumber.placeholder = LanguageModal.langObj.census_house_no
        lblCensusHN.text = LanguageModal.langObj.census_house_no
        
        tf_censusHouseHoldNumber.placeholder = LanguageModal.langObj.census_household_no
        nprHouseholdLabel.text = LanguageModal.langObj.census_household_no
        
        tf_nameOfInstitute.placeholder = LanguageModal.langObj.name_of_institue
        lblInstituteName.text = LanguageModal.langObj.name_of_institue
        proceedButton.setTitle(LanguageModal.langObj.proceed, for: .normal)
        
       
        
        backToIncompleteHouselholdLabel.text = LanguageModal.langObj.hh_member_details
        
    }
    
    func fillData()  {
        
        guard let houseTypeString = hhModel?.hhType else {
            return
        }
        
        let houseType = HouseType.init(rawValue: houseTypeString)
        var btnSelected = UIButton()
        
        switch houseType {
        case .normal:
            btnnstitute.isSelected = false
            btnHouseless.isSelected = false
            selectedHouseType = .normal
            strCensusHouseHoldNumber = ""
            tf_censusHouseNumber.text = hhModel?.census_hNo
            tf_censusHouseHoldNumber.text = hhModel?.census_hhNo
            tf_name.text = hhModel?.headName
            tf_censusHouseNumber.isEnabled = true
            tf_censusHouseHoldNumber.isEnabled = true
            strCensusHouseNumber = hhModel?.census_hNo ?? ""
            btnSelected = btnNormal
            break
            
            case .institute:
                
            btnNormal.isSelected = false
            btnHouseless.isSelected = false
            stackViewNameInstitute.isHidden = false
            
            selectedHouseType = .institute
            btnSelected = btnnstitute
                
               
                tf_name.text = hhModel?.headName
                tf_censusHouseNumber.isEnabled = true
                tf_censusHouseHoldNumber.isEnabled = false
               // tf_nameOfInstitute.text = hhModel.in
            break
        default:
            btnNormal.isSelected = false
            btnnstitute.isSelected = false
            selectedHouseType = .houseLess
            strCensusHouseHoldNumber = ""
            strCensusHouseNumber =  ""
            btnSelected = btnHouseless
            
            
            tf_name.text = hhModel?.headName
            tf_censusHouseNumber.isEnabled = false
            tf_censusHouseHoldNumber.isEnabled = true
          
        }
        btnSelected.isSelected =   true
        tf_censusHouseNumber.text = hhModel?.census_hNo ?? ""
        tf_censusHouseHoldNumber.text = hhModel?.census_hhNo ?? ""
        
        guard let strInstituteName = hhModel?.instituteName else {
            return
        }
        
        tf_nameOfInstitute.text = strInstituteName
    }
    
    override func viewDidAppear(_ animated: Bool) {
        overrideUserInterfaceStyle = .light
//        if #available(iOS 13.0, *) {
//            overrideUserInterfaceStyle = .light
//        } else {
//            // Fallback on earlier versions
//        }
    }
    
   
    
    
    @IBAction func btnBack_action(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
        
        
     }
    @IBAction func btnEdit_action(_ sender: UIButton) {
        
        
    }
    
    @IBAction func btnProceed_action(_ sender: UIButton) {
        if isAllFieldValid() {
           
            hhModel?.census_hNo = tf_censusHouseNumber.text?.censusHouseNumber()
            hhModel?.hhType = selectedHouseType?.rawValue
            hhModel?.census_hhNo = tf_censusHouseHoldNumber.text ?? "".censusHHNumber()
            hhModel?.instituteName = tf_nameOfInstitute.text ?? ""
            do {
                try context.save()
            } catch  {
                
            }
            editHouseDetailOFEachMembersINHH()
        }
       
    }
    
    
    @IBAction func btnTypeHousehold_action(_ sender: UIButton) {
       
        stackViewNameInstitute.isHidden = true
        self.isRadioButtonSelected = true
        let strTag = "\(sender.tag - 9)"
        var is_tf_CensusHHNumberEnable = true
        var is_tf_CensusHouseNumberEnable = true
        
        strCensusHouseNumber = hhModel?.census_hNo ?? ""
        strCensusHouseHoldNumber = hhModel?.census_hhNo ?? ""
        let houseType = HouseType.init(rawValue: strTag)
        
        switch houseType {
        case .normal:
            btnnstitute.isSelected = false
            btnHouseless.isSelected = false
            selectedHouseType = .normal
            strCensusHouseHoldNumber = ""
            is_tf_CensusHHNumberEnable = true
            is_tf_CensusHouseNumberEnable = true
            tf_nameOfInstitute.text = ""
           
            break
            
            case .institute:
                
            btnNormal.isSelected = false
            btnHouseless.isSelected = false
            stackViewNameInstitute.isHidden = false
            strCensusHouseHoldNumber = "999"
            tf_censusHouseHoldNumber.text = strCensusHouseHoldNumber
            
            selectedHouseType = .institute
            
            is_tf_CensusHHNumberEnable = false
            is_tf_CensusHouseNumberEnable = true
            break
        default:
            btnNormal.isSelected = false
            btnnstitute.isSelected = false
            selectedHouseType = .houseLess
            strCensusHouseNumber = ""
            tf_nameOfInstitute.text = ""
            is_tf_CensusHHNumberEnable = true
            is_tf_CensusHouseNumberEnable = false
            
        }
        sender.isSelected =   !sender.isSelected
        tf_censusHouseNumber.isEnabled = is_tf_CensusHouseNumberEnable
        tf_censusHouseHoldNumber.isEnabled = is_tf_CensusHHNumberEnable
        tf_censusHouseNumber.isUserInteractionEnabled = is_tf_CensusHouseNumberEnable
        tf_censusHouseHoldNumber.isUserInteractionEnabled = is_tf_CensusHHNumberEnable
        tf_censusHouseHoldNumber.text = strCensusHouseHoldNumber
        tf_censusHouseNumber.text = strCensusHouseNumber
    }
    
    func isValid() -> Bool {
       
        if !self.isRadioButtonSelected {
            
            let alert = AlertView()
            
            alert.alertWithoutButton( message: LanguageModal.langObj.check_hh_type, time: 2.0)
            
          return false
        }
        else if self.btnNormal.isSelected {
            
        }
        
        return true
    }
    
    
    func isAllFieldValid()-> Bool{
        let censusHouseNumber = Int(self.tf_censusHouseNumber.text ?? "")
        let censusHouseHoldNumber = Int(self.tf_censusHouseHoldNumber.text ?? "")
        let strCensusHouseNumber = tf_censusHouseNumber.text?.trimWhiteSpace()
        let strCensusHouseHoldNumber = tf_censusHouseHoldNumber.text?.trimWhiteSpace()
        
        let alert = AlertView()
        if !self.isRadioButtonSelected {
            
            
            
            alert.alertWithoutButton( message: LanguageModal.langObj.check_hh_type, time: 2.0)
            
          return false
        }
        if self.btnNormal.isSelected  {
            if  censusHouseNumber == 0 || tf_censusHouseNumber.text?.count == 0 ||  tf_censusHouseNumber.text == nil {
              
                
                let alert = AlertView()
                
                alert.alertWithoutButton( message: LanguageModal.langObj.validation_census_house_no_zero, time: 2.0)
                return false
            }else if  (censusHouseHoldNumber == 0) || tf_censusHouseHoldNumber.text?.count == 0 ||  tf_censusHouseHoldNumber.text == nil{
                
                alert.alertWithoutButton( message: LanguageModal.langObj.validation_new_census_household_no_zero, time: 2.0)
                return false
            }else if isExistCensusHHnumber() {
                
                alert.alertWithoutButton( message: LanguageModal.langObj.validation_newchh_no_already_exist, time: 2.0)
                return false
            }
                
            
            
        }
       else if self.btnnstitute.isSelected {
            if (self.tf_nameOfInstitute.text?.trimmingCharacters(in: .whitespaces).isEmpty)! || self.tf_nameOfInstitute.text!.count < 3 {
                var strMessage = ""
                
                if tf_nameOfInstitute.text?.count ?? 0 < 1  {
                    strMessage = LanguageModal.langObj.validation_name_of_institution
                }
                else{
                    strMessage =  LanguageModal.langObj.validation_name_of_institution
                }
                
                AlertView().alertWithoutButton( message:strMessage )
              
                return false
            }
        if  censusHouseNumber == 0 || strCensusHouseNumber?.count == 0 {
                
                
                alert.alertWithoutButton( message: LanguageModal.langObj.validation_census_house_no_zero, time: 2.0)
                return false
             }
            
        }
        
       else if self.btnHouseless.isEnabled {
        if isExistCensusHHnumber() {
        alert.alertWithoutButton( message: LanguageModal.langObj.validation_newchh_no_already_exist, time: 2.0)
        return false
        
       }
       }
        return true
    }
    
   private func isExistCensusHHnumber() -> Bool {
        
        let strCensusHHNumber = tf_censusHouseHoldNumber.text ?? ""
        
        if selectedHouseType == .institute {
            return false
        }
    if Int(strCensusHHNumber) == Int(strCensusHouseHoldNumber) {
        return false
    }
    
       let isExist = DBManagerHousehold().is_censusHouseholdExist(strCensusHHNo: strCensusHHNumber)
        if isExist {
            let alertVC = AlertView()
            
            alertVC.alertWithoutButton( message: LanguageModal.langObj.validation_newchh_no_already_exist)
        }
        return isExist
    }
    
    func editHouseDetailOFEachMembersINHH()  {
        
        if let modelHHLocal = self.hhModel {
        DBManagerMemberDetail().fetchedHHMembers(modelSelectedHH: modelHHLocal  ) { (arayMemberModel) in
           
             
                for memberModel in arayMemberModel {
                    memberModel.censusHH_number = self.tf_censusHouseHoldNumber.text ?? ""
                    memberModel.censusHouse_number = self.tf_censusHouseNumber.text ?? ""
                    memberModel.institution_name = self.tf_nameOfInstitute.text ?? ""
                    
                    do {
                        try context.save()
                    } catch  {
                        
                    }
                    if memberModel == arayMemberModel.last {
                        let alertVC = AlertView()
                        alertVC.delegate = self
                        alertVC.alertWithoutButton( message: AppMessages.changedHouseType)
                    }
                }
            }
            
        }
    }
    
}
    
//MARK:UITextfield Delegate
@available(iOS 13.0, *)
extension  ChangeHouseTypeVC: UITextFieldDelegate {
 
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == tf_censusHouseHoldNumber || textField == tf_censusHouseNumber{
            if !string.isValiNumberEntry(){
                return false
            }
        }else if textField == tf_nameOfInstitute {
            if !string.isValidAlphabetAndSpace(){
                AlertView().alertWithoutButton( message: LanguageModal.langObj.language_error, time: 3.0)
                return false
            }
        }
        
        if textField == self.tf_censusHouseNumber {
            guard let text = self.tf_censusHouseHoldNumber.text else { return true }
            
//            if DBManagerHousehold().is_censusHouseholdExist(strCensusHHNo: text){
//                AlertView().alertWithoutButton( message: English.AddNewMemberFormAlert.censusHHNoExist, time: 1.0)
//            }
            let newLength = text.count + string.count - range.length
            return newLength <= 4
        }
        else{
            if (string == "\n") {
                textField.resignFirstResponder()
            }
            return true
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}

extension ChangeHouseTypeVC:AlertViewDelegate {
    func alertTapedYes() {
        
    }
    
    func alertViewWithoutButtonDissMiss() {
        self.navigationController?.popViewController(animated: true)
    }
    
}
