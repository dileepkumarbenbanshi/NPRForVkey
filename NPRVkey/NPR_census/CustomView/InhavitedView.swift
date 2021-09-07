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
}
class InhavitedView: UIView {

    @IBOutlet weak var tf_NoHH: UITextField!
   
    @IBAction func btnOK_click(_ sender: UIButton) {
        
        if tf_NoHH.text?.count ?? 0 > 0 {
        singleton().selectEBListModel.is_InHavitedEB = true
        singleton().selectEBListModel.expectedHH_number = tf_NoHH.text ?? ""
            
            do {
                try context.save()
                self.removeFromSuperview()
            } catch  {
                
            }
        
        
        }
    }
    
    func lodInhavitedView()  {
        isInhavitedViewAlready()
        self.removeFromSuperview()
        self.removeFromSuperview()
        self.removeFromSuperview()
        tf_NoHH.setupDonButton_TextFields()
        if singleton().selectEBListModel.expectedHH_number?.count ?? 0 > 0 {
            tf_NoHH.text = singleton().selectEBListModel.expectedHH_number
        }
        self.backgroundColor = UIColor.init(white: 0.3, alpha: 0.5)
        self.frame = windows!.frame
        windows?.addSubview(self)
    }
    
    func isInhavitedViewAlready()  {
       
       let view =  window?.viewWithTag(20001)
        view?.removeFromSuperview()
    }
    
}
