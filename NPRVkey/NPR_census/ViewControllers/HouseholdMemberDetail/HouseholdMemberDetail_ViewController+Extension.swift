//
//  HouseholdMemberDetail_ViewController+Extension.swift
//  NPR-2020
//
//  Created by Dileep on 10/12/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
extension HouseholdMemberDetail_ViewController {
    
    func navigateToRespondentSignature()  {
       
        guard  let vc = self.storyboard?.instantiateViewController(withIdentifier: "EnumeratorSignatureViewController") as? EnumeratorSignatureViewController else {
            return
        }
        vc.isRespondentSign = true
        vc.modelHHRespondent = hhModel
        self.navigationController?.pushViewController(vc , animated: true)
        
    }
    
    @objc func btnDelete_action(_ sender: UIButton) {
    
        
        let modelMemberDetail = arayMembersModel[sender.tag]
        
        let alertView = AlertView()
        
        alertView.delegate = self
        isTapedDeleteButton = true
        
        alertView.showAlert(vc: self, title: AppMessages().areYouSure, message: "\(English.IncompleHHOrViewEditPage().deletMemberAlert)\(modelMemberDetail.name ?? "")")
        
    }
}


extension HouseholdMemberDetail_ViewController:HeadChangeDelegate {
    func headChanged() {
        self.statusChangeAfterYes(sender: buttonStatusChange)
        fetchHHMembers()
    }
    
    
}



extension HouseholdMemberDetail_ViewController:AlertViewDelegate {
    
    func alertTapedYes() {
        if isTapedDeleteButton {
            
        }else{
            statusChangeAfterYes(sender: buttonStatusChange)
        }
       
        
        isChangeMemberStatus = true
        
    }
    
    func alertViewTapedNo()  {
        
        let buttonPosition = buttonStatusChange.convert(CGPoint.zero, to: self.tbl_houseoldList)
        let indexPath = self.tbl_houseoldList.indexPathForRow(at: buttonPosition)!
        
        tbl_houseoldList.reloadSections([indexPath.section], with: .automatic)
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
            let objmembersListForHead = Bundle.main.loadNibNamed("HHMemberListForHeadSelection", owner: self, options: nil)?.first as? HHMemberListForHeadSelection
            objmembersListForHead?.delegate = self
            
         objmembersListForHead?.loadHeadChangeList(hhModel: hhModel, vc: self)
            
            
            return
        }
        
        memberStatusChangeInDB(status: memberStatusCode)
        //cell?.btnEdit.setImage(image, for: .normal)
    }
    
    
    func memberStatusChangeInDB(status:MemberLivingStatusCode)  {
        
        
        arayMembersModel[selectedIndexPath.section].memberStatus =
        status.rawValue
        arayMembersModel[selectedIndexPath.section].member_completionStatus = MemberCompletionStatusCode.completed
        
        do{
            try context.save()
        }
        catch{
            
        }
        
        
    }
    
    
    
    func deleteMemberFromHH()  {
        
        let memberModel = arayMembersModel[selectedIndexPath.section]
        
        context.delete(memberModel)
        do {
            try context.save()
        } catch  {
            
        }
        
        fetchHHMembers()
    }
    
    
    func cellTapeStatusButtun(sender:UIButton) -> HouseHoldDetail_TVC {
        
        let buttonPosition = sender.convert(CGPoint.zero, to: self.tbl_houseoldList)
        let indexPath = self.tbl_houseoldList.indexPathForRow(at: buttonPosition)!
        
        guard let cell = tbl_houseoldList.cellForRow(at: indexPath) as? HouseHoldDetail_TVC else { return HouseHoldDetail_TVC() }
        
        return cell
    }
}
