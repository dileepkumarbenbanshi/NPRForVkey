//
//  FormDateMangement.swift
//  NPR-2020
//
//  Created by Dileep on 28/01/21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation

class FormDateMangement {
    
    
    func dateFormat(type:dobType,formClass:AddNewHouseHoldForm_TVC) -> String {
        
        var date = ""
        var month = ""
        var year = ""
        
        
        
        switch type {
        case .personal:
             date = formClass.tf_pd_Dob_date.text ?? "00"
             month = formClass.tf_pd_Dob_month.text ?? "00"
             year = formClass.tf_pd_Dob_year.text ?? "0000"
            
           
        
        case .father:
            
             date = formClass.tf_ParentDetail_dob_date.text ?? "00"
             month = formClass.tf_ParentDetail_dob_month.text ?? "00"
             year = formClass.tf_ParentDetail_dob_year.text ?? "0000"
            
           
       
        case .mother:
            
             date = formClass.tf_ParentDetail_motherDob_date.text ?? "00"
             month = formClass.tf_ParentDetail_motherDob_month.text ?? "00"
             year = formClass.tf_ParentDetail_motherDob_year.text ?? "0000"

        }
        
        var strDate = "\(date)-\(month)-\(year)"
        
        if strDate == "--" {
          strDate = ""
        }
      return strDate
    }
    
    
    
}
