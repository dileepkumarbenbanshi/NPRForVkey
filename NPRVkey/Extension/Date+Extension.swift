//
//  Date+Extension.swift
//  NPR_census
//
//  Created by Dileep on 08/02/21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation

extension Date {
    
    var age: Int {
    return Calendar.current.dateComponents([.year], from: self, to: Date()).year!
        
    }
    
    var enumeratedOn:String {
     return datetoUpload()
    }
    var superVisorRemarkOn:String {
     return datetoUpload()
    }
    
   private func datetoUpload() -> String {
        let dateFormat = DateFormatter()
        dateFormat.dateFormat =  "yyyy-MM-dd'T'HH:mm:ss.SSS'Z"
        let strDate = dateFormat.string(from: self)
        return strDate
    }
    
}
