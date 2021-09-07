//
//  SV_RemarkView.swift
//  NPR-2020
//
//  Created by Dileep on 30/11/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

protocol SV_RemarkDelegate{
    func tap_svRemarkSubmit(remark:String) ->Void
}

class SV_RemarkView: UIView {
    var delgate:SV_RemarkDelegate?
    var vc = UIViewController()
    
    @IBOutlet weak var tfRemark: UITextField!
    
   
    @IBAction func btnNO_click(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    @IBAction func btnSubmit_click(_ sender: UIButton) {
        if tfRemark.text?.count ?? 0 > 1 && tfRemark.text?.count ?? 0 < 41 {
            delgate?.tap_svRemarkSubmit(remark: tfRemark.text ?? "")
            self.removeFromSuperview()
        }else{
            AlertView().alertWithoutButton( message: English.superVisorHHDetail.remarkLenth)
        }
       
    }
    
    
    
    func load_SV_RemarkView()  {
        
        self.backgroundColor = UIColor.init(white: 0.3, alpha: 0.5)
        self.frame = windows!.frame
        windows?.addSubview(self)
        
        tfRemark.delegate = self
        
        
    }
    
}

extension SV_RemarkView :UITextFieldDelegate {
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tfRemark.resignFirstResponder()
        return true
    }
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //Format Date of Birth dd-MM-yyyy
        var txtAfterUpdate = ""
       
        
        if let text = textField.text as NSString? {
                 txtAfterUpdate = text.replacingCharacters(in: range, with: string)
        }
        return txtAfterUpdate.count < 41
    }
    
}
