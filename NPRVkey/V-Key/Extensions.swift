//
//  Extensions.swift
//  VGuard-Swift
//
//  Created by Khant Zaw Ko on 29/7/19.
//  Copyright © 2019 V-Key Pte Ltd. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func getLogFromDocumentDirectory(isVTap: Bool) {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask = FileManager.SearchPathDomainMask.userDomainMask
        let paths = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        
        if let dirPath = paths.first {
            if isVTap {
                let vtapURL = URL(fileURLWithPath: dirPath).appendingPathComponent("vtap.db")
                let vguardURL = URL(fileURLWithPath: dirPath).appendingPathComponent("vguard.db")
                let activityController = UIActivityViewController(activityItems: [vtapURL, vguardURL], applicationActivities: nil)
                self.present(activityController, animated: true, completion: nil)
                
            } else {
                let vguardURL = URL(fileURLWithPath: dirPath).appendingPathComponent("vguard.db")
                let activityController = UIActivityViewController(activityItems: [vguardURL], applicationActivities: nil)
                self.present(activityController, animated: true, completion: nil)
            }
        }
    }
    
//    func hideKeyboardWhenTappedAround() {
//        
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
//    }
//    
//    @objc func dismissKeyboard() {
//        view.endEditing(true)
//    }
    
}
