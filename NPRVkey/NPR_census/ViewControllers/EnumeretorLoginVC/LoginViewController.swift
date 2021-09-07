//
//  LoginViewController.swift
//  NPR Screen
//
//  Created by mac on 05/08/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController{

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var labelLangauge: UILabel!
    @IBOutlet weak var textFieldUserId: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var buttonSuperVisiorLogin: UIButton!
    @IBOutlet weak var buttonChangePassword: UIButton!
    var loginData:LoginModel?
    var otpData:OTPModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.textFieldUserId.text = "ev_2211002_ravinder"//"ev_2211001_ravinder"//"ec_31010058002_demo"//"ec_31010068003_aarti"//
        //self.textFieldPassword.text = "Admin@1234"
        self.customize()
        
        Utils().vKeySetup(enable:true)
        
        self.addKeyboardObserver()
        
        //fatalError()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if #available(iOS 13.0, *) {
            
        } else {
            // Fallback on earlier versions
        }
        
        if #available(iOS 13.0, *) {
                    let statusBar = UIView(frame: UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
            statusBar.backgroundColor = ProjectColor.colorPrimaryDark
            overrideUserInterfaceStyle = .light
                     UIApplication.shared.keyWindow?.addSubview(statusBar)
                } else {
                     //UIApplication.shared.statusBarView?.backgroundColor = UIColor.init(red: 237.0/255.0, green: 85.0/255.0, blue: 61.0/255.0, alpha: 1.0)
                }
    
        //Crashlytics.crashlytics().setCustomValue(100, forKey: "int_key")
        
        
    }
    
    func customize(){
        self.containerView.cornerRadiusV = 5
        //singleton().isConnectedToNetwork() ? singleton().Alert.show(title: AppMessages.App_Name, message: AppMessages.Connected_To_Internet, delay: 5.0) : nil
        self.textFieldUserId.placeholder =  singleton().getFromUserDefaults(withKey: "Is_LoggedIn") as? Bool == true ? singleton().getCredentials().userId : "User Id"
        self.textFieldUserId.isEnabled = singleton().getFromUserDefaults(withKey: "Is_LoggedIn") as? Bool == true ? false : true
       
        
        singleton().getFromUserDefaults(withKey: "Is_LoggedIn") as? Bool == true ? self.hideShowSupervisorAndChangePswdButton(isSupervisorHidden: true, isChangePasswordHidden: false) : self.hideShowSupervisorAndChangePswdButton(isSupervisorHidden: false, isChangePasswordHidden: true)
    }
    
    func hideShowSupervisorAndChangePswdButton(isSupervisorHidden:Bool, isChangePasswordHidden:Bool){
        self.buttonSuperVisiorLogin.isHidden = isSupervisorHidden
        self.buttonChangePassword.isHidden = isChangePasswordHidden
    }
        
    @IBAction func onTapSignIn(_ sender: Any) {
        textFieldPassword.resignFirstResponder()
      print("Access Token",singleton().getDeviceIDORAccessToken().accessToken )
        
        print("Device ID",singleton().getDeviceInfo().deviceId )
        
        if  singleton().getFromUserDefaults(withKey: "Is_LoggedIn") as? Bool == true {
           if isAllFieldValid() {
              self.goToAssignEBController()
           }
        }
        else{
            if isAllFieldValid() {
                singleton().saveToUserDefaults(withKeyValue: ["userId":self.textFieldUserId.text!.lowercased(), "Password":self.textFieldPassword.text!], key: "User_Credentials")
                self.requestForEnrollement()
            }
        }
    }
    
    @IBAction func onTapChangePassword(_ sender: Any) {
        self.navigateToController(identifier: "ChangePasswordVC", storyBoardName: "Main")
    }
    
    @IBAction func onTapLanguage(_ sender: Any) {
        let pickerView = UINib.loadPickerView(PickerView.self) as! PickerView
        pickerView.delegate = self
        singleton().NPRRect.addSubViewToParentWindow(view: pickerView, withFrame:  CGRect(x: 0, y: UIScreen.main.bounds.height,  width: UIScreen.main.bounds.width, height: pickerView.frame.height + 50), isCenter: false)
        singleton().NPRRect.animateView(view: pickerView, key: true)
    }
    
    
    @IBAction func btnEye_tap(_ sender: UIButton) {
        
        textFieldPassword.isSecureTextEntry = sender.isSelected
        
        sender.isSelected =  !sender.isSelected
    }
    
    func isAllFieldValid()-> Bool{
        if  singleton().getFromUserDefaults(withKey: "Is_LoggedIn") as? Bool == true {
            if (self.textFieldPassword.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
               singleton().Alert.show(title: AppMessages.App_Name, message: AppMessages.Password_Empty, delay: 5.0)
                  return false
            }
            if self.textFieldPassword.text != singleton().getCredentials().password {
              singleton().Alert.show(title: AppMessages.App_Name, message: AppMessages.Wrong_Password, delay: 5.0)
                return false
            }
          return true
        }
        else{
            if (self.textFieldUserId.text?.trimmingCharacters(in: .whitespaces).isEmpty)! || (self.textFieldPassword.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
                      singleton().Alert.show(title: AppMessages.App_Name, message: AppMessages.User_Id_Password_Can_not_be_Empty, delay: 5.0)
                      return false
             }
           return true
        }
      
    }
    
    func goToAssignEBController(){
           DispatchQueue.main.async {
               let controller = self.storyboard?.instantiateViewController(withIdentifier: "AssignEBVC") as! AssignEBViewController
               self.navigationController?.pushViewController(controller, animated: true)
           }
       }
    
    func goToVerifyController(withData data:LoginModel?){
        DispatchQueue.main.async {
          let controller = self.storyboard?.instantiateViewController(withIdentifier: "OTPVerificationVC") as! OTPVerificationViewController
            singleton().saveToUserDefaults(withKeyValue: ["deviceId":singleton().getDeviceInfo().deviceId, "accessToken":data?.accessToken!], key: "Device_Info")
            controller.loginData = data
            self.navigationController?.pushViewController(controller, animated: true)
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
                 if let status = self.loginData?.status {
                     if status == 1 {
                         DispatchQueue.main.async {
                            self.requestForDeEnrollement(withDeviceId: (self.loginData?.deviceId!)!)
                         }
                     }
                    if status == 2 {
                        self.goToVerifyController(withData: self.loginData)
                    }
                 }
            }
            else{
                 if error?.localizedDescription == AppMessages.Not_Connected_To_Internet {
                   singleton().Alert.show(title: AppMessages.App_Name, message: AppMessages.Not_Connected_To_Internet, delay: 5.0)
                }
                  if error?.localizedDescription == AppMessages.Server_Response {
                    singleton().Alert.show(title: AppMessages.App_Name, message: AppMessages.UnAuthorized_Access, delay: 5.0)
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
                    if status == 3 {
                        DispatchQueue.main.async {
                            self.requestForEnrollement()
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
    
}

extension LoginViewController : PickerViewDelegate {
    
    func getLangauge(language: String) {
        self.labelLangauge.text = language
    }
}



