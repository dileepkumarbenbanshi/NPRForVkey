//
//  ChangePasswordViewController.swift
//  NPR Screen
//
//  Created by mac on 06/08/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var textFieldRegisteredUserId: UITextField!
    @IBOutlet weak var textFieldNewPassword: UITextField!
    @IBOutlet weak var textFieldRetypePassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textFieldNewPassword.textContentType = .oneTimeCode
        self.textFieldRetypePassword.textContentType = .oneTimeCode
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
    }
    
    @IBAction func onTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onTapChangePassword(_ sender: Any) {
        if isAllFieldValid(){
            print("GoTo Next Controller")
        }
    }
    
    func isAllFieldValid()-> Bool{
           if (self.textFieldNewPassword.text?.trimmingCharacters(in: .whitespaces).isEmpty)! || (self.textFieldRetypePassword.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
               singleton().Alert.show(title: AppMessages.App_Name, message: AppMessages.Password_Empty, delay: 2.0)
               return false
           }
        if self.textFieldNewPassword.text != self.textFieldRetypePassword.text {
            singleton().Alert.show(title: AppMessages.App_Name, message: AppMessages.Both_Password_Same, delay: 2.0)
            return false
         }
           return true
       }
    

}

