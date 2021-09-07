//
//  NPRAlert.swift
//  NPR_census
//
//  Created by mac on 26/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class NPRAlert: NSObject {

    //var duration=Double(5)
    private var isAutoHide=Bool(false)
    var willHideAlert:((Int)->(Void)?)!
    
    func show(title: String?=nil, message: String="", delay:Double = 0.5) {
        DispatchQueue.main.async {
              let alertController = UIAlertController(title:title, message:message, preferredStyle: .alert)
                  let controller=(UIApplication.shared.delegate as! AppDelegate).window?.rootViewController
                  controller?.present(alertController, animated:true, completion:nil)
                  DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                       alertController.dismiss(animated: true, completion:nil)
            }
        }
    }
    
    func showWithButtonAndImage(title: String?=nil, message: String="",image: UIImage, buttonsTitle:[String]=[], willHideAlert:((_ buttonIndex:Int)->Void)?=nil){
        self.willHideAlert = willHideAlert
            DispatchQueue.main.async {
                let alertController = UIAlertController(title:title, message:message, preferredStyle: .alert)
                let imgViewTitle = UIImageView(frame: CGRect(x: 20, y: 20, width: 35, height: 35))
                imgViewTitle.image = image
                alertController.view.addSubview(imgViewTitle)
                for(index, strTitle) in buttonsTitle.enumerated()
                     {
                      let action = UIAlertAction(title:strTitle, style: .default, handler: { (UIAlertAction) -> Void in
                        self.willHideAlert(index)
                    })
                    alertController.addAction(action)
                }
                let controller=(UIApplication.shared.delegate as! AppDelegate).window?.rootViewController
                controller?.present(alertController, animated:true, completion:nil)
            }
       }
    
  }

