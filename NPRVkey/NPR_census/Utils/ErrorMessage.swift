//
//  ErrorMessage.swift
//  NPR-2021
//
//  Created by Dileep on 22/07/21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation

class ErrorMessage {
    
    enum errorType:Int {
        case enrolledWithAnotherDevice = 409
        case unAuthorized = 401
    }
    
    
   static func errorMessage(code:Int) -> String {
        
        var strMessage = ""
        let error = errorType.init(rawValue: code)
        
        
        switch error {
        case .enrolledWithAnotherDevice:
            strMessage = LanguageModal.langObj.activated_devic_title
            break
        case .unAuthorized:
            break
        default:
            
          break
        }
        
        
      return strMessage
    }
    
}
