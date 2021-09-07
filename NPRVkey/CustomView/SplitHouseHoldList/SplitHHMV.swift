//
//  SplitHHMV.swift
//  NPR-2020
//
//  Created by Dileep on 11/03/21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation
class SplitHHMV {
    var modelHH = NPR_2021hh_Details()
   private var originalHH = NPR_2021hh_Details()
    var arayHHmodelAbleTospli = NPR_2021hh_Details()
    
    
   
    func viewPrepare()  {
        
        
        var arayHHNumbers = originalHH.originalHHSplitInto?.components(separatedBy: ",") ?? [""]
        
        if arayHHNumbers.count > 1 {
        
        arayHHNumbers = arayHHNumbers.sorted(by: {$0 < $1})
        for hhNumber in arayHHNumbers {
            
        DBManagerHousehold().fetchHHDetail(hhTin: hhNumber.hhTin()) { (hhModel) in
            if hhModel != self.modelHH {
                if (hhModel.hh_completed == HHCompletionStatusCode.notStarted ) || (hhModel.hh_completed == HHCompletionStatusCode.inComplete ) {
                   // self.arayHHmodelAbleTospli.append(hhModel)
                }
           
            }
            
            if hhNumber == arayHHNumbers.last{
                //self.tblView.reloadData()
            }
        }
        }
        }
    }
    
   
    func getOrinalHH()  {
        
        if modelHH.houseHoldhNo == modelHH.originalHHNumberSplit {
            self.originalHH = modelHH
        }else{
        DBManagerHousehold().fetchHHDetail(hhTin: modelHH.originalHHNumberSplit?.hhTin() ?? "") { (originalHHModel) in
            self.originalHH = originalHHModel
        }
        }
    }
}
