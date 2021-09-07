//
//  FormParentDataManagement.swift
//  NPR-2020
//
//  Created by Dileep on 08/02/21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation

class ParentDataManagementClass {

    var formClass:AddNewHouseHoldForm_TVC?
    
    init(formClass:AddNewHouseHoldForm_TVC) {
       
        self.formClass = formClass
        fatherDetail_setTaglabel()
    }
   
    func setParentData()  {
        
    }
    
    func setMotherData(modelMother:NPR2021MemberDetails)  {
        
    }
    
    func setFatherData(modelMother:NPR2021MemberDetails)  {
        
    }
    
    func fatherDetail_setTaglabel()  {
        
        formClass?.parentStayInThisHH_title.setTitle(LanguageModal.langObj.parents_are_in_hh, for: .normal)
        formClass?.btnParentDetail_title.setTitle(LanguageModal.langObj.parents_details, for: .normal)
        formClass?.btnSelectFatherName_title.setTitle(LanguageModal.langObj.select_father_name, for: .normal)
        formClass?.lblFatherName_title.text =  LanguageModal.langObj.f_name
        formClass?.lblFatherDOB_title.text =  LanguageModal.langObj.f_dob
        formClass?.btnFatherDOBCountry_title.setTitle(LanguageModal.langObj.f_birth_address, for: .normal)
        formClass?.btnFatherDOBState_title.setTitle(LanguageModal.langObj.f_birth_address2, for: .normal)
        formClass?.btnFatherDOBDistrict_title.setTitle(LanguageModal.langObj.f_birth_address3, for: .normal)
        motherDetail_setTaglabel()
    }
    
    func motherDetail_setTaglabel()  {
        
        formClass?.btnSelectMotherName_title.setTitle(LanguageModal.langObj.select_mother_name, for: .normal)
        formClass?.lblMotherName_title.text =  LanguageModal.langObj.m_name
        formClass?.lblDOBMother_title.text =  LanguageModal.langObj.m_dob
        formClass?.btnMotherDOBCountry_title.setTitle(LanguageModal.langObj.m_birth_address, for: .normal)
        formClass?.btnMotherDOBState_title.setTitle(LanguageModal.langObj.m_birth_address2, for: .normal)
        formClass?.btnMotherDOBDistrict_title.setTitle(LanguageModal.langObj.m_birth_address3, for: .normal)
        formClass?.lblSpouseName_title.text = LanguageModal.langObj.s_name
        formClass?.tf_ParentDetail_spouseName.placeholder = LanguageModal.langObj.s_name
        
        enableDisable_asSERefrence()
    }
    
    func enableDisable_asSERefrence()  {
        let isEnable = !(formClass?.isValidSeRefrence ?? false)
        //formClass?.sameas .isEnabled = isEnable
        //formClass?.btn_parentDetail_BirthCountry.isUserInteractionEnabled = isEnable
        
        formClass?.btn_parentDeatil_BirthState.isUserInteractionEnabled = isEnable
        formClass?.btn_parentDetail_birthDistrict.isUserInteractionEnabled = isEnable
        formClass?.btn_parentDetail_birthDistrict.isUserInteractionEnabled = isEnable
        formClass?.parentDetail_fatherName.isUserInteractionEnabled = isEnable
        formClass?.tf_ParentDetail_dob_date.isUserInteractionEnabled = isEnable
        formClass?.tf_ParentDetail_dob_month.isUserInteractionEnabled = isEnable
        formClass?.tf_ParentDetail_dob_year.isUserInteractionEnabled = isEnable
        
        
        formClass?.btn_ParentDetail_motherBirthCountry.isUserInteractionEnabled = isEnable
        
        formClass?.btn_ParentDetail_motherBirthState.isUserInteractionEnabled = isEnable
        formClass?.btn_ParentDetail_motherBirthDistrict.isUserInteractionEnabled = isEnable
        
        formClass?.tf_ParentDetail_motherName.isUserInteractionEnabled = isEnable
        formClass?.tf_ParentDetail_motherDob_date.isUserInteractionEnabled = isEnable
        formClass?.tf_ParentDetail_motherDob_month.isUserInteractionEnabled = isEnable
        formClass?.tf_ParentDetail_motherDob_year.isUserInteractionEnabled = isEnable
    }
    
}
