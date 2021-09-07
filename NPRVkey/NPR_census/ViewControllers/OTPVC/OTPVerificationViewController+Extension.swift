//
//  OTPVerificationViewController+Extension.swift
//  NPR-2020
//
//  Created by Dileep on 09/01/21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation

extension OTPVerificationViewController {
   
    func isOtpMatch()->Bool  {
        
        if isAllFieldValid() {
        let otpEntered = "\(textFieldOTPTextOne.text ?? "")\(textFieldOTPTextTwo.text ?? "")\(textFieldOTPTextThree.text ?? "")\(textFieldOTPTextFour.text ?? "")\(textFieldOTPTextFive.text ?? "")\(textFieldOTPTextSix.text ?? "")"
        if loginData?.otp == otpEntered {
            return true
        }
        }
        
        AlertView().alertWithoutButton(vc: self, message: AppMessages.Please_Enter_Correct_OTP)
        return false
    }
    
    func otpRefresh()  {
        
        textFieldOTPTextOne.text = ""
        textFieldOTPTextTwo.text = ""
        textFieldOTPTextThree.text = ""
        textFieldOTPTextFour.text = ""
        textFieldOTPTextFive.text = ""
        textFieldOTPTextSix.text = ""
        
    }
    
}
