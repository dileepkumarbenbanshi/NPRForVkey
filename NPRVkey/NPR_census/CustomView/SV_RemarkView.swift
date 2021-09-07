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
    
    @IBOutlet weak var tfRemark: UITextField!
    
   
    @IBAction func btnNO_click(_ sender: UIButton) {
        self.removeFromSuperview()
    }
    @IBAction func btnSubmit_click(_ sender: UIButton) {
        if tfRemark.text?.count ?? 0 > 2 {
            delgate?.tap_svRemarkSubmit(remark: tfRemark.text ?? "")
            self.removeFromSuperview()
        }else{
//            AlertView().showAlertWithSingleButton(vc: <#T##UIViewController#>, title: <#T##String#>, message: <#T##String#>)
        }
       
    }
    
    func load_SV_RemarkView()  {
        
        self.backgroundColor = UIColor.init(white: 0.3, alpha: 0.5)
        self.frame = windows!.frame
        windows?.addSubview(self)
        
        
        
        
    }
    
}
