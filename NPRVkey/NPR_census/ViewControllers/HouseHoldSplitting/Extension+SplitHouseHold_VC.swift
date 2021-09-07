//
//  Extension+SplitHouseHold_VC.swift
//  NPR_census
//
//  Created by Dileep on 30/09/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

extension SplitHouseHold_VC {
    
    func createNewHouseHold(Completion:@escaping(Bool) -> Void)  {
       
        strNewHouseNumber = DBManagerHousehold().getNewHouseNumber()
         strNewHH = DBManagerHousehold().getNewHouseHoldNumber()
        
        DBManagerHousehold().savedNewSplitHH(hhModel: hhModel, strHHID: strNewHH, strHN: strNewHouseNumber, araySelectedMember: araySplitedMembers) { (createdNewHH) in
            
            if createdNewHH {
            self.insertMembersNewHH { (saved) in
                Completion(true)
            }
            }
        }
       
    }
    

    func insertMembersNewHH(Completion:@escaping(Bool) -> Void)  {
        var memberIndex = 0
        
        for memberModel in araySplitedMembers {
            memberIndex = memberIndex+1
        
        var newMeberModel = DataBaseManager().openDataBase(entityName: EntityName.npr2021Data) as? NPR2021MemberDetails
        
            newMeberModel = memberModel
            
            newMeberModel?.hh_Number = strNewHH.hhNumber()
            newMeberModel?.censusHouse_number = memberModel.censusHouse_number
            newMeberModel?.censusHH_number = memberModel.censusHH_number
            newMeberModel?.hh_tin = strNewHH.hhTin()//"\(singleton().selectEBListModel.eb_number ?? "")\(strNewHH)"
            newMeberModel?.hh_tin = strNewHH.hhTin()//"\(singleton().selectEBListModel.eb_number ?? "")\(strNewHH)"
            memberModel.sloMember = String(format: AppFormat.member_sr_Format, memberIndex )
            if memberModel == araySplitedMembers[0] {
                let arayRelation = English().relationship_to_head_male()
               let model = PickerViewCommon_model.init(model: arayRelation[0])
                
                memberModel.relName = model.name
                memberModel.rel_code = model.id
            }
            else{
                memberModel.relName = ""
                memberModel.rel_code = ""
                
            }
            memberModel.member_completionStatus = MemberCompletionStatusCode.notStarted
            do {
                try context.save()
            } catch  {
                
            }
            
            if memberModel == araySplitedMembers.last {
                Completion(true)
               
                
            }
            
        }
        
        
    }
    
    
    func updateHHAfterSplit(Completion:@escaping(Bool) -> Void)   {
        updateOriginal()
        
        hhModel.is_Splited = true
        if let isSplitedAllReady = hhModel.splitedTo  {
            print(isSplitedAllReady)
            hhModel.splitedFrom = "\(hhModel.splitedTo ?? "") , \(strNewHH )"
        }else
        {
            hhModel.splitedFrom = strNewHH
//            hhModel.hh_tin_New = "\(singleton().selectEBListModel.eb_number ?? "")\(strNewHH )"
//            hhModel.hh_tin =  "\(singleton().selectEBListModel.eb_number ?? "")\(strNewHH )"
            
        }
       
        do {
            try context.save()
 
            
        } catch  {
            
            
        }
        self.newHHDetail(hhNumber: self.strNewHH)
        self.updateHHMemberAfterSplited { (inserted) in
            
           Completion(true)
            
        }
    }
    
    
    
    func updateHHMemberAfterSplited(Completion:@escaping(Bool) -> Void)   {
        var memberSloNO = 0
        //Filter Remain Member IN Orginal HH
        let arayRemainMembers = arayMemberModel.filter({$0.hh_tin == hhModel.hh_tin})
        let headDetail = arayRemainMembers.filter({$0.rel_code == "01"})
       
        updateSplitedHH_basedOnMemberStatus(houseHoldModel: hhModel)
            
            for modelMember in arayRemainMembers {
                memberSloNO = memberSloNO+1
                
                if headDetail.count == 0 {
                if modelMember == arayRemainMembers.first {
                 
                    let arayRelation = English().relationship_to_head_male()
                   let model = PickerViewCommon_model.init(model: arayRelation[0])
                    modelMember.rel_code = model.id
                    modelMember.relName = model.name
                    
                }
                else{
                    
                    modelMember.rel_code = ""
                    modelMember.relName = ""
                }
                }
                
                
                modelMember.sloMember = String(format: AppFormat.member_sr_Format, memberSloNO)
                
                do {
                    try context.save()
                } catch  {
                    
                }
                
                if modelMember == arayRemainMembers.last {
                    
                    Completion(true)
                    
                }
         
        }
        
       
       // updateSplitedHH_basedOnMemberStatus(houseHoldModel: )
        
        Completion(true)
        
        
    }
    
    func newHHDetail(hhNumber:String)  {
        
        
        DBManagerHousehold().fetchHHDetail(hhTin: hhNumber.hhTin()) { (hhDetailModel) in
            DBManagerHousehold().updateHHStatus_dependONMember(houseHoldModel: hhDetailModel) { (isUpdated) in
                
            }
        }
    }
    
    func updateSplitedHH_basedOnMemberStatus(houseHoldModel:NPR_2021hh_Details)  {
        
        DBManagerHousehold().updateHHStatus_dependONMember(houseHoldModel: houseHoldModel) { (isUpdated) in
            
        }
    }
    
 
    
    func updateOriginal()   {
       // let hh = hhModel.houseHoldhNo  == hhModel.originalHHNumberSplit ? hhModel.houseHoldhNo : hhModel.originalHHNumberSplit
        var originalHHTin = ""
        
        if let spliHHTin = hhModel.originalHHNumberSplit?.hhTin() {
            originalHHTin = spliHHTin
        }else{
            originalHHTin = hhModel.hh_tin ?? "".hhTin()
        }
        DBManagerHousehold().fetchHHDetail(hhTin: originalHHTin ) { (originalHHModel) in
            
           let oginialHHNumber = originalHHModel.originalHHSplitInto?.count == 0 ? self.strNewHH : "\(originalHHModel.originalHHSplitInto ?? ""),\(self.strNewHH)"
            
            originalHHModel.originalHHSplitInto = oginialHHNumber
            do {
                try context.save()
            } catch  {
                
            }
        }
        
        
    }
}

extension SplitHouseHold_VC:AlertViewDelegate {
    func alertTapedYes() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func alertViewSingelButtonTapedYes()  {
        self.navigationController?.popViewController(animated: true)
    }
}
