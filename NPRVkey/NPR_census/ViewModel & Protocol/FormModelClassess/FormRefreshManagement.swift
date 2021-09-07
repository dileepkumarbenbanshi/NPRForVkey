//
//  FormRefreshManagement.swift
//  NPR-2020
//
//  Created by Dileep on 28/01/21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation

protocol FormRefreshManagementProtocol {
   func formRefreshSuccess()
}
class FormRefreshManagement {
    
    func refreshForm(formClass:AddNewHouseHoldForm_TVC)  {
      
        formClass.tf_ID_adhar.text = ""
//        formClass.tf_pd_houseHoldNO.text = ""
//        formClass.tf_padHouseNumber.text = ""
        formClass.tf_pd_SE_refrenceNO.text = ""
        formClass.tf_pd_Name.text = ""
        formClass.tf_pd_Name.text = ""

        formClass.tf_pd_Name.text = ""

        formClass.btn_pd_relationWithHead.setTitle("", for: .normal)
        formClass.btn_pd_relationWithHead.isUserInteractionEnabled = true
        
        formClass.deSelectButton(sender:formClass.btnCheckMale , tag: formClass.genderId.rawValue+5)
        formClass.deSelectButton(sender: formClass.btnCheckNeverMarried, tag: 10)
        formClass.deSelectButton(sender: formClass.btnCheckNeverMarried, tag: 11)
        formClass.deSelectButton(sender: formClass.btnCheckNeverMarried, tag: 12)
        formClass.deSelectButton(sender: formClass.btnCheckNeverMarried, tag: 13)
        formClass.deSelectButton(sender: formClass.btnCheckNeverMarried, tag: 14)
        // objNprData.marital_status = formClass.ma
       // objNprData.dob = formClass.tf_date

        // formClass.btn_pd_birthPlaceCountry.setTitle("", for: .normal)
        // objNprData.birthCountryCode = formClass.
        //formClass.btn_pd_birthPlaceState.setTitle("", for: .normal)
        formClass.tf_pd_Dob_date.text = ""
        formClass.tf_pd_Dob_month.text = ""
        formClass.tf_pd_Dob_year.text = ""

         formClass.btn_pd_birthPlaceDistrict.setTitle("", for: .normal)
        // objNprData.birthDistrictCode = formClass.btn_pd_d

        //objNprData.birthNationality
        formClass.tf_passportNumber.text = ""

        //Education Qualification

        formClass.btn_ed_qualification.setTitle("", for: .normal)
        // objNprData.edu_code

        formClass.btn_ed_occupation.setTitle("", for: .normal)
        formClass.btn_ed_motherTounge.setTitle("", for: .normal)

        //Parents Detail

        formClass.tf_pd_Name.text = ""
       // formClass.tf_parentDetail_dob.text = ""
        // objNprData.father_dobType =
        // formClass.btn_pd_birthPlaceCountry.setTitle("", for: .normal)
        // objNprData.fatherBirthCountryCode

        formClass.btn_pd_birthPlaceState.setTitle("", for: .normal)
         formClass.btn_pd_birthPlaceDistrict.setTitle("", for: .normal)

        formClass.tf_ParentDetail_motherName.text = ""
        formClass.tf_ParentDetail_dob_date.text = ""
        formClass.tf_ParentDetail_dob_month.text = ""
        formClass.tf_ParentDetail_dob_year.text = ""
        //objNprData.mother_dobType = formClass.
      //  formClass.btn_ParentDetail_motherBirthCountry.setTitle("", for: .normal)
        //objNprData.mother_birthCountryCode =
        formClass.btn_ParentDetail_motherBirthState.setTitle("", for: .normal)
        //  objNprData.mother_birthStatecode =

         formClass.btn_ParentDetail_motherBirthDistrict.setTitle("", for: .normal)
        formClass.tf_ParentDetail_spouseName.text = ""
        
        formClass.tf_ParentDetail_dob_date.text = ""
        formClass.tf_ParentDetail_dob_month.text = ""
        formClass.tf_ParentDetail_dob_year.text = ""
        
        // objNprData.spouseCode =

        // Present address

//        formClass.btn_ptAdd_State.setTitle("", for: .normal)
//        formClass.btn_ptAdd_District.setTitle("", for: .normal)
//         formClass.btn_ptAdd_subDistrict.setTitle("", for: .normal)
//        // objNprData.town
//        formClass.tf_ptAd_townVillage.text = ""
//        formClass.tf_ptAd_houseNumber.text = ""
//        formClass.tf_ptAd_pinCode.text = ""

        // Permanent Address
      
        formClass.btnCkeck_permanentSameasPresentAdd.isSelected = false
        

        formClass.btn_padState.setTitle("", for: .normal)
        formClass.btn_padDistrict.setTitle("", for: .normal)
         formClass.btn_PadSubDistrict.setTitle("", for: .normal)
        formClass.tf_padTownVillage.text = ""
         //objNprData.address_line2 = formClass.tf_ptAd_townVillage.text = ""
         formClass.tf_padHouseNumber.text = ""
         formClass.tf_padPinCode.text = ""

        //objNprData.staying_since_birthdate

        // Identification Detail

        formClass.tf_ID_adhar.text = ""
         formClass.tf_ID_mobile.text = ""
        formClass.tf_ID_dL.text = ""
        formClass.tf_ID_voter.text = ""
        
        
   
        
    }
    
}
