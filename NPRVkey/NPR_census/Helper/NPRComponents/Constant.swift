//
//  Constant.swift
//  NPR Screen
//
//  Created by mac on 11/08/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit
let isProd = false
//let isProd = true
struct BaseUrl {
    //static let url = "http://10.10.10.21/fluwiz/"
    // Dev Base Url
    static let url1 = "http://10.10.10.21/"
    static let urlProdDefault = "https://apidel.census.gov.in"
    
    
     static var url = isProd ? "\(UserDefaults().getUserDefaultValue(key: .baseUrlProd ))"  : "https://vaptapi.census.gov.in:8081"
    
   
}

var baseURL:String{
    let url = isProd ? "\(UserDefaults().getUserDefaultValue(key: .baseUrlProd ))"  : "https://vaptapi.census.gov.in:8081"
    return url
}


struct AppFormat {
    
    static let hhFormat = "%05d"
    static let censusHHFormat = "%04d"
    static let censusHNFormat = "%03d"
    static let member_sr_Format = "%03d"
    static let twodigitFormat = "%02d"
    static let threeDigitFormat = "%03d"
    static let fourdigitFormat = "%04d"
    static let fivedigitFormat = "%05d"
    
    
}
fileprivate struct RegixString {
    
    static var regexStr:String {
         let arrSepRate = LanguageModal.currentLanguage.components(separatedBy: "-")
       var Regex = ""
         switch arrSepRate[0] {
         case "English" :
            // Regex = "\\u0000-\\u007F"
            Regex = "a-z,A-Z "
             break
         case "Hindi" :
             Regex = "\\u0905-\\u0963"//"[\\u0900-\\0965\\u0970-\\u097F\\u0030-\\u0039 ()]*"
             break
         case "Assamese" :
             Regex = "\\u0980-\\u09FF"
             break
         case "Urdu" :
             Regex = "\\u0621-\\u064A"
             break
         case "Punjabi" :
             Regex = "\\u0A00-\\u0A7F"//"[\\u0A00-\\u0A65\\u0A70-\\u0A76\\u0030-\\u0039 ()]*"
             break
         case "Malyalam" :
             Regex = "\\u0D00-\\u0D7F"
             break
             
         case "Marathi" :
             
             Regex = "\\u0900-\\u0963"
             break
         case "Konkani" :
             
             Regex = "\\u0900-\\0965"
             break
             
         case "Gujarati" :
             
             Regex = "\\u0A80-\\u0AFF"
             break
             
         case "Bengali" :
             
             Regex = "\\u0980-\\u09FF"
             break
         case "Tamil" :
             
             Regex = "\\u0B80-\\u0BFF"
             break
         case "Kannada" :
             
             Regex = "\\u0C80-\\u0CFF"
             break
         case "Odia" :
             
             Regex = "\\u0B00-\\u0B7F"
             break
         case "Nepali" :
             
             Regex = "\\u0900-\\0965"
             break
             
         case "Telugu" :
             
             Regex = "\\u0C00-\\u0C7F"
             break
             
         default:
             Regex = "\\u0000-\\u007F"
         }
         return Regex
     }
     
    
}

struct Regix {
    
    static var regeixAlphabetSpace = "^[\(RegixString.regexStr)]*$"
    static var regixNumber = "^[0-9]*$"
    static var adress = "^[\(RegixString.regexStr)()0-9 ./]*$"
  
    
    
}
    
struct  HHStatusCode{
    static let old             = "0"
    static let available       = "1"
    static let locked          = "2"
    static let migratedOut     = "3"
    static let notAvailable    = "4"
    static let new             = "5"
   
}
enum HHStaus:String {
    case available    = "1"
    case locked       = "2"
    case migratedOut  = "3"
    case notAvailable = "4"
    case new          = "5"
        
}

struct MemberStatusCode {
    static let notStarted   = "0"
    static let available    = "1"
    static let dead         = "2"
    static let migratedOut  = "3"
    static let newMember    = "4"
    static let notAvailable = "5"
    static let lockedMember = "6"
}

enum MemberLivingStatusCode:String {
    case notStarted  = "0"
    case available    = "1"
    case dead         = "2"
    case migratedOut  = "3"
    case newMember    = "4"
    case notAvailable = "5"
    case lockedMember = "6"
    
    func shortCode() -> String {
        switch self {
        case .notStarted :
            return "NS"
        case .available:
            return "AV"
            
        case.dead:
        return "Di"
        
        case.lockedMember:
        return "LO"
            
        case.migratedOut:
            
        return "MO"
            
        case.newMember:
        return "NM"
        
        case.notAvailable:
        return "NA"
            
        
        
        }
    }
    func dcodeDetail() -> String {
        switch self {
        case .notStarted :
            return "Not Started"
        case .available:
            return "Available"
            
        case.dead:
        return "Died"
        
        case.lockedMember:
        return "Locked"
            
        case.migratedOut:
            
        return "Moved Out"
            
        case.newMember:
        return "New Member"
        
        case.notAvailable:
        return "Not Available"
            
        
        
        }
    }
    
    
}
struct HHCompletionStatusCode {
    static let notStarted         = "0"
    static let inComplete         = "1"
    static let completed          = "2"
    static let uploaded           = "3"
    
}

struct MemberCompletionStatusCode {
    static let notStarted         = "0"
    static let completed          = "1"
    static let uploaded           = "2"
    static let deleted            = "3"
    
}
enum MemberCompletionStatus:String {
    case notStarted         = "0"
    case completed          = "1"
    case uploaded           = "2"
    case deleted            = "3"
    
}

enum HouseType:String {
    case normal = "1"
    case institute = "2"
    case houseLess  = "3"
    
    
}

enum entryFieldType {
    case name  , number , address ,passport ,voterID
}


struct EndPoint {
    static let getBaseURL = "/fluwiz/api/v1/pg/nquery/multidc/baseurl/first"
    
      static let Device_Enroll          = "/fluwiz/device/v1/pg/100/enlist"
      static let Device_De_Enroll       = "/fluwiz/device/v1/pg/100/delist"
      static let Verify_OTP             = "/fluwiz/device/v1/pg/100/verify"
      static let getOTP                 = "/fluwiz/api/v1/pg/exec/otp/send"
    static let changePwdOtpVeriFy = "/fluwiz/api/v1/pg/exec/otp/verify"
    
      static let country_List           = "/fluwiz/api/v1/pg/query/master_GeoCountry/list"
      static let state_List             = "/fluwiz/api/v1/pg/query/master_MstState/list"
      static let district_List          = "/fluwiz/api/v1/pg/query/master_MstDistrict/list"
      static let Tahsil_List            = "/fluwiz/api/v1/pg/query/master_MstTehsil/list"
      static let npr_2019Data_download  = "/fluwiz/api/v2/pg/query/nprdata2019_enum"
      static let npr_2021Data_download  = "/fluwiz/api/v2/pg/query/nprdata2021_enum"
     // static let uploadData            
      static let ebList                 = "/fluwiz/api/v1/pg/nquery/eballotment/nprenumerator/list"
    static let hloDataDownload          = "/fluwiz/api/v1/pg/nquery/eballotment/nprhousingdata/list"
      static let Upload_Data            = "/fluwiz/api/v2/pg/data/nprdatasig2021_enum"
      static let Active_Device          = "/fluwiz/device/v1/pg/100/active"
    static let EB_Start_Date = "/fluwiz/api/v1/pg/exec/npreb2021_enum/start"
    static let EB_Completion_Date = "/fluwiz/api/v1/pg/exec/npreb2021_enum/start"
    static let Expected_HH = "/fluwiz/api/v1/pg/data/npreb2021_enum"
    static let EB_Completation = "/fluwiz/api/v1/pg/exec/npreb2021_enum/complete"
    
    //SuperVisor
    
   
    static let super_hlbList = "/fluwiz/api/v1/pg/nquery/eballotment/nprsupervisor/list"
    static let createEbDetail = "/fluwiz/api/v1/pg/data/npreb2021_enum"
    static let super_downloadEb = "/fluwiz/api/v2/pg/query/nprdata2021_supr"
    static let Super_UploadData = "/fluwiz/api/v2/pg/data/nprdatasig2021_supr"
     
}



struct DeviceType {
    static let IS_IPHONE = UIDevice.current.userInterfaceIdiom == .phone
    static let IS_IPAD = UIDevice.current.userInterfaceIdiom == .pad
}

enum APIType {
    case DeviceManagement
    case NonDeviceManagement
}
struct storyBoardName {
   static let main = "Main"
    static let npr = "NPR"
    static let superVisor = "SuperVisor"
    
    
}

struct storyBoard {
    static let main = UIStoryboard.init(name:storyBoardName.main , bundle: nil)
     static let npr = UIStoryboard.init(name:storyBoardName.npr , bundle: nil)
}

enum RequestType:String {
    case GET
    case POST
    case PUT
    case DELETE
    case MULTIPART
    
    func requestType() -> String {
        switch self {
        case .GET:
            return "GET"
        case .POST:
            return "POST"
        case .PUT:
            return "PUT"
        case .DELETE:
            return "DELETE"
        case .MULTIPART:
            return "POST"
        }
    }
    
    
}

struct ClassID {
    static let addNewHouseHold = "AddNewHousehold_VC"
    static let addNewMemberForm = "AddNewHouseHoldForm_TVC"
    static let splitHousehold   =  "SplitHouseHold_VC"
    static let hhMemberDetail   = "HouseholdMemberDetail_ViewController"
    static let uploadData = "UploadDataVC"
    static let changeHHType = "ChangeHouseTypeVC"
    static let changePasswordOTPVerify = "ChangePasswordOtpVC"
}
struct Application {
    static let AppCode = "2"
}



enum MemberStatus:String {
    
    case available = "A"
    case movedOut = "M"
    case died    = "D"
}

enum gender:Int {
    
    case male = 1
    case female = 2
    case transGender = 3
    case notSelect = 4
}

struct Param_Key {
    
    static let DeviceID = "deviceId"
    static let Application = "application"
    static let Manufacturer = "manufacturer"
    static let Model = "model"
    static let SerialNumber = "serialNumber"
    static let OSVersion = "osVersion"
    static let AppVersion = "appVersion"
    static let OSPatch = "osPatch"
    static let OTP = "otp"
    static let ReasonGetOtp = "reason"
    static let StateCode = "statecode"
    static let DistrictCode = "districtcode"
    static let TehsilCode = "tehsilcode"
    static let TownCode = "towncode"
    static let WardID = "wardid"
    static let BlockNo = "blockno"
    static let SubEBNo = "subebno"
    static let NPREnumStarted = "nprEnumStarted"
    static let BatchID = "batchId"
    static let Record = "record"
    static let Signature = "signature"
    static let SignedON = "signedOn"
    static let NPREnumCompletion = "nprEnumCompletion"
    
}

struct classTitle {
    static let incompleteTitle = "Incomplete Household"
    static let locationParticular = "Location Particular"
    
}

struct AppMessages {
    
//    var lanModel:LanguageModal
//
//
//    init(model:LanguageModal) {
//        lanModel=model
//    }
//    var userId :String {
//        return LanguageModal?.lanModel.userId
//    }
    
   
    static let networkConnection = "Check your network connection"
    
    static var User_Id_Password_Can_not_be_Empty = "UserId and Password cannot be empty"
    static var Please_Enter_Correct_OTP =  "Please enter correct OTP"
    static var Password_Empty =  "Password fields can not be blank"
    static var Both_Password_Same =  "Both Password should be same"
    static var Expected_hh_Can_not_be_Blank =  "Expected Households No. cannot be blank"
    static var Expected_hh_Can_not_be_One = "Expected Households No. cannot be 1"
    static var Age_Text = "Enter age to calculate date of birth"
    static var Expected_hh_Can_not_be_More_Than = "Expected Households No. cannot be exceed than no.of HouseHold Members"
    static var Alert_Date = "Member doesnot know date of birth but knows age"
    static var Success = "Data Uploaded Successfully"
    static var Error401 = "You are not authorised user to upload Data"
    static var Error400 = "Bad Request"
    static var Server_Response = "Server Response"
    static var UnAuthorized_Access = "Unauthorized Access"
    static var device_de_enrolled = "This device has been de-enrolled"
    static var invalidCredential = "Please enter valid credential"
    static var Success200 = "Success"
    static var Fail = " Failed to upload data,try again"
    static var Already_Active_Device =  "User already has 1 active devices"
    static var Active_Device =  "You already have an active device."
    static var Active_Device_Info = "This User Is Already Active on - Google AOSP on IA Emulator. Please Sync The Data From That Device, Before Registering This Device, Otherwise The Data Stored In Other Device Will Be Lost. "
    static var No_Record = "You have no records to upload"
    static var NPR_Started = "NPR block marked successfully"
    static var EB_Start_Date_Mark = "HLB Start Date Marked successfully"
    static var EB_Complete_Successfully = "HLB Complete successfully"
    static var Button_Yes = "Yes"
    static var Button_No = "No"
    static var EB_Start_Date = "Unable to Fetch HLB Start Date. Please try again"
    static var Search_Heading = "Total HouseHold in HLB -"
    static var App_Name = "NPR-2020"
    static var National_Population_Register = "National Population Register"
    static var Developer_By = "Developed and Managed By"
    static var Indian_Gov = "Government of India --"
    static var Indian_Gov_ORGI = "ORGI,MHA,Government of India"
    static var Version = "Version-2.0 --"
    static var Version1 = "Version 1.0.0"
    static var Please_Wait = "Please Wait"
    static var Loading_Data = " Loading data..."
    static var Wrong_Password = "Wrong Password "
    static var Connected_To_Internet = "Good! Connected to the Internet "
    static var Not_Connected_To_Internet = "Sorry! Not connected to the internet"
    static var Total_Records = "Total Records -"
    static var Total_Households = "Total Household -"
    static var Enter_EB_Search = "Enter HLB for search"
    static var checkHHType = "Please choose Type of Household"
    
    static var dataSaved = "Data saved successfully"
    static var Please_Choose_Type_Household = "Please choose Type of Household"
    static var Family_Member_Should_Valid = "No. of family Member should be valid number"
    static var Name_Atleast_3_Char_Long = "Name should be atleast 3 characters long"
    static var Please_Enter_Institutional_Name = "Please enter Institutional Name"
    static var Institutional_Name_MoreThan3Char = "Institutional Name should be atleast 3 characters long "
    
    
    //Alert
    
    static var areYouSure = "Are You Sure"
    
    static var agreeImportant = "It's important to agree on assigned HLB to do allotted work. If any issues please contact to your Supervisor/Charge Officer."
   
   static var ebDownloadedSuccessFully = "HLB Downloaded Successfully"
   static var ebDoesNotExist = "This HLB has been unassigned for this user"
    
    // Change HouseType
    
    static var changedHouseType = "House type changed successfully "
    
 
    // set Value
    
    
    
    
    

}





struct ProjectColor {
    
    static let colorPrimary = UIColor.init(named: "color_primary") ?? UIColor()
    static let colorPrimaryDark = UIColor.init(named: "colorPrimaryDark") ?? UIColor()
    static let colorAccent = UIColor.init(named: "colorAccent") ?? UIColor()
    static let deep_purple_50 = UIColor.init(named: "deep_purple_50") ?? UIColor()
    static let purple_50 = UIColor.init(named: "purple_50") ?? UIColor()
    
   // static let deep_purple_200 = UIColor.init(named: "deep_purple_300") ?? UIColor()
    
    static let deep_purple_300 = UIColor.init(named: "deep_purple_300") ?? UIColor()
    static let deep_purple_400 = UIColor.init(named: "deep_purple_400") ?? UIColor()
    
    //static let purple_500 = UIColor.init(named: "deep_purple_500")?? UIColor()
    //static let deep_purple_600 = UIColor.init(named: "deep_purple_600") ?? UIColor()
    static let deep_purple_700 = UIColor.init(named: "deep_purple_700") ?? UIColor()
    static let deep_purple_800 = UIColor.init(named: "deep_purple_800") ?? UIColor()
    
    static let deep_purple_900 = UIColor.init(named: "deep_purple_900") ?? UIColor()
    static let deep_purple_A100 = UIColor.init(named: "deep_purple_A100") ?? UIColor()
    static let deep_purple_A200 = UIColor.init(named: "deep_purple_A200") ?? UIColor()
    static let deep_purple_A400 = UIColor.init(named: "deep_purple_A400") ?? UIColor()
    
    static let deep_purple_A700 = UIColor.init(named: "deep_purple_A700") ?? UIColor()
    static let gray = UIColor.init(named: "grey") ?? UIColor()
    //static let cyan_100 = UIColor.init(named: "color_primary")
    static let total_50_green = UIColor.init(named: "teal_50_green") ?? UIColor()
    
    static let color_divider = UIColor.init(named: "grey") ?? UIColor()
    //static let colorGray = UIColor.init(named: "color_primary")
    static let green = UIColor.init(named: "green") ?? UIColor()
    
    static let colorAmber = UIColor.init(named: "colorAmber") ?? UIColor()
}

struct EntityName {
    static let district = "District"
    static let tahsil = "Tahsil"
    static let state = "State"
    static let country = "Country"
    static let hloData = "HLOData"
    static let npr2021Data = "NPR2021MemberDetails"
    static let nprHHStats = "NPR_2021hh_Details"
    static let eb = "EB"
}

struct CellData {
    var opened = Bool()
    var houseHoldNumber = String()
    var name = String()
    var DOB = String()
    var sectionData = [String]()
}

struct CellIdentifier {
     static let splitHouseHold = "SplitHouseHoldCell"
     static let houseHoldDetailList = "HouseHoldDetail_Cell"
     static let houseHoldDetai_memberList = "HoldHoldMemberList_Cell"
    static let locationParticularAddress = "CellAddress"
    static let locationParticularHHCountbyLang = "CellHHCount"
    
}

