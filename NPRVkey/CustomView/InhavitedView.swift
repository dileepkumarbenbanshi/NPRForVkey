//
//  InhavitedView.swift
//  NPR-2020
//
//  Created by Dileep on 05/12/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

protocol InhavitedViewDelegate {
    func saveExpectedHH_number()
    func saveExpectedHHNumberZero()
    func popUpHaveToShowAgain()
    
   
}
class InhavitedView: UIView {

    var delegate:InhavitedViewDelegate?
    var hhCount = 0
    var unHabitedVM = UnHabitedVM()
    var cancelButtonSouldHide = false
    
    @IBOutlet weak var tf_NoHH: UITextField!
    @IBOutlet weak var BtnCancel: UIButton!
   
    @IBAction func btnOK_click(_ sender: UIButton) {
        unHabitedVM.enterExpectedHH = tf_NoHH.text ?? ""
        if unHabitedVM.isVlidEntryExpHH {
            saveExpectedHH()
        }
        
    }
    
    @IBAction func btnCancelAction(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    
    
    func saveExpectedHH()  {
       
//        singleton().selectEBListModel.is_InHavitedEB = true
        unHabitedVM.enterExpectedHH = tf_NoHH.text ?? ""
        if unHabitedVM.isVlidEntryExpHH {
           
            unHabitedVM.saveExpectedHH()
            self.removeFromSuperview()
            let expHHCount = Int(tf_NoHH.text ?? "") ?? 0
            if expHHCount == 0 {
                delegate?.saveExpectedHHNumberZero()
            }else{
                delegate?.saveExpectedHH_number()
            }
        }
      
    }
    
    func lodInhavitedView()  {
        tf_NoHH.text = ""
        //isInhavitedViewAlready()
        self.removeFromSuperview()
        //self.removeFromSuperview()
//        tf_NoHH.text = ""
//        tf_NoHH.text = ""
        tf_NoHH.delegate = self
        tf_NoHH.addupDoneButton_TextFields()
        if singleton().selectEBListModel.expectedHH_number?.count ?? 0 > 0 {
            tf_NoHH.text = singleton().selectEBListModel.expectedHH_number
        }
        self.backgroundColor = UIColor.init(white: 0.3, alpha: 0.5)
        self.frame = windows!.frame
        windows?.addSubview(self)
        tf_NoHH.addDoneButton()
        tf_NoHH.keyboardType = .numberPad
        tf_NoHH.returnKeyType = .done
        BtnCancel.isHidden = cancelButtonSouldHide
    }
    
    func isInhavitedViewAlready()  {
       // tf_NoHH.text = ""
       let view =  window?.viewWithTag(20001)
        view?.removeFromSuperview()
    }
    
}

extension InhavitedView:UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        var txtAfterUpdate = ""
        
        if let text = textField.text as NSString? {
                 txtAfterUpdate = text.replacingCharacters(in: range, with: string)
               
            }
        return txtAfterUpdate.count < 3
    }
}
