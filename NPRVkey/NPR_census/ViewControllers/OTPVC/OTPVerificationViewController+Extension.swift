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
        let otpEntered = "\(textFieldOTPTextOne.text ?? "")"
        if loginData?.otp == otpEntered {
            return true
        }
        }
        
        AlertView().alertWithoutButton( message: LanguageModal.langObj.please_enter_correct_otp)
        return false
    }
    
    func otpRefresh()  {
        
        textFieldOTPTextOne.text = ""
       
        
    }
    func addTimer()  {
   // timer : Timer?
        timeCount = 60
    timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        DispatchQueue.main.async {
            self.stackViewTimer.isHidden = false
            self.resendOTPButton.isEnabled = false
            self.resendOTPButton.backgroundColor = .lightGray
            
        }
        
    }
    
    @objc func updateTimer() {
        //example functionality
        DispatchQueue.main.async {
            if self.timeCount > 0 {
                print("\(self.timeCount) seconds left")
                self.timeCount -= 1
                self.lblTimerCount.text = "\(self.timeCount)"
        }else {
            self.timer = nil
            self.timer = nil
            self.stackViewTimer.isHidden = true
            self.resendOTPButton.isEnabled = true
            self.resendOTPButton.backgroundColor = ProjectColor.colorPrimaryDark
           // self.timeCount = 60
            self.lblTimerCount.text = "60"
        }
    }
    }
    
}
