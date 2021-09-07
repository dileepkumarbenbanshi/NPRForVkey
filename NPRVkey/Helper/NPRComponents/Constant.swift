//
//  Constant.swift
//  NPR Screen
//
//  Created by mac on 11/08/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation
import UIKit


struct BaseUrl {
    //static let url = "http://10.10.10.21/fluwiz/"
    // Dev Base Url
    static let url1 = "http://10.10.10.21/"
    // Vapt Base Url
    // UAT url
    static let url = "https://vaptapi.census.gov.in:8081/fluwiz/"
    
    // Production url
   // static let url = "https://apidel.census.gov.in/fluwiz/"
   
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

struct Regix {
    var regeixAlphabetSpace = "^[a-zA-Z '.-]*$"
    var regixNumber = "^[0-9]*$"
    var adress = "^[a-zA-Z0-9 .]*$"
    
    
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
      static let Device_Enroll          = "device/v1/pg/100/enlist"
      static let Device_De_Enroll       = "device/v1/pg/100/delist"
      static let Verify_OTP             = "device/v1/pg/100/verify"
      static let country_List           = "api/v1/pg/query/master_GeoCountry/list"
      static let state_List             = "api/v1/pg/query/master_MstState/list"
      static let district_List          = "api/v1/pg/query/master_MstDistrict/list"
      static let Tahsil_List            = "api/v1/pg/query/master_MstTehsil/list"
      static let npr_2019Data_download  = "api/v2/pg/query/nprdata2019_enum"
      static let npr_2021Data_download  = "api/v2/pg/query/nprdata2021_enum"
     // static let uploadData            
      static let ebList                 = "api/v1/pg/nquery/eballotment/nprenumerator/list"
    static let hloDataDownload          = "api/v1/pg/nquery/eballotment/nprhousingdata/list"
      static let Upload_Data            = "api/v2/pg/data/nprdatasig2021_enum"
      static let Active_Device          = "device/v1/pg/100/active"
    static let EB_Start_Date = "api/v1/pg/exec/npreb2021_enum/start"
    static let EB_Completion_Date = "api/v1/pg/exec/npreb2021_enum/start"
    static let Expected_HH = "api/v1/pg/data/npreb2021_enum"
    static let EB_Completation = "api/v1/pg/exec/npreb2021_enum/complete"
    
    //SuperVisor
    
   
    static let super_hlbList = "api/v1/pg/nquery/eballotment/nprsupervisor/list"
    static let createEbDetail = "api/v1/pg/data/npreb2021_enum"
    static let super_downloadEb = "api/v2/pg/query/nprdata2021_supr"
    static let Super_UploadData = "api/v2/pg/data/nprdatasig2021_supr"
     
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
    static let networkConnection = "Check your network connection"
    
    static let User_Id_Password_Can_not_be_Empty = "UserId and Password cannot be empty"
    static let Please_Enter_Correct_OTP =  "Please enter correct OTP"
    static let Password_Empty =  "Password fields can not be blank"
    static let Both_Password_Same =  "Both Password should be same"
    static let Expected_hh_Can_not_be_Blank =  "Expected Households No. cannot be blank"
    static let Expected_hh_Can_not_be_One = "Expected Households No. cannot be 1"
    static let Age_Text = "Enter age to calculate date of birth"
    static let Expected_hh_Can_not_be_More_Than = "Expected Households No. cannot be exceed than no.of HouseHold Members"
    static let Alert_Date = "Member doesnot know date of birth but knows age"
    static let Success = "Data Uploaded Successfully"
    static let Error401 = "You are not authorised user to upload Data"
    static let Error400 = "Bad Request"
    static let Server_Response = "Server Response"
    static let UnAuthorized_Access = "Unauthorized Access"
    static let device_de_enrolled = "This device has been de-enrolled"
    static let invalidCredential = "Please enter valid credential"
    static let Success200 = "Success"
    static let Fail = " Failed to upload data,try again"
    static let Already_Active_Device =  "User already has 1 active devices"
    static let Active_Device =  "You already have an active device."
    static let Active_Device_Info = "This User Is Already Active on - Google AOSP on IA Emulator. Please Sync The Data From That Device, Before Registering This Device, Otherwise The Data Stored In Other Device Will Be Lost. "
    static let No_Record = "You have no records to upload"
    static let NPR_Started = "NPR block marked successfully"
    static let EB_Start_Date_Mark = "HLB Start Date Marked successfully"
    static let EB_Complete_Successfully = "HLB Complete successfully"
    static let Button_Yes = "Yes"
    static let Button_No = "No"
    static let EB_Start_Date = "Unable to Fetch HLB Start Date. Please try again"
    static let Search_Heading = "Total HouseHold in HLB -"
    static let App_Name = "NPR-2020"
    static let National_Population_Register = "National Population Register"
    static let Developer_By = "Developed and Managed By"
    static let Indian_Gov = "Government of India --"
    static let Indian_Gov_ORGI = "ORGI,MHA,Government of India"
    static let Version = "Version-2.0 --"
    static let Version1 = "Version 1.0.0"
    static let Please_Wait = "Please Wait"
    static let Loading_Data = " Loading data..."
    static let Wrong_Password = "Wrong Password "
    static let Connected_To_Internet = "Good! Connected to the Internet "
    static let Not_Connected_To_Internet = "Sorry! Not connected to the internet"
    static let Total_Records = "Total Records -"
    static let Total_Households = "Total Household -"
    static let Enter_EB_Search = "Enter HLB for search"
    static let checkHHType = "Please choose Type of Household"
    
    static let dataSaved = "Data saved successfully"
    static let Please_Choose_Type_Household = "Please choose Type of Household"
    static let Family_Member_Should_Valid = "No. of family Member should be valid number"
    static let Name_Atleast_3_Char_Long = "Name should be atleast 3 characters long"
    static let Please_Enter_Institutional_Name = "Please enter Institutional Name"
    static let Institutional_Name_MoreThan3Char = "Institutional Name should be atleast 3 characters long "
    
    
    //Alert
    
    let areYouSure = "Are You Sure"
    
    let agreeImportant = "It's important to agree on assigned HLB to do allotted work. If any issues please contact to your Supervisor/Charge Officer."
   
   static let ebDownloadedSuccessFully = "HLB Downloaded Successfully"
   static let ebDoesNotExist = "This HLB has been unassigned for this user"
    
    // Change HouseType
    
    let changedHouseType = "House type changed successfully "
    
    

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
    
}

