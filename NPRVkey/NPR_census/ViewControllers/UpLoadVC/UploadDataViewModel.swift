//
//  UploadDataViewModel.swift
//  NPR-2020
//
//  Created by Dileep on 10/03/21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation

protocol EBCompletionDelegate {
    func ebUpdated()
}
class UploadDataViewModel  {
    var delegate:EBCompletionDelegate?
    
    var isEBNearToComplete: Bool {
    return isEBToComplete()
        
    }
    
    var isValidSatrtDate :Bool {
        
        let dateStart = date(strDate: singleton().selectEBListModel.ebStartDate ?? "")
        
        return dateStart <= Date()

        
    }
    
    var isValidEndDate:Bool {
        
        let dateEnd = date(strDate: singleton().selectEBListModel.ebEndDate ?? "")
        return dateEnd >= Date()
    }
    
    func date(strDate:String)-> Date  {
        
       let dateComponent = strDate.components(separatedBy: "T")
        
        return dateComponent[0].stringtoDate(format: .yearMonthDate) ?? Date()
    }
    var isValidStartAndEndDate:Bool {
        var strAlertMessage = ""
        
        if isValidEndDate && isValidSatrtDate {
            return true
        }
        if !isValidEndDate {
            strAlertMessage = "This HLB not Started yet "
        }else if !isValidEndDate {
            strAlertMessage = "This HLB end date is over "
        }
        AlertView().alertWithoutButton( message: strAlertMessage)
        return false
    }
    
    private func checkEbCompletionStatus()->Bool {
        
        let predicateHH = NSPredicate(format: "ebNumber = %@",singleton().selectEBListModel.eb_number!)
        guard let arayTotalHouseHoldINEB = DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicateHH) as? [NPR_2021hh_Details] else {
            
            return false
        }

       let  arayCopletedUploadedHouseHold =  arayTotalHouseHoldINEB.filter({$0.hh_completed == HHCompletionStatusCode.uploaded })
        if arayCopletedUploadedHouseHold.count > 0 {
       let colpetedHHRatio = Float(arayCopletedUploadedHouseHold.count/arayTotalHouseHoldINEB.count)

    if colpetedHHRatio > 0.95  {

        return true
            }
        }
        return false
        
    }
        
    
   private func isEBToComplete()->Bool  {
    
    let isComlete = singleton().selectEBListModel.is_InHavitedEB ? UnHabitedVM().isCompleteUnHabitedEb : checkEbCompletionStatus()
    return isComlete
  }
    
    ////////////////////////
    //MARK:EB Completion API
    ///////////////////////
    
    func ebCompletionAPI()  {
        
        let dictParam = [Param_Key.StateCode: singleton().selectEBListModel.ebState_code ?? "",
                         Param_Key.DistrictCode: singleton().selectEBListModel.ebDistrict_code ?? "",
                         Param_Key.TehsilCode: singleton().selectEBListModel.ebTahsil_code ?? "",
                         Param_Key.TownCode: singleton().selectEBListModel.ebTown_code ?? "",
                         Param_Key.WardID: singleton().selectEBListModel.ebWard_code ?? "",
                         Param_Key.BlockNo: singleton().selectEBListModel.eb_block_number ?? "",
                         Param_Key.SubEBNo: singleton().selectEBListModel.ebSubEB_code ?? "",
                         Param_Key.NPREnumCompletion: singleton().getCurrentTimeStamp()]
        APIManager().postEBCompletation(params: dictParam) { (done, result, error) in
          
//            guard let aray = result as? [[String:Any]] else {
//                          return
//                       }
            self.updateEbData()
                    
        }
    }
    
    func updateEbData()  {
        singleton().selectEBListModel.is_eb_uploaded = true
        singleton().selectEBListModel.is_eb_downloaded = true
        
        
        do {
            try context.save()
            delegate?.ebUpdated()
        } catch  {
            
        }
    }
}
