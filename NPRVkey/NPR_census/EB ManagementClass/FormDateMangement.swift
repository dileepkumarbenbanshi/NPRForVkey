//
//  FormDateMangement.swift
//  NPR-2020
//
//  Created by Dileep on 28/01/21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation

class FormDateMangement {
    
    enum dobStatus:String {
        case properDate = "A"
        case monthYear = "D"
        case yearOnly = "Y"
        case none = ""
        
    }
    
    func dateFormat(type:dobType,formClass:AddNewHouseHoldForm_TVC) -> String {
        
        var date = ""
        var month = ""
        var year = ""
        
        switch type {
        case .personal:
             date = formClass.tf_pd_Dob_date.text ?? "00"
             month = formClass.tf_pd_Dob_month.text ?? "00"
             year = formClass.tf_pd_Dob_year.text ?? ""
            
            if date == "00" || date.count == 0{
                formClass.tf_pd_Dob_date.text = "00"
                
            }
        
            if month == "00" || month.count == 0{
                formClass.tf_pd_Dob_date.text = "00"
                formClass.tf_pd_Dob_month.text = "00"
            }
            if year == "0000"  {
                formClass.tf_pd_Dob_date.text = "00"
                formClass.tf_pd_Dob_month.text = "00"
                formClass.tf_pd_Dob_year.text = "1896"
            }
            
        case .father:
            
             date = formClass.tf_ParentDetail_dob_date.text ?? "00"
             month = formClass.tf_ParentDetail_dob_month.text ?? "00"
             year = formClass.tf_ParentDetail_dob_year.text ?? ""
            
            if date == "00" || date.count == 0{
                formClass.tf_ParentDetail_dob_date.text = "00"
            }
        
            if month == "00" || month.count == 0{
                formClass.tf_ParentDetail_dob_month.text = "00"
                formClass.tf_ParentDetail_dob_date.text = "00"
            }
            if year == "0000"  {
                formClass.tf_ParentDetail_dob_date.text = "00"
                formClass.tf_ParentDetail_dob_month.text = "00"
                formClass.tf_ParentDetail_dob_year.text = "1771"
            }
       
        case .mother:
            
             date = formClass.tf_ParentDetail_motherDob_date.text ?? "00"
             month = formClass.tf_ParentDetail_motherDob_month.text ?? "00"
             year = formClass.tf_ParentDetail_motherDob_year.text ?? ""
            
            if date == "00" || date.count == 0{
                formClass.tf_ParentDetail_motherDob_date.text = "00"
                
            }
        
            if month == "00" || month.count == 0{
                formClass.tf_ParentDetail_motherDob_month.text = "00"
            }
            if year == "0000" {
                formClass.tf_ParentDetail_motherDob_date.text = "00"
                formClass.tf_ParentDetail_motherDob_month.text = "00"
                formClass.tf_ParentDetail_motherDob_year.text = "1771"
            }

        }
        
        if date == "00" || date.count == 0{
            date = "00"
            
        }
    
        if month == "00" || month.count == 0{
            date = "00"
            month = "00"
        }
        if year == "0000" {
           year = type == .personal ? "1896" : "1771"
        }
        var strDate = "\(date)-\(month)-\(year)"
        
        if strDate == "--" {
          strDate = ""
        }
      return strDate
    }
    
    
    func prepareDObForUpload(type:dobType,formClass:AddNewHouseHoldForm_TVC) -> (date:String,dobType:dobStatus ) {
        
        var date = ""
        var month = ""
        var year = ""
        var dobT = dobStatus.properDate
        switch type {
        case .personal:
             date = formClass.tf_pd_Dob_date.text ?? "00"
             month = formClass.tf_pd_Dob_month.text ?? "00"
             year = formClass.tf_pd_Dob_year.text ?? ""
            
            
            
        case .father:
            
             date = formClass.tf_ParentDetail_dob_date.text ?? "00"
             month = formClass.tf_ParentDetail_dob_month.text ?? "00"
             year = formClass.tf_ParentDetail_dob_year.text ?? ""
            
       
        case .mother:
            
             date = formClass.tf_ParentDetail_motherDob_date.text ?? "00"
             month = formClass.tf_ParentDetail_motherDob_month.text ?? "00"
             year = formClass.tf_ParentDetail_motherDob_year.text ?? ""
            
            

        }
        if year == "" || year.count == 0 {
            date = ""
            month = ""
            year = ""
            dobT = .none
            
        }
        
        else{ if date == "00" || date.count == 0{
            date = "01"
            dobT = .monthYear
        }
    
        if month == "00" || month.count == 0{
           month = "01"
            dobT = .yearOnly
        }
        
        if year == "0000" {
            
         year = type == .personal ? "1896" : "1771"
        }
        }
        var strDate = "\(date)-\(month)-\(year)"
        
        if strDate == "--" {
          strDate = ""
        }
       return (strDate,dobType:dobT)
    }
    
    
    func prepareDObForDataBase(type:dobType,formClass:AddNewHouseHoldForm_TVC) -> (date:String,dobType:dobStatus ) {
        
        var date = ""
        var month = ""
        var year = ""
        var dobT = dobStatus.properDate
        switch type {
        case .personal:
             date = formClass.tf_pd_Dob_date.text ?? "00"
             month = formClass.tf_pd_Dob_month.text ?? "00"
             year = formClass.tf_pd_Dob_year.text ?? ""
            
            
            
        case .father:
            
             date = formClass.tf_ParentDetail_dob_date.text ?? "00"
             month = formClass.tf_ParentDetail_dob_month.text ?? "00"
             year = formClass.tf_ParentDetail_dob_year.text ?? ""
            
       
        case .mother:
            
             date = formClass.tf_ParentDetail_motherDob_date.text ?? "00"
             month = formClass.tf_ParentDetail_motherDob_month.text ?? "00"
             year = formClass.tf_ParentDetail_motherDob_year.text ?? ""
            
            

        }
        if year == "" || year.count == 0 {
            date = ""
            month = ""
            year = ""
            dobT = .none
            
        }
        
        else{ if date == "00" || date.count == 0{
            date = "00"
            dobT = .monthYear
        }
    
        if month == "00" || month.count == 0{
           month = "00"
            dobT = .yearOnly
        }
        
        if year == "0000" {
            
         year = type == .personal ? "1896" : "1771"
        }
        }
        var strDate = "\(date)-\(month)-\(year)"
        
        if strDate == "--" {
          strDate = ""
        }
       return (strDate,dobType:dobT)
    }
    
    func updateDobByStatus(strStatus:String,strDate:String) -> String  {
        
        let statusDob = dobStatus.init(rawValue: strStatus)
        let splitedDate = strDate.splitDateString()
        var updatedDatestring = strDate
        var date = splitedDate.date
        var month = splitedDate.month
        let year = splitedDate.year
        
        
        switch statusDob {
        case .properDate:
            
            break
        case .monthYear :
            date = "00"
            break
        case .yearOnly:
            date = "00"
            month = "00"
        break
 
        case .some(.none):
            return ""
            
        case nil:
            break
        }
         updatedDatestring = "\(date)-\(month)-\(year)"
        return updatedDatestring
    }

    
}
