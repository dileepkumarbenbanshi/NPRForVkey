//
//  PresentAdressDetails.swift
//  NPR-2020
//
//  Created by Dileep on 24/01/21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation



class FormPresentAddressDetailFill {
    
    var formClass:AddNewHouseHoldForm_TVC?
        
    init(formClass:AddNewHouseHoldForm_TVC) {
        self.formClass = formClass
        
    }
    
    func headPresentAddressFill(modelHH: NPR_2021hh_Details) {
        
        if self.formClass == nil {
            return
        }
        DBManagerMemberDetail().fetchedHHMembers(modelSelectedHH: modelHH) { (arayMembers) in
            
            let modelHead = arayMembers.filter({$0.rel_code == "01"})
            
            self.presentAdressFill(modelMemberDetail: modelHead.last!)
            //return modelHead
        }
    }
    
    func memberPresentAddressFill(modelMember: NPR2021MemberDetails) {
        
        presentAdressFill(modelMemberDetail: modelMember)
        presentAdd_setTagLabel()
    }

    func refreshPresentAddressDetail(formClass: AddNewHouseHoldForm_TVC) {
        
}
    
 
    private func presentAdressFill(modelMemberDetail:NPR2021MemberDetails) {
        
        if formClass == nil {
            return
        }
         
        let formClass = self.formClass!
        
         if formClass.entryT == .editDetail || formClass.entryT == .addNewMemberExitHH{
            
            if formClass.entryT == .editDetail {
                
                
            }
             formClass.tf_ptAd_townVillage.text = modelMemberDetail.paddress_town  ?? "sde"
            formClass.tf_ptAd_houseNumber.text = modelMemberDetail.address_line1
             formClass.tf_ptAd_pinCode.text = modelMemberDetail.pinCode ?? "dd  q"
         }
      presentAddreesForNewMember()
     }
    
    func presentAddreesForNewMember()  {
        
        if formClass == nil {
            return
        }
         
        let formClass = self.formClass!
        
        let subDistrict = DBManager_CountryStateDistrict().getSubDistrictName(stateCode: singleton().selectEBListModel.ebState_code ?? "", districtCode: singleton().selectEBListModel.ebDistrict_code ?? "", tahsilCode:singleton().selectEBListModel.ebTahsil_code ?? "0001" )
        formClass.btn_ptAdd_subDistrict.setTitle(subDistrict, for: .normal)
        
       
        let strDistrict = DBManager_CountryStateDistrict().getDistrictName(stateCode: singleton().selectEBListModel.ebState_code ?? "", districtCode:singleton().selectEBListModel.ebDistrict_code ?? "001" )
        
         formClass.btn_ptAdd_District.setTitle(strDistrict, for: .normal)
         
        
         
        let strState = DBManager_CountryStateDistrict().getStateName(stateCode: singleton().selectEBListModel.ebState_code ?? "")
        
        formClass.btn_ptAdd_State.setTitle(strState, for: .normal)
         formClass.tf_ptAd_townVillage.text = singleton().selectEBListModel.ebTown_name
        if formClass.entryT != .newHouseHold {
            
        
        if let pinCode = formClass.modelHH.addressPinCode   {
            formClass.tf_ptAd_pinCode.text = pinCode
            
        }
        if let locality = formClass.modelHH.addressHNLocality {
            formClass.tf_ptAd_houseNumber.text = locality
        }
        }
        //formClass.tf_ptAd_pinCode.text = 
    }
    
   private func getHeadDeatil(modelHH:NPR_2021hh_Details) -> [NPR2021MemberDetails] {
        var  modelHead = [NPR2021MemberDetails]()
        
        DBManagerMemberDetail().fetchedHHMembers(modelSelectedHH: modelHH) { (arayMembers) in
            
             modelHead = arayMembers.filter({$0.rel_code == "01"})
            //return modelHead
        }
        
        return modelHead
        
    }
   
    func presentAdd_setTagLabel()  {
        formClass?.btnPresentAdd_title.setTitle(LanguageModal.langObj.address, for: .normal)
        formClass?.btnPresentAddState_title.setTitle(LanguageModal.langObj.state, for: .normal)
        formClass?.btnPresentAddDistrict_title.setTitle(LanguageModal.langObj.district, for: .normal)
        formClass?.btnPresentAddSubDistrict_title.setTitle(LanguageModal.langObj.sub_district, for: .normal)
        formClass?.lblTownVillage_title.text = LanguageModal.langObj.town_village
        formClass?.lblHouseNumber_title.text = LanguageModal.langObj.address1
        formClass?.lblPin_title.text = LanguageModal.langObj.pincode
        enableDisable_asSERefrence()
    }
    
    func enableDisable_asSERefrence()  {
        let isEnable =  formClass?.entryT == .newHouseHold || (formClass?.entryT == .editDetail && formClass?.modelMemberDetail.rel_code == "01")
        //formClass?.sameas .isEnabled = isEnable
        formClass?.btn_ptAdd_State .isEnabled = isEnable
        
        formClass?.btn_ptAdd_District .isEnabled = isEnable
        formClass?.btn_ptAdd_subDistrict .isEnabled = isEnable
        
        
        formClass?.tf_ptAd_townVillage .isEnabled = isEnable
        formClass?.tf_ptAd_houseNumber .isEnabled = isEnable
        formClass?.tf_ptAd_pinCode .isEnabled = isEnable
        
    }
}
