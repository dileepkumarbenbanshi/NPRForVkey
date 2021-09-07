//
//  Format.swift
//  NPR-2021
//
//  Created by Dileep on 25/08/21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation

class Format {
    
    
    enum dateFormat:String {
        case yearMonthDateTimeWithTimeZone = "yyyy-MM-ddThh:mm:ss'Z'"
        case yearMonthDate = "yyyy-MM-dd"
        case dateMonthYear = "dd-MM-yyyy"
        case monthYear     = "MM-yyyy"
        case year          = "yyyy"
    }
}
