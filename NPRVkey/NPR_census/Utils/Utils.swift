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

var selectedLanguageCode:String {
    
     let currentLangCode = LanguageModal.currentLanguage.prefix(2).lowercased()
      return currentLangCode
}


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
    let format = Format()
    
    var countryCode:String {
        return "083"
    }
    var notKnownCountryCode:String {
        return "999"
    }
    var notKnownStateCode:String {
        return "99"
    }
    var notKnownDistrictCode:String {
        return "99"
    }
    var notKnownSubDistrictCode:String {
        return "99"
    }
    
    var countryName:String {
        return "India"
    }
    
    var otherMotherTongueCode:String {
        return "999"
    }
    var censusHHInstitutional:String {
        return "999"
    }
    
    let rootVC = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController ?? UIViewController()
    
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
    
    func houseTypeDecode(houseType:HouseType) -> String {
        switch houseType {
        case .normal:
            return LanguageModal.langObj.normal
        case .houseLess:
            return LanguageModal.langObj.houseless
        case .institute:
            return LanguageModal.langObj.institutional//"Institutional"
        
        }
    }
    
    func vKeySetup(enable:Bool) {
        
        let kb: VKeySecureKeypad = VKeySecureKeypad.sharedModule()!
        kb.enableKeyboard = enable
//        kb.enableScrambleKeypad = true
        kb.keyboardBackgroundColour = ProjectColor.colorPrimary
        kb.keypadTextColor = ProjectColor.colorPrimary
    
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
    
    func isCountryIndia(countryName:String) ->Bool  {
      let countryCode =  DBManager_CountryStateDistrict().getCountryCode(countryName: countryName)
        if countryCode == "083" {
            return true
        }
        return false
    }
    func isCountryCodeIndia(countryCode:String) ->Bool  {
     
        return countryCode == "083"
    }
    
    func isSelectedLang_english()->Bool  {
        
        return UserDefaults().getCurrentLanguage() == "English" 
    }
    

    func selectedLanguageCode() -> String {
      let currentLang = LanguageModal.currentLanguage
       let currentLangCode = currentLang.prefix(2).lowercased()
        return currentLangCode
    }
    
}


struct AppUtility {
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.orientationLock = orientation
        }
    }

    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
        self.lockOrientation(orientation)
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
    }
    
    
}
