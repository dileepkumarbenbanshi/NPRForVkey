//
//  EnterAgeAndCalculateDOBView.swift
//  NPR-2021
//
//  Created by Dileep on 18/08/21.
//  Copyright © 2021 admin. All rights reserved.
//

import UIKit

class EnterAgeAndCalculateDOBView: UIView {

    @IBOutlet weak var btnOk: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var btnAgeTitle: UIButton!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var lblTitleTF: UILabel!
    @IBOutlet weak var tf_ageEntry: UITextField!
   private var formClass : AddNewHouseHoldForm_TVC?
  private  var dobFor = dobType.personal
    
    func viewPrepare()  {
        tf_ageEntry.placeholder = LanguageModal.langObj.age_text
        lblTitleTF.text = LanguageModal.langObj.age_text
        btnCancel.setTitle(LanguageModal.langObj.cancel, for: .normal)
        btnOk.setTitle(LanguageModal.langObj.ok, for: .normal)
        
        self.backgroundColor = UIColor.init(white: 0.3, alpha: 0.5)
        self.frame = formClass!.view.frame
        self.center = formClass!.view.center
        
        windows?.addSubview(self)
        
        btnAgeTitle.setTitle(LanguageModal.langObj.alert_date, for: .normal)
        btnAgeTitle.titleLabel?.numberOfLines = 0
        
        tf_ageEntry.addDoneButton()
    }
    
    
    override func awakeFromNib() {
        //pickerView.delegate = self
        //pickerView.dataSource = self
        
        //self.frame.size = CGSize.init
        
    }
    
    func showView(objFormClass:AddNewHouseHoldForm_TVC,dobFor:dobType)  {
        formClass = objFormClass
        self.dobFor = dobFor
        viewPrepare()
    }
    
    func calculateYear()  {
        guard let year = Int(tf_ageEntry.text ?? "") else {
            return
        }
        
        let calculatedYear =  Calendar.current.date(byAdding: .year, value: -(year), to: Date())
       // let strYear = "\(String(describing: calculatedYear))"
       let strYear = calculatedYear?.dateYear()
        let strZero = "00"
        
        
        switch dobFor {
        case .father:
            formClass?.tf_ParentDetail_dob_month.text = strZero
            formClass?.tf_ParentDetail_dob_date.text = strZero
            formClass?.tf_ParentDetail_dob_year.text = strYear
            break
        case .mother:
            formClass?.tf_ParentDetail_motherDob_date.text = strZero
            formClass?.tf_ParentDetail_motherDob_month.text = strZero
            formClass?.tf_ParentDetail_motherDob_year.text = strYear
            break
        default:
            formClass?.tf_pd_Dob_date.text = strZero
            formClass?.tf_pd_Dob_month.text = strZero
            formClass?.tf_pd_Dob_year.text = strYear
            break
        }
        self.removeFromSuperview()
    }
    
    
    

    @IBAction func btnCancel_action(_ sender: UIButton) {
        self.removeFromSuperview()
        
    }
    
    @IBAction func btnOkay_action(_ sender: UIButton) {
        if isEnteredValue && isValidEntry {
          calculateYear()
        }
    }
    
    @IBAction func btnCheck_action(_ sender: UIButton) {
      
        btnCheck.isSelected = !btnCheck.isSelected
        tf_ageEntry.isUserInteractionEnabled = btnCheck.isSelected
    }
    
    var isEnteredValue:Bool {
        guard let age = Int(tf_ageEntry.text ?? "") else { return false }
        if tf_ageEntry.text?.count == 0 || tf_ageEntry.text == nil {
            AlertView().alertWithoutButton( message: LanguageModal.langObj.validation_age)
            return false
        }else if age <= 0 {
            //AlertView().alertWithoutButton( message: LanguageModal.langObj.)
            tf_ageEntry.text = ""
            return false
        }
        return true
    }
    var isValidEntry: Bool  {
       let age = Int(tf_ageEntry.text ?? "") ?? 0
        if age <= 0 {
            tf_ageEntry.text = ""
            return false
        }
        
        if ((dobFor == .father || dobFor == .mother ) && age <= 250) || (dobFor == .personal && age <= 125 )
       {
        return true
       }
        let strAlertMessage = dobFor == .personal ? LanguageModal.langObj.validation_age : LanguageModal.langObj.validation_age_parents
        
        
        AlertView().alertWithoutButton( message:strAlertMessage )
        return false
    }
    
}

extension EnterAgeAndCalculateDOBView:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        var txtAfterUpdate = ""
        
        if let text = textField.text as NSString? {
                 txtAfterUpdate = text.replacingCharacters(in: range, with: string)
               
            }
        if txtAfterUpdate.count >= 4 {
            return false
        }
       return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
