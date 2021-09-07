//
//  UIView_Extension.swift
//  NPR
//
//  Created by admin on 03/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

extension UIView {
    
    func cornerRadius_circle()  {
        self.layer.cornerRadius = self.frame.width/2
        self.layer.masksToBounds = true
    }
    
    
    @IBInspectable var cornerRadiusV: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var boprderWidth: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.borderWidth = newValue
            //layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var shadow: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            //layer.borderWidth = newValue
            //layer.masksToBounds = newValue > 0
            
            self.layer.shadowColor = UIColor.gray.cgColor
                   self.layer.shadowOpacity = 0.8
                   self.layer.shadowOffset = .init(width: 0, height: newValue)
                   self.layer.shadowRadius = newValue
                   self.layer.masksToBounds = false
        }
    }
    
    func cornerRadius_withShadow()  {
        
        //customizeCornerRadius(radius: Utils().viewConer_radius)
        
        //self.layer.shadowOffset = CGSize(width: 4.0, height: 0.0)
        
        
       
    }
    
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat){
         let rectShape = CAShapeLayer()
         rectShape.bounds = self.frame
         rectShape.position = self.center
         rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
         //self.layer.backgroundColor = UIColor.green.cgColor
         self.layer.mask = rectShape
     }
    
    func showLoader()  {
        
        DispatchQueue.main.async {
            let loaderView = UIView()
            loaderView.tag = 101
            loaderView.frame = self.frame
            loaderView.backgroundColor = UIColor.init(white: 0.4, alpha: 0.5)
                // self.addSubview(loaderView)
            let window = UIApplication.shared.keyWindow
            window?.addSubview(loaderView)
            
            
            let indicaterView = UIActivityIndicatorView()
            indicaterView.bounds = CGRect.init(x: 0, y: 0, width: 80, height: 80)
            
            //indicaterView.setCorner()
            self.setCorner(radius: 5.0)
            
            indicaterView.style = .whiteLarge
            indicaterView.tag = 102
            indicaterView.startAnimating()
            indicaterView.color = ProjectColor.colorPrimary
            indicaterView.backgroundColor = .white
            indicaterView.setCorner(radius: 4.0)
            indicaterView.center = loaderView.center
            loaderView.addSubview(indicaterView)
            
            //loaderView.layer.addSublayer(indicaterView.layer)
            //loaderView.insertSubview(indicaterView, at: 0)
        }
    }
    
    func removeLoaderView()  {
        
        DispatchQueue.main.async {
            let window = UIApplication.shared.keyWindow
            //window?.viewWithTag(101)
            
            guard let loaderView = window?.viewWithTag(101)else{ return }
            //let indicator = loaderView.viewWithTag(102) as! UIActivityIndicatorView
            loaderView.removeFromSuperview()
            loaderView.isHidden = true
 
        }
        
    }
    

    
//    func setCorner()  {
//
//        setCorner(radius: self.frame.size.height / 6)
//    }
    
    func setCorner(radius:CGFloat)  {
        
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    
    
    
    
}
