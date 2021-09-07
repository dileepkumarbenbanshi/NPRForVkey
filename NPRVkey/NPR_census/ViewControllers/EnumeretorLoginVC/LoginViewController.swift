//
//  LoginViewController.swift
//  NPR Screen
//
//  Created by mac on 05/08/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController{

    @IBOutlet weak var btnBackHeightConstraint: NSLayoutConstraint!
    @IBOutlet var nprTitle: UILabel!
    @IBOutlet var signInbutton: UIButton!
    @IBOutlet var loginLabel: UILabel!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var labelLangauge: UILabel!
    @IBOutlet weak var textFieldUserId: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var buttonSuperVisiorLogin: UIButton!
    @IBOutlet weak var buttonChangePassword: UIButton!
    var loginData:LoginModel?
    var otpData:OTPModel?
    let loginVM = LoginVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.textFieldUserId.text = "ev_2211002_ravinder"//"ev_2211001_ravinder"//"ec_31010058002_demo"//"ec_31010068003_aarti"//
        //self.textFieldPassword.text = "Admin@1234"
        self.customize()
        
        Utils().vKeySetup(enable:true)
        
        self.addKeyboardObserver()
        btnBack.isHidden = true
        
//        let languageExtension = LanguageExtension()
//        languageExtension.getModal(language: "English")
//        
//        changeLang(langObj: LanguageModal.langObj)
//        
        
        //fatalError()
    }
    
    override func viewDidLayoutSubviews() {
        //btnBackHeightConstraint.constant = 0
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
//        if #available(iOS 13.0, *) {
//
//        } else {
//            // Fallback on earlier versions
//        }
        
        if #available(iOS 13.0, *) {
                    let statusBar = UIView(frame: UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
            statusBar.backgroundColor = ProjectColor.colorPrimaryDark
            overrideUserInterfaceStyle = .light
                     UIApplication.shared.keyWindow?.addSubview(statusBar)
                } else {
                     //UIApplication.shared.statusBarView?.backgroundColor = UIColor.init(red: 237.0/255.0, green: 85.0/255.0, blue: 61.0/255.0, alpha: 1.0)
                }
    
        //Crashlytics.crashlytics().setCustomValue(100, forKey: "int_key")
        
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
    }
    
//    override open var shouldAutorotate: Bool {
//       return false
//    }

    // Specify the orientation.
//    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//       return .portrait
//    }
    
    func customize(){
        self.containerView.cornerRadiusV = 5
        //singleton().isConnectedToNetwork() ? singleton().Alert.show(title: AppMessages.App_Name, message: AppMessages.Connected_To_Internet, delay: 5.0) : nil
        self.textFieldUserId.placeholder =  singleton().getFromUserDefaults(withKey: "Is_LoggedIn") as? Bool == true ? singleton().getCredentials().userId : "User Id"
        self.textFieldUserId.isEnabled = singleton().getFromUserDefaults(withKey: "Is_LoggedIn") as? Bool == true ? false : true
       
        
        singleton().getFromUserDefaults(withKey: "Is_LoggedIn") as? Bool == true ? self.hideShowSupervisorAndChangePswdButton(isSupervisorHidden: true, isChangePasswordHidden: false) : self.hideShowSupervisorAndChangePswdButton(isSupervisorHidden: false, isChangePasswordHidden: true)
        
        setTageValue()
    }
    
    func setTageValue()  {
        
        loginLabel.text = LanguageModal.langObj.login
        signInbutton.setTitle(LanguageModal.langObj.LOGIN, for: .normal)
        self.textFieldUserId.placeholder =  singleton().getFromUserDefaults(withKey: "Is_LoggedIn") as? Bool == true ? singleton().getCredentials().userId : LanguageModal.langObj.userid
        textFieldPassword.placeholder = LanguageModal.langObj.password
        buttonSuperVisiorLogin.setTitle(LanguageModal.langObj.supervisor_login_title, for: .normal)
        buttonChangePassword.setTitle(LanguageModal.langObj.CHANGE_PASSWORD, for: .normal)
        nprTitle.text = AppMessages.App_Name
        
        labelLangauge.text = LanguageModal.currentLanguage
    }
    
    func hideShowSupervisorAndChangePswdButton(isSupervisorHidden:Bool, isChangePasswordHidden:Bool){
        self.buttonSuperVisiorLogin.isHidden = isSupervisorHidden
        self.buttonChangePassword.isHidden = isChangePasswordHidden
    }
        
    @IBAction func onTapSignIn(_ sender: Any) {
        textFieldPassword.resignFirstResponder()
      print("Access Token",singleton().getDeviceIDORAccessToken().accessToken )
        
        print("Device ID",singleton().getDeviceInfo().deviceId )
        
        if  singleton().getFromUserDefaults(withKey: "Is_LoggedIn") as? Bool == true {
           if isAllFieldValid() {
            
            goToAssignEBController()
           }
        }
        else{
            if isAllFieldValid() {
                singleton().saveToUserDefaults(withKeyValue: ["userId":self.textFieldUserId.text!.lowercased(), "Password":self.textFieldPassword.text!], key: "User_Credentials")
               // self.requestForEnrollement()
                let loginVM = LoginVM ()
                loginVM.delegate = self
                isProd ? loginVM.getBaseURL() : requestForEnrollement()
            }
        }
    }
    
    @IBAction func onTapChangePassword(_ sender: Any) {
        self.navigateToController(identifier: "ChangePasswordVC", storyBoardName: "Main")
    }
    
    @IBAction func onTapLanguage(_ sender: Any) {
        textFieldPassword.resignFirstResponder()
        textFieldUserId.resignFirstResponder()
        
      getLanguageList()
        
        
        
    }
    
    @IBAction func onTapSuperVisorLogin(_ sender: UIButton) {
        var strTitle = ""
        sender.isSelected = !sender.isSelected
       strTitle = sender.isSelected == true ?  LanguageModal.langObj.supervisor_login :  LanguageModal.langObj.login

        sender.setTitle(LanguageModal.langObj.supervisor_login, for: .normal)
        textFieldPassword.text = ""
        textFieldUserId.text = ""
        loginLabel.text = strTitle
        loginVM.isTapedEnumLogin = !sender.isSelected
        sender.isHidden = true
        
        updateViewConstraints()
        sender.backgroundColor = .clear
        btnBack.isHidden = false
        //self.navigateToController(identifier: "SuperVisorLoginVC", storyBoardName: storyBoardName.superVisor)
    }
    
    @IBAction func onTapbackButton(_ sender: UIButton) {
        buttonSuperVisiorLogin.isHidden = false
        btnBack.isHidden = true
        loginLabel.text = LanguageModal.langObj.login
       // btnBackHeightConstraint.constant = 0
    }
    func getLanguageList(){
        if let path = Bundle.main.path(forResource: "Language", ofType: "plist") {
            if let array = NSArray(contentsOfFile: path) as? [[String: Any]] {
                let pickerViewLang = Bundle.main.loadNibNamed("PickerViewCommon", owner: self, options: nil)?.first as? PickerViewCommon
                
                
                pickerViewLang?.delegate = self
                pickerViewLang?.loadPicker(aray: array, pickerType: .langaugeList)
            }
        }
    }
    
    @IBAction func btnEye_tap(_ sender: UIButton) {
        
        textFieldPassword.isSecureTextEntry = sender.isSelected
        
        sender.isSelected =  !sender.isSelected
    }
    
    func isAllFieldValid()-> Bool{
        if  singleton().getFromUserDefaults(withKey: "Is_LoggedIn") as? Bool == true {
            if (self.textFieldPassword.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
                singleton().Alert.show(title: AppMessages.App_Name, message: LanguageModal.langObj.user_id_password_cant_be_empty, delay: 5.0)
                  return false
            }
            if self.textFieldPassword.text != singleton().getCredentials().password {
              
                
                let alert = AlertView()
                alert.alertWithoutButton( message: LanguageModal.langObj.wrong_password, time: 2.0)
                return false
            }
          return true
        }
        else{
            if (self.textFieldUserId.text?.trimmingCharacters(in: .whitespaces).isEmpty)! || (self.textFieldPassword.text?.trimmingCharacters(in: .whitespaces).isEmpty)! {
                      
                let alert = AlertView()
                alert.alertWithoutButton( message: LanguageModal.langObj.user_id_password_cant_be_empty, time: 2.0)
                
                      return false
             }
           return true
        }
      
    }
    
    
    
    func goToAssignEBController(){
           DispatchQueue.main.async {
               let controller = self.storyboard?.instantiateViewController(withIdentifier: "AssignEBVC") as! AssignEBViewController
               self.navigationController?.pushViewController(controller, animated: true)
           }
       }
    
    func goToVerifyController(withData data:LoginModel?){
        DispatchQueue.main.async {
          let controller = self.storyboard?.instantiateViewController(withIdentifier: "OTPVerificationVC") as! OTPVerificationViewController
            singleton().saveToUserDefaults(withKeyValue: ["deviceId":singleton().getDeviceInfo().deviceId, "accessToken":data?.accessToken!], key: "Device_Info")
            controller.loginData = data
            self.navigationController?.pushViewController(controller, animated: true)
         }
    }
 
    
    func requestForEnrollement(){
        if Reachability.shared.isConnected {
        
        
        let dictParam = [Param_Key.DeviceID: singleton().getDeviceInfo().deviceId,
                         Param_Key.Application: Application.AppCode,
                         Param_Key.Manufacturer: "Iphone",
                         Param_Key.Model: singleton().getDeviceInfo().deviceName,
                         Param_Key.SerialNumber: "",
                         Param_Key.OSVersion: singleton().getDeviceInfo().deviceVersion,
                         Param_Key.AppVersion: singleton().getDeviceInfo().appVersion,
                         Param_Key.OSPatch: ""]
           // self.view.showLoader()
            APIManager().postEnrollementRequest(params: dictParam) { (success, responseData, error) in
             DispatchQueue.main.async {self.view.removeLoaderView()}
             self.loginData = LoginModel(fromDictionary: responseData as! [String:Any])
            if success {
                guard let loginData = self.loginData else {
                    return
                }
               let isValidID_asUserType = self.loginVM.isValidID_userType(loginModel: loginData)
                if !isValidID_asUserType {
                    
                    return
                }
                 if let status = self.loginData?.status {
                     if status == 1 {
                         DispatchQueue.main.async {
                            self.requestForDeEnrollement(withDeviceId: (self.loginData?.deviceId!)!)
                         }
                     }
                    if status == 2 {
                        self.goToVerifyController(withData: self.loginData)
                    }
                 }
            }
            else{
                 if error?.localizedDescription == AppMessages.Not_Connected_To_Internet {
                   
                    
                    let alert = AlertView()
                    alert.alertWithoutButton( message: LanguageModal.langObj.user_id_password_cant_be_empty, time: 2.0)
                }
                  if error?.localizedDescription == AppMessages.Server_Response {
                    
                    
                    let alert = AlertView()
                    alert.alertWithoutButton( message: LanguageModal.langObj.wrong_password, time: 2.0)
                }
            }
            }
        }else {
            
            AlertView().alertWithoutButton( message: LanguageModal.langObj.not_connected_to_internet)
        }
    }
    
    func requestForDeEnrollement(withDeviceId deviceId:String){
        let dictParam = [Param_Key.DeviceID: deviceId,
                         Param_Key.Application: Application.AppCode]
            self.view.showLoader()
            APIManager().postDeEnrollementRequest(params: dictParam) { (success, responseData, error) in
            DispatchQueue.main.async {self.view.removeLoaderView()}
                self.otpData = OTPModel(fromDictionary: responseData as! [String:Any])
            if success {
                    if let status = self.otpData?.status {
                    if status == 3 {
                        DispatchQueue.main.async {
                            self.requestForEnrollement()
                        }
                    }
                }
            }
            else{
                 if error?.localizedDescription == AppMessages.Not_Connected_To_Internet {
                  
                    
                    let alert = AlertView()
                    alert.alertWithoutButton( message: LanguageModal.langObj.not_connected_to_internet, time: 2.0)
                }
                 if error?.localizedDescription == AppMessages.Server_Response {
                  
                    
                    
                    let alert = AlertView()
                    alert.alertWithoutButton( message: self.otpData?.message ?? AppMessages.invalidCredential, time: 2.0)
                 }
             }
        }
    }
    
    
   private func getBaseURL()  {
       
    
    }
    
}

extension LoginViewController : PickerViewDelegate {
    
    func getLangauge(language: String) {
        
      //  util.saveUserDefauldValue(key: .language, value: language)
        self.labelLangauge.text = language
        UserDefaults().saveUserDefauldValue(key: .language, value: language)
        LanguageModal.currentLanguage = language
        // Create a Langauge Modal based on user selection
        
        let languageExtension = LanguageExtension()
        languageExtension.getModal(language: language)
       // print("Language Check: ", LanguageModal.langObj.relationship_to_head_male[0].name)
        
        // Change Language on UI
        
       setTageValue()
        self.textFieldUserId.placeholder =  singleton().getFromUserDefaults(withKey: "Is_LoggedIn") as? Bool == true ? singleton().getCredentials().userId : LanguageModal.langObj.userid
        
        
        changeLang(langObj: LanguageModal.langObj)
    }
}

extension LoginViewController:UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension LoginViewController {
    
   
    // MARK: Language Change (Add data to existing modal)
    func changeLang(langObj: LanguageModal){
        
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
        AppMessages.Active_Device_Info = langObj.activated_devic_title
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
       // AppMessages.ebDoesNotExist = langObj.
      //  AppMessages.changedHouseType = langObj.
        
        //Alert
        
        
        


        
    }
    
    
    
}
    

extension LoginViewController:PickerViewCommonDelegate {
    
    func didPickComponent(component: String) {
      let language = component
        labelLangauge.text = component
        
        UserDefaults().saveUserDefauldValue(key: .language, value: language)
        LanguageModal.currentLanguage = language
        // Create a Langauge Modal based on user selection
        
        let languageExtension = LanguageExtension()
        languageExtension.getModal(language: language)
        
        
        setTageValue()
         self.textFieldUserId.placeholder =  singleton().getFromUserDefaults(withKey: "Is_LoggedIn") as? Bool == true ? singleton().getCredentials().userId : LanguageModal.langObj.userid
         
         
         changeLang(langObj: LanguageModal.langObj)
    }
    
    func cancelPicker() {
        
    }
    
    
 
    
    
}


extension LoginViewController:MultiDCDelegate {
    func gotBaseurl(baseUrl:String) {
        BaseUrl.url = baseUrl
        UserDefaults().saveUserDefauldValue(key: .baseUrlProd, value: baseUrl)
        self.requestForEnrollement()
    }
    
    
}
