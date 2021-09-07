//
//  AddNewHouseHoldForm_TVC.swift
//  NPR_census
//
//  Created by admin on 04/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
//import IQKeyboardManagerSwift

class AddNewHouseHoldForm_TVC: UITableViewController {
    
    @IBOutlet weak var lblPageTitle: UILabel!
    @IBOutlet weak var lblBlockNo: UILabel!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMemberSerial: UILabel!
    @IBOutlet weak var lblHHNumber: UILabel!
    //MARK:PersonalDetail Outlet Personal Details
    @IBOutlet weak var btnCheckMale: UIButton!
    @IBOutlet weak var btn_ed_qualification: UIButton!
    @IBOutlet weak var btn_ed_occupation: UIButton!
    @IBOutlet weak var btn_ed_motherTounge: UIButton!
    @IBOutlet weak var btnNeverMarried: UIButton!
    
    @IBOutlet weak var btnCheckNeverMarried: UIButton!
    @IBOutlet weak var lbl_pd_messageNote: UILabel!
    @IBOutlet weak var tf_passportNumber: UITextField!
    @IBOutlet weak var btn_pd_birthPlaceCountry: UIButton!
    @IBOutlet weak var btn_pd_Natinality: UIButton!
    var strPDNationality = ""
    
    @IBOutlet weak var btn_pd_birthPlaceState: UIButton!
    var strPD_birthState = ""
    @IBOutlet weak var btn_pd_birthPlaceDistrict: UIButton!
    var strPD_birthDistrict = ""
    @IBOutlet weak var btn_pd_relationWithHead: UIButton!
    var strPD_realationCode = ""
    @IBOutlet weak var pd_houseNo: UITextField!
    @IBOutlet weak var tf_pd_houseHoldNO: UITextField!
    @IBOutlet weak var tf_pd_SE_refrenceNO: UITextField!
    @IBOutlet weak var tf_search: UISearchBar!
    @IBOutlet weak var tf_pd_Name: UITextField!
    
    @IBOutlet weak var tf_pd_Dob_date: UITextField!
    @IBOutlet weak var tf_pd_Dob_month: UITextField!
    @IBOutlet weak var tf_pd_Dob_year: UITextField!
    
    @IBOutlet var headerView: UIView!
    @IBOutlet weak var permanentAdd_innerStackView: StackView!
    @IBOutlet weak var presentAdd_innerStackView: StackView!
    @IBOutlet weak var eq_innerStackView: StackView!
    @IBOutlet weak var btn_PD: UIButton!
    @IBOutlet weak var pd_mainStackView: StackView!
    @IBOutlet weak var pd_innerStackView: StackView!
    
    @IBOutlet weak var stackHeight_pd_passportEntry: NSLayoutConstraint!
    
 //MARK:Education Details
    @IBOutlet weak var btn_EQ_Expand: UIButton!
    
    //MARK:Present Address Outlet
     
    @IBOutlet weak var stackViewSamePresentAddAsHead: UIStackView!
    @IBOutlet weak var btn_presentAdd_expand: UIButton!
    @IBOutlet weak var btn_ptAdd_Country: UIButton!
    @IBOutlet weak var btn_ptAdd_State: UIButton!
    
    @IBOutlet weak var btn_ptAdd_District: UIButton!
    @IBOutlet weak var btn_ptAdd_subDistrict: UIButton!
    
    @IBOutlet var tf_ptAd_pinCode: UITextField!
    @IBOutlet weak var tf_ptAd_houseNumber: UITextField!
    @IBOutlet weak var tf_ptAd_townVillage: UITextField!
    //MARK:permanent Address
    @IBOutlet weak var stackViewSamePermanentAddAsHead: UIStackView!
    @IBOutlet weak var btnCkeck_permanentSameasPresentAdd: UIButton!
    @IBOutlet weak var btn_permanentAdd_expand: UIButton!
    @IBOutlet weak var btn_PaddCountry: UIButton!
    @IBOutlet weak var btn_padState: UIButton!
    @IBOutlet weak var btn_padDistrict: UIButton!
    @IBOutlet weak var btn_PadSubDistrict: UIButton!
    
    @IBOutlet weak var tf_padTownVillage: UITextField!
    @IBOutlet weak var tf_padHouseNumber: UITextField!
    
    @IBOutlet weak var tf_padPinCode: UITextField!
    
    @IBOutlet weak var btn_padNo: UIButton!
    @IBOutlet weak var btn_padYes: UIButton!
    
    @IBOutlet weak var stackViewLastResidence: UIStackView!
    @IBOutlet weak var tf_staySameAddressYear: UITextField!
    
    @IBOutlet weak var btnLastResidenceCountry: UIButton!
    
    
    //MARK:Parent Detail
    @IBOutlet weak var stackViewSelectFather: UIStackView!
    @IBOutlet var constraintHeight_viewSelectFatherName: NSLayoutConstraint!
    @IBOutlet weak var viewSelectFatherName: UIView!
    @IBOutlet weak var btnSelectFatherName: UIButton!
    @IBOutlet weak var btn_parentD_expand: UIButton!
    @IBOutlet weak var parentDetail_fatherName: UITextField!
    @IBOutlet weak var parentDetail_innerStackView: StackView!
    
    //@IBOutlet weak var tf_parentDetail_dob: UITextField!
    @IBOutlet weak var tf_ParentDetail_dob_date: UITextField!
    @IBOutlet weak var tf_ParentDetail_dob_month: UITextField!
    @IBOutlet weak var tf_ParentDetail_dob_year: UITextField!
    @IBOutlet weak var btn_parentDeatil_BirthState: UIButton!
    @IBOutlet weak var btn_parentDetail_birthDistrict: UIButton!
    
    @IBOutlet weak var btn_parentDetail_BirthCountry: UIButton!
    
   // @IBOutlet weak var tf_parentDetail_motherName: UITextField!
    // @IBOutlet weak var tf_parentDetail_motherDOB: UITextField!
    @IBOutlet weak var constraintHeight_viewSelectMotherName: NSLayoutConstraint!
    @IBOutlet weak var viewSelectMotherName: UIStackView!
    
    @IBOutlet weak var btnSelectMotherName: UIButton!
    @IBOutlet weak var tf_ParentDetail_motherName: UITextField!
    @IBOutlet weak var btn_ParentDetail_motherBirthCountry: UIButton!
    @IBOutlet weak var stackViewSelectMotherDetail: UIStackView!
    
    @IBOutlet weak var tf_ParentDetail_motherDob_date: UITextField!
    @IBOutlet weak var tf_ParentDetail_motherDob_month: UITextField!
    @IBOutlet weak var tf_ParentDetail_motherDob_year: UITextField!
    @IBOutlet weak var btn_ParentDetail_motherBirthState: UIButton!
    
    @IBOutlet weak var btn_ParentDetail_motherBirthDistrict: UIButton!
    @IBOutlet weak var tf_ParentDetail_spouseName: UITextField!
    
    //IdentiFication Detail
    @IBOutlet weak var btn_ID_expand: UIButton!
    @IBOutlet weak var iD_detail_innerStackView: StackView!
    
    @IBOutlet weak var tf_ID_voter: UITextField!
    @IBOutlet weak var tf_ID_mobile: UITextField!
    @IBOutlet weak var tf_ID_dL: UITextField!
    @IBOutlet weak var tf_ID_adhar: UITextField!
    
    var modelMemberDetail = NPR2021MemberDetails()
    var modelHH = NPR_2021hh_Details()
    var isEditingDetail = false
    var isOldHH = false
    
    var pickerView:PickerViewCommon?
    var genderId = gender.male
    var maritalStatus = Utils.marritalStaus.none
    
    var tapedButton = UIButton()
    var strHHNumber = ""
    var strMemberNumber = ""
    var strMemberName = ""
    var strHouseNumber = ""
    var strCensusHHNumber = ""
    
    
    var hhType = ""
    var entryT = entryType.newHouseHold
    
    
    var hhStatus = ""
    var memberStatus = ""
    var hh_completionStatus = ""
    var memberComletionStatus = ""
    //var memberSerialNumber = ""
    var isDataSaved = false
    
    //let formDetailProtocol:formDetailProtocol? = nil
    
    // Others
    var selectedHouseType:HouseType?
    
    //var addnewMemberformVM = AddNewHouseholdForm_ViewModel()
    
    
    enum clickDetailButton: Int {
        
        case PersonalDetail = 2
        case EducationDetail = 3
        case PresentAddressDetail = 4
        case PermanentAddressDetail = 5
        case ParentDetail = 6
        case IdentificationDetail = 7
        
    }
    enum entryType {
        case editDetail
        case addNewMemberExitHH
        case newHouseHold
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.intialViewPrepare()
       
    }
    
    
    func intialViewPrepare() {
        
        //addnewMemberformVM.formClass = self
        
        self.removeKeyboardObserver()
        
        
        tf_pd_houseHoldNO.setupDonButton_TextFields()
        tf_padHouseNumber.setupDonButton_TextFields()
        
        if isEditingDetail {
           // viewPrepare()
            lblPageTitle.text = "Household Member Detail"
        }
        else{
            
            switch selectedHouseType {
            case .normal:
                
                tf_pd_houseHoldNO.isUserInteractionEnabled = true
                
                break
            case .institute:
                tf_pd_houseHoldNO.isUserInteractionEnabled = true
                tf_padHouseNumber.isUserInteractionEnabled = false
                tf_pd_houseHoldNO.text = strCensusHHNumber
                
                break
            case .houseLess:
                tf_pd_houseHoldNO.isUserInteractionEnabled = false
                tf_padHouseNumber.isUserInteractionEnabled = true
               // tf_pd_houseHoldNO.text = strCensusHHNumber
                break
            default:
                break
            }
           
            
            viewPrepareForAllCondition()

            if self.getNewMemberSerialNumber(hhNumber: strHHNumber) == "1".memberSrNumber() {
               let arayRelation = English().relationship_to_head_male()
               let relationModel = PickerViewCommon_model.init(model:arayRelation[0])
                btn_pd_relationWithHead.setTitle(relationModel.name, for: .normal)
                btn_pd_relationWithHead.setTitleColor(ProjectColor.colorPrimary, for: .normal)
                btn_pd_relationWithHead.isUserInteractionEnabled = false
                tf_pd_Name.text = strMemberName
            }else{
                btn_pd_relationWithHead.isUserInteractionEnabled = true
            }
        }
        
        pickerView = Bundle.main.loadNibNamed("PickerViewCommon", owner: self, options: nil)?.first as? PickerViewCommon
           pickerView?.delegate = self
        //   pickerView?.backgroundColor =
        viewPrepareForAllCondition()
        
    }
    func viewPrepareForAllCondition()  {
        
    
        
        if isEditingDetail {
           
            tf_ptAd_pinCode.text = modelMemberDetail.pinCode
            
        }
       
        switch  entryT{
        case .newHouseHold:
           
            memberStatus = MemberStatusCode.newMember
            strMemberNumber = self.getNewMemberSerialNumber(hhNumber: strHHNumber)
            basicInfo_Member(hhN: strHHNumber , headName: strMemberName )
            memberStatus = MemberStatusCode.newMember
            tf_pd_Name.text = strMemberName
            hh_completionStatus = HHCompletionStatusCode.completed
            stackViewSamePresentAddAsHead.isHidden = true
            stackViewSamePermanentAddAsHead.isHidden = true
            
            break
            
        case .addNewMemberExitHH:
            strHHNumber = modelHH.houseHoldhNo ?? ""
            
            strMemberNumber = self.getNewMemberSerialNumber(hhNumber: strHHNumber)
            lblPageTitle.text = "Household Member Detail"
            basicInfo_Member(hhN: strHHNumber, headName: English.AddNewMemberFormAlert.newMember)
            memberStatus = MemberStatusCode.newMember
            
            hhAlreadyExist()
            stackViewSamePresentAddAsHead.isHidden = false
            stackViewSamePermanentAddAsHead.isHidden = false
            
            break
            
        case .editDetail:
            strHHNumber = modelHH.houseHoldhNo ?? ""
            viewPrepareEditMember()
            strMemberNumber = modelMemberDetail.sloMember ?? ""
            basicInfo_Member(hhN: modelMemberDetail.hh_Number ?? "", headName: modelMemberDetail.name ?? "")
            tf_ptAd_houseNumber.text = modelMemberDetail.censusHouse_number
            personalDetail()
            educationDetail()
            fatherDetail(modelMember: modelMemberDetail, modelType: .personal)
            motherDetail(modelMember: modelMemberDetail, modelType: .personal)
            permanentAdressDetail()
            idDetail()
            lblPageTitle.text = "Household Member Detail"
            personalDetail()
            memberStatus = MemberStatusCode.available
            hhAlreadyExist()
            btn_parentDetail_BirthCountry.setTitle("India", for: .normal)
            btn_ParentDetail_motherBirthCountry.setTitle("India", for: .normal)
            
            if modelMemberDetail.rel_code == "01" {
                btn_pd_relationWithHead.isUserInteractionEnabled = false
                stackViewSamePresentAddAsHead.isHidden = true
                stackViewSamePermanentAddAsHead.isHidden = true
                
                btn_pd_relationWithHead.setTitle(modelMemberDetail.rel_code?.getName_by_ID(aray: English().relationship_to_head_male()), for: .normal)
            }else{
                btn_pd_relationWithHead.isUserInteractionEnabled = true
                stackViewSamePresentAddAsHead.isHidden = false
                stackViewSamePermanentAddAsHead.isHidden = false
                
            }
            
            break
        
        }
        
        presentAdressDetail()
    }
    
    func hhAlreadyExist()  {
        
        tf_pd_houseHoldNO.text = modelHH.census_hhNo
        pd_houseNo.text = modelHH.census_hNo
    }
    
    func basicInfo_Member(hhN:String,headName:String)  {
       
        lblBlockNo.text = "Block No - \(singleton().selectEBListModel.eb_block_number ?? "")"
        lblHHNumber.text = "Household No. - \(hhN )"
        
        lblMemberSerial.text = "Member Sr.No. - \(strMemberNumber)"
        lblName.text = headName
        
    }

    func personalDetail()  {
      

        strHHNumber = modelMemberDetail.hh_Number ?? ""
       // tf_pd_houseHoldNO.isUserInteractionEnabled = false
        //Peronal Detail
        tf_pd_Name.text = modelMemberDetail.name ?? ""
        tf_pd_SE_refrenceNO.text = modelMemberDetail.selfEnumerationRef_number ?? ""
        tf_pd_houseHoldNO.text = modelHH.census_hhNo ?? "" //modelMemberDetail.censusHH_number ?? ""
        tf_ptAd_houseNumber.text = modelHH.census_hNo ?? ""
        let dateComponent = modelMemberDetail.dob?.splitDateString()
        
        tf_pd_Dob_date.text = dateComponent?.date
        tf_pd_Dob_month.text = dateComponent?.month
        tf_pd_Dob_year.text = dateComponent?.year
        
         btn_pd_relationWithHead.setTitle(modelMemberDetail.relName ?? "", for: .normal)
         btn_pd_birthPlaceDistrict.setTitle(modelMemberDetail.birthDistrictName ?? "", for: .normal)
         btn_pd_birthPlaceState.setTitle(modelMemberDetail.birthStateName ?? "", for: .normal)
         btn_pd_birthPlaceCountry.setTitle("India", for: .normal)
        
         btn_pd_Natinality.setTitle("India", for: .normal)
        tf_ParentDetail_spouseName.text = modelMemberDetail.spouseName ?? ""
        
    }
     
    func educationDetail()  {
       
        
        let eduName = modelMemberDetail.edu_code?.getName_by_ID(aray: English().education_qualification())
        
       
        
        btn_ed_qualification.setTitle(eduName, for: .normal)
        
       // let mt = modelMemberDetail.motherToungeode?.getName_by_ID(aray: English().education_qualification())
        
        let occuName = modelMemberDetail.occu_code?.getName_by_ID(aray: English().occupation())
        
        btn_ed_occupation.setTitle(occuName ?? "", for: .normal)
        btn_ed_motherTounge.setTitle(modelMemberDetail.motherTounge ?? "", for: .normal)
    }
    
    func fatherDetail(modelMember:NPR2021MemberDetails , modelType:dobType)  {
        
        btnSelectFatherName.isUserInteractionEnabled = true
        var fatherName = ""
        var fatherBDistrict = ""
        var fatherBState = ""
        var fatherBCountry = ""
        var dob = ""
        
        if modelType == .personal {
            fatherName = modelMember.father_name ?? ""
            fatherBState = modelMember.fatherBirthState ?? ""
            fatherBDistrict = modelMember.fatherBirthDistrict ?? ""
            fatherBCountry = modelMember.fatherBirthState ?? ""
            dob = modelMember.father_dob ?? ""
        }else {
            
            fatherName = modelMember.name ?? ""
             fatherBState = modelMember.birthStateName ?? ""
             fatherBDistrict = modelMember.birthDistrictName ?? ""
             fatherBCountry = modelMember.birthCountryName ?? ""
             dob = modelMemberDetail.dob ?? ""
        }
         let dateComponent = dob.splitDateString()
        tf_ParentDetail_dob_date.text = dateComponent.date
        tf_ParentDetail_dob_month.text = dateComponent.month
        tf_ParentDetail_dob_year.text = dateComponent.year
         parentDetail_fatherName.text = fatherName
         btn_parentDetail_birthDistrict.setTitle(fatherBDistrict , for: .normal)
         btn_parentDeatil_BirthState.setTitle(fatherBState, for: .normal)
         btn_parentDetail_BirthCountry.setTitle(fatherBCountry, for: .normal)
 //
   //      btn_parentDetail_birthDistrict.setTitle(modelMemberDetail.fatherBirthDistrict ?? "", for: .normal)
   //
    }
    
    func motherDetail(modelMember:NPR2021MemberDetails , modelType:dobType)  {
        
       
        var motherName = ""
        var motherBDistrict = ""
        var motherBState = ""
        var motherBCountry = ""
        var dob = ""
        
        if modelType == .personal {
            
            dob = modelMember.mother_dob ?? ""
            motherName = modelMember.motherName ?? ""
            motherBState = DBManager_CountryStateDistrict().getStateName(stateCode: modelMember.mother_birthStateCode ?? "")
            motherBDistrict = DBManager_CountryStateDistrict().getDistrictName(stateCode: modelMember.mother_birthStateCode ?? "", districtCode: modelMember.mother_birthDistrictCode ?? "")//modelMemberDetail.birthDistrictName ?? ""
            motherBCountry = DBManager_CountryStateDistrict().getCountryName(countryCode: modelMember.mother_birthCountryCode ?? "")
            
        }else {
            
            motherName = modelMember.name ?? ""
            motherBState = DBManager_CountryStateDistrict().getStateName(stateCode: modelMember.birthStateCode ?? "")
            motherBDistrict = DBManager_CountryStateDistrict().getDistrictName(stateCode: modelMember.birthStateCode ?? "", districtCode: modelMember.birthDistrictCode ?? "")//modelMemberDetail.birthDistrictName ?? ""
            motherBCountry = DBManager_CountryStateDistrict().getCountryName(countryCode: modelMember.birthCountryCode ?? "")
            dob = modelMember.dob ?? ""
        }
        
        let dateComponent = dob.splitDateString()
        
        tf_ParentDetail_motherDob_date.text = dateComponent.date
        tf_ParentDetail_motherDob_month.text = dateComponent.month
        tf_ParentDetail_motherDob_year.text = dateComponent.year
        tf_ParentDetail_motherName.text = motherName
        btn_parentDetail_birthDistrict.setTitle(motherBDistrict , for: .normal)
        btn_ParentDetail_motherBirthState.setTitle(motherBState, for: .normal)
        
        btn_ParentDetail_motherBirthCountry.setTitle(motherBCountry, for: .normal)
        
    }
    
    func presentAdressDetail()  {
        AddNewHouseholdForm_ViewModel().presentAddressMember(memberDetal: modelMemberDetail, formClass: self)
        
        
        
    }
    func permanentAdressDetail()  {
        
        
      //  AddNewHouseholdForm_ViewModel().permanentAddressMember(memberDetal: modelMemberDetail, formClass: self)
        
//        btn_PaddCountry.setTitle(modelMemberDetail.paddress_country ?? "", for: .normal)
//
//        btn_padState.setTitle(modelMemberDetail.paddress_state ?? "", for: .normal)
//
//        btn_padDistrict.setTitle(modelMemberDetail.paddre_district ?? "", for: .normal)
//
//        btn_PadSubDistrict.setTitle(modelMemberDetail.paddre_tahsil ?? "", for: .normal)
//
//        tf_padTownVillage.text = modelMemberDetail.paddress_town ?? ""
//        tf_padPinCode.text = modelMemberDetail.ppinCode
    }
    
    func idDetail()  {
        
        tf_ID_voter.text = modelMemberDetail.voter_id ?? ""
        tf_ID_mobile.text = modelMemberDetail.mobile ?? ""
        
        tf_ID_dL.text = modelMemberDetail.driving_lincence ?? ""
        tf_ID_adhar.text = modelMemberDetail.aadhar ?? ""
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        updateNeverMarriedButton()
    }
    
    func viewPrepareEditMember()  {
 
        setGenderStatus(genderID: modelMemberDetail.gender_id ?? "")
        let genderInt = Int(modelMemberDetail.gender_id ?? "" )
        genderId = gender.init(rawValue: genderInt ?? 0) ?? gender.male
        // Parents Detail
        
 
        
    }
    override func viewDidLayoutSubviews() {
        
        
    }
    
    //MARK: - Buttons Action
    
    //Present Adrees
    
    @IBAction func btnDropdownCountry_action(_ sender: UIButton) {
        
        let aray = DataBaseManager().fetchDBData(entityName: EntityName.country)
        
        tapedButton = sender
        pickerView?.loadPicker(aray: aray, pickerTitle: "Choose Country", view: self.view)
        
      

        
    }
    
    
    
    @IBAction func btnDropdown_state_action(_ sender: UIButton) {
        
        let arayManagedObject = DataBaseManager().fetchDBData(entityName: EntityName.state)
        
        
        tapedButton = sender
        pickerView?.loadPicker(aray: arayManagedObject, pickerTitle: "Choose State", view: self.view)
    }
    
    
    
    @IBAction func btnDropdown_district_action(_ sender: UIButton) {
        
       let stateName = getButtonTitle(sender: sender, tag: sender.tag-1)
        let stateCode = DBManager_CountryStateDistrict().getStateCode(stateName: stateName)
        
        let predicate = NSPredicate(format: "stateCode = %@", stateCode)
        let arayManagedObject = DataBaseManager().fetchDBData(entityName: EntityName.district, predicate: predicate)
        
        
        tapedButton = sender
        pickerView?.loadPicker(aray: arayManagedObject, pickerTitle: "Choose District", view: self.view)
        
    }
    
    
    
    @IBAction func btnDropdown_subdistrict_action(_ sender: UIButton) {
        let stateName = getButtonTitle(sender: sender, tag: sender.tag-2)
        
         let stateCode = DBManager_CountryStateDistrict().getStateCode(stateName: stateName)
       // let predicate = NSPredicate(format: "", "")
        
        let districtName = getButtonTitle(sender: sender, tag: sender.tag-1)
        
        let disdictCode = DBManager_CountryStateDistrict().getDistrictCode(stateCode: stateCode, districtName: districtName)
        
        let predicate = NSPredicate(format: "district_code = %@ AND state_code = %@ ",disdictCode,stateCode )
//
        let arayManagedObject = DataBaseManager().fetchDBData(entityName: EntityName.tahsil, predicate: predicate)
//
        tapedButton = sender
        pickerView?.loadPicker(aray: arayManagedObject, pickerTitle: "Choose Tehsil", view: self.view)
    }
    
    
    
    @IBAction func btnDropdown_occupation_action(_ sender: UIButton) {
        let arayOccupation = English().occupation()
        tapedButton = sender
        pickerView?.loadPicker(aray: arayOccupation, pickerTitle: "Choose Occupation", view: self.view)
    }
    
    
    
    @IBAction func btnDropdown_qualification_action(_ sender: UIButton) {
        let arayOccupation = English().education_qualification()
               tapedButton = sender
        pickerView?.loadPicker(aray: arayOccupation, pickerTitle:"Education Qualification", view: self.view )
    }
    
    
    
    @IBAction func btnDropdown_motherToungue_action(_ sender: UIButton) {
        
        if let URL = Bundle.main.url(forResource: "MotherToungue", withExtension: "plist") {
        if let arr = NSArray(contentsOf: URL) as? [String] {
            
            
                var arayDict = [[String:Any]]()
                
                for item in arr {
                    let arayDateComponent = item.components(separatedBy: "-")
                    let dict = ["name":item,"id":arayDateComponent[1]]
                    arayDict.append(dict)
                }
                        
                 print( "Final Aray",arayDict)
                tapedButton = sender
                pickerView?.loadPicker(aray: arayDict, pickerTitle: "Choose Mothertoungue", view: self.view)
                }
           
           
          }
        
        
       
    }
    
    
    
    
    @IBAction func btnDropdown_nationality_action(_ sender: UIButton) {
       //let aray = ["India","America","Japan","China",""]
              
              tapedButton = sender
        let aray = DataBaseManager().fetchDBData(entityName: EntityName.country)
        
              pickerView?.loadPicker(aray: aray, pickerTitle: "Choose Nationality", view: self.view)
    }
    
    
    
    
    @IBAction func btnDropdown_relationShip_action(_ sender: UIButton) {
        
        var arayRelation =  [[String:String]]()
               tapedButton = sender
        
        switch genderId {
        case .male:
           arayRelation = English().relationship_to_head_male()
            break
        case .female:
            arayRelation = English().relationship_to_head_female()
            break
        default:
            arayRelation = English().relationship_to_head_transGender()
            break
        }
        arayRelation = arayRelation.filter{($0["id"]) != "01"}
        pickerView?.loadPicker(aray: arayRelation, pickerTitle: " Relationship to Head ", view: self.view)
    }
    
    
    @IBAction func btn_details_action(_ sender: UIButton) {
        updateDetailsView(clickedButton: sender)
        
    }

    @IBAction func btnGender_action(_ sender: UIButton) {
       
        sender.isSelected = true
       // let relCode = getRelationCode()
        
        switch sender.tag {
        case 6:
            deSelectButton(sender: sender, tag: 7)
            deSelectButton(sender: sender, tag: 8)
            genderId = gender.male
            break
            
            case 7:
                deSelectButton(sender: sender, tag: 6)
                deSelectButton(sender: sender, tag: 8)
                genderId = gender.female
                
            break
            
        default:
            deSelectButton(sender: sender, tag: 7)
            deSelectButton(sender: sender, tag: 6)
            genderId = gender.transGender
            break
        }
       // updateRelationNameByGender(relCode: relCode)
        if (btn_pd_relationWithHead.titleLabel?.text ?? "" == "Head/Self") {
            
        }else{
        
        btn_pd_relationWithHead.setTitle("", for: .normal)
        btn_pd_relationWithHead.isEnabled = true
        btn_pd_relationWithHead.isUserInteractionEnabled = true
        }
    }
    
    
    
    @IBAction func btn_pd_maritalStatus_action(_ sender: UIButton) {
        
        sender.isSelected = true
               switch sender.tag {
                case 10:
                deSelectButton(sender: sender, tag: 11)
                deSelectButton(sender: sender, tag: 12)
                deSelectButton(sender: sender, tag: 13)
                deSelectButton(sender: sender, tag: 14)
                    maritalStatus = .neverMarried
                break
                
               case 11:
                   deSelectButton(sender: sender, tag: 10)
                   deSelectButton(sender: sender, tag: 12)
                   deSelectButton(sender: sender, tag: 13)
                   deSelectButton(sender: sender, tag: 14)
                maritalStatus = .curentlyMarried
                   break
                   
                   case 12:
                      deSelectButton(sender: sender, tag: 11)
                       deSelectButton(sender: sender, tag: 10)
                       deSelectButton(sender: sender, tag: 13)
                       deSelectButton(sender: sender, tag: 14)
                    maritalStatus = .widowed
                       
                   break
                case 13:
                   deSelectButton(sender: sender, tag: 11)
                    deSelectButton(sender: sender, tag: 12)
                    deSelectButton(sender: sender, tag: 10)
                    deSelectButton(sender: sender, tag: 14)
                    maritalStatus = .seprated
                break
                   
               default:
                  deSelectButton(sender: sender, tag: 11)
                  deSelectButton(sender: sender, tag: 12)
                  deSelectButton(sender: sender, tag: 13)
                  deSelectButton(sender: sender, tag: 10)
                  maritalStatus = .divorced
                   break
               }
        
    }
    
   
    @IBAction func btn_samePresentAddAsHead_action(_ sender: UIButton) {
        
        sender.isSelected = true
        
        AddNewHouseholdForm_ViewModel().presentAddressHead(hhModel: modelHH, formClass: self)
        
    }
    @IBAction func btn_samePermanentAddAsHead_action(_ sender: UIButton) {
        
        sender.isSelected = true
        AddNewHouseholdForm_ViewModel().presentAddressHead(hhModel: modelHH, formClass: self)
    }
    
    @IBAction func btn_sameAsPresentAddress_action(_ sender: UIButton) {
        if sender.isSelected {
            
            tf_padHouseNumber.text = ""
            tf_padTownVillage.text = ""
            tf_padPinCode.text = ""
            btn_PadSubDistrict.setTitle("", for: .normal)
            btn_padDistrict.setTitle("", for: .normal)
            btn_padState.setTitle("", for: .normal)
            btn_PadSubDistrict.setTitle("", for: .normal)
            
            
        } else {
            tf_padHouseNumber.text = tf_ptAd_houseNumber.text
            tf_padTownVillage.text = tf_ptAd_townVillage.text
            tf_padPinCode.text = tf_ptAd_pinCode.text
            btn_PadSubDistrict.setTitle(btn_ptAdd_subDistrict.titleLabel?.text, for: .normal)
            btn_padDistrict.setTitle(btn_ptAdd_District.titleLabel?.text, for: .normal)
            btn_padState.setTitle(btn_ptAdd_State.titleLabel?.text, for: .normal)
            btn_PaddCountry.setTitle(btn_ptAdd_Country.titleLabel?.text, for: .normal)
            btn_PadSubDistrict.setTitle(btn_ptAdd_subDistrict.titleLabel?.text, for: .normal)
            
        }
        
        sender.isSelected = !sender.isSelected
        
    }
    
    @IBAction func btn_pad_actions(_ sender: UIButton) {
        
    }
    
    @IBAction func btn_padYEsNo_action(_ sender: UIButton) {
        
        AddNewHouseholdForm_ViewModel().btnStaySinceBirthTap(sender: sender, formClass: self)
        
        
    }
    @IBAction func btnSave_action(_ sender: UIButton) {
      
        var objAddFormVM = AddNewHouseholdForm_ViewModel()
        objAddFormVM.delgate = self
        objAddFormVM.validate(formClass: self)
        
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        
        let alertView = AlertView()
        isDataSaved = false
        alertView.delegate = self
        alertView.showAlert(vc: self, title: AppMessages().areYouSure, message: English.AddNewMemberFormAlert.tapBackButton)
        
       
    }
    
    @IBAction func btnSelectMotherName(_ sender: UIButton) {
        fetchMemberForMotherFather(gender: .female)
      
        
    }
    
    @IBAction func btnSelectFatherName_action(_ sender: UIButton) {
        if entryT != .newHouseHold {
        fetchMemberForMotherFather(gender: .male)
        }
    }
    
    @IBAction func btn_parent_stayInSameHH_action(_ sender: UIButton) {
        
        if sender.isSelected {
//            constraintHeight_viewSelectFatherName.constant = 0
//            constraintHeight_viewSelectMotherName.constant = 0
            stackViewSelectFather.isHidden = true
            stackViewSelectMotherDetail.isHidden = true
        }else{
            stackViewSelectFather.isHidden = false
            stackViewSelectMotherDetail.isHidden = false
//            constraintHeight_viewSelectFatherName.constant = 40
//            constraintHeight_viewSelectMotherName.constant = 40
        }
        btnSelectFatherName.isUserInteractionEnabled = true
        sender.isSelected = !sender.isSelected
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
    
    
    func deSelectButton(sender:UIButton,tag:Int)  {
        
        let buttonMale = sender.superview?.superview?.viewWithTag(tag) as? UIButton
        buttonMale?.isSelected = false
        
    }
    
    
    func fetchMemberForMotherFather(gender:gender)  {
        var antiGender = gender
        
        if gender == .male {
            antiGender = .female
        }else{
            antiGender = .male
        }
       let fatherMotherList = Bundle.main.loadNibNamed("SelectFatherMotherView", owner: self, options: nil)?.first as? SelectFatherMotherView
        fatherMotherList?.delegate = self
        let memberTin = strMemberNumber.memberTin(hhNumber: strHHNumber)
        
        // Father may be male or Transgender and Mother may be Female or Transgender 
        let predicate = NSPredicate(format: "hh_tin = %@ AND gender_id != %@ AND new_tin != %@ ", modelMemberDetail.hh_tin ?? "","\(antiGender.rawValue)",memberTin)
        DBManagerMemberDetail().searchMembers(predicate: predicate) { (arayMembers) in
            fatherMotherList?.loadMotherFatherList(aray: arayMembers, gender: gender, view: self.view)
            
        }
        
    }
    
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 8
    }

    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {

        
       return UITableView.automaticDimension
    }
////    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{


         return UITableView.automaticDimension

    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerView.backgroundColor = ProjectColor.colorPrimary
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return 80//UITableView.automaticDimension
    }
    
}

//MARK:PickerViewCommonDelegate

extension AddNewHouseHoldForm_TVC:PickerViewCommonDelegate{
    
    func didPickComponent(component: String) {
        tapedButton.setTitle(component, for: .normal)
        tapedButton.setTitleColor(ProjectColor.colorPrimary, for: .normal)
        
        if tapedButton == btn_pd_Natinality {
            if component == "India" {
                stackHeight_pd_passportEntry.constant = 100
                lbl_pd_messageNote.isHidden = false
            }else{
                stackHeight_pd_passportEntry.constant = 0
                lbl_pd_messageNote.isHidden = true
                btn_PD.isSelected = false
                
            }
            updateCell(clickedButton: btn_PD)
            return
        }
      
        if ((tapedButton == btn_pd_birthPlaceCountry )||(tapedButton ==  btn_PaddCountry ) || (tapedButton == btn_ptAdd_Country) || (tapedButton == btn_parentDetail_BirthCountry) || (tapedButton == btn_ParentDetail_motherBirthCountry))  {
            var isEnableButton = false
            
            
            if component == "India" {
                isEnableButton = true
            }
            let nextButton = findNextORPrevButton(sender: tapedButton, tagToFind: tapedButton.tag+1)
            nextButton.isUserInteractionEnabled = isEnableButton
            
            
        }
        else if ((tapedButton == btn_pd_birthPlaceState )||(tapedButton ==  btn_ptAdd_State ) || (tapedButton == btn_ptAdd_State) || (tapedButton == btn_parentDeatil_BirthState) || (tapedButton == btn_ParentDetail_motherBirthState) || (tapedButton == btn_padState))  {
            
            let nextButton = findNextORPrevButton(sender: tapedButton, tagToFind: tapedButton.tag+1)
            nextButton.isUserInteractionEnabled = true
            nextButton.setTitle("", for: .normal)
        }
        else if ((tapedButton == btn_pd_birthPlaceDistrict )||(tapedButton ==  btn_ptAdd_District ) || (tapedButton == btn_padDistrict) || (tapedButton == btn_ParentDetail_motherBirthDistrict) || (tapedButton == btn_ParentDetail_motherBirthDistrict))  {
            
            let nextButton = findNextORPrevButton(sender: tapedButton, tagToFind: tapedButton.tag+1)
            nextButton.isUserInteractionEnabled = true
            if tapedButton != btn_pd_birthPlaceDistrict
            {
                nextButton.setTitle("", for: .normal)
            }
            
        }else if (tapedButton == btn_pd_relationWithHead){
            updateNeverMarriedButton()
        }
        
        
        
    }
    
    func cancelPicker() {
        //pickerView?.removeFromSuperview()
    }
    
    
}

//MARK:Add NewMember Delegate
extension AddNewHouseHoldForm_TVC:AddNewHouseholdForm_ViewModelDelegate{
    func dataSavedSucessFully() {
        let alertView = AlertView()
        alertView.delegate = self
        switch entryT {
        
        case .newHouseHold:
            
           
            
            isDataSaved = true
            
            alertView.showAlert(vc: self, title: AppMessages().areYouSure, message: English.AddNewMemberFormAlert.doYouWantAddMoreMember)
            //entryT = .addNewMemberExitHH
            
            break
        case .addNewMemberExitHH:
            
            
            //self.backAccordingCondition()
            alertView.alertWithoutButton(vc: self, message:English.AddNewMemberFormAlert.newMemberAddedSuccesFully)
            break
          
        case .editDetail:
            modelMemberDetail.memberStatus = MemberStatusCode.available
            modelMemberDetail.member_completionStatus = MemberCompletionStatusCode.completed
            do {
                try context.save()
            } catch  {
                
            }
            
            
            
            self.backAccordingCondition()
           // alertView.alertWithoutButton(vc: self, message:English.AddNewMemberFormAlert.memberUpdatedSuccess)
            break
        
        }
        
        

    }
   
    
    
}



