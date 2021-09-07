//
//  OTPVerificationViewController.swift
//  NPR Screen
//
//  Created by mac on 11/08/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class OTPVerificationViewController: UIViewController {
    @IBOutlet weak var lblPrevPageTitle: UILabel!
    @IBOutlet var verifyOTPButton: UIButton!
    @IBOutlet var resendOTPButton: UIButton!
    @IBOutlet var otpVerificationLabel: UILabel!
    @IBOutlet weak var stackViewTimer: UIStackView!
    @IBOutlet weak var lblTimerTitle: UILabel!
    @IBOutlet weak var lblTimerCount: UILabel!
    @IBOutlet weak var labelMobileAndEmail: UILabel!
    @IBOutlet weak var textFieldOTPTextOne: UITextField!
    //@IBOutlet weak var btnResendOTP: UIButton!
    //    @IBOutlet weak var textFieldOTPTextTwo: UITextField!
//    @IBOutlet weak var textFieldOTPTextThree: UITextField!
//    @IBOutlet weak var textFieldOTPTextFour: UITextField!
//    @IBOutlet weak var textFieldOTPTextFive: UITextField!
//    @IBOutlet weak var textFieldOTPTextSix: UITextField!
    
    
    var loginData:LoginModel?
    var otpData:OTPModel?
    var timeCount = 60
    var timer : Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.hideKeyboardWhenTappedAround()
       viewPrepare()
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
        self.fillData()
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
        self.maskEmailAndPhone(email: self.loginData?.email ?? "", phone: self.loginData?.phone ?? "")
       
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
            self.requestForVerifyOTP()
            timeCount = 60
            timer = nil
        }else{
            AlertView().alertWithoutButton( message: AppMessages.networkConnection)
        }
        
    }
    
    @IBAction func onTapResend(_ sender: Any) {
        if Reachability.shared.isConnected {
        self.requestForEnrollement()
        otpRefresh()
            
        }else{
            AlertView().alertWithoutButton( message: AppMessages.networkConnection)
        }
    }
   
    
    @IBAction func btnBack(_ sender: UIButton) {
       
        self.navigationController?.popViewController(animated: true)
    }
    
    func goToAssignEBController(){
        self.timer = nil
        DispatchQueue.main.async {
            singleton().saveToUserDefaults(withKeyValue: true, key: "Is_LoggedIn")
            
            singleton().saveToUserDefaults(withKeyValue: self.loginData?.userType ?? "", key: "userType")
            
            singleton().saveToUserDefaults(withKeyValue: ["deviceId":singleton().getDeviceInfo().deviceId, "accessToken":self.loginData?.accessToken!], key: "Device_Info")
            
            let controller = self.storyboard?.instantiateViewController(withIdentifier: "AssignEBVC") as! AssignEBViewController
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    func goToLoginController(){
         DispatchQueue.main.async {
           self.navigationController?.popViewController(animated: true)
        }
    }
    
    func isAllFieldValid()-> Bool{
         if  (self.textFieldOTPTextOne.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {

            
            AlertView().alertWithoutButton( message: AppMessages.Please_Enter_Correct_OTP)
             return false
         }
         return true
     }
    
    func getDeviceId(fromData data:[ActiveDeviceModel]) -> String?{
        var deviceId:String? = ""
        for i in 0..<data.count {
            if data[i].application == 2 {
                deviceId = data[i].deviceId
            }
        }
        return deviceId
    }

    func requestForVerifyOTP(){
        let otp = "\(self.textFieldOTPTextOne.text!)"
        let dictParam = [Param_Key.DeviceID: singleton().getDeviceInfo().deviceId,
                         Param_Key.Application: Application.AppCode,
                         Param_Key.OTP: otp]
            self.view.showLoader()
            APIManager().postVerifyOTPRequest(params: dictParam) { (success, responseData, error) in
             DispatchQueue.main.async {self.view.removeLoaderView()}
             self.otpData = OTPModel(fromDictionary: responseData as! [String : Any])
                
            if success {
                if let status = self.otpData?.status{
                    if status == 1{
                        DispatchQueue.main.async {
                            self.goToAssignEBController()
                        }
                    }
                }
            }
            else{
                 if error?.localizedDescription == AppMessages.Not_Connected_To_Internet {
                  singleton().Alert.show(title: AppMessages.App_Name, message: AppMessages.Not_Connected_To_Internet, delay: 5.0)
                    
                    let alert = AlertView()
                    alert.alertWithoutButton( message: LanguageModal.langObj.not_connected_to_internet, time: 2.0)
                }
                 if error?.localizedDescription == AppMessages.Server_Response {
                    if self.otpData?.message == AppMessages.Already_Active_Device {
                        
//                        let alert = AlertView()
//                        alert.delegate = self
//                        alert.showAlert( title: LanguageModal.langObj.activated_devic_title, message: LanguageModal.langObj.same_device_already_activated)
                        
                        singleton().Alert.showWithButtonAndImage(title: LanguageModal.langObj.activated_devic_title, message: LanguageModal.langObj.same_device_already_activated, image: UIImage(named: "ic_warning")!, buttonsTitle: ["NO","YES"]) { (buttonIndex) in
                            buttonIndex == 0 ? self.goToLoginController() : self.requestForActiveDevice()
                        }
                    }
                    else {
                        
                        let alert = AlertView()
                        alert.alertWithoutButton( message: LanguageModal.langObj.invalid_otp, time: 2.0)
                    }
                }
            }
        }
    }
    
  private func requestForActiveDevice(){
           self.view.showLoader()
          APIManager().postActiveDeviceRequest { (success, responseData, error) in
            DispatchQueue.main.async {self.view.removeLoaderView()}
            self.otpData?.setActiveData(arr: responseData as? NSArray)
              if success {
                if let deviceId = self.getDeviceId(fromData: self.otpData!.activeData) {
                    DispatchQueue.main.async {
                       self.requestForDeEnrollement(withDeviceId: deviceId)
                    }
                 }
               }
           else{
                if error?.localizedDescription == AppMessages.Not_Connected_To_Internet {
                 
                    
                    let alert = AlertView()
                    alert.alertWithoutButton( message: self.otpData?.message ?? AppMessages.Not_Connected_To_Internet, time: 3.0)
               }
               if error?.localizedDescription == AppMessages.Server_Response {
                
               
                
                let alert = AlertView()
                alert.alertWithoutButton( message: self.otpData?.message ?? AppMessages.UnAuthorized_Access, time: 3.0)
                }
           }
       }
   }
    
    func requestForDeEnrollement(withDeviceId deviceId:String){
        let dictParam = [Param_Key.DeviceID: deviceId,
                         Param_Key.Application: Application.AppCode]
            self.view.showLoader()
            APIManager().postDeEnrollementRequest(params: dictParam) { (success, responseData, error) in
             DispatchQueue.main.async {self.view.removeLoaderView()}
                self.otpData = OTPModel(fromDictionary: responseData as! [String:Any])
            if success {
                if let status = self.otpData?.status {
                    if status == 3{
                        DispatchQueue.main.async {
                            self.requestForVerifyOTP()
                        }
                    }
                }
            }
            else{
                 if error?.localizedDescription == AppMessages.Not_Connected_To_Internet {
                  
                    
                    let alert = AlertView()
                    alert.alertWithoutButton( message:  AppMessages.Not_Connected_To_Internet , time: 3.0)
                }
                if error?.localizedDescription == AppMessages.Server_Response {
                    
                    DispatchQueue.main.async {
                        
                    
                    let alert = AlertView()
                    alert.alertWithoutButton( message:  self.otpData?.message ?? AppMessages.UnAuthorized_Access , time: 3.0)
                 }
                }
            }
        }
    }
    
   private func requestForEnrollement(){
          let dictParam = [Param_Key.DeviceID: singleton().getDeviceInfo().deviceId,
                               Param_Key.Application: Application.AppCode,
                               Param_Key.Manufacturer: "Iphone",
                               Param_Key.Model: singleton().getDeviceInfo().deviceName,
                               Param_Key.SerialNumber: "",
                               Param_Key.OSVersion: singleton().getDeviceInfo().deviceVersion,
                               Param_Key.AppVersion: singleton().getDeviceInfo().appVersion,
                               Param_Key.OSPatch: ""]
            self.view.showLoader()
            APIManager().postEnrollementRequest(params: dictParam) { (success, responseData, error) in
             DispatchQueue.main.async {self.view.removeLoaderView()}
             self.loginData = LoginModel(fromDictionary: responseData as! [String:Any])
             if success {
                //singleton().Alert.show(title:  AppMessages.App_Name, message: "OTP is - \((self.loginData?.otp ?? "")!)", delay: 3.0)
                self.addTimer()
             }
            else{
                 if error?.localizedDescription == AppMessages.Not_Connected_To_Internet {
                  singleton().Alert.show(title: AppMessages.App_Name, message: AppMessages.Not_Connected_To_Internet, delay: 5.0)
                    
                    let alert = AlertView()
                    alert.alertWithoutButton( message:  AppMessages.Not_Connected_To_Internet , time: 3.0)
                    
                   
                }
                if error?.localizedDescription == AppMessages.Server_Response {
                     
                    
                    let alert = AlertView()
                    alert.alertWithoutButton( message:  self.otpData?.message ?? AppMessages.UnAuthorized_Access , time: 3.0)
                 }
            }
        }
    }
    
       
}


extension OTPVerificationViewController:UITextFieldDelegate{
    
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
    
}

extension OTPVerificationViewController:AlertViewDelegate {
    func alertTapedYes() {
        self.requestForActiveDevice()
    }
    
    func alertViewTapedNo() {
        self.goToLoginController()
    }
}
