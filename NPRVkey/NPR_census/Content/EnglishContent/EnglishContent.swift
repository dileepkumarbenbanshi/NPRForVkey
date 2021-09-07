//
//  EnglishContent.swift
//  NPR_census
//
//  Created by Dileep on 11/09/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

struct English {
    
    
//    struct dropDownPickerTitle {
//        
//       static var country = "Choose Country"
//    }
    
//    func getRelationShipAray(gender:gender) -> [[String:String]]  {
//
//        switch gender {
//        case .male:
//            return relationship_to_head_male()
//        case .female:
//            return relationship_to_head_female()
//        default:
//            return relationship_to_head_transGender()
//        }
//    }

//    func genderList() -> [[String:String]] {
//
//        var arayRelation = [["name":"Male","id":"1"],["name":"Female","id":"2"],["name":"Trans Gender","id":"3"]]
//
//    return arayRelation
//    }
//
//    func maritalStatusList() -> [[String:String]] {
//
//        var arayRelation = [["name":"Never Married","id":"1"],["name":"Currently Married","id":"2"],["name":"Widowed","id":"3"],["name":"Seprated","id":"4"],["name":"Divorced","id":"5"]]
//
//    return arayRelation
//    }
//
//
//    func relationship_to_head_male() -> [[String:String]] {
//
//        var arayRelation = [["name":"Head/Self","id":"01"],["name":"Spouse","id":"02"],["name":"Son","id":"03"],["name":"Grand Son","id":"04"],["name":"Father","id":"05"],["name":"Grandfather","id":"06"],["name":"Brother","id":"07"],["name":"Son-in-law","id":"08"],["name":"Father-in-law","id":"09"],["name":"Other Related person","id":"10"],["name":"Domestic Servant","id":"11"],["name":"Other Unrelated Person","id":"12"]]
//
//
//
//      return arayRelation
//
//    }
//
//    func relationship_to_head_female() -> [[String:String]] {
//
//
//
//        var arayRelation = [["name":"Head/Self","id":"01"],["name":"Spouse","id":"02"],["name":"Daughter","id":"03"],["name":"Grand Daughter","id":"04"],["name":"Mother","id":"05"],["name":"Grandmother","id":"06"],["name":"Sister","id":"07"],["name":"Daughter-in-Law","id":"08"],["name":"Mother-in-law","id":"09"],["name":"Other Related person","id":"10"],["name":"Domestic Servant","id":"11"],["name":"Other Unrelated Person","id":"12"]]
//
//      return arayRelation
//    }
//
//    func relationship_to_head_transGender() -> [[String:String]] {
//
//        var arayRelation = [["name":"Head/Self","id":"01"],["name":"Spouse","id":"02"],["name":"Son/Daughter","id":"03"],["name":"Grand Son/Grand Daughter","id":"04"],["name":"Father/Mother","id":"05"],["name":"Grandfather/Grandmother","id":"06"],["name":"Brother/Sister","id":"07"],["name":"Son-in-law/Daughter-in-Law","id":"08"],["name":"Father-in-law/Mother-in-law","id":"09"],["name":"Other Related person","id":"10"],["name":"Domestic Servant","id":"11"],["name":"Other Unrelated Person","id":"12"]]
//
//
//
//      return arayRelation
//    }
    
//    func maritalStatus() -> [String] {
//        var arayMaritalStatus = ["Choose Marital Status","married","Currently Married","Currently Married","Widowed","Separted","Divorced"]
//
//        return arayMaritalStatus
//    }
//    func education_qualification() -> [[String:String]] {
//
//
//
//        var arayEducationQualification = [["name":"Pre-Primary","id":"00"],["name":"Class 1","id":"01"],["name":"Class 2","id":"02"],["name":"Class 3","id":"03"],["name":"Class 4","id":"04"],["name":"Class 5","id":"05"],["name":"Class 6","id":"06"],["name":"Class 7","id":"07"],["name":"Class 8","id":"08"],["name":"Class 9","id":"09"],["name":"Class 10","id":"10"],["name":"Class 11","id":"11"],["name":"Class 12","id":"12"],["name":"ITI","id":"13"],["name":"Polytechnic","id":"14"],["name":"Nursing Diploma","id":"15"],["name":"Teacher Training Diploma","id":"16"],["name":"Certificate/Other Diploma","id":"17"],["name":"Bachelor/Undergraduate","id":"18"],["name":"PG Diploma","id":"19"],["name":"Master/Post graduate","id":"20"],["name":"M.Phil","id":"21"],["name":"Doctorate & above","id":"22"],["name":"Without formal Education","id":"23"],["name":"Illiterate","id":"99"]]
//
//        return arayEducationQualification
//
//
//    }
    
//    func occupation() -> [[String:String]] {
//
//
//        var arayOccupation = [["name":"Cultivator","id":"1"],["name":"Agriculture Labourer","id":"2"],["name":"Daily wages Earner(Other than Agriculture Labourer)","id":"3"],["name":"Single/Family Worker/Self Employed","id":"4"],["name":"Employer","id":"5"],["name":"Government Employee","id":"6"],["name":"Private Employee(Other than Domestic Helper)","id":"7"],["name":"Domestic Helper","id":"8"],["name":"Non-Worker","id":"9"]]
//
//        return arayOccupation
//    }
   
    static var arayGender = [["name":"Male","id":"1"],["name":"Female","id":"2"],["name":"Trans Gender","id":"3"]]
    
    static var arayMaritalStatusList = [["name":"Never Married","id":"1"],["name":"Currently Married","id":"2"],["name":"Widowed","id":"3"],["name":"Seprated","id":"4"],["name":"Divorced","id":"5"]]
    
    static var arayRelation_head_male = [["name":"Head/Self","id":"01"],["name":"Spouse","id":"02"],["name":"Son","id":"03"],["name":"Grand Son","id":"04"],["name":"Father","id":"05"],["name":"Grandfather","id":"06"],["name":"Brother","id":"07"],["name":"Son-in-law","id":"08"],["name":"Father-in-law","id":"09"],["name":"Other Related person","id":"10"],["name":"Domestic Servant","id":"11"],["name":"Other Unrelated Person","id":"12"],["name":"","id":""]]
    
    static var arayRelation_head_female = [["name":"Head/Self","id":"01"],["name":"Spouse","id":"02"],["name":"Daughter","id":"03"],["name":"Grand Daughter","id":"04"],["name":"Mother","id":"05"],["name":"Grandmother","id":"06"],["name":"Sister","id":"07"],["name":"Daughter-in-Law","id":"08"],["name":"Mother-in-law","id":"09"],["name":"Other Related person","id":"10"],["name":"Domestic Servant","id":"11"],["name":"Other Unrelated Person","id":"12"],["name":"","id":""]]
    
    static var arayRelation_head_transGender = [["name":"Head/Self","id":"01"],["name":"Spouse","id":"02"],["name":"Son/Daughter","id":"03"],["name":"Grand Son/Grand Daughter","id":"04"],["name":"Father/Mother","id":"05"],["name":"Grandfather/Grandmother","id":"06"],["name":"Brother/Sister","id":"07"],["name":"Son-in-law/Daughter-in-Law","id":"08"],["name":"Father-in-law/Mother-in-law","id":"09"],["name":"Other Related person","id":"10"],["name":"Domestic Servant","id":"11"],["name":"Other Unrelated Person","id":"12"],["name":"","id":""]]
    
    static var arayMaritalStatus = ["Choose Marital Status","married","Currently Married","Currently Married","Widowed","Separted","Divorced"]
    
    static var arayEducationQualification = [["name":"Pre-Primary","id":"00"],["name":"Class 1","id":"01"],["name":"Class 2","id":"02"],["name":"Class 3","id":"03"],["name":"Class 4","id":"04"],["name":"Class 5","id":"05"],["name":"Class 6","id":"06"],["name":"Class 7","id":"07"],["name":"Class 8","id":"08"],["name":"Class 9","id":"09"],["name":"Class 10","id":"10"],["name":"Class 11","id":"11"],["name":"Class 12","id":"12"],["name":"ITI","id":"13"],["name":"Polytechnic","id":"14"],["name":"Nursing Diploma","id":"15"],["name":"Teacher Training Diploma","id":"16"],["name":"Certificate/Other Diploma","id":"17"],["name":"Bachelor/Undergraduate","id":"18"],["name":"PG Diploma","id":"19"],["name":"Master/Post graduate","id":"20"],["name":"M.Phil","id":"21"],["name":"Doctorate & above","id":"22"],["name":"Without formal Education","id":"23"],["name":"Illiterate","id":"99"]]
    
    static var arayOccupation = [["name":"Cultivator","id":"1"],["name":"Agriculture Labourer","id":"2"],["name":"Daily wages Earner(Other than Agriculture Labourer)","id":"3"],["name":"Single/Family Worker/Self Employed","id":"4"],["name":"Employer","id":"5"],["name":"Government Employee","id":"6"],["name":"Private Employee(Other than Domestic Helper)","id":"7"],["name":"Domestic Helper","id":"8"],["name":"Non-Worker","id":"9"]]
    
    struct dropDownPickerTitle {
        
       static var country = "Choose Country"
        
    }
    
    func getRelationShipAray(gender:gender) -> [ModelNameID]  {
        
        switch gender {
        case .male:
            return LanguageModal.langObj.relationship_to_head_male
        case .female:
            return LanguageModal.langObj.relationship_to_head_female
        default:
            return LanguageModal.langObj.relationship_to_head
        }
        
    }
    
    
    func getRelationShipAray(sex:String) -> [ModelNameID]  {
        let intGender = Int(sex)
        let genderE = gender.init(rawValue: intGender ?? 1)
        
        switch genderE {
        case .male:
            return LanguageModal.langObj.relationship_to_head_male
        case .female:
            return LanguageModal.langObj.relationship_to_head_female
        default:
            return LanguageModal.langObj.relationship_to_head
        }
        
    }
    
    func genderList() -> [[String:String]] {
        
        return English.arayGender
    }
    
    
//    func maritalStatusList() -> [[String:String]] {
//
//        return English.arayMaritalStatusList
//
//    }
    
    func maritalStatusList() -> [ModelNameID] {
        
        return LanguageModal.langObj.marital_statusArr
        
    }
    
    func relationship_to_head_male() -> [[String:String]] {
        
        return English.arayRelation_head_male
        
    }
    func relationship_to_head_female() -> [[String:String]] {
    
        return English.arayRelation_head_female
    }
    
    
    func relationship_to_head_transGender() -> [[String:String]] {
        
        return English.arayRelation_head_transGender
        
    }

    func maritalStatus() -> [String] {
        
        return English.arayMaritalStatus
        
    }
    func education_qualification() -> [[String:String]] {
        
        return English.arayEducationQualification
        
        
    }
    
    func occupation() -> [[String:String]] {
        
        return English.arayOccupation
        
    }
    
    
    func motherTongueList() -> [[String:String]] {
        var arayDict = [["":""]]
        if var URL = Bundle.main.url(forResource: "MotherToungue", withExtension: "plist") {
            
        if var arr = NSArray(contentsOf: URL) as? [String] {
        
                
                for item in arr {
                    var arayDateComponent = item.components(separatedBy: "-")
                    var dict = ["name":item,"id":arayDateComponent[1]]
                    arayDict.append(dict)
                }
                print( "Final Aray",arayDict)
            
    }
        }
            return arayDict
}
        

    
    
   
    
    
    
    struct commonString {
        static var census_household_no = ""
        
    }
    
    struct AddNewMemberFormAlert {
        
        static var newMember = "New Member"
        static var hhEmpty = "Check Census Household No. as in Houselist"
        static var hNEmpty = "Check Census House Number as in Houselist,which cannot be empty"
        static var nameValidation = "Name should be at least 3 characters long"
        static var hhValidation = "Household No. should be valid number"
        static var censusHHNoExist = "Census Household no. as in Houselist (New) already exist"
        
        static var hhAlreadyExist = "Household No. already exist"
        static var memberNumberValidation = "No. of family Member should be valid number."
        static var relationEmpty = "Choose relationship with Head"
        static var chooseNationality = "Select Nationality"
        static var invalidPassportVlidation = "Please check Passport number"
        
        static var dob_invalid = "Please enter a valid date of birth"
        
        static var gender = "Choose Sex"
        static var maritalStatusMiss = "Choose Marital Status"
        static var memberDOBEmpty = "Member date of birth cannot be empty"
        static var memberDob_monthEmpty = "Member month of birth cannot be empty"
        static var memberDob_yearEmpty = "Member year of birth cannot be empty"
        static var relationEmpmemberDOB_valid = "Please enter a valid Member\'s date of birth"
        static var memberBirthDate_today = "Birth Date cannot be today\'s date"
        
        static var memberBirthDate_future = "Birth Date can not be future date"
        static var memberBirthCountry = "Choose Birth Country"
        static var memberBirthState = "Choose Birth State"
        static var chosoeBirthDistrict = "Choose Birth District"
        
        static var chosseYourCountry = "Choose your Country"
        static var memberBirthDistrict = "Choose Birth District"
        static var memberBirthSubDistrict = "Choose Birth Sub-District"
        static var chooseEduQualification = "Choose Education Qualification"
        static var chooseOccupation = "Choose Occupation"
        static var chooseMotherTongue = "Choose MotherTongue"
        
        // Parent's Detail
        // Father's
        static var fatherNameInvalid = "Father Name should be more atleast 3 character "
        static var fatherDob_invalid = "Please enter a valid Father's date of birth"
        static var fatherDob_monthEmpty = "Father month of birth cannot be empty"
        static var fatherDob_yearEmpty = "Father year of birth cannot be empty"
        static var chooseFatherDob_country = "Choose Father's Birth Country"
        static var chooseFatherDob_state = "Choose Father's Birth State"
        static var chooseFatherDob_district = "Choose Father's Birth District"
        static var selectFatherName = " Select Father Name "
        // Mother's
        
        static var motherNameInvalid = "Mother Name should be more atleast 3 character "
        static var motherDob_invalid = "Please enter a valid Mother's date of birth"
        static var motherDob_monthEmpty = "Mother month of birth cannot be empty"
        static var motherDob_yearEmpty = "Mother year of birth cannot be empty"
        static var chooseMotherDob_country = "Choose Mother's Birth Country"
        static var chooseMotherDob_state = "Choose Mother's Birth State"
        static var chooseMotherDob_district = "Choose Mother's Birth District"
        static var selectMotherName = " Select Mother Name "
        
        // Spouse Detail
        
        static var spouseNameInvalid = "Spouse Name should be more atleast 3 character "
        //Present Address
        static var choosePresentAddress_country = "Choose Present Address Country"
        static var choosePresentAddress_state = "Choose Present Address State"
        static var choosePresentAddress_district = "Choose Present Address District"
        static var choosePresentAddress_subDistrict = "Choose Present Address Sub-District"
        static var checkPresentAddress_HouseNumber = "Check Present Address House Number and Locality"
         static var checkPresentAddress_town_village = "Check Present Address Town/Village"
        static var checkPresentAddress_HouseNumberLocality = "Check Present Address House Number and Locality"
        static var checkPresentAddress_pinCode = "Check Present Address Pin Code"
       
       
       
        
        //Permanent Address
        static var choosePermanentAddress_country = "Choose Permanent Address Country"
        static var choosePermanentAddress_state = "Choose Permanent Address State"
        static var choosePermanentAddress_district = "Choose Permanent Address District"
        static var choosePermanentAddress_subDistrict = "Choose Permanent Address Sub-District"
        static var checkPermanentAddress_HouseNumber = "Check Permanent Address House Number and Locality"
         static var checkPermanentAddress_town_village = "Check Permanent Address Town/Village"
        static var checkPermanentAddress_HouseNumberLocality = "Check Permanent Address House Number and Locality"
        static var checkPermanentAddress_pinCode = "Check Permanent Address Pin Code"
        static var chooseStaySinceBirth = "Choose Whether staying at present address since birth."
        static var stayYearMorethanAge = "This value can not be more than your age"
        static var stayYearCanNotEmpty = "Staying at present address can not be empty"
        static var chooseLastResidencyState = "Choose Last Residence Address State"
        
        static var chooseLastResidencyDistrict = "Choose Last Residence Address District"
        // Member ID Detail
        
        static var inValidAadharNumber = "Check Aadhaar Number"
        static var inValidAadharLenth = "Aadhaar Number should be 12 digit"
        static var inValidMobilerNumber = "Check Mobile Number"
        static var inValidMobileLenth = "Mobile Number should be 10 digit"
        static var inValidVoterID = "Check Voter-ID "
        static var inValidDL = "Check Driving Licence ID"
        static var proceedWithoutAadhar = "Do you want to proceed without adding Aadhaar detail?"
        
        //Other alert message
        
        static var doYouWantAddMoreMember = "Press YES to add more member else click on No"
        
        static var tapBackButton  = "If you press Yes, you will lose entered data (if any)"
        
        static var memberUpdatedSuccess = "Member Updated Successfully"
        
        static var newMemberAddedSuccesFully = "New member added successfully"
    }
    
    struct IncompleHHOrViewEditPage {
      
        static var searchPlaceHolder = "Search"
        static var deleteMemberAlert = "To delete member - "
       static var cantAddNewHHinThisHLB = "Now you can not add new household in this HLB"
        
        
    }
    
    struct SplitView {
      
         var searchPlaceHolder = "Search"
         var deleteMemberAlert = "To delete member - "
         var splitNumberAlert = "split number should be between "
         var splitNumberShouldGreterThan2 = "Split number should not be less than 2"
         var splitNumberGreter = "Household with existing status cannot be splitted "
         var atleastTwoMemberShouldAvailble = "Atleast 2 member must be available in Household "
         var availableMember = "Splitting is only applicable for more than 1 Available member"
        
         var atleastOneMemberLeftInsameHH = "Atleast one member should available in current HouseHold"
        
        static var slitDoneAlert = "If This Household Splitting is done then press Yes else No"
        
        static var splitDoneTittle = "Splitting Completed"
        //static var splitDoneTittle = "Splitting Compvared"

    }
    
    struct signatureRespondent {
        static var signature_consent = "I acknowledge and confirm that the Enumerator has shown/read all my household particulars recorded on the App(as told by me) and I declare that all the information provided by me is true to the best of my knowledge and belief."
        static var respondant_unable_to_sign_consent = "Read and signed in front of respondent by Enumerator because respondent is unable to sign."
        static var respondent = "Respondent"
        static var signType = "Respondent Signature"
        static var enumerator_status = "Enumerator Status"
        static var census_household_no = "Census House No. as in Houselist"
        static var  hhNumber = "Household Number"
        static var  tickRespondent = "Please tick the consent."
        static var  chooseRespondent = "Choose Respondent"
        static var  tickRespondent_chhoseRespont = "Please tick the consent \n Choose Respondent"
        static var signatureCaptredSuccess = "Signature capture successful"
        static var signatureRequired = "Respondent Sign required"
        static var signatureRequiredMessage = "Press OK to take Respondent Signature"
        
       
    }
    
    struct UploadData {
       static var completeEBAlert = "If you click YES,then this HLB will be marked as Complete. Else,click NO"
       static var completeEBAlertConfirm = "Are you sure to mark the current HLB Completed?"
       //static var hlbCompletedAlert = "HLB Completed Successfully"
        
    }
    struct HouseholdDetail {
        static var headSelectionC = " is new head of Household"
        static var shiftMemberIntoHH = " is shifted to Household Number "
        static var atLeastOneMemberINHH = " Atleast One Member must be Available in Household "
        static var toShift = "To shift"
       static var deleteMember = "To delete Member - "
        static var titleIncompleteHH = "Incompplete HouseHold"
        static var titleViewEditHH = "View/Edit"
    }
    
    struct superVisorHHDetail {
        static var remarkSaved = "Remark saved successfully"
        static var remarkLenth = "Failed to capture remark.Remark should be at least 2 characters long "
        
       
    }
    
}




