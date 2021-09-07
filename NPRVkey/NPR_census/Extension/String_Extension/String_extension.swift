//
//  String_extension.swift
//  NPR
//
//  Created by admin on 03/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Foundation

extension String {
    
     func maskEmail() -> String{
        let components = self.components(separatedBy: "@")
        var maskEmail = ""
        if let first = components.first {
                maskEmail = String(first.enumerated().map { index, char in
                 return [0].contains(index) ? char : "*"
                })
          }
        if let last = components.last {
               maskEmail = maskEmail + "@" + last
         }
         print (maskEmail)
        return maskEmail
     }
    
    func maskMobile() -> String{
        var mobile = ""
        mobile =  String(self.enumerated().map { index, char in
            return [0, 6, self.count - 3, self.count - 2, self.count - 1].contains(index) ? char : "*"
        })
       print(mobile)
       return mobile
    }
    
    func convertDateFormater() -> String{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: self)
            dateFormatter.dateFormat = "dd-MM-yyyy"
            return  dateFormatter.string(from: date ?? Date())

        }
    
    
    
    
    func getDropDownItem_id(aray:[[String:String]]) -> String {
        
        //let predicate = NSPredicate(format:"name == %@", self)
        if self.count > 0 {
        let filteredAray = aray.filter { $0["name"] == self }
            
            
        if filteredAray.count > 0 {
          
            let model = PickerViewCommon_model.init(model: filteredAray[0])
            
            return model.id
        }
            return ""
        }
       
       return ""
    }
    
    
    func getName_by_ID(aray:[[String:String]]) -> String {
        
        //let predicate = NSPredicate(format:"name == %@", self)
        let filteredAray = aray.filter { $0["id"] == self }
            
            
        if filteredAray.count > 0 {
          
            let model = PickerViewCommon_model.init(model: filteredAray[0])
            
            return model.name
        }
       
       return ""
    }
    
    
    func getRealtionShipAray() -> [[String:String]] {
        
        
        let genderId = gender.init(rawValue: Int(self) ?? 0)
        var arayRelation =  [[String:String]]()
         switch genderId {
         case .male:
            arayRelation = English().relationship_to_head_male()
             break
         case .female:
             arayRelation = English().relationship_to_head_female()
             break
         case .transGender:
             arayRelation = English().relationship_to_head_transGender()
             break
            
         default:
             arayRelation = English().relationship_to_head_transGender()
             break
         }
        return arayRelation
    }
    
    func splitStringBySpecialCharector()  {
        
    }
   
    func splitDateString() -> (date: String, month: String,year: String) {
        
//       let arayDateComponent = self.components(separatedBy: "-")as?[String]  else {
//
//           return (date: "", month:"" ,year: "")
//        }
          let arayDateComponent = self.components(separatedBy: "-")
        if arayDateComponent.count > 2 {
            return (date: arayDateComponent[0], month: arayDateComponent[1],year: arayDateComponent[2])
        }
        return (date: "", month: "",year: "")
        
    }
    
    
    func isValidMobileNumber() -> Bool {
        
        let PHONE_REGEX = "^[5-9][0-9]{9}$|^[0-9][0-9]{10}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result =  phoneTest.evaluate(with: self)
        return result
    }
    
    func isValidDOB() -> Bool  {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-YYYY"
       // let date = dateFormatter.date(from: self)
        
        if let dateExist  = dateFormatter.date(from: self) {
            print("date DOB" ,dateExist)
            
            let dateComponent = self.splitDateString()
            
            if (1854 < Int(dateComponent.year) ?? 0) && (dateExist < Date()) {
                return true
            }
            return false
            
            
        } else {
            return false
        }
        
      //  return true
    }
    
    
 //MARK:Formater
    
    func dataFormater() -> String {
      let araySeratedDateString = self.splitDateString()
        var dateFormater = ""
        
        if araySeratedDateString.date == "00" && araySeratedDateString.month == "00" && araySeratedDateString.year == "0000" {
            
        }else if araySeratedDateString.date == "00" && araySeratedDateString.month == "00" {
            dateFormater = "yyyy"
            
        } else if araySeratedDateString.date == "00" {
            dateFormater = "MM-yyyy"
        }else{
            dateFormater = "dd-MM-yyyy"
        }
        return dateFormater
    }
    
    
    func memberSrNumber() -> String {
        if  let intHHNumber = Int(self) {
        
        let strSrNumber = String(format: AppFormat.member_sr_Format, intHHNumber)
        
      return  strSrNumber
        }
            return ""
    }
    
    func hhNumber() -> String {
        if  let intHHNumber = Int(self) {
        
        let strHHNumber = String(format: AppFormat.fivedigitFormat, intHHNumber)
        
      return  strHHNumber
        }
            return ""
    }
    
    func hhTin() -> String {
        if  let intHHNumber = Int(self) {
        
        let strHHNumber = String(format: AppFormat.fivedigitFormat, intHHNumber)
        
      return  "\(singleton().selectEBListModel.eb_number ?? "")\(strHHNumber)"
        }
            return ""
    }
   
    func memberTin(hhNumber:String) -> String {
        if  let intHHNumber = Int(hhNumber) {
        
        let strHHNumber = String(format: AppFormat.fivedigitFormat, intHHNumber)
            if let intMemberSr = Int(self) {
                let strSrNumber = String(format: AppFormat.threeDigitFormat, intMemberSr)
            
        
      return  "\(singleton().selectEBListModel.eb_number ?? "")\(strHHNumber)\(strSrNumber)"
        }
        }
            return ""
    }
    
    func censusHHNumber() -> String {
        if  let intHHNumber = Int(self) {
        
        let strHHNumber = String(format: AppFormat.fourdigitFormat, intHHNumber)
        
      return  strHHNumber
        }
            return ""
    }
    
    
    func censusHouseNumber() -> String {
        if  let intHHNumber = Int(self) {
        
        let strHHNumber = String(format: AppFormat.threeDigitFormat, intHHNumber)
        
      return  strHHNumber
        }
            return ""
    }
}


