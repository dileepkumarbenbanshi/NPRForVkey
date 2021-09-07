//
//  FormIDManagement.swift
//  NPR-2020
//
//  Created by Dileep on 23/02/21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation

class FormIDManagement {
    var formClass:AddNewHouseHoldForm_TVC?
    
    init(formClass:AddNewHouseHoldForm_TVC) {
        self.formClass = formClass
         
    }
    
    func setIDDetail()  {
        if self.formClass == nil {
            return
        }
        
        
        if formClass?.entryT == .editDetail   {
            formClass?.tf_ID_adhar.text = formClass?.modelMemberDetail.aadhar ?? ""
            formClass?.tf_ID_mobile.text = formClass?.modelMemberDetail.mobile ?? ""
            formClass?.tf_ID_voter.text = formClass?.modelMemberDetail.voter_id ?? ""
            formClass?.tf_ID_dL.text = formClass?.modelMemberDetail.driving_lincence ?? ""
        }
        setTagLabel()
    }
    func setTagLabel()  {
        formClass?.btnID_title.setTitle(LanguageModal.langObj.identification_details, for: .normal)
        formClass?.lblAdhar_title.text = LanguageModal.langObj.aadhaar
        formClass?.tf_ID_adhar.placeholder = LanguageModal.langObj.aadhaar
        
        formClass?.lblVoterID_title.text = LanguageModal.langObj.voter_id
        formClass?.tf_ID_voter.placeholder = LanguageModal.langObj.voter_id
        
        formClass?.lblMobile_title.text = LanguageModal.langObj.mobile
        formClass?.tf_ID_mobile.placeholder = LanguageModal.langObj.mobile
        
        formClass?.lblDL_title.text = LanguageModal.langObj.driving_licence
        formClass?.tf_ID_dL.placeholder = LanguageModal.langObj.driving_licence
        enableDisable_asSERefrence()
    }
    
    
    func enableDisable_asSERefrence()  {
        let isEnable = !(formClass?.isValidSeRefrence ?? false)
        //formClass?.sameas .isEnabled = isEnable
        
        
       
        
        formClass?.tf_ID_adhar.isEnabled = isEnable
        formClass?.tf_ID_mobile.isEnabled = isEnable
        formClass?.tf_ID_voter.isEnabled = isEnable
        formClass?.tf_ID_dL.isEnabled = isEnable
    }
    
    func checkAAdharDuplicacy()  {
      let TotalMembers =  DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data) as? [NPR2021MemberDetails]
        
        guard let memberWithSameAadhar = TotalMembers?.filter({$0.aadhar == formClass?.tf_ID_adhar.text ?? ""}) else {
            return
        }
        
        if (memberWithSameAadhar.count > 0 && formClass?.entryT == .editDetail) || (memberWithSameAadhar.count == 0 && (formClass?.entryT == .addNewMemberExitHH || formClass?.entryT == .newHouseHold)) {
            
            
        }else{
            // String in english now
            formClass?.tf_ID_adhar.text = ""
            AlertView().alertWithoutButton( message: "Duplicate AAdhar")
        }
    }
    
}
