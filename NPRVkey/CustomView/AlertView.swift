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
    
    func showAlert(vc:UIViewController, title:String, message:String)  {
       
        let alertController = UIAlertController.init(title: title, message:message, preferredStyle: .alert)
        alertController.view.tintColor = ProjectColor.colorPrimary
        let btnYes = UIAlertAction.init(title: "Yes", style: .default) { (alertK) in
            
            self.delegate?.alertTapedYes()
        }
        
        let btnNo = UIAlertAction.init(title: "No", style: .cancel) { (alertN) in
            self.delegate?.alertViewTapedNo?()
            
        }
        
        alertController.addAction(btnYes)
        alertController.addAction(btnNo)
        vc.present(alertController, animated: true, completion: nil)
    }
    
  
    func alertWithoutButton(vc:UIViewController,message:String)  {
        
        let alertController = UIAlertController.init(title: nil, message:message, preferredStyle: .alert)
        alertController.view.tintColor = ProjectColor.colorPrimary
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            alertController.dismiss(animated: true, completion:{
                self.delegate?.alertViewWithoutButtonDissMiss?()
            })
  }
  
        vc.present(alertController, animated: true, completion: nil)
        
        
    }
    
    func alertWithoutButton(vc:UIViewController,message:String,time:Double)  {
        
        let alertController = UIAlertController.init(title: nil, message:message, preferredStyle: .alert)
        alertController.view.tintColor = ProjectColor.colorPrimary
        
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            alertController.dismiss(animated: true, completion:{
                self.delegate?.alertViewWithoutButtonDissMiss?()
            })
  }
  
        vc.present(alertController, animated: true, completion: nil)
        
        
    }
    
    func showAlertWithSingleButton(vc:UIViewController, title:String, message:String)  {
       
        let alertController = UIAlertController.init(title: title, message:message, preferredStyle: .alert)
        alertController.view.tintColor = ProjectColor.colorPrimary
        
//
//        let btnNo = UIAlertAction.init(title: "OK", style: .cancel) { (alertN) in
//
//            self.delegate?.alertViewSingelButtonTapedYes()
//        }
        
        
        let btnNo = UIAlertAction.init(title: "OK", style: .cancel) { (alertN) in
            self.delegate?.alertViewSingelButtonTapedYes?()
            
        }
        
        alertController.addAction(btnNo)
        vc.present(alertController, animated: true, completion: nil)
    }
    
    
}
