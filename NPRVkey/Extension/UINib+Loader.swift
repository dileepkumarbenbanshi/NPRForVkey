//
//  UINib+Loader.swift
//  NPR_census
//
//  Created by mac on 19/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

fileprivate extension UINib {
    
    static func nib(named nibName: String) -> UINib {
        return UINib(nibName: nibName, bundle: nil)
    }
    
    static func loadSingleView(_ nibName: String, owner: Any?) -> UIView {
        return nib(named: nibName).instantiate(withOwner: owner, options: nil)[0] as! UIView
    }
}

// MARK: App Views
extension UINib {
    
    class func loadPickerView(_ owner: AnyObject) -> UIView {
        return loadSingleView("PickerView", owner: owner)
    }
    
    class func loadAgreeView(_ owner: AnyObject) -> UIView {
           return loadSingleView("AgreeView", owner: owner)
       }
    
    class func loadSkipView(_ owner: AnyObject) -> UIView {
           return loadSingleView("SkipHHView", owner: owner)
       }
    
}



