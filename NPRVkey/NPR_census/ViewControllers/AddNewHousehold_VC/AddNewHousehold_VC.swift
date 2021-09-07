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
    @IBOutlet weak var tf_nameOfInstitute: UITextField!
    @IBOutlet weak var tf_name: UITextField!
    @IBOutlet weak var tf_houseHoldNumber: UITextField!
    @IBOutlet weak var tf_numberOfMember: UITextField!
    @IBOutlet weak var btnHouseless: UIButton!
    @IBOutlet weak var btnnstitute: UIButton!
    @IBOutlet weak var btnNormal: UIButton!
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
        tf_numberOfMember.setupDonButton_TextFields()
        tf_houseHoldNumber.setupDonButton_TextFields()
        
        
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
        self.navigationController?.pushViewController(vc, animated: true)
        }
       
    }
    
    @IBAction func btnTypeHousehold_action(_ sender: UIButton) {
       
        stackViewNameInstitute.isHidden = true
        self.isRadioButtonSelected = true
        let houseType = HouseType.init(rawValue: sender.tag)
        
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
        if !self.isRadioButtonSelected {
          singleton().Alert.show(title: AppMessages.App_Name, message: AppMessages.Please_Choose_Type_Household, delay: 5.0)
          return false
        }
        if self.btnNormal.isSelected || self.btnHouseless.isSelected {
            if (self.tf_numberOfMember.text?.trimmingCharacters(in: .whitespaces).isEmpty)! || self.tf_numberOfMember.text == "0"{
              singleton().Alert.show(title: AppMessages.App_Name, message: AppMessages.Family_Member_Should_Valid, delay: 5.0)
                return false
             }
            if (self.tf_name.text?.trimmingCharacters(in: .whitespaces).isEmpty)! || self.tf_name.text!.count < 3 {
              singleton().Alert.show(title: AppMessages.App_Name, message: AppMessages.Name_Atleast_3_Char_Long, delay: 5.0)
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
                
                AlertView().alertWithoutButton(vc: self, message:strMessage )
              
                return false
            }
            if (self.tf_numberOfMember.text?.trimmingCharacters(in: .whitespaces).isEmpty)! || self.tf_numberOfMember.text == "0"{
              singleton().Alert.show(title: AppMessages.App_Name, message: AppMessages.Family_Member_Should_Valid, delay: 5.0)
                return false
             }
            if (self.tf_name.text?.trimmingCharacters(in: .whitespaces).isEmpty)! || self.tf_name.text!.count < 3 {
              singleton().Alert.show(title: AppMessages.App_Name, message: AppMessages.Name_Atleast_3_Char_Long, delay: 5.0)
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
        if textField == self.tf_numberOfMember {
            guard let text = self.tf_numberOfMember.text else { return true }
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
