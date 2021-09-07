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
        if self.isValidMobileNumber() {
          
            mobile =  String(self.enumerated().map { index, char in
                return [0, 6, self.count - 3, self.count - 2, self.count - 1].contains(index) ? char : "*"
            })
            
        }
        
       print(mobile)
       return mobile
    }
    
    func maskAadhar() -> String{
       
        if Verhoeff.validateVerhoeff(for: self) {
          
            return String(repeating: "*", count: Swift.max(0, count-4)) + suffix(3)
            }
            
        
        
       
       return ""
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
    
    func isValidPassport() -> Bool {
        let passportRegEx = "^[A-PR-WYa-pr-wy][1-9]\\d" + "\\s?\\d{4}[1-9]$"//"[a-zA-Z]{2}[0-9]{7}"

        let passportPred = NSPredicate(format:"SELF MATCHES %@", passportRegEx)
        return passportPred.evaluate(with: self)
      }
    
    func isValidAlphabetAndSpace() -> Bool {
        let namePred = NSPredicate(format:"SELF MATCHES %@", Regix().regeixAlphabetSpace)
       return namePred.evaluate(with: self)
        
        
    }
    func isValidAddressEntry() -> Bool {
        let namePred = NSPredicate(format:"SELF MATCHES %@", Regix().adress)
       return namePred.evaluate(with: self)
        
        
    }
    
    func isValidDOB() -> Bool  {
        
        let dateFormatter = DateFormatter()
        
        let dateandFormat = dateFormatAndDateString()
        
        dateFormatter.dateFormat = dateandFormat.format
       // let date = dateFormatter.date(from: self)
        
        if let dateExist  = dateFormatter.date(from:dateandFormat.strDate ) {
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
    
    func isValidParentDOB() -> Bool  {
        
        let dateFormatter = DateFormatter()
        
        let dateandFormat = dateFormatAndDateString()
        
        dateFormatter.dateFormat = dateandFormat.format
       // let date = dateFormatter.date(from: self)
        
        if let dateExist  = dateFormatter.date(from:dateandFormat.strDate ) {
            print("date DOB" ,dateExist)
            
            let dateComponent = self.splitDateString()
            
            if (1771 < Int(dateComponent.year) ?? 0) && (dateExist < Date()) {
                return true
            }
            return false
            
            
        } else {
            return false
        }
        
      //  return true
    }
    
    func dateForSearch()->String  {
        var date = ""
        var month = ""
        
        if self.count == 2 && self == "00" {
            return "01"
        }
        if self.count > 2 && self.count <= 6 {
            
        } else {
            
        }
        let dateAray = self.split(separator: "-")
       
        let year = dateAray[2]
        if date == "00" && month == "00"  {
            date = "01"
            month = "01"
        }else if (date == "00" || month == "00"){
          
            
            if date == "00" {
                date = "01"
                
                
            }
            else if month == "00" {
                month = "01"
            }
        }
        
        let strDate = "\(date)-\(month)-\(year)"
        return strDate
    }
    
 //MARK:Formater
    func dateFormatAndDateString() -> (format :String ,strDate:String) {
        
        let araySeratedDateString = self.splitDateString()
          var dateFormater = ""
        var strDate = ""
        
          if araySeratedDateString.date == "00" && araySeratedDateString.month == "00" && araySeratedDateString.year == "0000" {
            
          }else if (araySeratedDateString.date == "00" || araySeratedDateString.date.isEmpty ) && ( araySeratedDateString.month == "00"  || araySeratedDateString.month.isEmpty ) {
              dateFormater = "yyyy"
            strDate = araySeratedDateString.year
              
          } else  if ( araySeratedDateString.date == "00" || araySeratedDateString.date.isEmpty ) {
              dateFormater = "MM-yyyy"
            strDate = "\(araySeratedDateString.month)-\(araySeratedDateString.year)"
          }else{
              dateFormater = "dd-MM-yyyy"
            strDate = "\(araySeratedDateString.date)-\(araySeratedDateString.month)-\(araySeratedDateString.year)"
          }
          return (dateFormater,strDate)
    }
    
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
    
    
    func stringToDate() -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dataFormater()
        let date = dateFormatter.date(from: self)
        return date ?? Date()
        
    }
    
    func memberSrNumber() -> String {
        if  let intHHNumber = Int(self) {
        
        let strSrNumber = String(format: AppFormat.member_sr_Format, intHHNumber)
        
      return  strSrNumber
        }
            return ""
    }
    
    func memberSrNumberForUpload() -> String {
        if  let intHHNumber = Int(self) {
        
        let strSrNumber = String(format: AppFormat.member_sr_Format, intHHNumber)
        
      return  strSrNumber
        }
            return ""
    }
    
    func hhNumber() -> String {
        if  let intHHNumber = Int(self) {
            var hhNumberDigit = AppFormat.fivedigitFormat
            
            if intHHNumber == 9999 {
                hhNumberDigit = AppFormat.fourdigitFormat
            }
        let strHHNumber = String(format: hhNumberDigit, intHHNumber)
        
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
        
        let strHHNumber = String(format: AppFormat.fivedigitFormat, intHHNumber)
        
      return  strHHNumber
        }
            return ""
    }
    
    
    func censusHouseNumber() -> String {
        if  let intHHNumber = Int(self) {
        
        let strHHNumber = String(format: AppFormat.fourdigitFormat, intHHNumber)
        
      return  strHHNumber
        }
            return ""
    }
    
    func trimWhiteSpace() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
    
    var maskedMobile: String {
            return String(repeating: "*", count: Swift.max(0, count-3)) + suffix(3)
        }
    
    var maskedAadhar: String {
            return String(repeating: "*", count: Swift.max(0, count-4)) + suffix(3)
        }
}


