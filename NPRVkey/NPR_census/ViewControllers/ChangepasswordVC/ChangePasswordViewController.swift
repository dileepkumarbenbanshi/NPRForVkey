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
    @IBOutlet weak var lblBackTititle: UILabel!
    @IBOutlet weak var lblPageTitle: UILabel!
    @IBOutlet weak var btnChangePassword: UIButton!
    let otpVerify = OTPVerifyVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textFieldNewPassword.textContentType = .oneTimeCode
        self.textFieldRetypePassword.textContentType = .oneTimeCode
        textFieldRegisteredUserId.text = singleton().getCredentials().userId
        setTagLabel()
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
            
            otpVerify.delegate = self
            
            otpVerify.getOtp()
            
            
        }
    }
    
    func isAllFieldValid()-> Bool{
        let alert = AlertView()
        let oldPassword = singleton().getCredentials().password
        
        if (self.textFieldNewPassword.text?.trimmingCharacters(in: .whitespaces).isEmpty)! || (self.textFieldRetypePassword.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
               
            
            
            alert.alertWithoutButton( message: LanguageModal.langObj.password_field_can_not_be_blank, time: 2.0)
            
            
               return false
           }
        if self.textFieldNewPassword.text != self.textFieldRetypePassword.text {
           
            
            
            alert.alertWithoutButton( message: LanguageModal.langObj.both_password_should_be_same, time: 2.0)
            return false
         }
        
        if self.textFieldNewPassword.text == oldPassword {
            alert.alertWithoutButton( message: LanguageModal.langObj.wrong_password, time: 2.0)
            return false
        }
        
        if self.textFieldNewPassword.text?.count ?? 0 < 6 {
            alert.alertWithoutButton( message: LanguageModal.langObj.validation_both_password_length, time: 2.0)
            return false
        }
           return true
       }
    

    
    @IBAction func btnEye_tapNewPassword(_ sender: UIButton) {
        
        textFieldNewPassword.isSecureTextEntry = sender.isSelected
        
        sender.isSelected =  !sender.isSelected
    }
    
    
    @IBAction func btnEye_tapReTypePassword(_ sender: UIButton) {
        
        textFieldRetypePassword.isSecureTextEntry = sender.isSelected
        
        sender.isSelected =  !sender.isSelected
    }
    
    
    func setTagLabel()  {
        textFieldRegisteredUserId.placeholder = LanguageModal.langObj.registered_userId
        textFieldNewPassword.placeholder = LanguageModal.langObj.new_password
        textFieldRetypePassword.placeholder = LanguageModal.langObj.retype_password
        
        lblBackTititle.text = LanguageModal.langObj.login
        lblPageTitle.text = LanguageModal.langObj.chnage_password_via_otp
        btnChangePassword.setTitle(LanguageModal.langObj.CHANGE_PASSWORD, for: .normal)
    }
}


extension ChangePasswordViewController:OTPVeryficationDelegate {
    func changedPassword() {
        
    }
    
    func gotOTP() {
        DispatchQueue.main.async {
        guard let otpVeryFyClass = self.storyboard?.instantiateViewController(identifier: ClassID.changePasswordOTPVerify) as? ChangePasswordOtpVC else {
           return
        }
        
            otpVeryFyClass.newpassword = self.textFieldNewPassword.text ?? ""
            otpVeryFyClass.otpVerifyVM = self.otpVerify
        self.navigationController?.pushViewController(otpVeryFyClass, animated: true)
        
    }
    }
    
}
