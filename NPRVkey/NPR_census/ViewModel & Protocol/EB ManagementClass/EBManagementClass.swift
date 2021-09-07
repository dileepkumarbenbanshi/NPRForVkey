//
//  EBManagementClass.swift
//  NPR-2020
//
//  Created by Dileep on 29/01/21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation
import CoreData


protocol EBManagememntProtocol {
   
    func ebSavedSuccessFully()
}

class EBManagementClass {
    var delegate:EBManagememntProtocol?
    
   private var arrayEB : [[String:Any]]?
   private var arrayEBModelClass = [EBList_ModelClassRootClass] ()
   private var arayPrevAsignedEBModel = [EB]()
    
    init(ebResponce:[[String:Any]]) {
       arrayEB = ebResponce
    }
    
    func ebDataManagement()  {
       ebListPrepareModelClass()
    }
    
   private func ebListPrepareModelClass()  {
    
    
   let arayEBCurrent = self.arrayEB ?? [[String:Any]] ()
    
        for dictAtIndex in arayEBCurrent {
           
            let ebListModel:EBList_ModelClassRootClass = EBList_ModelClassRootClass.init(fromDictionary: dictAtIndex)
            arrayEBModelClass.append(ebListModel)
        }
        
        ebListDelete()
    }
    
    
   private func ebListDelete()  {
        
        
       let arayPrevAsignedEBModel  = prevEbDataList()
    
        //var arayPrevEbNotExixtNow = [EB]()
        
        for prevModelAtIndex in arayPrevAsignedEBModel {
            
           let arayPrevEbNotExixtNow = arrayEBModelClass.filter({$0.blockno == prevModelAtIndex.eb_block_number  })
            
            if arayPrevEbNotExixtNow.count == 0 {
                prevModelAtIndex.eb_active = "0"
                context.delete(prevModelAtIndex)
                
                do {
                    try context.save()
                } catch  {
                    
                }
            }
        }
        
       
        
        
        
        
    save_EBList()
        
    }
    
    
    
    func save_EBList(){
        
        let arayPrevEbList = prevEbDataList()
        
    var index = 0
        for ebListModel in arrayEBModelClass {
            
           // let ebListModel:EBList_ModelClassRootClass = EBList_ModelClassRootClass.init(fromDictionary: dict )
            let isFindEb = arayPrevEbList.filter({$0.ebTown_code == ebListModel.towncode && $0.eb_block_number == ebListModel.blockno })
            
            if isFindEb.count == 0 {
                
            
            let ebListDBModel = self.openDataBase(entityName: EntityName.eb) as? EB
            ebListDBModel?.eb_active = "0"
            ebListDBModel?.eb_block_number = ebListModel.blockno
            ebListDBModel?.ebState_code = ebListModel.statecode
            ebListDBModel?.ebState_name = ebListModel.statename
            ebListDBModel?.ebState_nameSL = ebListModel.statenamesl
            ebListDBModel?.ebDistrict_code = ebListModel.districtcode
            ebListDBModel?.ebDistrict_name = ebListModel.districtname
            ebListDBModel?.ebDistrict_nameSL = ebListModel.districtnamesl
            ebListDBModel?.ebTown_code = ebListModel.towncode
            
            ebListDBModel?.ebTown_name = ebListModel.townname
            ebListDBModel?.ebTahsil_name = ebListModel.tehsilname
            ebListDBModel?.ebTahsil_code = ebListModel.tehsilcode
            ebListDBModel?.ebTahsil_nameSL = ebListModel.townnamesl
            ebListDBModel?.ebSubEB_code = ebListModel.subebno
            ebListDBModel?.ebEnumerator = ebListModel.enumerator
//            if ebListModel.enumStartedOn.count > 0 {
//                ebListDBModel?.ebEnumStartOn = ebListModel.enumStartedOn
//            }else{
//                ebListDBModel?.ebEnumStartOn = singleton().getCurrentTimeStamp()
//            }
            
            ebListDBModel?.ebWard_code = ebListModel.ward
            ebListDBModel?.enumerator_name = ebListModel.name
            ebListDBModel?.eb_number     = "\(ebListModel.statecode ?? "")\(ebListModel.districtcode ?? "")\(ebListModel.tehsilcode ?? "")\(ebListModel.towncode ?? "")\(ebListModel.ward ?? "")\(ebListModel.blockno ?? "")\(ebListModel.subebno ?? "")"
            do {
                try context.save()
                if index == arrayEBModelClass.count-1 {
                    
       
        }

            } catch {
                print("Eb List Failed saving")

                if index == arrayEBModelClass.count-1 {
                    //delegate?.ebSavedSuccessFully()
       
        }
        }
    }
      index = +1
    }

        delegate?.ebSavedSuccessFully()
}
    
    func openDataBase(entityName:String) -> NSManagedObject {
//               let entity = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context)
               let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
        let managedObject = NSManagedObject(entity: entity!, insertInto: context)
        
        return managedObject
    }
    
    
    
    func prevEbDataList() -> [EB] {
        DataBaseManager().fetchDBData(entityName: EntityName.eb) as! [EB]
    }
}
