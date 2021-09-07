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
        let countryName = DBManager_CountryStateDistrict().getCountryName(countryCode: util.countryCode)
        formClass.tf_ID_adhar.text = ""
//        formClass.tf_pd_houseHoldNO.text = ""
//        formClass.tf_padHouseNumber.text = ""
        formClass.tf_pd_SE_refrenceNO.text = ""
        formClass.tf_pd_Name.text = ""
        formClass.tf_pd_Name.text = ""
        formClass.tf_pd_midleName.text = ""
        formClass.tf_pd_lastName.text = ""
        formClass.tf_pd_Name.text = ""

        formClass.btn_pd_relationWithHead.setTitle("", for: .normal)
        formClass.genderId = .notSelect
        formClass.btnCheckMale.isSelected = false
        formClass.btnCheckFemale.isSelected = false
        formClass.btnCheckTransgender.isSelected = false
        formClass.btn_pd_relationWithHead.titleLabel?.text = ""
        formClass.maritalStatus = .none
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
        formClass.btn_pd_birthPlaceDistrict.titleLabel?.text = ""
        
        formClass.btn_pd_birthPlaceState.setTitle("", for: .normal)
        formClass.btn_pd_birthPlaceState.titleLabel?.text = ""
        
        
        // objNprData.birthDistrictCode = formClass.btn_pd_d

        //objNprData.birthNationality
        formClass.tf_passportNumber.text = ""

        //Education Qualification

        formClass.btn_ed_qualification.setTitle("", for: .normal)
        formClass.btn_ed_qualification.titleLabel?.text = ""
        // objNprData.edu_code

        formClass.btn_ed_occupation.setTitle("", for: .normal)
        formClass.btn_ed_occupation.titleLabel?.text = ""
        
        formClass.btn_ed_motherTounge.setTitle("", for: .normal)
        formClass.btn_ed_motherTounge.titleLabel?.text = ""
        
        formClass.stackView_enterOtherMotherTongue.isHidden = true
        formClass.tf_edu_enterOtherMotherTongue.text = ""
        //Parents Detail

        formClass.parentDetail_fatherName.text = ""
        
        formClass.tf_ParentDetail_dob_date.text = ""
        formClass.tf_ParentDetail_dob_month.text = ""
        formClass.tf_ParentDetail_dob_year.text = ""
        
       
        formClass.btn_pd_birthPlaceState.setTitle("", for: .normal)
        formClass.btn_pd_birthPlaceState.titleLabel?.text = ""
        
         formClass.btn_pd_birthPlaceDistrict.setTitle("", for: .normal)
        formClass.btn_pd_birthPlaceDistrict.titleLabel?.text = ""

        formClass.btn_parentDetail_birthDistrict.setTitle("", for: .normal)
        formClass.btn_parentDetail_birthDistrict.titleLabel?.text = ""
        
        formClass.btn_parentDetail_birthDistrict.titleLabel?.text = ""
        formClass.btn_parentDetail_birthDistrict.titleLabel?.text = ""
        
        formClass.btn_parentDeatil_BirthState.setTitle("", for: .normal)
        formClass.btn_parentDeatil_BirthState.titleLabel?.text = ""
        
        formClass.btn_parentDeatil_BirthState.titleLabel?.text = ""
        
        formClass.btn_parentDetail_BirthCountry.setTitle(countryName, for: .normal)
        formClass.btn_parentDetail_BirthCountry.titleLabel?.text = ""
        
        formClass.btn_parentDetail_BirthCountry.titleLabel?.text = countryName
        //  objNprData.mother_birthStatecode =

         formClass.btn_ParentDetail_motherBirthDistrict.setTitle("", for: .normal)
        formClass.btn_ParentDetail_motherBirthDistrict.titleLabel?.text = ""
        
        formClass.tf_ParentDetail_motherName.text = ""
        formClass.tf_ParentDetail_motherDob_date.text = ""
        formClass.tf_ParentDetail_motherDob_month.text = ""
        formClass.tf_ParentDetail_motherDob_year.text = ""
        //objNprData.mother_dobType = formClass.
        formClass.btn_ParentDetail_motherBirthCountry.setTitle(countryName, for: .normal)
        formClass.btn_ParentDetail_motherBirthCountry.titleLabel?.text = ""
        
        formClass.btn_ParentDetail_motherBirthState.setTitle("", for: .normal)
        formClass.btn_ParentDetail_motherBirthState.titleLabel?.text = ""
        //  objNprData.mother_birthStatecode =

        formClass.btn_ParentDetail_motherBirthDistrict.setTitle("", for: .normal)
        
        formClass.btn_ParentDetail_motherBirthDistrict.titleLabel?.text = ""
        formClass.tf_ParentDetail_spouseName.text = ""
        
        
        
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
        
        
        formClass.btn_PaddCountry.setTitle(countryName, for: .normal)
        formClass.btn_PaddCountry.titleLabel?.text = countryName
        formClass.btn_padState.setTitle("", for: .normal)
        formClass.btn_padState.titleLabel?.text = ""
        formClass.btn_padDistrict.setTitle("", for: .normal)
        formClass.btn_padDistrict.titleLabel?.text = ""
         formClass.btn_PadSubDistrict.setTitle("", for: .normal)
        formClass.btn_PadSubDistrict.titleLabel?.text = ""
        formClass.tf_padTownVillage.text = ""
         //objNprData.address_line2 = formClass.tf_ptAd_townVillage.text = ""
         formClass.tf_padHouseNumber.text = ""
         formClass.tf_padPinCode.text = ""
        formClass.stackViewLastResidence.isHidden = true
        formClass.btnLastResidenceCountry.titleLabel?.text = countryName
        formClass.btnLastResidenceCountry.setTitle(countryName, for: .normal)
        
        formClass.btnLastResidenceState.setTitle("", for: .normal)
        formClass.btnLastResidenceState.titleLabel?.text = ""
        formClass.btnLastResidenceDistrict.setTitle("", for: .normal)
        formClass.btnLastResidenceDistrict.titleLabel?.text = ""
        formClass.btn_padYes.isSelected = false
        formClass.btn_padNo.isSelected = false

        //objNprData.staying_since_birthdate

        // Identification Detail

        formClass.tf_ID_adhar.text = ""
         formClass.tf_ID_mobile.text = ""
        formClass.tf_ID_dL.text = ""
        formClass.tf_ID_voter.text = ""
        
        
   
        
    }
    
}
