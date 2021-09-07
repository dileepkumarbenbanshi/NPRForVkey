//
//  UITextField+Extension.swift
//  NPR_census
//
//  Created by Dileep on 09/01/21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation
extension UITextField {
func setupDonButton_TextFields() {
        let toolbar = UIToolbar()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done,
                                         target: self, action: #selector(doneButtonTapped))
        
        toolbar.setItems([flexSpace, doneButton], animated: true)
        toolbar.sizeToFit()
        
        self.inputAccessoryView = toolbar
       
    }
    
    func addDonButton_TextFields() {
//            let toolbar = UIToolbar()
//            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
//                                            target: nil, action: nil)
//            let doneButton = UIBarButtonItem(title: "Done", style: .done,
//                                             target: self, action: #selector(doneButtonTapped))
//            
//            toolbar.setItems([flexSpace, doneButton], animated: true)
//            toolbar.sizeToFit()
//            
//            self.inputAccessoryView = toolbar
           
        }

    
    @objc func doneButtonTapped() {
        self.superview?.endEditing(true)
    }
}
