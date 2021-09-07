//
//  DBManagerHousehold+Extension.swift
//  NPR-2020
//
//  Created by Dileep on 15/01/21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation

extension DBManagerHousehold {
    
    
    func save2021HHData(headDetalApiResponse:NPRData2021ModelClassResult)  {
        let modelDict = headDetalApiResponse
        
        var nprHHData : NPR_2021hh_Details?
        
        let predicateHH = NSPredicate(format: "hh_tin = %@ ", headDetalApiResponse.slnohhd.hhTin())
        DBManagerHousehold().fetchHHList(predicateHH: predicateHH) { (arayHHList) in
           
            if arayHHList.count > 0 {
                
                nprHHData =  arayHHList[0]
            }else{
                nprHHData = DataBaseManager().openDataBase(entityName: EntityName.nprHHStats) as? NPR_2021hh_Details
            }
            
            
           
             
            
            let oldFormatDate = modelDict.dob ?? ""
            
            let strModifiedDate = oldFormatDate.convertDateFormater()
    //        if !util.isEnumerator() {
    //            nprHHData?.is_superVisor_login = true
    //        }
             nprHHData?.block_no = modelDict.blockno ?? ""
            //let hhInt = Int(modelDict.hh ?? "")
            nprHHData?.houseHoldhNo = modelDict.slnohhd.hhNumber()
            print("Found HH NO",modelDict.slnohhd ?? "")
            print("Enter HH NO ", nprHHData?.houseHoldhNo ?? "")
            nprHHData?.houseHoldhNo = modelDict.slnohhd.hhNumber()
            
           // nprHHData?.houseNo = AppFormat.hhFormat.censusHouseNumber()
            nprHHData?.census_hNo = AppFormat.hhFormat.censusHouseNumber()
            nprHHData?.census_hhNo = AppFormat.hhFormat.censusHHNumber()
             //nprHHData?.houseNo = modelDict.hhNoHh ?? ""
             nprHHData?.sub_eb = modelDict.subebno ?? ""
             nprHHData?.hh_tin = modelDict.tin ?? ""
           // nprHHData?.hh_tin_New = modelDict.hh.hhTin()
             nprHHData?.hh_status = "\(modelDict.hhStatus ?? 0)"
            nprHHData?.hh_completed = HHCompletionStatusCode.uploaded
            
            //nprHHData?.slnohhd = modelDict.hh.hhNumber()
            nprHHData?.discrictCode = modelDict.districtcode
            nprHHData?.block_no = modelDict.blockno
            nprHHData?.sub_eb = modelDict.subebno
            nprHHData?.wardID = modelDict.wardid
             nprHHData?.stateCode = modelDict.statecode ?? ""
             nprHHData?.townCode = modelDict.towncode ?? ""
             nprHHData?.tahsil_code = modelDict.tehsilcode ?? ""
             nprHHData?.head_DOB =  strModifiedDate
             nprHHData?.headName = modelDict.name ?? ""
            nprHHData?.headGenderID = "\(modelDict.genderid ?? 0)"
             nprHHData?.isOpen = false
             //nprHHData?.isUpdated
             nprHHData?.wardID = modelDict.wardid ?? ""
            
            nprHHData?.ebNumber     = singleton().selectEBListModel.eb_number//"\(modelDict.statecode ?? "")\(modelDict.districtcode ?? "")\(modelDict.tehsilcode ?? "")\(modelDict.towncode ?? "")\(modelDict.wardid ?? "")\(modelDict.blockno ?? "")\(modelDict.subebno ?? "")"
            
            nprHHData?.hh_tin = nprHHData?.houseHoldhNo?.hhTin()
            
             do {
                 try context.save()
                 
                print("IndexSaved")
                     //Completion(true)
                 
                 } catch {
                                       print(" Household list Failed saving")
                     
             }
            
            
            
            
            
        }
    }
}
