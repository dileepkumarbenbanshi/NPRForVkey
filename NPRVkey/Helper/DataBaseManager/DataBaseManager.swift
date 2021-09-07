//
//  DataBaseManager.swift
//  NPR_census
//
//  Created by Dileep on 27/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let contextMain =  appDelegate.persistentContainer.viewContext
let context :NSManagedObjectContext = appDelegate.persistentContainer.viewContext
// context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

class DataBaseManager: NSObject {
    
    static let dataManager = DataBaseManager()
    
    func openDataBase(entityName:String) -> NSManagedObject {
//               let entity = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context)
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: context)
        let managedObject = NSManagedObject(entity: entity!, insertInto: context)
        
        return managedObject
    }
    
    
    func dataSave()  {
        
        
       
    }
    
    
    
   func fetchDBData(entityName:String) -> [NSManagedObject] {
       
       var fethedData = [NSManagedObject]()
       
       let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
    
       do {
           fethedData = try context.fetch(userFetch) as! [NSManagedObject]
           if fethedData.count > 0 {
               //                shareUserDetail(userDetail: userDetail.last!)
           }
       } catch  {
           
       }
       return fethedData
   }
    
    func fetchDBData(entityName:String,predicate:NSPredicate) -> [NSManagedObject] {
          
          var fethedData = [NSManagedObject]()
          
          let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
          do {
            userFetch.predicate = predicate
              fethedData = try context.fetch(userFetch) as! [NSManagedObject]
              if fethedData.count > 0 {
                  //                shareUserDetail(userDetail: userDetail.last!)
              }
          } catch  {
              
          }
          return fethedData
      }
    
    func dataDelete(dataModel:NSManagedObject)  {
        
    
        
    }
    
    
    func dataUpdate()  {
        
    }
    
    
    func save_EBList(arayEBList:[[String:Any]],Completion:@escaping(Bool) -> Void ){
        
    var index = 0
        for dict in arayEBList {
            let ebListModel:EBList_ModelClassRootClass = EBList_ModelClassRootClass.init(fromDictionary: dict )
            
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
            if ebListModel.enumStartedOn.count > 0 {
                ebListDBModel?.ebEnumStartOn = ebListModel.enumStartedOn
            }else{
                ebListDBModel?.ebEnumStartOn = singleton().getCurrentTimeStamp()
            }
            
            ebListDBModel?.ebWard_code = ebListModel.ward
            ebListDBModel?.enumerator_name = ebListModel.name
            ebListDBModel?.eb_number     = "\(ebListModel.statecode ?? "")\(ebListModel.districtcode ?? "")\(ebListModel.tehsilcode ?? "")\(ebListModel.towncode ?? "")\(ebListModel.ward ?? "")\(ebListModel.blockno ?? "")\(ebListModel.subebno ?? "")"
            do {
                try context.save()
                //if index == arayEBList.count-1 {
        Completion(true)
      //  }

            } catch {
                print("Eb List Failed saving")

                if index == arayEBList.count-1 {
        Completion(true)
        }
        }
      index = +1
    }

}
}
