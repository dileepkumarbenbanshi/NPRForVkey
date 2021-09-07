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
    
    func checkAndOpenSignatureView()  {
        
        let alertView = AlertView()
        alertView.delegate = self
        if entryT == .newHouseHold {
            DBManagerHousehold().fetchHHDetail(hhTin: strHHNumber.hhTin()) { (hhModel) in
                self.modelHH =  hhModel
            }
        }
        
        if entryT == .newHouseHold || (modelHH.respondentName?.count ?? 0 ==  0 && (modelHH.hh_completed == HHCompletionStatusCode.inComplete || modelHH.hh_completed == HHCompletionStatusCode.completed || modelHH.hh_completed == HHCompletionStatusCode.uploaded))  {
        
            alertView.showAlertWithSingleButton( title: LanguageModal.langObj.signature_required, message: LanguageModal.langObj.press_ok_to_take_signature)
        
        }else{
            self.backAccordingCondition()
            //self.navigationController?.popViewController(animated: true)
        }
    }
    func navigateToRespondentSignature()  {
       
        guard  let vc = self.storyboard?.instantiateViewController(withIdentifier: "EnumeratorSignatureViewController") as? EnumeratorSignatureViewController else {
            return
        }
        vc.isRespondentSign = true
        vc.delegate = self
        vc.isFromFormPage = true
        vc.modelHHRespondent = modelHH
        self.navigationController?.pushViewController(vc , animated: true)
        
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
        
        case .notSelect:
            break
        case .none:
            return
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
        
        if relCode == "02" || relCode == "05" || relCode == "08" || relCode == "09" {
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

//MARK:Alert Delegate

extension AddNewHouseHoldForm_TVC :AlertViewDelegate {
    
    func alertTapedYes() {
        if alertFor == .aadhar {
            formModelClass?.validate()
            alertFor = .dataSaved
            return
        }
        
        if isDataSaved {
         // If want to add More member
            
             DBManagerHousehold().fetchHHDetail(hhTin: strHHNumber.hhTin(), Completion: { (hhModelDetail) in
                self.modelHH = hhModelDetail
                    self.strMemberName = "New member"
                        self.entryT = .addNewMemberExitHH
                            self.isDataSaved = false
                                self.tf_pd_Name.becomeFirstResponder()
                self.intialViewPrepare()
             })

        }else {
            self.backAccordingCondition()
        }
        
    }
    
    func alertViewTapedNo()  {
        if alertFor == .aadhar {
            alertFor = .none
            return
        }
        if isDataSaved {
            backAccordingCondition()
           // checkAndOpenSignatureView()
        }
    }
    
    func alertViewWithoutButtonDissMiss()  {
        backAccordingCondition()
    }
    
    func alertViewSingelButtonTapedYes() {
        navigateToRespondentSignature()
    }
    
    func backAccordingCondition() {
        
        let predicateHH = NSPredicate(format: "hh_tin = %@ ", strHHNumber.hhTin())
        DBManagerHousehold().fetchHHList(predicateHH: predicateHH) { (arayHH) in
          
            if  arayHH.count > 0 {
                let isDetailClass = self.navigationController?.viewControllers.contains(where: {$0 is HouseholdMemberDetail_ViewController}) ?? false
                if isDetailClass {
                    self.popBackToController(toControllerType: HouseholdMemberDetail_ViewController.self)
                }else{
                    if #available(iOS 13.0, *) {
                        self.navigateToHHDetail()
                    } else {
                        // Fallback on earlier versions
                    }
                }
                
                
            }else{
                self.popBackToController(toControllerType: MainViewController.self)
                //
                 //self.popTwoView()
            }
        }
        

    }
    
    
    @available(iOS 13.0, *)
    private func navigateToHHDetail()  {
        
        DBManagerHousehold().fetchHHDetail(hhTin: strHHNumber.hhTin()) { (hhDetail) in
           
            let objStoryBoard:UIStoryboard = UIStoryboard.init(name: storyBoardName.npr, bundle: nil)
            
          // let vc1 = objStoryBoard.instantiateViewController(identifier: ClassID.hhMemberDetail)
            guard let vc = objStoryBoard.instantiateViewController(identifier:ClassID.hhMemberDetail ) as? HouseholdMemberDetail_ViewController else {
                return
            }
            //vc.arayMembersModel = arayMemberDetail
            vc.hhModel = hhDetail
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
}

extension AddNewHouseHoldForm_TVC:SelectFatherMotherDelegate {
    func didSelectFatherMother(modelParent: NPR2021MemberDetails, genderType: gender) {
        
        var name = ""
        
        if modelParent.language?.IsSelectedLangauge_nonEnglish ?? false {
            
            name = ((modelParent.nameSL?.count != 0) ? modelParent.nameSL ?? "" : modelParent.name) ?? ""
        }else{
            name = ((modelParent.name?.count != 0) ? modelParent.name ?? "" : modelParent.nameSL) ?? ""
        }
        
        if genderType == .male {
            
            self.fatherDetail(modelMember: modelParent, modelType: .father)
            
            btnSelectFatherName.setTitle(name, for: .normal)
            
        }else {
            self.motherDetail(modelMember: modelParent, modelType: .mother)
            btnSelectMotherName.setTitle(name, for: .normal)
        }
    }
   
}

extension AddNewHouseHoldForm_TVC:SignatureDelegate {
    func respondentSignatureCpatered() {
        backAccordingCondition()
    }
}

extension AddNewHouseHoldForm_TVC:SelectMemberDelegate {
    func didSelectMember(memberModel: NPR2021MemberDetails) {
        btnCkeck_permanentSameasPertularMember.setTitle(memberModel.name, for: .normal)
        formModelClass?.objPermanentAddressDetail?.permanentAddressFill(modelMemberDetail: memberModel)
        btnCkeck_permanentSameasHead.isSelected = false
        btnCkeck_permanentSameasPresentAdd.isSelected = false
    }
    
    
    
}
