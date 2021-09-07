//
//  SelectedLanguageString.swift
//  NPR-2021
//
//  Created by Dileep on 22/07/21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation

struct ChanageLangaugeString {
    
    
    // MARK: Language Change (Add data to existing modal)
    func setString_keyAllreadyUsed(){
        LanguageModal.currentLanguage = UserDefaults().getCurrentLanguage()
        let langObj = LanguageModal.langObj
        English.AddNewMemberFormAlert.censusHHNoExist = langObj.validation_hh_no_already_exist
        //English.AddNewMemberFormAlert.checkPermanentAddress_HouseNumber
        //English.AddNewMemberFormAlert.checkPermanentAddress_town_village
        English.AddNewMemberFormAlert.checkPermanentAddress_pinCode = langObj.validation_permaneent_pincode
        English.AddNewMemberFormAlert.checkPresentAddress_HouseNumber = langObj.validation_present_address1
        English.AddNewMemberFormAlert.checkPresentAddress_pinCode = langObj.validation_present_pincode
        English.AddNewMemberFormAlert.checkPresentAddress_town_village = langObj.validation_present_address2
        English.AddNewMemberFormAlert.chooseEduQualification = langObj.validation_education
        English.AddNewMemberFormAlert.chooseFatherDob_country = langObj.validation_father_birth_country
        English.AddNewMemberFormAlert.chooseFatherDob_district = langObj.validation_father_birth_district
        English.AddNewMemberFormAlert.chooseFatherDob_state = langObj.validation_father_birth_state
        English.AddNewMemberFormAlert.chooseMotherDob_country = langObj.validation_mother_birth_country
        English.AddNewMemberFormAlert.chooseMotherDob_district = langObj.validation_mother_birth_district
        English.AddNewMemberFormAlert.chooseMotherDob_state = langObj.validation_mother_birth_state
        English.AddNewMemberFormAlert.chooseMotherTongue = langObj.enter_mother_tounge
        English.AddNewMemberFormAlert.chooseNationality = langObj.choose_Nationality
        English.AddNewMemberFormAlert.chooseOccupation = langObj.validation_occupation
        English.AddNewMemberFormAlert.choosePermanentAddress_country = langObj.validation_permaneent_country
        English.AddNewMemberFormAlert.choosePermanentAddress_district = langObj.validation_permaneent_district
        English.AddNewMemberFormAlert.choosePermanentAddress_state = langObj.validation_permaneent_state
        English.AddNewMemberFormAlert.choosePermanentAddress_subDistrict = langObj.validation_permaneent_tehsil
        //English.AddNewMemberFormAlert.choosePresentAddress_country = langObj.
        English.AddNewMemberFormAlert.choosePresentAddress_district = langObj.validation_present_district
        English.AddNewMemberFormAlert.choosePresentAddress_state = langObj.validation_present_state
        English.AddNewMemberFormAlert.choosePresentAddress_subDistrict = langObj.validation_present_sub_district
        English.AddNewMemberFormAlert.chosoeBirthDistrict = langObj.validation_member_birthdistrict
        English.AddNewMemberFormAlert.chosseYourCountry = langObj.validation_member_Nationality
        English.AddNewMemberFormAlert.doYouWantAddMoreMember = langObj.yes_to_add_more_member
        English.AddNewMemberFormAlert.dob_invalid = langObj.validation_member_dob_not_valid
        English.AddNewMemberFormAlert.fatherDob_invalid = langObj.validation_father_dob_not_valid
        English.AddNewMemberFormAlert.fatherNameInvalid = langObj.validation_father_name
        English.AddNewMemberFormAlert.gender = langObj.validation_gender
        English.AddNewMemberFormAlert.hNEmpty = langObj.validation_census_house_no
        English.AddNewMemberFormAlert.hhAlreadyExist = langObj.validation_hh_no_already_exist
        English.AddNewMemberFormAlert.hhEmpty = langObj.validation_new_census_household_no
        English.AddNewMemberFormAlert.hhValidation = langObj.validation_hh_no
        //English.AddNewMemberFormAlert.inValidAadharLenth = langObj.
        English.AddNewMemberFormAlert.inValidAadharNumber = langObj.validation_aadhaar
        English.AddNewMemberFormAlert.inValidDL = langObj.validation_dl
        //English.AddNewMemberFormAlert.inValidMobileLenth = langObj.
        English.AddNewMemberFormAlert.inValidMobilerNumber = langObj.validation_mobile
        English.AddNewMemberFormAlert.inValidVoterID = langObj.validation_voterid
        English.AddNewMemberFormAlert.maritalStatusMiss = langObj.validation_marital_status
        English.AddNewMemberFormAlert.memberBirthCountry = langObj.validation_member_birthcountry
        English.AddNewMemberFormAlert.memberBirthDate_future = langObj.validation_dob_date_future_date
        English.AddNewMemberFormAlert.memberBirthDate_today = langObj.validation_dob_date_today_date
        English.AddNewMemberFormAlert.memberBirthDistrict = langObj.validation_member_birthdistrict
        English.AddNewMemberFormAlert.memberBirthState = langObj.validation_member_birthstate
        English.AddNewMemberFormAlert.memberBirthSubDistrict = langObj.validation_member_birthtehsil
        English.AddNewMemberFormAlert.memberDOBEmpty = langObj.validation_member_dob
        //English.AddNewMemberFormAlert.memberDob_monthEmpty = langObj.
        //English.AddNewMemberFormAlert.memberDob_yearEmpty = langObj.
        English.AddNewMemberFormAlert.memberNumberValidation = langObj.validation_hh_family_membr_no
        English.AddNewMemberFormAlert.memberUpdatedSuccess = langObj.member_updated_successfully
        English.AddNewMemberFormAlert.motherDob_invalid = langObj.validation_mother_dob_not_valid
        English.AddNewMemberFormAlert.motherNameInvalid = langObj.validation_mother_name
        English.AddNewMemberFormAlert.nameValidation = langObj.validation_name
        English.AddNewMemberFormAlert.newMember = langObj.new_member
        English.AddNewMemberFormAlert.newMemberAddedSuccesFully = langObj.new_member_added_successfully
        English.AddNewMemberFormAlert.relationEmpmemberDOB_valid = langObj.validation_member_dob_not_valid
        English.AddNewMemberFormAlert.relationEmpty = langObj.validation_relationship
        English.AddNewMemberFormAlert.selectFatherName = langObj.select_father_name
        English.AddNewMemberFormAlert.selectMotherName = langObj.select_mother_name
        English.AddNewMemberFormAlert.spouseNameInvalid = langObj.validation_spouse_name
        English.AddNewMemberFormAlert.tapBackButton = langObj.you_will_loss_data
        English.AddNewMemberFormAlert.proceedWithoutAadhar = langObj.aadhar_detail_alert
        
        English.IncompleHHOrViewEditPage.deleteMemberAlert = langObj.to_delete
        English.IncompleHHOrViewEditPage.cantAddNewHHinThisHLB = langObj.expected_hh_can_not_be_zero_after_eb_upload
        
        
        // SplitView
        
        
      //  English.SplitView().searchPlaceHolder = langObj.search
       // English.SplitView().searchPlaceHolder = langObj.search
//
//        English.SplitView.deleteMemberAlert = langObj.to_delete
//        English.SplitView.deleteMemberAlert = langObj.expected_hh_to_split
        
        AppMessages.User_Id_Password_Can_not_be_Empty = langObj.user_id_password_cant_be_empty
        
        AppMessages.ebDownloadedSuccessFully = langObj.eb_download_successfully
       // AppMessages.App_Name = langObj.app_name
        AppMessages.Both_Password_Same = langObj.both_password_should_be_same
        AppMessages.Expected_hh_Can_not_be_Blank = langObj.expected_hh_can_not_be_blank
        AppMessages.Expected_hh_Can_not_be_One = langObj.expected_hh_can_not_be_one
        AppMessages.Expected_hh_Can_not_be_More_Than = langObj.expected_hh_can_not_be_more_than
        AppMessages.Alert_Date = langObj.alert_date
        AppMessages.Success = langObj.success
        AppMessages.Error401 = langObj.error401
        AppMessages.Error400 = langObj.error400
       // AppMessages.Server_Response = langObj.serv
        AppMessages.UnAuthorized_Access = langObj.unauthorized_access
        AppMessages.device_de_enrolled = langObj.de_enroll_message1
        AppMessages.Fail = langObj.fail
       // AppMessages.Already_Active_Device = langObj.same_device_already_activated
        AppMessages.Active_Device_Info = langObj.same_device_already_activated
        AppMessages.No_Record = langObj.no_data_to_upload
        AppMessages.NPR_Started = langObj.nprstarted
        AppMessages.EB_Start_Date_Mark = langObj.ebstartdateMark
        AppMessages.EB_Complete_Successfully = langObj.eb_complete_successfully
        AppMessages.ebDownloadedSuccessFully = langObj.eb_download_successfully
        AppMessages.Button_Yes = langObj.button_yes
        AppMessages.Button_No = langObj.button_no
        AppMessages.Search_Heading = langObj.searchHeading
        AppMessages.National_Population_Register = langObj.national_population_register
        AppMessages.Developer_By = langObj.developer_by
        AppMessages.Indian_Gov = langObj.indian_gov
        AppMessages.Indian_Gov_ORGI = langObj.indian_gov
        AppMessages.Version = langObj.version
        AppMessages.Please_Wait = langObj.please_wait
        AppMessages.Loading_Data = langObj.loading_data
        AppMessages.Total_Records = langObj.total_records
        AppMessages.Total_Households = langObj.total_households
        AppMessages.Enter_EB_Search = langObj.enter_eb_search
        AppMessages.checkHHType = langObj.check_hh_type
        AppMessages.dataSaved = langObj.save
        AppMessages.Family_Member_Should_Valid = langObj.validation_hh_family_membr_no
        AppMessages.Name_Atleast_3_Char_Long = langObj.validation_name
        AppMessages.Please_Enter_Institutional_Name = langObj.validation_name_of_institution
        
        AppMessages.areYouSure = langObj.are_you_sure
        AppMessages.agreeImportant = langObj.AGREE
        AppMessages.Not_Connected_To_Internet = LanguageModal.langObj.not_connected_to_internet
       // AppMessages.ebDoesNotExist = langObj.
      //  AppMessages.changedHouseType = langObj.
        
        //Alert
        
        
        


        
    }
}
