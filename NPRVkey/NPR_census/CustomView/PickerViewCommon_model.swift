//
//  PickerViewCommon_model.swift
//  NPR_census
//
//  Created by Dileep on 24/09/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import CoreData
class PickerViewCommon_model{
    var id = ""
    var name = ""
    var code = ""
    
    
    
    init(model:Any) {
        if let modelNameid = model as? ModelNameID {
            id = modelNameid.id ?? ""
            name = modelNameid.name ?? ""
        }else{
        if let nameFound = (model as AnyObject).value(forKey: "name") as?String {
            name = nameFound
        }
        if let idFound = (model as AnyObject).value(forKey: "id") as?String {
            id = idFound
        }
        }
        
    }
    
    
}


