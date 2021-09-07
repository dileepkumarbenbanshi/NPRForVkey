//
//  EnglishContent.swift
//  NPR_census
//
//  Created by Dileep on 11/09/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct English {
    
    
    struct dropDownPickerTitle {
        
       static let country = "Choose Country"
    }
    
    func getRelationShipAray(gender:gender) -> [[String:String]]  {
        
        switch gender {
        case .male:
            return relationship_to_head_male()
        case .female:
            return relationship_to_head_female()
        default:
            return relationship_to_head_transGender()
        }
    }
    
    
    func genderList() -> [[String:String]] {
        
        let arayRelation = [["name":"Male","id":"1"],["name":"Female","id":"2"],["name":"Trans Gender","id":"3"]]
        
    return arayRelation
    }
    
    func maritalStatusList() -> [[String:String]] {
        
        let arayRelation = [["name":"Never Married","id":"1"],["name":"Currently Married","id":"2"],["name":"Widowed","id":"3"],["name":"Seprated","id":"4"],["name":"Divorced","id":"5"]]
        
    return arayRelation
    }
    
    func relationship_to_head_male() -> [[String:String]] {
        
        let arayRelation = [["name":"Head/Self","id":"01"],["name":"Spouse","id":"02"],["name":"Son","id":"03"],["name":"Grand Son","id":"04"],["name":"Father","id":"05"],["name":"Grandfather","id":"06"],["name":"Brother","id":"07"],["name":"Son-in-law","id":"08"],["name":"Father-in-law","id":"09"],["name":"Other Related person","id":"10"],["name":"Domestic Servant","id":"11"],["name":"Other Unrelated Person","id":"12"],["name":"","id":""]]
        
            

      return arayRelation
    }
    
    func relationship_to_head_female() -> [[String:String]] {
        

       
        let arayRelation = [["name":"Head/Self","id":"01"],["name":"Spouse","id":"02"],["name":"Daughter","id":"03"],["name":"Grand Daughter","id":"04"],["name":"Mother","id":"05"],["name":"Grandmother","id":"06"],["name":"Sister","id":"07"],["name":"Daughter-in-Law","id":"08"],["name":"Mother-in-law","id":"09"],["name":"Other Related person","id":"10"],["name":"Domestic Servant","id":"11"],["name":"Other Unrelated Person","id":"12"],["name":"","id":""]]

      return arayRelation
    }
    
    func relationship_to_head_transGender() -> [[String:String]] {
        
        let arayRelation = [["name":"Head/Self","id":"01"],["name":"Spouse","id":"02"],["name":"Son/Daughter","id":"03"],["name":"Grand Son/Grand Daughter","id":"04"],["name":"Father/Mother","id":"05"],["name":"Grandfather/Grandmother","id":"06"],["name":"Brother/Sister","id":"07"],["name":"Son-in-law/Daughter-in-Law","id":"08"],["name":"Father-in-law/Mother-in-law","id":"09"],["name":"Other Related person","id":"10"],["name":"Domestic Servant","id":"11"],["name":"Other Unrelated Person","id":"12"],["name":"","id":""]]
        
            

      return arayRelation
    }
    
    func maritalStatus() -> [String] {
        let arayMaritalStatus = ["Choose Marital Status","married","Currently Married","Currently Married","Widowed","Separted","Divorced"]
        
        return arayMaritalStatus
    }
    func education_qualification() -> [[String:String]] {
        

        
        let arayEducationQualification = [["name":"Pre-Primary","id":"00"],["name":"Class 1","id":"01"],["name":"Class 2","id":"02"],["name":"Class 3","id":"03"],["name":"Class 4","id":"04"],["name":"Class 5","id":"05"],["name":"Class 6","id":"06"],["name":"Class 7","id":"07"],["name":"Class 8","id":"08"],["name":"Class 9","id":"09"],["name":"Class 10","id":"10"],["name":"Class 11","id":"11"],["name":"Class 12","id":"12"],["name":"ITI","id":"13"],["name":"Polytechnic","id":"14"],["name":"Nursing Diploma","id":"15"],["name":"Teacher Training Diploma","id":"16"],["name":"Certificate/Other Diploma","id":"17"],["name":"Bachelor/Undergraduate","id":"18"],["name":"PG Diploma","id":"19"],["name":"Master/Post graduate","id":"20"],["name":"M.Phil","id":"21"],["name":"Doctorate & above","id":"22"],["name":"Without formal Education","id":"23"],["name":"Illiterate","id":"99"]]
        
        return arayEducationQualification
        
        
    }
    
    func occupation() -> [[String:String]] {
      

        let arayOccupation = [["name":"Cultivator","id":"1"],["name":"Agriculture Labourer","id":"2"],["name":"Daily wages Earner(Other than Agriculture Labourer)","id":"3"],["name":"Single/Family Worker/Self Employed","id":"4"],["name":"Employer","id":"5"],["name":"Government Employee","id":"6"],["name":"Private Employee(Other than Domestic Helper)","id":"7"],["name":"Domestic Helper","id":"8"],["name":"Non-Worker","id":"9"]]
        
        return arayOccupation
    }
   
    

    
    func dateList() -> [[String:String]] {
        
        let arayRelation = [["name":"Dont Know","id":"00"],["name":"01","id":"01"],["name":"02","id":"02"],["name":"03","id":"03"],["name":"04","id":"04"],["name":"05","id":"05"],["name":"06","id":"06"],["name":"07","id":"07"],["name":"08","id":"08"],["name":"09","id":"09"],["name":"10","id":"10"],["name":"11","id":"11"],["name":"12","id":"12"],["name":"13","id":"13"],["name":"14","id":"14"],["name":"15","id":"15"],["name":"16","id":"16"],["name":"17","id":"17"],["name":"18","id":"18"],["name":"19","id":"19"],["name":"20","id":"20"],["name":"21","id":"21"],["name":"22","id":"22"],["name":"23","id":"23"],["name":"24","id":"24"],["name":"25","id":"25"],["name":"26","id":"26"],["name":"27","id":"27"],["name":"28","id":"28"],["name":"29","id":"29"],["name":"20","id":"30"],["name":"31","id":"31"]]
        
            

      return arayRelation
    }
   
    func MonthList() -> [[String:String]] {
        
        let arayMoth = [["name":"Dont Know","id":"00"],["name":"January","id":"01"],["name":"February","id":"02"],["name":"March","id":"03"],["name":"April","id":"04"],["name":"May","id":"05"],["name":"June","id":"06"],["name":"July","id":"07"],["name":"August","id":"08"],["name":"September","id":"09"],["name":"October","id":"10"],["name":"November","id":"11"],["name":"December","id":"12"]]
        
            

      return arayMoth
    }
    
    
    struct commonString {
        static let census_household_no = ""
        
    }
    
    struct AddNewMemberFormAlert {
        
        static let newMember = "New Member"
        static let hhEmpty = "Check Census Household No. as in Houselist"
        static let hNEmpty = "Check Census House Number as in Houselist,which cannot be empty"
        static let nameValidation = "Name should be at least 3 characters long"
        static let hhValidation = "Household No. should be valid number"
        static let censusHHNoExist = "Census Household no. as in Houselist (New) already exist"
        
        static let hhAlreadyExist = "Household No. already exist"
        static let memberNumberValidation = "No. of family Member should be valid number."
        static let relationEmpty = "Choose relationship with Head"
        static let chooseNationality = "Select Nationality"
        static let dob_invalid = "Please enter a valid date of birth"
        
        static let gender = "Choose Gender"
        static let maritalStatusMiss = "Choose Marital Status"
        static let memberDOBEmpty = "Member date of birth cannot be empty"
        static let memberDob_monthEmpty = "Member month of birth cannot be empty"
        static let memberDob_yearEmpty = "Member year of birth cannot be empty"
        static let relationEmpmemberDOB_valid = "Please enter a valid Member\'s date of birth"
        static let memberBirthDate_today = "Birth Date cannot be today\'s date"
        
        static let memberBirthDate_future = "Birth Date can not be future date"
        static let memberBirthCountry = "Choose Birth Country"
        static let memberBirthState = "Choose Birth State"
        static let chosoeBirthDistrict = "Choose Birth District"
        
        static let chosseYourCountry = "Choose your Country"
        static let memberBirthDistrict = "Choose Birth District"
        static let memberBirthSubDistrict = "Choose Birth Sub-District"
        static let chooseEduQualification = "Choose Education Qualification"
        static let chooseOccupation = "Choose Occupation"
        static let chooseMotherTongue = "Choose MotherTongue"
        
        // Parent's Detail
        // Father's
        static let fatherNameInvalid = "Father Name should be more atleast 3 character "
        static let fatherDob_invalid = "Please enter a valid Father's date of birth"
        static let chooseFatherDob_country = "Choose Father's Birth Country"
        static let chooseFatherDob_state = "Choose Father's Birth State"
        static let chooseFatherDob_district = "Choose Father's Birth District"
        static let selectFatherName = " Select Father Name "
        // Mother's
        
        static let motherNameInvalid = "Mother Name should be more atleast 3 character "
        static let motherDob_invalid = "Please enter a valid Mother's date of birth"
        static let chooseMotherDob_country = "Choose Mother's Birth Country"
        static let chooseMotherDob_state = "Choose Mother's Birth State"
        static let chooseMotherDob_district = "Choose Mother's Birth District"
        static let selectMotherName = " Select Mother Name "
        
        // Spouse Detail
        
        static let spouseNameInvalid = "Spouse Name should be more atleast 3 character "
        //Present Address
        static let choosePresentAddress_country = "Choose Present Address Country"
        static let choosePresentAddress_state = "Choose Present Address State"
        static let choosePresentAddress_district = "Choose Present Address District"
        static let choosePresentAddress_subDistrict = "Choose Present Address Sub-District"
        static let checkPresentAddress_HouseNumber = "Check Present Address House Number and Locality"
         static let checkPresentAddress_town_village = "Check Present Address Town/Village"
        static let checkPresentAddress_pinCode = "Check Present Address Pin Code"
       
       
       
        
        //Permanent Address
        static let choosePermanentAddress_country = "Choose Permanent Address Country"
        static let choosePermanentAddress_state = "Choose Permanent Address State"
        static let choosePermanentAddress_district = "Choose Permanent Address District"
        static let choosePermanentAddress_subDistrict = "Choose Permanent Address Sub-District"
        static let checkPermanentAddress_HouseNumber = "Check Permanent Address House Number and Locality"
         static let checkPermanentAddress_town_village = "Check Permanent Address Town/Village"
        static let checkPermanentAddress_pinCode = "Check Permanent Address Pin Code"
        
        
        // Member ID Detail
        
        static let inValidAadharNumber = "Check Aadhar Number"
        static let inValidAadharLenth = "Aadhar Number should be 12 digit"
        static let inValidMobilerNumber = "Check Mobile Number"
        static let inValidMobileLenth = "Mobile Number should be 10 digit"
        static let inValidVoterID = "Check Voter-ID "
        static let inValidDL = "Check Driving Licence ID"
        
        //Other alert message
        
        static let doYouWantAddMoreMember = "Press YES to add more member else click on No"
        
        static let tapBackButton  = "If you press Yes, you will lose entered data (if any)"
        
        static let memberUpdatedSuccess = "Member Updated Successfully"
        
        static let newMemberAddedSuccesFully = "New member added successfully"
    }
    
    struct IncompleHHOrViewEditPage {
      
        let searchPlaceHolder = "Search"
        let deletMemberAlert = "To delete member - "
        
        
    }
    
    struct SplitView {
      
        let searchPlaceHolder = "Search"
        let deletMemberAlert = "To delete member - "
        let splitNumberAlert = "split number should be between "
        
        let splitNumberGreter = "Split number should be greater than 1 "
        
        let availableMember = "Sliting is only applicable for more than 1 Available member"
        
        let atleastOneMemberLeftInsameHH = "Atleast one member should available in current HouseHold"
        
        static let slitDoneAlert = "If This Household Spliting is done then press Yes else No"
        
        static let splitDoneTittle = "Splitting Completed"
        //static let splitDoneTittle = "Splitting Completed"

    }
    
    struct signatureRespondent {
        static let signature_consent = "I acknowledge and confirm that the Enumerator has shown/read all my household particulars recorded on the App(as told by me) and I declare that all the information provided by me is true to the best of my knowledge and belief."
        static let respondant_unable_to_sign_consent = "Read and signed in front of respondent by Enumerator because respondent is unable to sign."
        static let respondent = "Respondent"
        static let signType = "Respondent Signature"
        static let enumerator_status = "Enumerator Status"
        static let census_household_no = "Census House No. as in Houselist"
        static let  hhNumber = "Household Number"
        static let  tickRespondent = "Please tick the consent."
        static let  chooseRespondent = "Choose Respondent"
        static let  tickRespondent_chhoseRespont = "Please tick the consent \n Choose Respondent"
        
       
    }
    
    struct HouseholdDetail {
        static let headSelectionC = " is new head of Household"
        
        static let atLeastOneMemberINHH = " Atleast One Member must be Available in Household "
       
    }
    
    
}




