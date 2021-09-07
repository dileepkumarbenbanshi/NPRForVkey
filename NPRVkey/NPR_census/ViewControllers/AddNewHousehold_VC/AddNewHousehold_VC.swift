//
//  AddNewHousehold_VC.swift
//  NPR_census
//
//  Created by Dileep on 24/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
@available(iOS 13.0, *)
class AddNewHousehold_VC: UIViewController {
    @IBOutlet weak var lblAssignEB: UILabel!
    @IBOutlet weak var lblPrevVC: UILabel!
    @IBOutlet weak var tf_nameOfInstitute: UITextField!
    @IBOutlet weak var tf_name: UITextField!
    @IBOutlet weak var tf_houseHoldNumber: UITextField!
    @IBOutlet weak var tf_numberOfMember: UITextField!
    @IBOutlet weak var btnHouseless: UIButton!
    @IBOutlet weak var btnnstitute: UIButton!
    @IBOutlet weak var btnNormal: UIButton!
    
    @IBOutlet var proceedButton: UIButton!
    @IBOutlet var nameOfHeadLabel: UILabel!
    @IBOutlet var numberOfMembersLabel: UILabel!
    @IBOutlet var nprHouseholdLabel: UILabel!
    @IBOutlet var houselessButton: UIButton!
    @IBOutlet var institutionalButton: UIButton!
    @IBOutlet var normalButton: UIButton!
    @IBOutlet var typeOfHouseholdLabel: UILabel!
    @IBOutlet var addNewHouseholdLabel: UILabel!
    @IBOutlet var backToIncompleteHouselholdLabel: UILabel!
    
    
    
    var isRadioButtonSelected:Bool = false
    var houseHoldArr = [NPR_2021hh_Details]()
    var selectedHouseType:HouseType?
    var strCensusHouseHoldNumber = ""
    
    @IBOutlet weak var stackViewNameInstitute: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        // Do any additional setup after loading the view.
        viewPrepare()
        self.addKeyboardObserver()
    }
    
    func viewPrepare()  {
        
        self.tf_numberOfMember.delegate = self
        tf_houseHoldNumber.text =  DBManagerHousehold().getNewHouseHoldNumber()
        
        lblAssignEB.text = "Assign HLB - \(singleton().activeEB)"
        tf_numberOfMember.addupDoneButton_TextFields()
        tf_houseHoldNumber.addupDoneButton_TextFields()
        
        
        
        lblAssignEB.text = LanguageModal.langObj.assign_eb_number + " " + (singleton().activeEB)
       
        
        nameOfHeadLabel.text = LanguageModal.langObj.head_of_family_name
        numberOfMembersLabel.text = LanguageModal.langObj.number_of_member_in_family
        nprHouseholdLabel.text = LanguageModal.langObj.hh_number2
        houselessButton.setTitle(LanguageModal.langObj.houseless, for: .normal)
        institutionalButton.setTitle(LanguageModal.langObj.institutional, for: .normal)
        normalButton.setTitle(LanguageModal.langObj.normal, for: .normal)
        typeOfHouseholdLabel.text = LanguageModal.langObj.hh_type
        addNewHouseholdLabel.text = LanguageModal.langObj.ad_new_hh
        backToIncompleteHouselholdLabel.text = LanguageModal.langObj.head_of_family_name
        proceedButton.setTitle(LanguageModal.langObj.proceed, for: .normal)
        tf_houseHoldNumber.placeholder = LanguageModal.langObj.hh_number2
        tf_numberOfMember.placeholder = LanguageModal.langObj.number_of_member_in_family
        tf_name.placeholder = LanguageModal.langObj.head_of_family_name
        backToIncompleteHouselholdLabel.text = LanguageModal.langObj.hh_summary
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
    
    @IBAction func btnProceed_action(_ sender: UIButton) {
        if isAllFieldValid() {
        guard let vc = self.storyboard?.instantiateViewController(identifier: ClassID.addNewMemberForm) as? AddNewHouseHoldForm_TVC else { return  }
            
        vc.strHHNumber = tf_houseHoldNumber.text ?? ""
        vc.strMemberNumber = tf_numberOfMember.text ?? ""
        vc.strMemberName = tf_name.text ?? ""
        vc.strCensusHHNumber = strCensusHouseHoldNumber
        vc.selectedHouseType = selectedHouseType
        vc.strInstituteName = tf_nameOfInstitute.text ?? ""
            
        self.navigationController?.pushViewController(vc, animated: true)
        }
       
    }
    
    @IBAction func btnTypeHousehold_action(_ sender: UIButton) {
       
        stackViewNameInstitute.isHidden = true
        self.isRadioButtonSelected = true
        let strTag = "\(sender.tag - 9)"
        
        let houseType = HouseType.init(rawValue: strTag)
        
        switch houseType {
        case .normal:
            btnnstitute.isSelected = false
            btnHouseless.isSelected = false
            selectedHouseType = .normal
            strCensusHouseHoldNumber = ""
            break
            
            case .institute:
                
            btnNormal.isSelected = false
            btnHouseless.isSelected = false
            stackViewNameInstitute.isHidden = false
            strCensusHouseHoldNumber = "9999"
            selectedHouseType = .institute
            break
        default:
            btnNormal.isSelected = false
            btnnstitute.isSelected = false
            selectedHouseType = .houseLess
            strCensusHouseHoldNumber = ""
        }
        sender.isSelected =   !sender.isSelected
    }
    
    func isAllFieldValid()-> Bool{
        let numberOfMembers = Int(self.tf_numberOfMember.text ?? "")
        
        if !self.isRadioButtonSelected {
         
            let alert = AlertView()
            alert.alertWithoutButton( message: LanguageModal.langObj.check_hh_type, time: 2.0)
            
          return false
        }
        if self.btnNormal.isSelected || self.btnHouseless.isSelected {
            if (self.tf_numberOfMember.text?.trimmingCharacters(in: .whitespaces).isEmpty)! || (numberOfMembers == 0) {
             
                let alert = AlertView()
                alert.alertWithoutButton( message: LanguageModal.langObj.validation_hh_family_membr_no, time: 2.0)
                
                return false
             }
            if (self.tf_name.text?.trimmingCharacters(in: .whitespaces).isEmpty)! || self.tf_name.text!.count < 2 {
                
             
                
                let alert = AlertView()
                alert.alertWithoutButton( message: LanguageModal.langObj.validation_first_name, time: 2.0)
                return false
            }
        }
        if self.btnnstitute.isSelected {
            if (self.tf_nameOfInstitute.text?.trimmingCharacters(in: .whitespaces).isEmpty)! || self.tf_nameOfInstitute.text!.count < 3 {
                var strMessage = ""
                
                if tf_nameOfInstitute.text?.count ?? 0 < 1  {
                    strMessage = AppMessages.Please_Enter_Institutional_Name
                }
                else{
                    strMessage =  AppMessages.Institutional_Name_MoreThan3Char
                }
                
                AlertView().alertWithoutButton( message:strMessage )
              
                return false
            }
            if (self.tf_numberOfMember.text?.trimmingCharacters(in: .whitespaces).isEmpty)! || Int(self.tf_numberOfMember.text ?? "") == 0{
              
                let alert = AlertView()
                alert.alertWithoutButton( message: LanguageModal.langObj.validation_hh_family_membr_no, time: 2.0)
                
                return false
             }
            if (self.tf_name.text?.trimmingCharacters(in: .whitespaces).isEmpty)! || self.tf_name.text!.count < 2 {
              
                
                let alert = AlertView()
                alert.alertWithoutButton( message: LanguageModal.langObj.validation_first_name, time: 2.0)
                return false
            }
        }
        return true
    }
    
}
    

//MARK:UITextfield Delegate
@available(iOS 13.0, *)
extension AddNewHousehold_VC : UITextFieldDelegate {
 
     func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var txtAfterUpdate = ""
        if let text = textField.text as NSString? {
                 txtAfterUpdate = text.replacingCharacters(in: range, with: string)
               
            }
        if textField == tf_nameOfInstitute || textField == tf_name {
            if !(string.isValidAlphabetAndSpace() ) {
                AlertView().alertWithoutButton( message: LanguageModal.langObj.language_error, time: 3.0)
                return false
            }
        
        }
        
        if textField == self.tf_numberOfMember {
            if !(string.isValiNumberEntry() ) || txtAfterUpdate.count > 2 {
                return false
            }
            return true
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
