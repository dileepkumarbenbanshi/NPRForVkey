//
//  LocationParticularVM.swift
//  NPR-2021
//
//  Created by Dileep on 27/08/21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation
class LocationParticularVM {
   private var language = ""
    
   private var arayTotalHH:[NPR_2021hh_Details] {
      
        let predicateHH = NSPredicate(format: "ebNumber = %@",singleton().selectEBListModel.eb_number!)
        guard let arayTotalHouseHoldINEB = DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicateHH) as? [NPR_2021hh_Details] else {
            return [NPR_2021hh_Details]()
        }
        return arayTotalHouseHoldINEB
    }
    
    
   private var hhCountInEnglishLang:String {
        let predicateHH = NSPredicate(format: "ebNumber = %@ AND isInEnglish = %@",singleton().selectEBListModel.eb_number!,"1")
       let aray =  DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicateHH)
        return "\(aray.count)"
    }
    
    var totalHHCount:Int {
       return arayTotalHH.count
    }
    
    
    
    var totalNewHH:Int {
        
        let  arayNewHouseHold =  arayTotalHH.filter({$0.hh_status == HHStatusCode.new })
        return arayNewHouseHold.count
    }
   
    
    
    var otalOldHH:Int {
        
        return totalHHCount - totalNewHH
    }
    
    var arayLanguage:[String]{
        var aray = ["en"]
        
        for hhModel in arayTotalHH {
            if aray.count > 0 && (aray.firstIndex(of: hhModel.language ?? "en") == nil) {
                
                aray.append(hhModel.language ?? "en")
            }
            
        
        }
        //aray.remove(at: 0)
        return aray
    }
    
   
    func hhCountinLanguage (lang:String) -> String{
        if lang.isEnglishLangCode() {
          return hhCountInEnglishLang
        }
        let aray = arayTotalHH.filter({$0.language == lang})
         return "\(aray.count)"
    }
   
    
    func langaugeByCode(langCode:String) -> String {
        var strLang = ""
        
        switch langCode {
        case "en":
           strLang = "English"
            break
        case "hi":
           strLang = "Hindi"
            
            break
        case "ma":
           strLang = "Malyalam"
            break
            
        case "be":
           strLang = "Bengali"
            break
        case "ko":
           strLang = "Konkani"
            break
            
        case "mr":
           strLang = "Marathi"
            break
        case "as":
           strLang = "Assamese"
            break
            
        case "ka":
           strLang = "Kannad"
            break
        case "te":
           strLang = "Telagu"
            break
        case "gu":
           strLang = "Gujrati"
            break
        case "ne":
           strLang = "Nepali"
            break
            
        case "pu":
           strLang = "Konkani"
            break
        default:
            strLang = "English"
        }
        return strLang
    }
    
}
