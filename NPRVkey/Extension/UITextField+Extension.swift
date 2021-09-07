//
//  UITextField+Extension.swift
//  NPR_census
//
//  Created by Dileep on 09/01/21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation
extension UITextField {
func addupDoneButton_TextFields() {
        let toolbar = UIToolbar()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                        target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done,
                                         target: self, action: #selector(doneButtonTapped))
        
        toolbar.setItems([flexSpace, doneButton], animated: true)
        toolbar.sizeToFit()
        
        self.inputAccessoryView = toolbar
       
    }
    
    func addDoneButton() {
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


class CustomTextField: UITextField {
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
            if action == #selector(UIResponderStandardEditActions.paste(_:)) || action == #selector(UIResponderStandardEditActions.copy(_:)) || action == #selector(UIResponderStandardEditActions.cut(_:)) {
                return false
            }
            return super.canPerformAction(action, withSender: sender)
        }
}
