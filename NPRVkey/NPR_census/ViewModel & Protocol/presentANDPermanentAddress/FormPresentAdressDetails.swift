//
//  PresentAdressDetails.swift
//  NPR-2020
//
//  Created by Dileep on 24/01/21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation

protocol FormPresentAddressProtocol {
  
    //func presentAddressFill(modelHH:NPR_2021hh_Details,formClass:AddNewHouseHoldForm_TVC)
    
    func refreshPresentAddressDetail(formClass:AddNewHouseHoldForm_TVC)
    func headPresentAddressFill(modelHH:NPR_2021hh_Details,formClass:AddNewHouseHoldForm_TVC)
    
    func memberPresentAddressFill(modelHH:NPR2021MemberDetails,formClass:AddNewHouseHoldForm_TVC)
}

class PresentAddressDetailFill: FormPresentAddressProtocol {
    
    
    func headPresentAddressFill(modelHH: NPR_2021hh_Details, formClass: AddNewHouseHoldForm_TVC) {
        
        DBManagerMemberDetail().fetchedHHMembers(modelSelectedHH: modelHH) { (arayMembers) in
            
            let modelHead = arayMembers.filter({$0.rel_code == "01"})
            
            self.presentAddressFill(modelMemberDetail: modelHead[0], formClass: formClass)
            //return modelHead
        }
    }
    
    func memberPresentAddressFill(modelHH: NPR2021MemberDetails, formClass: AddNewHouseHoldForm_TVC) {
        
        presentAddressFill(modelMemberDetail: modelHH, formClass: formClass)
        
    }
    
    
    
    
    
    
    
    func refreshPresentAddressDetail(formClass: AddNewHouseHoldForm_TVC) {
        
        
        
    }
    
    
    
   
    
    
   private func presentAddressFill(modelMemberDetail:NPR2021MemberDetails , formClass: AddNewHouseHoldForm_TVC) {
       
      
        
        if formClass.entryT == .editDetail {
            formClass.tf_ptAd_townVillage.text = modelMemberDetail.paddress_town  ?? ""
            
            formClass.tf_padPinCode.text = modelMemberDetail.pinCode ?? ""
        }
        
        
        formClass.btn_pd_birthPlaceState.isUserInteractionEnabled = true
        //btn_ptAdd_State.isUserInteractionEnabled = true
        formClass.btn_padState.isUserInteractionEnabled = true
        formClass.btn_parentDeatil_BirthState.isUserInteractionEnabled = true
        formClass.btn_ParentDetail_motherBirthState.isUserInteractionEnabled = true
        formClass.btn_pd_Natinality.isUserInteractionEnabled = true
        formClass.tf_ptAd_houseNumber.isUserInteractionEnabled = true
        formClass.tf_ptAd_pinCode.isUserInteractionEnabled = true
        
        
        formClass.btn_ptAdd_subDistrict.setTitle(singleton().selectEBListModel.ebTahsil_name, for: .normal)
        
        formClass.btn_ptAdd_District.setTitle(singleton().selectEBListModel.ebDistrict_name ?? "", for: .normal)
        
        formClass.btn_ptAdd_State.setTitle(singleton().selectEBListModel.ebState_name ?? "", for: .normal)
        
        //tf_ptAd_pinCode.text = singleton().selectEBListModel.
        formClass.tf_ptAd_townVillage.text = singleton().selectEBListModel.ebTown_name
        
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
