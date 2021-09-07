//
//  AddnewHousHoldForm_Extension.swift
//  NPR_census
//
//  Created by admin on 07/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Foundation
import CoreData


extension AddNewHouseHoldForm_TVC{
    
    //MARK:Check Validation
    
    func isValid() -> Bool {
        return true
    }
   // Get 
    func getNewMemberSerialNumber(hhNumber:String) -> String {
        
        let predicate = NSPredicate.init(format: "hh_tin = %@", strHHNumber.hhTin())
        guard var hhMembers = DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data, predicate: predicate) as? [NPR2021MemberDetails] else{
            return ""
        }
        
       hhMembers = hhMembers.sorted(by: {$0.sloMember ?? "0" < $1.sloMember ?? "1"})
        var serialNumber = ""
        for i in 0...hhMembers.count {
             serialNumber = String(format: AppFormat.member_sr_Format, i+1)
            if i == hhMembers.count {
             return serialNumber
            }
            else if hhMembers[i].sloMember != serialNumber {
                return serialNumber
            }
        }
        return serialNumber
    }
   
    // get Button By Tag
    func findNextORPrevButton(sender:UIButton,tagToFind:Int)->UIButton  {
        
        
        
        guard let stackViewHoldTitleButtonAlso = sender.superview?.superview?.superview?.superview else {
            return UIButton()
        }
        guard  let stackViewHoldTitleButtonAlsoSubView = stackViewHoldTitleButtonAlso.viewWithTag(tagToFind)else {
            return UIButton()
        }
        
        guard  let viewContener = stackViewHoldTitleButtonAlsoSubView.viewWithTag(tagToFind)else {
            return UIButton()
        }
        guard  let button = viewContener.viewWithTag(tagToFind) as? UIButton else {
            
           
            return UIButton()
        }
        print("findView",button)
       return button
    }
    
    func enableButton(sender:UIButton,tag:Int)  {
        
        sender.isUserInteractionEnabled = true
    }
    
    
    // Get Any Button Title by view Tag
    func getButtonTitle(sender:UIButton,tag:Int) -> String {
        
     let button = findNextORPrevButton(sender: sender, tagToFind: tag)
        return button.titleLabel?.text ?? ""
    }
    func setGenderStatus(genderID:String)  {
      
        let genderINT = Int(genderID) ?? 0
        let  genderType = gender.init(rawValue: genderINT)
        let tagButton = genderINT + 5
        
        let stackView = pd_innerStackView.viewWithTag(2)
        
        guard let button = stackView?.viewWithTag(tagButton) as? UIButton else {
            return
        }
         
         button.isSelected = true
        
        
        switch genderType {
        case .male:
            deSelectButton(sender: button, tag: 7)
            deSelectButton(sender: button, tag: 8)
            break
        case .female:
            deSelectButton(sender: button, tag: 6)
            deSelectButton(sender: button, tag: 8)
            break
        case .transGender:
            deSelectButton(sender: button, tag: 7)
            deSelectButton(sender: button, tag: 6)
            break
        
        case .none:
            break
        }
        
       
    }
    
    func updateDetailsView(clickedButton:UIButton) {
        
        let button = clickDetailButton.init(rawValue: clickedButton.tag)
        var stackView = UIStackView()
        //alletailButtonmake_deselect()
        
        switch button {
        case .PersonalDetail:
            
           // btn_PD.isSelected = true
            stackView = pd_innerStackView
            
            
            
            break
            
            case .EducationDetail:
                stackView = eq_innerStackView
//                pd_innerStackView.isHidden = true
//                eq_innerStackView.isHidden = false
//                presentAdd_innerStackView.isHidden = true
//                permanentAdd_innerStackView.isHidden = true
//                parentDetail_innerStackView.isHidden = true
//                iD_detail_innerStackView.isHidden = true
//                btn_EQ_Expand.isSelected = true
            break
            
            case .PresentAddressDetail:
                stackView = presentAdd_innerStackView
//                pd_innerStackView.isHidden = true
//                eq_innerStackView.isHidden = true
//                presentAdd_innerStackView.isHidden = false
//                permanentAdd_innerStackView.isHidden = true
//                parentDetail_innerStackView.isHidden = true
//                iD_detail_innerStackView.isHidden = true
//                btn_presentAdd_expand.isSelected = true
            break
            
            case .PermanentAddressDetail:
                stackView = permanentAdd_innerStackView
                
//                pd_innerStackView.isHidden = true
//                eq_innerStackView.isHidden = true
//                presentAdd_innerStackView.isHidden = true
//                permanentAdd_innerStackView.isHidden = false
//                parentDetail_innerStackView.isHidden = true
//                iD_detail_innerStackView.isHidden = true
//                btn_permanentAdd_expand.isSelected = true
            break
            
            
            case .ParentDetail:
                stackView = parentDetail_innerStackView
//                pd_innerStackView.isHidden = true
//                eq_innerStackView.isHidden = true
//                presentAdd_innerStackView.isHidden = true
//                permanentAdd_innerStackView.isHidden = true
//                parentDetail_innerStackView.isHidden = false
//                iD_detail_innerStackView.isHidden = true
                //btn_presentAdd_expand.isSelected = true
                
            break
            
            case .IdentificationDetail:
                stackView = iD_detail_innerStackView
                
//                pd_innerStackView.isHidden = true
//                eq_innerStackView.isHidden = true
//                presentAdd_innerStackView.isHidden = true
//                permanentAdd_innerStackView.isHidden = true
//                parentDetail_innerStackView.isHidden = true
//                iD_detail_innerStackView.isHidden = false
               // btn_ID_expand.isSelected = true
            break
            
        
            
        case .none:
            break
        }
        
        if clickedButton.isSelected {
            stackView.isHidden = true
        }
        else{
            stackView .isHidden = false
        }

        updateCell(clickedButton: clickedButton)
        
       // updateCell_acordingButton()
        
    }
    
    func alletailButtonmake_deselect()  {
        btn_PD.isSelected = false
        btn_EQ_Expand.isSelected = false
        btn_parentD_expand.isSelected = false
        btn_presentAdd_expand.isSelected = false
        btn_permanentAdd_expand.isSelected = false
        btn_ID_expand.isSelected = false
    }
    
    func updateCell_acordingButton() {
        
        updateCell(clickedButton: btn_PD)
        updateCell(clickedButton: btn_EQ_Expand)
        updateCell(clickedButton: btn_parentD_expand)
        updateCell(clickedButton: btn_presentAdd_expand)
        updateCell(clickedButton: btn_permanentAdd_expand)
        updateCell(clickedButton: btn_ID_expand)
        
    }
    func updateCell(clickedButton:UIButton)  {
        
        //updateCellHeight(clickedButton: clickedButton)
        updatecellSize()
        clickedButton.isSelected = !clickedButton.isSelected
        
    }
    
    func updatecellSize()  {
        
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }

}


    
    
    



//MARK:Other Update on Condition
extension AddNewHouseHoldForm_TVC {
   
    func getRelationCode() -> String {
        
        let relName = btn_pd_relationWithHead.titleLabel?.text
        let arayDropList = English().getRelationShipAray(gender: genderId)
        let relCode = relName?.getDropDownItem_id(aray: arayDropList)
        
        return relCode ?? ""
    }
    func updateNeverMarriedButton()  {
    
     
        let relCode = getRelationCode()
        var enable = false
        
        if relCode == "02" || relCode == "05" || relCode == "06" || relCode == "08" {
            enable = false
        } else {
            enable = true
        }
        btnNeverMarried.isEnabled = enable
        btnCheckNeverMarried.isEnabled = enable
    }
    
    func updateRelationNameByGender(relCode:String)  {
    
      //let relCode = getRelationCode()
        let arayDropList = English().getRelationShipAray(gender: genderId)
        let relName = relCode.getName_by_ID(aray: arayDropList)
        btn_pd_relationWithHead.setTitle(relName, for: .normal)
       
    }
    
}

extension AddNewHouseHoldForm_TVC :AlertViewDelegate {
    
    func alertTapedYes() {
        
        if isDataSaved {
         // If want to add More member
            
             DBManagerHousehold().fetchHHDetail(hhTin: strHHNumber.hhTin(), Completion: { (hhModelDetail) in
                self.modelHH = hhModelDetail
                    self.strMemberName = "New member"
                        self.entryT = .addNewMemberExitHH
                            self.isDataSaved = false
                self.intialViewPrepare()
             })
            
             
             
            
        }else {
            self.backAccordingCondition()
        }
        
    }
    
    func alertViewTapedNo()  {
        if isDataSaved {
            backAccordingCondition()
        }
    }
    
    func alertViewWithoutButtonDissMiss()  {
        backAccordingCondition()
    }
    func backAccordingCondition() {
        
        switch entryT {
        case .addNewMemberExitHH:
            self.popBackToController(toControllerType: HouseholdMemberDetail_ViewController.self)
            break
        case .editDetail:
            self.popBackToController(toControllerType: HouseholdMemberDetail_ViewController.self)
            break
            
        case .newHouseHold :
            self.popBackToController(toControllerType: MainViewController.self)
            
            //self.popTwoView()
            break
        
            
        }
    }
    
}




extension AddNewHouseHoldForm_TVC:SelectFatherMotherDelegate {
    func didSelectFatherMother(modelParent: NPR2021MemberDetails, genderType: gender) {
        if genderType == .male {
            self.fatherDetail(modelMember: modelParent, modelType: .father)
            btnSelectFatherName.setTitle(modelParent.name, for: .normal)
            
        }else {
            self.motherDetail(modelMember: modelParent, modelType: .mother)
            btnSelectMotherName.setTitle(modelParent.name, for: .normal)
        }
    }
    
    
   
    
    
}
