//
//  UserDefault_Extension.swift
//  NPR-2021
//
//  Created by Dileep on 22/07/21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation

extension UserDefaults {
    enum defaultKey:String {
        case language = "langauge"
        case credential = "Credential"
        case baseUrlProd = "baseUrl"
    }
    
    
    func getUserDefaultValue(key:defaultKey)-> Any  {
        return UserDefaults.standard.object(forKey: key.rawValue) ?? ""
    }
    
    func saveUserDefauldValue(key:defaultKey,value:Any)  {
        return UserDefaults.standard.setValue(value, forKey: key.rawValue)
    }
    
    func getCurrentLanguage() -> String {
        return UserDefaults.standard.object(forKey:defaultKey.language.rawValue)  as? String ?? ""
    }
    
}
