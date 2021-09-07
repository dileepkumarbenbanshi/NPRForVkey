//
//  OTPVerifyVM.swift
//  NPR-2021
//
//  Created by Dileep on 24/08/21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation

protocol OTPVeryficationDelegate {
    func changedPassword()
    func gotOTP()
}

class OTPVerifyVM {
    init() {
        
    }
    var otp = ""
    var newPassword = ""
    var delegate:OTPVeryficationDelegate?
    var otpModel : LoginModel?
    let rootVC = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController
    
    var mailId:String {
        return otpModel?.email ?? ""
    }
    var phone:String {
        return otpModel?.phone ?? ""
    }
    
    
    func getOtp() {
        
        let dictParam = ["reason":"RSTPWD_NPR","otp":""]
       NPRURLRequestSession().getOtpChangePassword(params: dictParam) { success, result, error in
            
            if success {
                self.otpModel = LoginModel.init(fromDictionary: result as! [String : Any])
                    self.delegate?.gotOTP()
            }else if error != nil {
                AlertView().alertForApiResponse(error: error!)
            }
        }
    }
    
    
    
    func requestForVerifyOTP(otp:String){
       // let otp = ""
        let dictParam = [Param_Key.OTP: otp , "reason":"RSTPWD_NPR"]
        rootVC?.view.showLoader()
            APIManager().postChangePwdVerifyOTPRequest(params: dictParam) { (success, responseData, error) in
                DispatchQueue.main.async {self.rootVC?.view.removeLoaderView()}
//             self.otpData = OTPModel(fromDictionary: responseData as! [String : Any])
                
            if success {
                self.saveNewPassword()
                
                singleton().Alert.show(title: AppMessages.App_Name, message: LanguageModal.langObj.password_changed_message, delay: 2.0)
            }
            else{
                 if error?.localizedDescription == AppMessages.Not_Connected_To_Internet {
                  singleton().Alert.show(title: AppMessages.App_Name, message: AppMessages.Not_Connected_To_Internet, delay: 5.0)
                    
                    let alert = AlertView()
                    alert.alertWithoutButton( message: LanguageModal.langObj.not_connected_to_internet, time: 2.0)
                }
                 if error?.localizedDescription == AppMessages.Server_Response {

                        
                        
                    }
                    else {
                        
                        let alert = AlertView()
                        alert.alertWithoutButton( message: LanguageModal.langObj.invalid_otp, time: 2.0)
                    }
                }
            }
        }
    
    
    func saveNewPassword()  {
        
        
        singleton().saveToUserDefaults(withKeyValue: ["userId":singleton().getCredentials().userId.lowercased(), "Password":newPassword], key: "User_Credentials")
        
        delegate?.changedPassword()
    }
}
