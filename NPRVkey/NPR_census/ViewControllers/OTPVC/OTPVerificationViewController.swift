//
//  OTPVerificationViewController.swift
//  NPR Screen
//
//  Created by mac on 11/08/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class OTPVerificationViewController: UIViewController {

    @IBOutlet weak var labelMobileAndEmail: UILabel!
    @IBOutlet weak var textFieldOTPTextOne: UITextField!
    @IBOutlet weak var textFieldOTPTextTwo: UITextField!
    @IBOutlet weak var textFieldOTPTextThree: UITextField!
    @IBOutlet weak var textFieldOTPTextFour: UITextField!
    @IBOutlet weak var textFieldOTPTextFive: UITextField!
    @IBOutlet weak var textFieldOTPTextSix: UITextField!
    
    
    var loginData:LoginModel?
    var otpData:OTPModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // self.hideKeyboardWhenTappedAround()
        self.fillData() 
        Utils().vKeySetup(enable:true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
    }
    
    func fillData(){
        self.maskEmailAndPhone(email: self.loginData?.email ?? "", phone: self.loginData?.phone ?? "")
        singleton().Alert.show(title:  AppMessages.App_Name, message: "OTP is - \((self.loginData?.otp ?? "")!)", delay: 3.0)
    }
    
    func maskEmailAndPhone(email:String, phone:String){
        if email == "" {
          self.labelMobileAndEmail.text = "OTP has been sent to  - \(phone.maskMobile()) & Email id is not available."
        }
        else if phone == "" {
          self.labelMobileAndEmail.text = "OTP has been sent to  - Phone is not available & \(phone.maskEmail())"
        }
        else{
           self.labelMobileAndEmail.text = "OTP has been sent to  - \(phone.maskMobile()) & \(email.maskEmail())"
        }
    }
    
    @IBAction func onTapVerify(_ sender: Any) {
        if isOtpMatch() {
            self.requestForVerifyOTP()
        }
    }
    
    @IBAction func onTapResend(_ sender: Any) {
        self.requestForEnrollement()
        otpRefresh()
    }
   
    func goToAssignEBController(){
        DispatchQueue.main.async {
            singleton().saveToUserDefaults(withKeyValue: true, key: "Is_LoggedIn")
            singleton().saveToUserDefaults(withKeyValue: self.loginData?.userType ?? "", key: "userType")
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
         if  (self.textFieldOTPTextOne.text?.trimmingCharacters(in: .whitespaces).isEmpty)! || (self.textFieldOTPTextTwo.text?.trimmingCharacters(in: .whitespaces).isEmpty)! ||
             (self.textFieldOTPTextThree.text?.trimmingCharacters(in: .whitespaces).isEmpty)! ||
             (self.textFieldOTPTextFour.text?.trimmingCharacters(in: .whitespaces).isEmpty)! ||
             (self.textFieldOTPTextFive.text?.trimmingCharacters(in: .whitespaces).isEmpty)! ||
             (self.textFieldOTPTextSix.text?.trimmingCharacters(in: .whitespaces).isEmpty)!{
//             singleton().Alert.show(title: AppMessages.App_Name, message: AppMessages.Please_Enter_Correct_OTP, delay: 2.0)
            
            AlertView().alertWithoutButton(vc: self, message: AppMessages.Please_Enter_Correct_OTP)
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
        let otp = "\(self.textFieldOTPTextOne.text!)\(self.textFieldOTPTextTwo.text!)\(self.textFieldOTPTextThree.text!)\(self.textFieldOTPTextFour.text!)\(self.textFieldOTPTextFive.text!)\(self.textFieldOTPTextSix.text!)"
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
                }
                 if error?.localizedDescription == AppMessages.Server_Response {
                    if self.otpData?.message == AppMessages.Already_Active_Device {
                        singleton().Alert.showWithButtonAndImage(title: AppMessages.Active_Device, message: AppMessages.Active_Device_Info, image: UIImage(named: "ic_warning")!, buttonsTitle: ["NO","YES"]) { (buttonIndex) in
                            buttonIndex == 0 ? self.goToLoginController() : self.requestForActiveDevice()
                        }
                    }
                    else {
                        singleton().Alert.show(title: AppMessages.App_Name, message: self.otpData?.message ?? AppMessages.UnAuthorized_Access , delay: 5.0)
                    }
                }
            }
        }
    }
    
   func requestForActiveDevice(){
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
                 singleton().Alert.show(title: AppMessages.App_Name, message: AppMessages.Not_Connected_To_Internet, delay: 5.0)
               }
               if error?.localizedDescription == AppMessages.Server_Response {
                singleton().Alert.show(title: AppMessages.App_Name, message: self.otpData?.message ?? AppMessages.UnAuthorized_Access, delay: 5.0)
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
                  singleton().Alert.show(title: AppMessages.App_Name, message: AppMessages.Not_Connected_To_Internet, delay: 5.0)
                }
                if error?.localizedDescription == AppMessages.Server_Response {
                    singleton().Alert.show(title: AppMessages.App_Name, message: self.otpData?.message ?? AppMessages.UnAuthorized_Access , delay: 5.0)
                 }
            }
        }
    }
    
    func requestForEnrollement(){
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
                singleton().Alert.show(title:  AppMessages.App_Name, message: "OTP is - \((self.loginData?.otp!)!)", delay: 3.0)
             }
            else{
                 if error?.localizedDescription == AppMessages.Not_Connected_To_Internet {
                  singleton().Alert.show(title: AppMessages.App_Name, message: AppMessages.Not_Connected_To_Internet, delay: 5.0)
                }
                if error?.localizedDescription == AppMessages.Server_Response {
                     singleton().Alert.show(title: AppMessages.App_Name, message: self.loginData?.message ?? AppMessages.UnAuthorized_Access , delay: 5.0)
                 }
            }
        }
    }
       
}


extension OTPVerificationViewController:UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        
        if let textStr = textField.text as NSString? {
                let txtAfterUpdate = textStr.replacingCharacters(in: range, with: string)
               
            }
        
       
        
        let text = textField.text
        if  text?.count == 0 && string != "" {
//            if textField.tag == 6 {
//                textField.resignFirstResponder()
//            }
            let nextTF = view.viewWithTag(textField.tag+1)
            nextTF?.becomeFirstResponder()
            switch textField{
            case textFieldOTPTextOne:
               
                textFieldOTPTextTwo.becomeFirstResponder()
                 break
            case textFieldOTPTextTwo:
                
                textFieldOTPTextThree.becomeFirstResponder()
                break
            case textFieldOTPTextThree:
                
                textFieldOTPTextFour.becomeFirstResponder()
                break
            case textFieldOTPTextFour:
               
                textFieldOTPTextFive.becomeFirstResponder()
                break
            case textFieldOTPTextFive:
                
                textFieldOTPTextSix.becomeFirstResponder()
                break
            case textFieldOTPTextSix:
               
                
                textFieldOTPTextSix.resignFirstResponder()
                
                break
            default:
                break
            }
            return true
        }
        else if  text!.count  >= 0 && string == "" {
            if textField.tag == 1 {
                textField.becomeFirstResponder()
                return true
            }
            let prevTF = view.viewWithTag(textField.tag-1)
            prevTF?.becomeFirstResponder()
            return true
        }
        else{
           
            
        }
        
    return false
    }
    
}
