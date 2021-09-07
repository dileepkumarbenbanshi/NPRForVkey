//
//  Utils.swift
//  NPR-2020
//
//  Created by Dileep on 16/10/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

let windows =  UIApplication.shared.keyWindow
let util = Utils()


enum dobType:Int {
    case personal
    case father
    case mother
}

enum detailType:Int {
    case personal
    case father
    case mother
}

class Utils {
    
    
    
    func memberStatus_dependOn_hhStatus(hhStatus:String) -> MemberLivingStatusCode {
        let hstatus = HHStaus.init(rawValue: hhStatus)
        
        var memberStatus = MemberLivingStatusCode.init(rawValue: "")
        
        switch hstatus {
        case .notAvailable:
            memberStatus = .notAvailable
            break
        case .locked:
            memberStatus = .lockedMember
            break
        case .migratedOut:
            memberStatus = .migratedOut
            break
        default:
            memberStatus = .available
            break
        }
        return memberStatus!
    }
    
    enum marritalStaus:String {
        
        case neverMarried = "1"
        case curentlyMarried = "2"
        case widowed = "3"
        case seprated = "4"
        case divorced = "5"
        case none = ""
    }
    
    func vKeySetup(enable:Bool) {
        
        let kb: VKeySecureKeypad = VKeySecureKeypad.sharedModule()!
        kb.enableKeyboard = enable
//        kb.enableScrambleKeypad = true
        kb.keyboardBackgroundColour = ProjectColor.colorPrimary
        //kb.keypadTextColor = ProjectColor.colorPrimary
       // kb.keybo
    }
    
    enum searchType:Int {
        case name = 101,aadhar,mobile ,head,dob
    }
    
    func isEnumerator() -> Bool {
        
       let userType = singleton().getFromUserDefaults(withKey: "userType") as? String
        
        if userType == "SUP" {
            return false
        }
        return true
    }
    
    
}
