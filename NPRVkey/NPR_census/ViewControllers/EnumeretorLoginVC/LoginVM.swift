//
//  LoginVM.swift
//  NPR-2021
//
//  Created by Dileep on 24/08/21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation
protocol MultiDCDelegate {
    func gotBaseurl(baseUrl:String)
}
class LoginVM {

    var userID = ""
    var password = ""
    var bseUrl = ""
    var isTapedEnumLogin = true
    
    var delegate:MultiDCDelegate?
    
    private let alert = AlertView()
    init() {
        
    }
  
    func getBaseURL()  {
        if Reachability.shared.isConnected {
        
        
            let dictParam = ["":""]
            util.rootVC.view.showLoader()
            APIManager().getBaseURL(params: dictParam) { (success, responseData, error) in
                DispatchQueue.main.async {util.rootVC.view.removeLoaderView()}
             
            if success {
                let modelMultiDC = MultiDCModel(fromDictionary: responseData as! [String:Any])
                
               // BaseUrl.url = modelMultiDC.baseurl
                self.delegate?.gotBaseurl(baseUrl:modelMultiDC.baseurl)
            }
            else{
                 if error?.localizedDescription == AppMessages.Not_Connected_To_Internet {
                   
                    
                    let alert = AlertView()
                    alert.alertWithoutButton( message: LanguageModal.langObj.user_id_password_cant_be_empty, time: 2.0)
                }
                  if error?.localizedDescription == AppMessages.Server_Response {
                    
                    
                    
                    self.alert.alertWithoutButton( message: LanguageModal.langObj.wrong_password, time: 2.0)
                }
            }
            }
        }else {
            
            alert.alertWithoutButton( message: LanguageModal.langObj.not_connected_to_internet)
        }
    }
    
    
  
    func isValidID_userType(loginModel:LoginModel) -> Bool {
        
       let isValid = isTapedEnumLogin ? loginModel.userType == "DEO" : loginModel.userType == "SUP"
        if !isValid {
            DispatchQueue.main.async {
                self.alert.alertWithoutButton(message: LanguageModal.langObj.user_doesnot_exist)
            }
            
        }
        return isValid
    }
    
    
}
