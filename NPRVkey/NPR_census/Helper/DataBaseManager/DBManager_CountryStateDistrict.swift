//
//  DBManager_CountryStateDistrict.swift
//  NPR_census
//
//  Created by Dileep on 16/09/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation


class DBManager_CountryStateDistrict {
    
    
    func saveContryList(arayCountryList:[[String:Any]],Completion:@escaping(Bool) -> Void )  {

        var index = 0
        DispatchQueue.main.async {
            
        
        
        for dictCountry in arayCountryList {
            let contryDB = DataBaseManager().openDataBase(entityName: EntityName.country) as? Country
            let modelCountryModel = CountryListRootClass.init(fromDictionary: dictCountry)
            contryDB?.id = modelCountryModel.id
            contryDB?.name = modelCountryModel.country
            contryDB?.code = modelCountryModel.id
            
            do {
                
                try context.save()
                index = index+1
                if index == arayCountryList.count {
                    Completion(true)
                }
                
            } catch  {
                
            }
            
            
        }
        }
        
    }
    
    func saveStateList(arayStateList:[[String:Any]],Completion:@escaping(Bool) -> Void )  {

        var index = 0
        DispatchQueue.main.async {
            
        
        for dictCountry in arayStateList {
            let contryDB = DataBaseManager().openDataBase(entityName: EntityName.state) as? State
            let modelState = StateListRootClass.init(fromDictionary: dictCountry)
            
            contryDB?.id = modelState.statecode
            contryDB?.name = modelState.statename
            contryDB?.code = modelState.statecode
            
            do {
                try context.save()
                index = index+1
                if index == arayStateList.count {
                    Completion(true)
                }
                
            } catch  {
                
            }
            
            
        }
        }
        
    }
    
    
    func saveDistrictList(arayDistrictList:[[String:Any]],Completion:@escaping(Bool) -> Void )  {
        DispatchQueue.main.async {
            
        
        var index = 0
        
        for dictDistrict in arayDistrictList {
            let districtDB = DataBaseManager().openDataBase(entityName: EntityName.district) as? District
            let modelState = DistrictListRootClass.init(fromDictionary: dictDistrict)
            districtDB?.stateCode = modelState.statecode
            districtDB?.id = modelState.districtcode
            districtDB?.name = modelState.districtname
           
            do {
                try context.save()
                index = index+1
                if index == arayDistrictList.count {
                    Completion(true)
                }
                
            } catch  {
                
            }
            
            
        }
        }
        
    }
    
    func saveTahsilList(arayDistrictList:[[String:Any]],Completion:@escaping(Bool) -> Void )  {

        var index = 0
        DispatchQueue.main.async {
            
        
        for dictDistrict in arayDistrictList {
            let tahsilDB = DataBaseManager().openDataBase(entityName: EntityName.tahsil) as? Tahsil
            let modelTahsil = TahsilListRootClass.init(fromDictionary: dictDistrict)
            
            tahsilDB?.id = modelTahsil.tehsilcode
            tahsilDB?.name = modelTahsil.tehsilname
            tahsilDB?.state_code = modelTahsil.statecode
            tahsilDB?.district_code = modelTahsil.districtcode
            do {
                try context.save()
                index = index+1
                if index == arayDistrictList.count {
                    Completion(true)
                }
                
            } catch  {
                
            }
            
            
        }
        
    }
    }
    
    func getCountryCode(countryName:String) -> String {
        if countryName.isEmpty   {
            return ""
        }
        let predicate = NSPredicate(format: "name = %@",countryName )
        
        guard let countryCodeList:[Country] = DataBaseManager().fetchDBData(entityName: EntityName.country, predicate: predicate) as? [Country] else {
            return ""
        }
        if countryCodeList.count > 0 {
            
            let model = countryCodeList[0]
            
            return model.id ?? ""
        }
        
      return ""
    }
    
    func getStateCode(stateName:String) -> String {
        if stateName.isEmpty   {
            return ""
        }
        
        let predicate = NSPredicate(format: "name = %@",stateName )
        
        guard let countryCodeList = DataBaseManager().fetchDBData(entityName: EntityName.state, predicate: predicate) as? [State] else {
            return ""
        }
        if countryCodeList.count  > 0 {
            
            let model = countryCodeList[0]
            
            return model.id ?? ""
        }
        return ""
        
        
    }
    
    func getDistrictCode(stateCode:String,districtName:String) -> String {
        
        if stateCode.isEmpty || districtName.isEmpty  {
            return ""
        }
        
        let predicate = NSPredicate(format: "name = %@ AND stateCode = %@ ",districtName,stateCode )
        
        guard let districtCodeList = DataBaseManager().fetchDBData(entityName: EntityName.district, predicate: predicate) as? [District] else {
            return ""
        }
        
        if districtCodeList.count > 0 {
            
            let model = districtCodeList[0]
            
            return model.id ?? ""
        }
        
      return ""
    }
    
    func getSubDistrictCode(districtCode:String,tahsilName:String) -> String {
        if districtCode.isEmpty || tahsilName.isEmpty  {
            return ""
        }
        
        let predicate = NSPredicate(format: "name = %@ AND state_code = %@ ",tahsilName,districtCode )
        
        guard let districtCodeList = DataBaseManager().fetchDBData(entityName: EntityName.tahsil, predicate: predicate) as? [Tahsil] else {
            return ""
        }
        if districtCodeList.count > 0 {
            
            let model = districtCodeList[0]
            
            return model.name ?? ""
        }
        return ""
       
        
    }
    
    func getSubDistrictName(stateCode:String,tahsilCode:String) -> String {
        if stateCode.isEmpty || tahsilCode.isEmpty  {
            return ""
        }
        
        let predicate = NSPredicate(format: "id = %@ AND state_code = %@ ",tahsilCode,stateCode )
        
        guard let districtCodeList = DataBaseManager().fetchDBData(entityName: EntityName.tahsil, predicate: predicate) as? [Tahsil] else {
            return ""
        }
        if districtCodeList.count > 0 {
            
            let model = districtCodeList[0]
            
            return model.name ?? ""
        }
        return ""
       
        
    }
    
    func getDistrictName(stateCode:String,districtCode:String) -> String {
        
        if stateCode.isEmpty || districtCode.isEmpty  {
            return ""
        }
        let predicate = NSPredicate(format: "id = %@ AND stateCode = %@ ",districtCode,stateCode )
        
        guard let districtCodeList = DataBaseManager().fetchDBData(entityName: EntityName.district, predicate: predicate) as? [District] else {
            return ""
        }
        if districtCodeList.count > 0 {
            
            let model = districtCodeList[0]
            
            return model.name ?? ""
        }
        return ""
       
        
    }
    
    func getStateName(stateCode:String) -> String {
        
        if stateCode.isEmpty   {
            return ""
        }
        
        let predicate = NSPredicate(format: "id = %@ ",stateCode )
        
        guard let districtCodeList = DataBaseManager().fetchDBData(entityName: EntityName.state, predicate: predicate) as? [State] else {
            return ""
        }
        if districtCodeList.count > 0 {
            
            let model = districtCodeList[0]
            
            return model.name ?? ""
        }
        return ""
       
        
    }
    
    func getCountryName(countryCode:String) -> String {
        
        if countryCode.isEmpty  {
            return ""
        }
        
        let predicate = NSPredicate(format: "id = %@ ",countryCode )
        
        guard let districtCodeList = DataBaseManager().fetchDBData(entityName: EntityName.country, predicate: predicate) as? [Country] else {
            return ""
        }
        if districtCodeList.count > 0 {
            
            let model = districtCodeList[0]
            
            return model.name ?? ""
        }
        return ""
       
        
    }
    
}
