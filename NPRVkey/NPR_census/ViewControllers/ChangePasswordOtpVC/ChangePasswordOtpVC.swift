//
//  ChangePasswordOtpVC.swift
//  NPR-2021
//
//  Created by Dileep on 23/08/21.
//  Copyright © 2021 admin. All rights reserved.
//

import UIKit

class ChangePasswordOtpVC: UIViewController {
    @IBOutlet weak var lblPrevPageTitle: UILabel!
    @IBOutlet var verifyOTPButton: UIButton!
    @IBOutlet var resendOTPButton: UIButton!
    @IBOutlet var otpVerificationLabel: UILabel!
    @IBOutlet weak var stackViewTimer: UIStackView!
    @IBOutlet weak var lblTimerTitle: UILabel!
    @IBOutlet weak var lblTimerCount: UILabel!
    @IBOutlet weak var labelMobileAndEmail: UILabel!
    @IBOutlet weak var textFieldOTPTextOne: UITextField!
    
    
    var loginData:LoginModel?
    var otpData:OTPModel?
    var timeCount = 60
    var timer : Timer?
    var otpVerifyVM = OTPVerifyVM ()
    var newpassword = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewPrepare()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        otpVerifyVM.delegate = self
        //otpVerifyVM.getOtp()
        
    }
    
    func viewPrepare()  {
        
        
        
        textFieldOTPTextOne.defaultTextAttributes.updateValue(36.0,
             forKey: NSAttributedString.Key.kern)
        //Utils().vKeySetup(enable:true)
        
        addTimer()
        otpVerificationLabel.text = LanguageModal.langObj.verify_otp
        resendOTPButton.setTitle(LanguageModal.langObj.resend_otp, for: .normal)
        verifyOTPButton.setTitle(LanguageModal.langObj.verify_otp_lable, for: .normal)
        //textFieldOTPTextOne.placeholder = LanguageModal.langObj.otp
        lblPrevPageTitle.text = LanguageModal.langObj.login
        lblTimerTitle.text = LanguageModal.langObj.seconds_remaining
        fillData()
    }
    override func viewDidAppear(_ animated: Bool) {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        //textFieldOTPTextOne.addDoneButton()
    }
    
    func fillData(){
        self.maskEmailAndPhone(email: otpVerifyVM.mailId, phone: otpVerifyVM.phone )
       
    }
    
    func maskEmailAndPhone(email:String, phone:String){
        if email == "" {
            self.labelMobileAndEmail.text = "\(LanguageModal.langObj.otp_send_on)  - \(phone.maskMobile()) \(LanguageModal.langObj.email_id_not_available)  - \(email.maskMobile())"
        }
        else if phone == "" {
          self.labelMobileAndEmail.text = "\(LanguageModal.langObj.otp_send_on)  - Phone is not available & \(phone.maskEmail())"
        }
        else{
           self.labelMobileAndEmail.text = "\(LanguageModal.langObj.otp_send_on)  - \(phone.maskMobile()) & \(email.maskEmail())"
        }
    }


    @IBAction func onTapVerify(_ sender: Any) {
        if Reachability.shared.isConnected {
            
            timeCount = 60
            timer = nil
            otpVerifyVM.delegate = self
            otpVerifyVM.newPassword = newpassword
            otpVerifyVM.requestForVerifyOTP(otp: textFieldOTPTextOne.text ?? "")
            
        }else{
            AlertView().alertWithoutButton( message: AppMessages.networkConnection)
        }
        
    }
    
    @IBAction func onTapResend(_ sender: Any) {
        if Reachability.shared.isConnected {
        getOtp()
            
        }else{
            AlertView().alertWithoutButton( message: AppMessages.networkConnection)
        }
    }
   
    
    @IBAction func btnBack(_ sender: UIButton) {
       
        self.navigationController?.popViewController(animated: true)
    }
    
    private func getOtp() {
        
        let dictParam = ["reason":"RSTPWD_NPR","otp":""]
       NPRURLRequestSession().getOtpChangePassword(params: dictParam) { success, result, error in
            
            if success {
                
            }else if error != nil {
                
            }
        }
    }
    
   
    
    
}


extension ChangePasswordOtpVC:UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        var txtAfterUpdate = ""
        
        if let textStr = textField.text as NSString? {
                 txtAfterUpdate = textStr.replacingCharacters(in: range, with: string)
               
            }
        
        if txtAfterUpdate.count > 6 {
            textField.resignFirstResponder()
            return false
            
        }
       
        
        
        
    return true
    }
    
    
    func goToLoginController(){
         DispatchQueue.main.async {
            self.popBackToController(toControllerType: LoginViewController.self)
        }
    }

    func isAllFieldValid()-> Bool{
         if  (self.textFieldOTPTextOne.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {

            
            AlertView().alertWithoutButton( message: AppMessages.Please_Enter_Correct_OTP)
             return false
         }
         return true
     }
    
    
}


extension ChangePasswordOtpVC {
    
    
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

extension ChangePasswordOtpVC:OTPVeryficationDelegate {
    func changedPassword() {
        goToLoginController()
    }
  
    func gotOTP()  {
        self.fillData()
    }
    
}
