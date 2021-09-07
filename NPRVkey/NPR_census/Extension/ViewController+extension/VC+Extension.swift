//
//  VC+Extension.swift
//  NPR
//
//  Created by admin on 03/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit


extension UIViewController {
    
    func navigateToController(identifier:String, storyBoardName:String)  {
        DispatchQueue.main.async {
          let storyBoard:UIStoryboard = UIStoryboard(name: storyBoardName, bundle: nil)
          let vcClass:UIViewController = storyBoard.instantiateViewController(withIdentifier:identifier)
          self.navigationController?.pushViewController(vcClass, animated: true)
        }
    }
    
    func navigateToController(vc:UIViewController)  {
        DispatchQueue.main.async {
         
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    func popTwoView()  {
        guard let viewControllers = self.navigationController?.viewControllers else{
            return
        }
        if viewControllers.count > 2 {
            let vcPrevToPrev = self.navigationController?.viewControllers[viewControllers.count-2 ]
            vcPrevToPrev?.navigationController?.popViewController(animated: true)
        }
        
    }
    
    func popBackToController<T: UIViewController>(toControllerType: T.Type) {
        if var viewControllers: [UIViewController] = self.navigationController?.viewControllers {
            viewControllers = viewControllers.reversed()
            for currentViewController in viewControllers {
                if currentViewController .isKind(of: toControllerType) {
                    self.navigationController?.popToViewController(currentViewController, animated: true)
                    break
                }
            }
        }
    }
    
    
    

    
    func is_VC_inNavigationStcak() -> Bool {
        
        if let viewControllers = self.navigationController?.viewControllers
            {
                for controller in viewControllers
                {
                    if self == controller
                    {
                        
                        return true
                    }
                }
            }
        return false
    }
}


extension UIViewController {
    func addKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardNotifications(notification:)),
                                               name: UIResponder.keyboardWillChangeFrameNotification,
                                               object: nil)
    }
    
    func removeKeyboardObserver(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    // This method will notify when keyboard appears/ dissapears
    @objc func keyboardNotifications(notification: NSNotification) {
        
        var txtFieldY : CGFloat = 0.0  //Using this we will calculate the selected textFields Y Position
        let spaceBetweenTxtFieldAndKeyboard : CGFloat = 5.0 //Specify the space between textfield and keyboard
       
        
        var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        if let activeTextField = UIResponder.currentFirst() as? UITextField ?? UIResponder.currentFirst() as? UITextView {
            // Here we will get accurate frame of textField which is selected if there are multiple textfields
            frame = self.view.convert(activeTextField.frame, from:activeTextField.superview)
            txtFieldY = frame.origin.y + frame.size.height
        }
        
        if let userInfo = notification.userInfo {
            // here we will get frame of keyBoard (i.e. x, y, width, height)
            let keyBoardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let keyBoardFrameY = keyBoardFrame!.origin.y
            let keyBoardFrameHeight = keyBoardFrame!.size.height
            
            var viewOriginY: CGFloat = 0.0
            //Check keyboards Y position and according to that move view up and down
            if keyBoardFrameY >= UIScreen.main.bounds.size.height {
                viewOriginY = 0.0
            } else {
                // if textfields y is greater than keyboards y then only move View to up
                if txtFieldY >= keyBoardFrameY {
                    
                    viewOriginY = (txtFieldY - keyBoardFrameY) + spaceBetweenTxtFieldAndKeyboard
                    
                    //This condition is just to check viewOriginY should not be greator than keyboard height
                    // if its more than keyboard height then there will be black space on the top of keyboard.
                    if viewOriginY > keyBoardFrameHeight { viewOriginY = keyBoardFrameHeight }
                }
            }
            
            //set the Y position of view
            self.view.frame.origin.y = -viewOriginY
        }
    }
}
