//
//  UnHabitedVM.swift
//  NPR-2020
//
//  Created by Dileep on 10/03/21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation

protocol UnHabitedVMDelegate {
    func saveExpectedHH_number()
    func saveExpectedHHNumberZero()
    
    
   
}
class UnHabitedVM {
    
    
    
    var enterExpectedHH = ""
   private let selectedEb = singleton().selectEBListModel
    private let expectedHH = Int(singleton().selectEBListModel.expectedHH_number ?? "") ?? 0
    
   private let isUnhavited = singleton().selectEBListModel.is_InHavitedEB
    
    private var expectHHPoopNotOpenYet:Bool {
        return (selectedEb.ebInHabitedPopUpCount < 1 && !selectedEb.is_eb_uploaded)
        
    }
    
    var uiEbAbleToUpload:Bool {
     
       return ( hhCountInSelectedHLB() == 0 && expectedHH == 0 )
      
    }
    
    var isInhavitedAndUploaded:Bool {
       return (hhCountInSelectedHLB() == 0 && selectedEb.is_eb_uploaded && expectedHH == 0)
    }
    
    var isCompleteUnHabitedEb :Bool {
        return checkEBCompletion()
    }
    
    var expHHPopupInInconcompleteHH:Bool {
        let expectedHHCount = expectedHH
        
        return (hhCountInSelectedHLB() == 0 && isUnhavited && expectedHHCount < 1 && !selectedEb.is_eb_uploaded)
        
    }
    
    var shouldOpenExpHHPopup:Bool {
       
        return (hhCountInSelectedHLB() == 0 && singleton().selectEBListModel.ebInHabitedPopUpCount < 1 && !selectedEb.is_eb_uploaded && util.isEnumerator() )
    }
    
    var isVlidEntryExpHH:Bool {
        
        let expHHCount = Int(enterExpectedHH) ?? -1
        
       return expHHCount >= hhCountInSelectedHLB()
    }
    
    func saveExpectedHH()  {
        if isVlidEntryExpHH {
            let count = singleton().selectEBListModel.ebInHabitedPopUpCount
            singleton().selectEBListModel.expectedHH_number = enterExpectedHH
            singleton().selectEBListModel.ebInHabitedPopUpCount = count+1
                
                do {
                    try context.save()
                   
                } catch  {
                    
                }
        }
        
    }
  ///////////////////////////////
    // MARK: Private Functions
///////////////////////
    func checkEBCompletion()-> Bool  {
       
        
        let predicateHH = NSPredicate(format: "ebNumber = %@",singleton().selectEBListModel.eb_number!)
        guard let arayTotalHouseHoldINEB = DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicateHH) as? [NPR_2021hh_Details] else {
            return false
        }

        let expectHhCount = Float(singleton().selectEBListModel.expectedHH_number ?? "0") ?? 0
        
        if expectHhCount == 0 {
            return true
        }
      let  arayCopletedUploadedHouseHold =  arayTotalHouseHoldINEB.filter({$0.hh_completed == HHCompletionStatusCode.uploaded })

        if arayCopletedUploadedHouseHold.count == 0 {
            return false
        }
        
    let colpetedHHRatio = Float(arayCopletedUploadedHouseHold.count)/expectHhCount

    if colpetedHHRatio > 0.95  {

        return true
            }
        return false
        
    }
    
    
    private func hhCountInSelectedHLB () -> Int{
        
        let predicateHH = NSPredicate(format: "ebNumber = %@",singleton().selectEBListModel.eb_number!)
        guard let arayTotalHouseHoldINEB = DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicateHH) as? [NPR_2021hh_Details] else {
            return 0
        }
        return arayTotalHouseHoldINEB.count
    }
}
