//
//  AlertView.swift
//  NPR-2020
//
//  Created by Dileep on 19/10/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

@objc protocol AlertViewDelegate {
    
    func alertTapedYes()
    
    @objc optional func alertViewTapedNo()
    
    @objc optional func alertViewWithoutButtonDissMiss()
    
    @objc optional func alertViewSingelButtonTapedYes()
    
}
class AlertView {
    
     var delegate : AlertViewDelegate?
    let rootVC = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController ?? UIViewController()
    
    func showAlert( title:String, message:String)  {
        DispatchQueue.main.async {
        let alertController = UIAlertController.init(title: title, message:message, preferredStyle: .alert)
        alertController.view.tintColor = ProjectColor.colorPrimary
        let btnYes = UIAlertAction.init(title: LanguageModal.langObj.button_yes, style: .default) { (alertK) in
            
            self.delegate?.alertTapedYes()
        }
        
        let btnNo = UIAlertAction.init(title: LanguageModal.langObj.no, style: .cancel) { (alertN) in
            self.delegate?.alertViewTapedNo?()
            
        }
        
        let controller = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController
        alertController.addAction(btnYes)
        alertController.addAction(btnNo)
            controller?.present(alertController, animated: true, completion: nil)
            
        }
    }
    
  
    func alertWithoutButton(message:String)  {
        
        let alertController = UIAlertController.init(title: nil, message:message, preferredStyle: .alert)
        alertController.view.tintColor = ProjectColor.colorPrimary
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            alertController.dismiss(animated: true, completion:{
                self.delegate?.alertViewWithoutButtonDissMiss?()
            })
  }
  
        let controller = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController
        controller?.present(alertController, animated: true, completion: nil)
        
        
    }
    
    func alertWithoutButton(message:String,time:Double)  {
        DispatchQueue.main.async {
        let alertController = UIAlertController.init(title: nil, message:message, preferredStyle: .alert)
        alertController.view.tintColor = ProjectColor.colorPrimary
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            alertController.dismiss(animated: true, completion:{
                self.delegate?.alertViewWithoutButtonDissMiss?()
            })
  }
  
            
            self.rootVC.present(alertController, animated: true, completion: nil)
        
        }
    }
    
    func showAlertWithSingleButton( title:String, message:String)  {
        DispatchQueue.main.async {
        let alertController = UIAlertController.init(title: title, message:message, preferredStyle: .alert)
        alertController.view.tintColor = ProjectColor.colorPrimary
        
//
//        let btnNo = UIAlertAction.init(title: "OK", style: .cancel) { (alertN) in
//
//            self.delegate?.alertViewSingelButtonTapedYes()
//        }
        
        
        let btnNo = UIAlertAction.init(title: LanguageModal.langObj.OK, style: .cancel) { (alertN) in
            self.delegate?.alertViewSingelButtonTapedYes?()
            
        }
        
        alertController.addAction(btnNo)
            self.rootVC.present(alertController, animated: true, completion: nil)
    }
    
    }
    
    
    func alertForApiResponse(error:CustomServiceError)  {
        let alert = AlertView()
        
             if error.localizedDescription == AppMessages.Not_Connected_To_Internet {
              singleton().Alert.show(title: AppMessages.App_Name, message: AppMessages.Not_Connected_To_Internet, delay: 3.0)
                
               
                alert.alertWithoutButton( message: LanguageModal.langObj.not_connected_to_internet, time: 3.0)
            }
             if error.localizedDescription == AppMessages.Server_Response {

                alert.alertWithoutButton(message: LanguageModal.langObj.unauthorized_access, time: 3.0)
                    
                }
                else {
                    
                    
                    alert.alertWithoutButton( message: LanguageModal.langObj.invalid_otp, time: 3.0)
                }
            }
        }
    

