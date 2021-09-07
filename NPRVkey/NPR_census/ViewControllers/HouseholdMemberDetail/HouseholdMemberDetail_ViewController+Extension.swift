//
//  HouseholdMemberDetail_ViewController+Extension.swift
//  NPR-2020
//
//  Created by Dileep on 10/12/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
extension HouseholdMemberDetail_ViewController {
    /////////////////
    // MARK:Others
    /////////////////////
    func checkAndOpenSignatureView()  {
        // Member Count for check skip HH
        var memberCount = 0
        
        if hhModel.hh_completed == HHCompletionStatusCode.completed  {
            
            DBManagerMemberDetail().fetchMembers_currentalyLeaveinHH(modelSelectedHH: hhModel, Completion: { (araMemberLiveInHH) in
                
                memberCount = araMemberLiveInHH.count
            })
        }
        if hhModel.respondentName?.count ?? 0 ==  0 && (hhModel.hh_completed == HHCompletionStatusCode.inComplete || (hhModel.hh_completed == HHCompletionStatusCode.completed && memberCount > 0 )){
        
            alertView.showAlertWithSingleButton( title: LanguageModal.langObj.signature_required, message: LanguageModal.langObj.press_ok_to_take_signature)
        
        }else{
            if isCameFromEditPage {
                self.navigationController?.popViewController(animated: true)
            }else{
            self.popBackToController(toControllerType: MainViewController.self)
            }
           // self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    func navigateToRespondentSignature()  {
       
        guard  let vc = self.storyboard?.instantiateViewController(withIdentifier: "EnumeratorSignatureViewController") as? EnumeratorSignatureViewController else {
            return
        }
        vc.isRespondentSign = true
        vc.modelHHRespondent = hhModel
        self.navigationController?.pushViewController(vc , animated: true)
        
    }
    
    @objc func btnDelete_action(_ sender: UIButton) {
        
        let buttonPosition = sender.convert(CGPoint.zero, to: self.tbl_houseoldList)
            let indexPath = self.tbl_houseoldList.indexPathForRow(at: buttonPosition)!
        selectedMemberToDelete = arayMembersModel[sender.tag]
        let cell = tbl_houseoldList.cellForRow(at: indexPath) as? HouseHoldDetail_TVC
        isTapedDeleteButton = true
        isTapedShiftMember = false
        if #available(iOS 13.0, *) {
            alertForDeleteMember (indexPath: indexPath)
        } else {
            // Fallback on earlier versions
        } 
        
        
//        buttonStatusChange = sender
//        btnTaped = sender
//        isTapedDeleteButton = true
//        tapedButtonTypeAlert = .deleteBuuton
//        alertView.showAlert( title: AppMessages().areYouSure, message: "\(English.IncompleHHOrViewEditPage().deletMemberAlert)\(selectedMemberToDelete.name ?? "")")
        
    }
    
    func deleteMember()  {
        
        
        context.delete(selectedMemberToDelete)
        do {
            try context.save()
        } catch  {
            
        }
        
        DBManagerHousehold().updateHHStatus_dependONMember(houseHoldModel: hhModel) { (isUpdated) in
            self.isSelectedCell = false
            self.fetchHHMembers()
        }
        
        
    }
    
    func alertPrepare(message:String)  {
       
        
    }
    /////////////////
    // MARK:Shift open
    /////////////////////
    func openShiftMemberView()  {
        
        let objShiftMemberHHList = Bundle.main.loadNibNamed("SplitViewHouseHoldList", owner: self, options: nil)?.first as? SplitViewHouseHoldList
        objShiftMemberHHList?.delegate = self
        
        objShiftMemberHHList?.loadHouseHoldList(hhModel: hhModel, memberModel: arayMembersModel[btnTaped.tag], vc: self)

        
    }
}

// MARK:Delegates Head Change
extension HouseholdMemberDetail_ViewController:HeadChangeDelegate {
    func headChanged() {
        if isTapedDeleteButton {
            deleteMember()
        }else{
            self.statusChangeAfterYes(sender: buttonStatusChange)
            fetchHHMembers()
        }
        
        
    }
    
    func tapedCancelHeadChange() {
        
    }
}

// MARK:Alert Delegates

extension HouseholdMemberDetail_ViewController:AlertViewDelegate {
    
    func alertTapedYes() {
        if isTapedShiftMember {
            openShiftMemberView()
        }
       else if isTapedDeleteButton {
        
        openHeaderList()
        }else{
            statusChangeAfterYes(sender: buttonStatusChange)
        }
       
        
        isChangeMemberStatus = true
        
        fetchHHMembers()
        
    }
    
    func alertViewSingelButtonTapedYes(){
        navigateToRespondentSignature()
    }
    
    func statusChangeAfterYes(sender:UIButton)  {
    
        let cell = cellTapeStatusButtun(sender: sender)
        
    
     cell.btnAvailable.isSelected = false
     cell.btnMoved.isSelected = false
     cell.btnDied.isSelected = false
        var image = UIImage.init(named: "")
        cell.stackViewEdit.isHidden = true
         var memberStatusCode = MemberLivingStatusCode.notStarted
        
        switch sender.tag {
        case 10:
            
            cell.btnAvailable.isSelected = true
            
             //cell?.btnEdit.isSelected = true
            image = UIImage.init(named: "Pencil")
           
            memberStatusCode  = MemberLivingStatusCode.available
            cell.stackViewEdit.isHidden = false
            return
            
        case 11:
            cell.btnMoved.isSelected = true
            memberStatusCode  = MemberLivingStatusCode.migratedOut
            //cell?.btnEdit.isSelected = false
            cell.stackViewEdit.isHidden = true
            
            break
            case 12:
            cell.btnDied.isSelected = true
            memberStatusCode  = MemberLivingStatusCode.dead
            
            //cell?.btnEdit.isSelected = false
            cell.stackViewEdit.isHidden = true
            break
            
        default:
            cell.btnDied.isSelected = true
            memberStatusCode  = MemberLivingStatusCode.dead
            //cell?.btnEdit.isSelected = false
            cell.stackViewEdit.isHidden = true
           
            break
        }
        if arayMembersModel[selectedIndexPath.section].rel_code == "01" {
            
            //openHeaderList()
            openHeadSelectionView()
            return
        }
        
        memberStatusChangeInDB(status: memberStatusCode)
        cell.lblMemberStatusValue.text = MemberLivingStatusCode.dcodeDetail(memberStatusCode)()
    }
    
    func openHeadSelectionView()  {
       
        
        let objmembersListForHead = Bundle.main.loadNibNamed("HHMemberListForHeadSelection", owner: self, options: nil)?.first as? HHMemberListForHeadSelection
        objmembersListForHead?.delegate = self
        
     objmembersListForHead?.loadHeadChangeList(hhModel: hhModel, vc: self)
    }
    func openHeaderList()  {
        if selectedMemberToDelete.rel_code == "01" {
            
        openHeadSelectionView()
        }else{
            deleteMember()
        }
    }
    func memberStatusChangeInDB(status:MemberLivingStatusCode)  {
        
        isChangeMemberStatus = true
        arayMembersModel[selectedIndexPath.section].memberStatus =
        status.rawValue
       
        arayMembersModel[selectedIndexPath.section].member_completionStatus = MemberCompletionStatusCode.completed
        arayMembersModel[selectedIndexPath.section].isUpdatedMemberStatus = true
        
        do{
            try context.save()
        }
        catch{
            
        }
        
        hhModel.respondentName = ""
        
        do{
            try context.save()
        }
        catch{
            
        }
        
        DBManagerHousehold().updateHHStatus_dependONMember(houseHoldModel: hhModel) { (isUpdated) in
        }
    }
    
    
    func updateSkipedHHMembersStatus()  {
       
        
    }
    
    func deleteMemberFromHH()  {
        
        let memberModel = arayMembersModel[selectedIndexPath.section]
        
        context.delete(memberModel)
        do {
            try context.save()
        } catch  {
            
        }
        
        fetchHHMembers()
        
        openHeaderList()
    }
    
    
    func cellTapeStatusButtun(sender:UIButton) -> HouseHoldDetail_TVC {
        
        let buttonPosition = sender.convert(CGPoint.zero, to: self.tbl_houseoldList)
        let indexPath = self.tbl_houseoldList.indexPathForRow(at: buttonPosition)!
        
        guard let cell = tbl_houseoldList.cellForRow(at: indexPath) as? HouseHoldDetail_TVC else { return HouseHoldDetail_TVC() }
        
        return cell
    }
    
    func alertViewTapedNo()  {
        if !isTapedDeleteButton {
            let buttonPosition = buttonStatusChange.convert(CGPoint.zero, to: self.tbl_houseoldList)
            let indexPath = self.tbl_houseoldList.indexPathForRow(at: buttonPosition)!
            tbl_houseoldList.reloadSections([indexPath.section], with: .automatic)
        }
        
    }
}

//MARK:Shift button Delegate
extension HouseholdMemberDetail_ViewController:shiftButtonDelegate {
    func shiftButtonTaped(sender: UIButton) {
        btnTaped = sender
        tapedButtonTypeAlert = .shift
        
        isTapedDeleteButton = false
        isTapedShiftMember = true
        alertView.showAlert( title: AppMessages.areYouSure, message: "\(LanguageModal.langObj.to_shift) \(arayMembersModel[sender.tag].name ?? "")")
    }
    
   
}

// MARK:shift Section

//MARK:Shift selected HH Delegate
extension HouseholdMemberDetail_ViewController:selectouseHoldShiftMember {
    
    func shiftWillHide(memberModel:NPR2021MemberDetails)->Bool  {
        
        if hhModel.is_Splited {
            if MemberLivingStatusCode(rawValue: memberModel.memberStatus ?? "") == MemberLivingStatusCode.newMember {
              return true
            }
            else if (hhModel.hh_completed == HHCompletionStatusCode.completed) || (hhModel.hh_completed == HHCompletionStatusCode.uploaded) {
                return true
            }
            var arayTotalAvailableMembers = [NPR2021MemberDetails]()
            
            DBManagerMemberDetail().fetchOldMembers_currentalyLiveinHH(modelSelectedHH: hhModel) { (araMemberModel) in
                arayTotalAvailableMembers = araMemberModel
                
            }
            if arayTotalAvailableMembers.count == 1 {
               return true
            }else{
                return false
            }
           
        }
        return true
    }
    
    func memberShiftedSuccessfully() {
        indexPathSelecNone()
        isSelectedCell = false
        fetchHHMembers()
    }
    
    func cancelButtonTaped()  {
        isTapedShiftMember = false
        btnTaped = UIButton()
    }
}

//MARK:Shift selected HH Delegate
extension HouseholdMemberDetail_ViewController:UITextFieldDelegate {
   
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        var txtAfterUpdate = ""
        
        if let text = textField.text as NSString? {
                 txtAfterUpdate = text.replacingCharacters(in: range, with: string)
               
            }
        return txtAfterUpdate.count < 3
    }
}
