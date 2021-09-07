//
//  FormPermanentAddressProtocol.swift
//  NPR-2020
//
//  Created by Dileep on 25/01/21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation

//Mark:PermanentAddress Protocol
protocol FormPermanentAddressProtocol {
  
    //func PermanentAddressFill(modelHH:NPR_2021hh_Details,formClass:AddNewHouseHoldForm_TVC)
    
    func refreshPermanentAddressDetail(formClass:AddNewHouseHoldForm_TVC)
    func headPermanentAddressFill(modelHH:NPR_2021hh_Details,formClass:AddNewHouseHoldForm_TVC)
    
    func memberPermanentAddressFill(modelMember:NPR2021MemberDetails,formClass:AddNewHouseHoldForm_TVC)
}

//Mark:PermanentAddress Data Fill

class PermanentAddressDetailFill: FormPermanentAddressProtocol {
    
    
     func headPermanentAddressFill(modelHH: NPR_2021hh_Details, formClass: AddNewHouseHoldForm_TVC) {
        
        DBManagerMemberDetail().fetchedHHMembers(modelSelectedHH: modelHH) { (arayMembers) in
            
            let modelHead = arayMembers.filter({$0.rel_code == "01"})
            
            self.permanentAddressFill(modelMemberDetail: modelHead[0], formClass: formClass)
            //return modelHead
        }
    }
    
    func memberPermanentAddressFill(modelMember: NPR2021MemberDetails, formClass: AddNewHouseHoldForm_TVC) {
        
        permanentAddressFill(modelMemberDetail: modelMember, formClass: formClass)
        
    }

    
    //Mark:Refresh aff Filled Value
    func refreshPermanentAddressDetail(formClass: AddNewHouseHoldForm_TVC) {
        
        
        
    }
    
    
    
   
    
    
   private func permanentAddressFill(modelMemberDetail:NPR2021MemberDetails , formClass: AddNewHouseHoldForm_TVC) {
       
      
        
        if formClass.entryT == .editDetail {
            formClass.tf_ptAd_townVillage.text = modelMemberDetail.paddress_town  ?? ""
            
            formClass.tf_padPinCode.text = modelMemberDetail.pinCode ?? ""
        }
        
        
        
        
        formClass.btn_PadSubDistrict.setTitle(singleton().selectEBListModel.ebTahsil_name, for: .normal)
        
        formClass.btn_padDistrict.setTitle(singleton().selectEBListModel.ebDistrict_name ?? "", for: .normal)
        
        formClass.btn_padState.setTitle(singleton().selectEBListModel.ebState_name ?? "", for: .normal)
        
        //tf_ptAd_pinCode.text = singleton().selectEBListModel.
        formClass.tf_padTownVillage.text = singleton().selectEBListModel.ebTown_name
        
    }
    
    func staySinceBirth(sender:UIButton , formClass:AddNewHouseHoldForm_TVC) {
       
        if sender == formClass.btn_padYes {
            formClass.stackViewLastResidence.isHidden = true
            formClass.btn_padYes.isSelected = true
            formClass.btn_padNo.isSelected = false
        }else{
            formClass.stackViewLastResidence.isHidden = false
            formClass.btn_padYes.isSelected = false
            formClass.btn_padNo.isSelected = true
        }
        
        formClass.updatecellSize()
    }
    
    
   private func getHeadDeatil(modelHH:NPR_2021hh_Details) -> [NPR2021MemberDetails] {
        var  modelHead = [NPR2021MemberDetails]()
        
        DBManagerMemberDetail().fetchedHHMembers(modelSelectedHH: modelHH) { (arayMembers) in
            
             modelHead = arayMembers.filter({$0.rel_code == "01"})
            //return modelHead
        }
        
        return modelHead
        
    }
    
}
