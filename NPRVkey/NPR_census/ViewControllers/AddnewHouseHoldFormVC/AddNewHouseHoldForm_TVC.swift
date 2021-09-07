//
//  AddNewHouseHoldForm_TVC.swift
//  NPR_census
//
//  Created by admin on 04/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import MetalKit
//import IQKeyboardManagerSwift

class AddNewHouseHoldForm_TVC: UITableViewController {
    
    @IBOutlet weak var lblPageTitle: UILabel!
    @IBOutlet weak var lblPrevPageName: UILabel!
    @IBOutlet weak var lblBlockNo: UILabel!
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMemberSerial: UILabel!
    @IBOutlet weak var lblHHNumber: UILabel!
    //MARK:PersonalDetail Outlet Personal Details
    @IBOutlet weak var btnPD_title: UIButton!
    @IBOutlet weak var lblCensusHNTitle: UILabel!
    @IBOutlet weak var lblCensusHHNOTitle: UILabel!
    @IBOutlet weak var lblSERefrenceTitle: UILabel!
    
    @IBOutlet weak var lblNameTitle: UILabel!
    @IBOutlet weak var middleNameTitle: UILabel!
    @IBOutlet weak var lastNameTitle: UILabel!
    
    @IBOutlet weak var lblSexTitle: UILabel!
    @IBOutlet weak var btnMaleTitle: UIButton!
    
    @IBOutlet weak var btnFemaleTitle: UIButton!
    @IBOutlet weak var btnTransgenderTitle: UIButton!
    @IBOutlet weak var btnRelationWithHeadTitle: UIButton!
    @IBOutlet weak var lblMaritalStatusTitle: UILabel!
    
    @IBOutlet weak var btnCurrentalyMarriedTitle: UIButton!
    
    @IBOutlet weak var btnSepratedTitle: UIButton!
    @IBOutlet weak var btnWidowedTitle: UIButton!
    @IBOutlet weak var btnDivorcedTitle: UIButton!
   
    
    @IBOutlet weak var lblDOBTitle: UILabel!
    
    @IBOutlet weak var btnDOBCountry_title: UIButton!
    @IBOutlet weak var btnDOBState_title: UIButton!
    
    @IBOutlet weak var btnDOBDistrict_title: UIButton!
    
    @IBOutlet weak var lblNationality_title: UIButton!
    
    @IBOutlet weak var lblHavingPassport_title: UILabel!
    
    
    //Education Detail
    
    @IBOutlet weak var btnEducationSection_title: UIButton!
    
    @IBOutlet weak var btnEduQuali_title: UIButton!
    @IBOutlet weak var btnOccupation_title: UIButton!
    @IBOutlet weak var btnMotherTongue_title: UIButton!
    
    @IBOutlet weak var lblOtherMotherTongue_title: UILabel!
    // Present Address

    @IBOutlet weak var btnPresentAdd_title: UIButton!
    @IBOutlet weak var prentAddSameAsHead_title: UIButton!
    
    @IBOutlet weak var btnPresentAddCountry_title: UIButton!
    @IBOutlet weak var btnPresentAddState_title: UIButton!
    
    @IBOutlet weak var btnPresentAddDistrict_title: UIButton!
    @IBOutlet weak var btnPresentAddSubDistrict_title: UIButton!
    @IBOutlet weak var lblTownVillage_title: UILabel!
    @IBOutlet weak var lblHouseNumber_title: UILabel!
    @IBOutlet weak var lblPin_title: UILabel!
    
    
    
    
    
    
    
    // Permanent Add Titles
    
    
    @IBOutlet weak var btnPermaAdd_title: UIButton!
    @IBOutlet weak var btnPermaAddSameAsHead_title: UIButton!
    @IBOutlet weak var btnPermaAddSameAsParticularMember_title: UIButton!
    @IBOutlet weak var btnPermaAddSameAsPresentAdd_title: UIButton!
    @IBOutlet weak var btnPermaAddCountry_title: UIButton!
    @IBOutlet weak var btnPermaAddState_title: UIButton!
    
    @IBOutlet weak var btnPermaAddDistrict_title: UIButton!
    @IBOutlet weak var btnPermaAddSubDistrict_title: UIButton!
    @IBOutlet weak var lblPermaTownVillage_title: UILabel!
    @IBOutlet weak var lblPermaHouseNumber_title: UILabel!
    @IBOutlet weak var lblPermaPin_title: UILabel!
    @IBOutlet weak var lblStayingPresentAdd_title: UILabel!
    
    @IBOutlet weak var btnYes_title: UIButton!
    @IBOutlet weak var btnNo_title: UIButton!
    
    @IBOutlet weak var lblStayingYear_title: UILabel!
    
    @IBOutlet weak var btnLastStayingCountry_title: UIButton!
    @IBOutlet weak var btnLastStayingState_title: UIButton!
    
    @IBOutlet weak var btnLastStayingDistrict_title: UIButton!
   
    
    /// Parent's Detail Titles
    @IBOutlet weak var btnParentDetail_title: UIButton!
    
    @IBOutlet weak var parentStayInThisHH_title: UIButton!
 
    @IBOutlet weak var btnSelectFatherName_title: UIButton!
    @IBOutlet weak var lblFatherName_title: UILabel!
    @IBOutlet weak var lblFatherDOB_title: UILabel!
    @IBOutlet weak var btnFatherDOBCountry_title: UIButton!
    
    @IBOutlet weak var btnFatherDOBState_title: UIButton!
    
    @IBOutlet weak var btnFatherDOBDistrict_title: UIButton!
    @IBOutlet weak var btnSelectMotherName_title: UIButton!
    
    @IBOutlet weak var lblMotherName_title: UILabel!
    @IBOutlet weak var lblDOBMother_title: UILabel!
    
    @IBOutlet weak var btnMotherDOBCountry_title: UIButton!
    @IBOutlet weak var btnMotherDOBState_title: UIButton!
    
    @IBOutlet weak var btnMotherDOBDistrict_title: UIButton!
    
    @IBOutlet weak var lblSpouseName_title: UILabel!
    
    
    
    
    //////ID Detail Titles
    @IBOutlet weak var btnID_title: UIButton!
    @IBOutlet weak var lblAdhar_title: UILabel!
    @IBOutlet weak var lblMobile_title: UILabel!
    @IBOutlet weak var lblVoterID_title: UILabel!
    @IBOutlet weak var lblDL_title: UILabel!
    //MARK:PersonalDetail Outlet Personal Details
    @IBOutlet weak var btnCheckMale: UIButton!
    @IBOutlet weak var btnCheckFemale: UIButton!
    @IBOutlet weak var btnCheckTransgender: UIButton!
    @IBOutlet weak var btn_ed_qualification: UIButton!
    @IBOutlet weak var btn_ed_occupation: UIButton!
    @IBOutlet weak var btn_ed_motherTounge: UIButton!
    @IBOutlet weak var btnNeverMarried: UIButton!
    
    @IBOutlet weak var btnCheckCurrentlyMarried: UIButton!
    @IBOutlet weak var btnCheckNeverMarried: UIButton!
    @IBOutlet weak var btnCheckWidowed: UIButton!
    @IBOutlet weak var btnCheckSeprated: UIButton!
    @IBOutlet weak var btncheckDivorce: UIButton!
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
    
    @IBOutlet weak var tf_pd_lastName: CustomTextField!
    @IBOutlet weak var tf_pd_midleName: CustomTextField!
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
    @IBOutlet weak var stackView_enterOtherMotherTongue: UIStackView!
    @IBOutlet weak var btn_EQ_Expand: UIButton!
    @IBOutlet weak var constraintHeight_enterOtherMotherTongue: NSLayoutConstraint!
    
    @IBOutlet weak var tf_edu_enterOtherMotherTongue: CustomTextField!
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
    @IBOutlet weak var stackViewSamePermanentAddAsPerticularMember: UIStackView!
    
    @IBOutlet weak var btnCkeck_permanentSameasPresentAdd: UIButton!
    @IBOutlet weak var btnCkeck_permanentSameasHead: UIButton!
    @IBOutlet weak var btnCkeck_permanentSameasPertularMember: UIButton!
    
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
    @IBOutlet weak var btnLastResidenceState: UIButton!
    @IBOutlet weak var btnLastResidenceDistrict: UIButton!
    var isStayPrensetAddSinceBirth = false
    
    @IBOutlet weak var stackView_padd_country: UIStackView!
    
    @IBOutlet weak var stackView_padd_state: UIStackView!
    @IBOutlet weak var stackView_padd_district: UIStackView!
    @IBOutlet weak var stackView_padd_subDistrict: UIStackView!
    @IBOutlet weak var stackView_padd_houseNPinCode: UIStackView!
    @IBOutlet weak var stackView_lastResidenseState: UIStackView!
    
    @IBOutlet weak var stackView_lastResidenseDistrict: UIStackView!
    
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
    
    @IBOutlet weak var stackViewSpouseName: UIStackView!
    //IdentiFication Detail
    @IBOutlet weak var btn_ID_expand: UIButton!
    @IBOutlet weak var iD_detail_innerStackView: StackView!
    
    @IBOutlet weak var tf_ID_voter: UITextField!
    @IBOutlet weak var tf_ID_mobile: UITextField!
    @IBOutlet weak var tf_ID_dL: UITextField!
    @IBOutlet weak var tf_ID_adhar: UITextField!
    
    @IBOutlet weak var btnSave: UIButton!
    
    
    var modelMemberDetail = NPR2021MemberDetails()
    var modelHH = NPR_2021hh_Details()
    var isEditingDetail = false
    var isOldHH = false
    
    var pickerView:PickerViewCommon?
    var genderId = gender.notSelect
    var maritalStatus = Utils.marritalStaus.none
    
    var tapedButton = UIButton()
    var strHHNumber = ""
    var strMemberNumber = ""
    var strMemberName = ""
    var strHouseNumber = ""
    var strCensusHHNumber = ""
    var strInstituteName = ""
    
    
    var hhType = ""
    var entryT = entryType.newHouseHold
    var alertFor = AlertFor.none
    
    
    var hhStatus = ""
    var memberStatus = ""
    var hh_completionStatus = ""
    var memberComletionStatus = ""
    var isValidSeRefrence = false
    
    //var memberSerialNumber = ""
    var isDataSaved = false
    var isPressYesProceedWithoutAadhar = false
    enum AlertFor:Int {
        case dataSaved = 1 , aadhar , none
    }
    
    //let formDetailProtocol:formDetailProtocol? = nil
    
    // Others
    var selectedHouseType:HouseType?
    
    //var addnewMemberformVM = AddNewHouseholdForm_ViewModel()
    
    var formModelClass : AddNewHouseholdForm_ViewModel?
    var objPersonalDetail : FormPersonalDetailManagement?
    
    var objIDManagement : FormIDManagement?
    
    
    
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
        self.tableView.contentInsetAdjustmentBehavior = .scrollableAxes
        self.intialViewPrepare()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //
    }
    func intialViewPrepare() {
        
        lblPrevPageName.text = "\(LanguageModal.langObj.hh_member_form)"
        formModelClass = AddNewHouseholdForm_ViewModel(formClass: self)
        formModelClass!.delgate = self
        //addnewMemberformVM.formClass = self
        let indexPathTop = IndexPath.init(row: 0, section: 0)
        btnSave.setTitle(LanguageModal.langObj.button_save, for: .normal)
        self.tableView.scrollToRow(at:indexPathTop , at: .top, animated: true)
        objPersonalDetail  = FormPersonalDetailManagement.init(formClass: self)
        formModelClass?.viewPrepareForAllCondition()
        self.removeKeyboardObserver()
        
        btn_parentDetail_BirthCountry.setTitle("India", for: .normal)
        btn_ParentDetail_motherBirthCountry.setTitle("India", for: .normal)
        pd_houseNo.addDoneButton()
        tf_pd_houseHoldNO.addDoneButton()
        tf_pd_SE_refrenceNO.addDoneButton()
        tf_staySameAddressYear.addupDoneButton_TextFields()
        tf_pd_houseHoldNO.addupDoneButton_TextFields()
        tf_padHouseNumber.addupDoneButton_TextFields()
        tf_pd_Dob_date.addDoneButton()
        tf_pd_Dob_month.addDoneButton()
        tf_pd_Dob_year.addDoneButton()
        
        tf_ParentDetail_dob_date.addupDoneButton_TextFields()
        tf_ParentDetail_dob_month.addupDoneButton_TextFields()
        tf_ParentDetail_dob_year.addupDoneButton_TextFields()
        
        tf_ParentDetail_motherDob_date.addupDoneButton_TextFields()
        tf_ParentDetail_motherDob_month.addupDoneButton_TextFields()
        tf_ParentDetail_motherDob_year.addupDoneButton_TextFields()
        
        tf_ptAd_pinCode.addupDoneButton_TextFields()
        tf_padPinCode.addupDoneButton_TextFields()
        
        tf_ID_adhar.addupDoneButton_TextFields()
        tf_ID_mobile.addupDoneButton_TextFields()
    
        if isEditingDetail {
           // viewPrepare()
            lblPrevPageName.text = "\(LanguageModal.langObj.hh_member_details)"
        }
        else{
            
            switch selectedHouseType {
            case .normal:
                
                tf_pd_houseHoldNO.isUserInteractionEnabled = true
                
                break
            case .institute:
                tf_pd_houseHoldNO.isUserInteractionEnabled = false
                pd_houseNo.isUserInteractionEnabled = true
                tf_pd_houseHoldNO.text = strCensusHHNumber
                
                break
            case .houseLess:
                tf_pd_houseHoldNO.isUserInteractionEnabled = true
                pd_houseNo.isUserInteractionEnabled = false
               // tf_pd_houseHoldNO.text = strCensusHHNumber
                break
            default:
                break
            }
           
            
            formModelClass?.viewPrepareForAllCondition()

            if DBManagerMemberDetail().getNewMemberSerialNumber(hhNumber: strHHNumber) == "1".memberSrNumber() {
                let arayRelation = LanguageModal.langObj.relationship_to_head_male
               //let relationModel = PickerViewCommon_model.init(model:arayRelation[0])
                let relCode_name = "\(arayRelation[0].id ?? "") - \(arayRelation[0].name ?? "")"
                
                btn_pd_relationWithHead.setTitle(relCode_name, for: .normal)
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
            formModelClass?.viewPrepareForAllCondition()
        
    }
    func viewPrepareForAllCondition()  {
    
        var strPageTitle = ""
        
        switch  entryT{
        case .newHouseHold:
           
            memberStatus = MemberStatusCode.newMember
            strMemberNumber = DBManagerMemberDetail().getNewMemberSerialNumber(hhNumber: strHHNumber)
            basicInfo_Member(hhN: strHHNumber , headName: strMemberName )
            memberStatus = MemberStatusCode.newMember
            tf_pd_Name.text = strMemberName
            
            hh_completionStatus = HHCompletionStatusCode.completed
            stackViewSamePresentAddAsHead.isHidden = true
            stackViewSamePermanentAddAsHead.isHidden = true
            stackViewSamePermanentAddAsPerticularMember.isHidden = true
           // formModelClass?.presentAddressHead(hhModel: <#T##NPR_2021hh_Details#>, formClass: <#T##AddNewHouseHoldForm_TVC#>)
            formModelClass?.presentAddressMember()
            formModelClass?.presentAddressMember()
            btnSave.setTitle(LanguageModal.langObj.button_save, for: .normal)
            lblPrevPageName.text = LanguageModal.langObj.hh_summary
            strPageTitle = "\(LanguageModal.langObj.hh_member_form)"
            break
            
        case .addNewMemberExitHH:
            strHHNumber = modelHH.houseHoldhNo ?? ""
            
            strMemberNumber = DBManagerMemberDetail().getNewMemberSerialNumber(hhNumber: strHHNumber)
            lblPrevPageName.text = LanguageModal.langObj.hh_member_details//"Household Member Detail"
            basicInfo_Member(hhN: strHHNumber, headName: English.AddNewMemberFormAlert.newMember)
            
            lblPrevPageName.text = LanguageModal.langObj.hh_member_details
            
            selectedHouseType = HouseType.init(rawValue: modelHH.hhType ?? "1")
            
            memberStatus = MemberStatusCode.newMember
            
            hhAlreadyExist()
            stackViewSamePresentAddAsHead.isHidden = false
            stackViewSamePermanentAddAsHead.isHidden = false
            formModelClass?.presentAddressMember()
            formModelClass?.presentAddressMember()
            btnSave.setTitle(LanguageModal.langObj.button_save, for: .normal)
            
            strPageTitle = "\(LanguageModal.langObj.hh_member_form)"
            
            break
            
        case .editDetail:
            strPageTitle = "\(LanguageModal.langObj.hh_member_form)"
            strHHNumber = modelHH.houseHoldhNo ?? ""
            viewPrepareEditMember()
            strMemberNumber = modelMemberDetail.sloMember ?? ""
            basicInfo_Member(hhN: modelMemberDetail.hh_Number ?? "", headName: modelMemberDetail.name ?? "")
            tf_ptAd_houseNumber.text = modelMemberDetail.censusHouse_number
           // personalDetail()
            //educationDetail()
            fatherDetail(modelMember: modelMemberDetail, modelType: .personal)
            motherDetail(modelMember: modelMemberDetail, modelType: .personal)
            
            
           selectedHouseType = HouseType.init(rawValue: modelHH.hhType ?? "1")
            idDetail()
            lblPrevPageName.text = LanguageModal.langObj.hh_member_details//"Household Member Detail"
            
                memberStatus = MemberStatusCode.available
          
            
            
            //personalDetail()
            
            hhAlreadyExist()
           
            
            
            formModelClass?.setMemberDetailData()
            
            
            
            break
        
        }
        
        lblPageTitle.text =  strPageTitle
    }
    
    func hhAlreadyExist()  {
        
        tf_pd_houseHoldNO.text = modelHH.census_hhNo
        pd_houseNo.text = modelHH.census_hNo
    }
    
    func basicInfo_Member(hhN:String,headName:String)  {
       
        lblBlockNo.text = "\(LanguageModal.langObj.block_no) \(singleton().selectEBListModel.eb_block_number ?? "")"
        lblHHNumber.text = "\(LanguageModal.langObj.hh_no) \(hhN )"
        
        lblMemberSerial.text = "\(LanguageModal.langObj.member_sr_no). - \(strMemberNumber)"
        lblName.text = headName
        
    }

    func fatherDetail(modelMember:NPR2021MemberDetails , modelType:dobType)  {
        
        btnSelectFatherName.isUserInteractionEnabled = true
        var fatherName = ""
        var fatherBDistrictCode = ""
        var fatherBStateCode = ""
        var fatherBCountryCode = ""
        var dob = ""
        var dobStatus = ""
        
        if modelType == .personal {
            fatherName = modelMember.father_name ?? ""
            
            if modelMember.language?.IsSelectedLangauge_nonEnglish ?? false {
                fatherName = ((modelMember.father_name_sl?.count != 0) ? modelMember.father_name_sl ?? "" : modelMember.father_name) ?? ""
            }else{
                fatherName = ((modelMember.father_name?.count != 0) ? modelMember.father_name ?? "" : modelMember.father_name_sl) ?? ""
            }
            
            
            
            
            
            
            
            fatherBStateCode = modelMember.fatherBirthStateCode ?? ""
            fatherBDistrictCode = modelMember.fatherBirthDistrictCode ?? ""
            fatherBCountryCode = modelMember.fatherBirthCountryCode ?? ""
            dob = modelMember.father_dob ?? ""
           dobStatus = modelMember.father_dobType ?? ""
        }else {
            
            fatherName = modelMember.name ?? ""
            
            
            if modelMember.language?.IsSelectedLangauge_nonEnglish ?? false {
                fatherName = ((modelMember.nameSL?.count != 0) ? modelMember.nameSL ?? "" : modelMember.name) ?? ""
            }else{
                fatherName = ((modelMember.name?.count != 0) ? modelMember.name ?? "" : modelMember.nameSL) ?? ""
            }
            
            
            
            fatherBStateCode = modelMember.fatherBirthStateCode ?? ""
            fatherBDistrictCode = modelMember.fatherBirthDistrictCode ?? ""
            fatherBCountryCode = modelMember.fatherBirthCountryCode ?? ""
             dob = modelMember.dob ?? ""
            dobStatus = modelMember.dob_type ?? ""
        }
       let modifiedDob = FormDateMangement().updateDobByStatus(strStatus: dobStatus, strDate: dob)
         let dateComponent = modifiedDob.splitDateString()
        tf_ParentDetail_dob_date.text = dateComponent.date
        tf_ParentDetail_dob_month.text = dateComponent.month
        tf_ParentDetail_dob_year.text = dateComponent.year
         parentDetail_fatherName.text = fatherName
        
        let fatherBDistrict = DBManager_CountryStateDistrict().getDistrictName(stateCode: fatherBStateCode, districtCode: fatherBDistrictCode)
        let fatherBState = DBManager_CountryStateDistrict().getStateName(stateCode: fatherBStateCode)
        let fatherBCountry = DBManager_CountryStateDistrict().getCountryName(countryCode: fatherBCountryCode)
        
        
         btn_parentDetail_birthDistrict.setTitle(fatherBDistrict , for: .normal)
         btn_parentDeatil_BirthState.setTitle(fatherBState, for: .normal)
         btn_parentDetail_BirthCountry.setTitle(fatherBCountry, for: .normal)
        btn_parentDetail_BirthCountry.titleLabel?.text = fatherBCountry
        btn_parentDeatil_BirthState.titleLabel?.text = fatherBState
        btn_parentDetail_birthDistrict.titleLabel?.text = fatherBDistrict
        
        let isBirthCountryIndia = util.isCountryCodeIndia(countryCode: fatherBCountryCode)
        
        btn_parentDetail_birthDistrict.isUserInteractionEnabled = isBirthCountryIndia
        btn_parentDeatil_BirthState.isUserInteractionEnabled = isBirthCountryIndia
       // btn_parentDetail_BirthCountry.isUserInteractionEnabled = isBirthCountryIndia
        
        
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
        var dobStatus = ""
        
        if modelType == .personal {
            
            dob = modelMember.mother_dob ?? ""
            motherName = modelMember.motherName ?? ""
            
            if modelMember.language?.IsSelectedLangauge_nonEnglish ?? false {
                motherName = ((modelMember.motherName_sl?.count != 0) ? modelMember.motherName_sl ?? "" : modelMember.motherName) ?? ""
            }else{
                motherName = ((modelMember.motherName?.count != 0) ? modelMember.motherName ?? "" : modelMember.motherName_sl) ?? ""
            }
            
            motherBState = DBManager_CountryStateDistrict().getStateName(stateCode: modelMember.mother_birthStateCode ?? "")
            motherBDistrict = DBManager_CountryStateDistrict().getDistrictName(stateCode: modelMember.mother_birthStateCode ?? "", districtCode: modelMember.mother_birthDistrictCode ?? "")//modelMemberDetail.birthDistrictName ?? ""
            motherBCountry = DBManager_CountryStateDistrict().getCountryName(countryCode: modelMember.mother_birthCountryCode ?? "")
            dobStatus = modelMember.mother_dobType ?? ""
        }else {
            
            motherName = modelMember.name ?? ""
            
            
            if modelMember.language?.IsSelectedLangauge_nonEnglish ?? false {
                motherName = ((modelMember.nameSL?.count != 0) ? modelMember.nameSL ?? "" : modelMember.name) ?? ""
            }else{
                motherName = ((modelMember.name?.count != 0) ? modelMember.name ?? "" : modelMember.nameSL) ?? ""
            }
            motherBState = DBManager_CountryStateDistrict().getStateName(stateCode: modelMember.birthStateCode ?? "")
            motherBDistrict = DBManager_CountryStateDistrict().getDistrictName(stateCode: modelMember.birthStateCode ?? "", districtCode: modelMember.birthDistrictCode ?? "")//modelMemberDetail.birthDistrictName ?? ""
            motherBCountry = DBManager_CountryStateDistrict().getCountryName(countryCode: modelMember.birthCountryCode ?? util.countryCode)
            dob = modelMember.dob ?? ""
            dobStatus = modelMember.dob_type ?? ""
        }
        
        let modifiedDob = FormDateMangement().updateDobByStatus(strStatus: dobStatus, strDate: dob)
        let dateComponent = modifiedDob.splitDateString()
        
        tf_ParentDetail_motherDob_date.text = dateComponent.date
        tf_ParentDetail_motherDob_month.text = dateComponent.month
        tf_ParentDetail_motherDob_year.text = dateComponent.year
        tf_ParentDetail_motherName.text = motherName
        
        btn_ParentDetail_motherBirthDistrict.setTitle(motherBDistrict , for: .normal)
        btn_ParentDetail_motherBirthState.setTitle(motherBState, for: .normal)
        
        btn_ParentDetail_motherBirthCountry.setTitle(motherBCountry, for: .normal)
        
        btn_ParentDetail_motherBirthCountry.titleLabel?.text = motherBCountry
        btn_ParentDetail_motherBirthState.titleLabel?.text = motherBState
        btn_ParentDetail_motherBirthDistrict.titleLabel?.text = motherBDistrict
       // let isBirthCountryIndia = util.isCountryCodeIndia(countryCode: modelMember.birthCountryCode ?? util.countryCode)
        
       // btn_ParentDetail_motherBirthDistrict.isUserInteractionEnabled = isBirthCountryIndia
      //  btn_ParentDetail_motherBirthState.isUserInteractionEnabled = isBirthCountryIndia
        
        
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
   
    @IBAction func btnQRCodeScan_action(_ sender: UIButton) {
        
        objPersonalDetail?.openQRCodeScanner()
        
      }
    
    @IBAction func btnDropdownCountry_action(_ sender: UIButton) {
        
        let aray = DataBaseManager().fetchDBData(entityName: EntityName.country)
        
        tapedButton = sender
        
        if tapedButton == btn_PaddCountry || tapedButton == btnLastResidenceCountry  {
            pickerView?.delegate = formModelClass?.objPermanentAddressDetail
        }else{
            pickerView?.delegate = self
        }
        pickerView?.loadPicker(aray: aray, pickerType: .countryList)
        
      }
    
    
    
    @IBAction func btnDropdown_state_action(_ sender: UIButton) {
        var isEnable = false
        
        if sender == btn_ptAdd_State {
           isEnable = true
            
            
        }else{
            let btnCountry = findNextORPrevButton(sender: sender, tagToFind: sender.tag - 1)
            let strContryCode = DBManager_CountryStateDistrict().getCountryCode(countryName: btnCountry.titleLabel?.text ?? "")
            if util.isCountryCodeIndia(countryCode: strContryCode) {
                isEnable = true
            }
        }
        
        let arayManagedObject = DataBaseManager().fetchDBData(entityName: EntityName.state)
        
        tapedButton = sender
        if isEnable {
            if tapedButton == btn_padState || tapedButton == btnLastResidenceState {
                pickerView?.delegate = formModelClass?.objPermanentAddressDetail
            }else{
                pickerView?.delegate = self
            }
            
            pickerView?.loadPicker(aray: arayManagedObject, pickerType: .stateList)
        }
       
    }
    
    
    
    @IBAction func btnDropdown_district_action(_ sender: UIButton) {
       
        let btnCountry = findNextORPrevButton(sender: sender, tagToFind: sender.tag - 1)
        let strstateName = btnCountry.titleLabel?.text ?? ""
        
        
        if strstateName.count > 0 {
        let stateName = getButtonTitle(sender: sender, tag: sender.tag-1)
        let stateCode = DBManager_CountryStateDistrict().getStateCode(stateName: stateName)
        
        let predicate = NSPredicate(format: "stateCode = %@ OR stateCode = %@", stateCode,"99")
        let arayManagedObject = DataBaseManager().fetchDBData(entityName: EntityName.district, predicate: predicate)
        
        
        tapedButton = sender
            
            if tapedButton == btn_padDistrict || tapedButton == btnLastResidenceDistrict {
                pickerView?.delegate = formModelClass?.objPermanentAddressDetail
            }else{
                pickerView?.delegate = self
            }
        
            
            pickerView?.loadPicker(aray: arayManagedObject, pickerType: .districtList)
        }
    }
    
    
    
    @IBAction func btnDropdown_subdistrict_action(_ sender: UIButton) {
        let stateName = getButtonTitle(sender: sender, tag: sender.tag-2)
        
        let btnCountry = findNextORPrevButton(sender: sender, tagToFind: sender.tag - 1)
        let strSubDistrictName = btnCountry.titleLabel?.text ?? ""
        if strSubDistrictName.count > 0 {
        
        
         let stateCode = DBManager_CountryStateDistrict().getStateCode(stateName: stateName)
       // let predicate = NSPredicate(format: "", "")
        
        let districtName = getButtonTitle(sender: sender, tag: sender.tag-1)
        
        let disdictCode = DBManager_CountryStateDistrict().getDistrictCode(stateCode: stateCode, districtName: districtName)
        
        let predicate = NSPredicate(format: "district_code = %@ AND state_code = %@ ",disdictCode,stateCode )
//
        let arayManagedObject = DataBaseManager().fetchDBData(entityName: EntityName.tahsil, predicate: predicate)
//
        tapedButton = sender
            
            if tapedButton == btn_PadSubDistrict  {
                pickerView?.delegate = formModelClass?.objPermanentAddressDetail
            }else{
                pickerView?.delegate = self
            }
            
       
            pickerView?.loadPicker(aray: arayManagedObject, pickerType: .subDistrictList)
        }
    }
    
    @IBAction func btn_searchHeadFormHLO_action(_ sender: UIButton) {
        
        let searchHeaed = Bundle.main.loadNibNamed("SelectHeadFromHLOView", owner: self, options: nil)?.first as? SelectHeadFromHLOView
       // selectMemberView?.delegate = self
        

        
        searchHeaed?.loadMemberList()
        
    }
    
    @IBAction func btnDropdown_occupation_action(_ sender: UIButton) {
        let arayOccupation = LanguageModal.langObj.occupationArr
        tapedButton = sender
        
        pickerView?.loadPicker(aray: arayOccupation, pickerType: .occopationList)
    }
    
    
    
    @IBAction func btnDropdown_qualification_action(_ sender: UIButton) {
        let arayOccupation = LanguageModal.langObj.education_qualification
               tapedButton = sender
        
        pickerView?.loadPicker(aray: arayOccupation, pickerType: .educationList)
    }
    
    
    
    @IBAction func btnDropdown_motherToungue_action(_ sender: UIButton) {
        tapedButton = sender
        
        pickerView?.loadPicker(aray: LanguageModal.langObj.mother_toungeArr, pickerType: .motherTongueList)
        
        }

    @IBAction func btnDropdown_nationality_action(_ sender: UIButton) {
       //let aray = ["India","America","Japan","China",""]
              
              tapedButton = sender
        
        let aray = DataBaseManager().fetchDBData(entityName: EntityName.country)
        
        
        
        pickerView?.loadPicker(aray: aray, pickerType: .nationality)
    }

    @IBAction func btnDropdown_relationShip_action(_ sender: UIButton) {
        
        
        var arayRelation =  [ModelNameID]()
               tapedButton = sender
        
        switch genderId {
        case .male:
            arayRelation = LanguageModal.langObj.relationship_to_head_male
            break
        case .female:
            arayRelation =  LanguageModal.langObj.relationship_to_head_female
            break
        case .transGender:
            arayRelation =  LanguageModal.langObj.relationship_to_head
            break
            
        default:
            
            return
           
        }
        arayRelation = arayRelation.filter{($0.id) != "01"}
        
        
        pickerView?.loadPicker(aray: arayRelation, pickerType: .relationList)
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
            
        case 8:
            
            deSelectButton(sender: sender, tag: 7)
            deSelectButton(sender: sender, tag: 6)
            genderId = gender.transGender
            
        break
                
        default:
            
            deSelectButton(sender: sender, tag: 8)
            deSelectButton(sender: sender, tag: 7)
            deSelectButton(sender: sender, tag: 6)
            genderId = gender.notSelect
            break
        }
       // updateRelationNameByGender(relCode: relCode)
        let relCodeComponent = btn_pd_relationWithHead.titleLabel?.text?.components(separatedBy: "-")
        let relcode = relCodeComponent?.first?.trimWhiteSpace()
        
        if (relcode == LanguageModal.langObj.relationship_to_head_male[0].id) {
            
        }else{
        
        btn_pd_relationWithHead.setTitle("", for: .normal)
        btn_pd_relationWithHead.titleLabel?.text = ""
        btn_pd_relationWithHead.isEnabled = true
        btn_pd_relationWithHead.isUserInteractionEnabled = true
        btn_pd_relationWithHead.setTitle("", for: .normal)
        
        }
    }
    
    
    
    @IBAction func btn_pd_maritalStatus_action(_ sender: UIButton) {
        objPersonalDetail?.selectMaritalStatus(sender: sender)
        }

    @IBAction func btn_samePresentAddAsHead_action(_ sender: UIButton) {
        
        sender.isSelected = true
        
        formModelClass!.presentAddressHead(hhModel: modelHH, formClass: self)
        btnCkeck_permanentSameasPertularMember.setTitle("", for: .normal)
        btnCkeck_permanentSameasPertularMember.titleLabel?.text = ""
        
    }
    @IBAction func btn_samePermanentAddAsHead_action(_ sender: UIButton) {
        
        //sender.isSelected = true
        if sender.isSelected {
            
            tf_padHouseNumber.text = ""
            tf_padTownVillage.text = ""
            tf_padPinCode.text = ""
            btn_PadSubDistrict.setTitle("", for: .normal)
            btn_padDistrict.setTitle("", for: .normal)
            btn_padState.setTitle("", for: .normal)
            btn_PadSubDistrict.setTitle("", for: .normal)
            
            
        } else {
            btnCkeck_permanentSameasPresentAdd.isSelected = false
            formModelClass!.permanentAddressHead( formClass: self)
            btnCkeck_permanentSameasPertularMember.setTitle("", for: .normal)
            btnCkeck_permanentSameasPertularMember.titleLabel?.text = ""
        }
        
        sender.isSelected = !sender.isSelected
       
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
            btnCkeck_permanentSameasPertularMember.setTitle("", for: .normal)
            
        } else {
            tf_padHouseNumber.text = tf_ptAd_houseNumber.text
            tf_padTownVillage.text = tf_ptAd_townVillage.text
            tf_padPinCode.text = tf_ptAd_pinCode.text
            btn_PadSubDistrict.setTitle(btn_ptAdd_subDistrict.titleLabel?.text, for: .normal)
            btn_padDistrict.setTitle(btn_ptAdd_District.titleLabel?.text, for: .normal)
            btn_padState.setTitle(btn_ptAdd_State.titleLabel?.text, for: .normal)
            btn_PaddCountry.setTitle(btn_ptAdd_Country.titleLabel?.text, for: .normal)
            btn_PadSubDistrict.setTitle(btn_ptAdd_subDistrict.titleLabel?.text, for: .normal)
            btnCkeck_permanentSameasHead.isSelected = false
            }
        
      sender.isSelected = !sender.isSelected
  //  sender.isSelected = true
    }
    
    @IBAction func btn_sameAsParticularMember_action(_ sender: UIButton) {
        
            
            let selectMemberView = Bundle.main.loadNibNamed("SelectMemberView", owner: self, options: nil)?.first as? SelectMemberView
            selectMemberView?.delegate = self
            let memberTin = strMemberNumber.memberTin(hhNumber: strHHNumber)
            let predicate = NSPredicate(format: "hh_tin = %@ AND new_tin != %@ ", modelHH.hh_tin ?? "",memberTin)
            DBManagerMemberDetail().searchMembers(predicate: predicate) { (arayMembers) in
                let arayUpdatedMember = arayMembers.filter({$0.memberStatus == MemberStatusCode.available || $0.memberStatus == MemberStatusCode.newMember})
                
                if arayUpdatedMember.count > 0 {
                selectMemberView?.loadMemberList(aray: arayUpdatedMember, view: self.view)
                }
            }
            
            
        
      //sender.isSelected = !sender.isSelected
  //  sender.isSelected = true
    }
    
    
    @IBAction func btn_pad_actions(_ sender: UIButton) {
        
    }
    
    @IBAction func btn_padYEsNo_action(_ sender: UIButton) {
        
        formModelClass?.btnStaySinceBirthTap(sender: sender)
        
        
    }
    @IBAction func btnSave_action(_ sender: UIButton) {
      
      formModelClass?.validate()
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        
        let alertView = AlertView()
        isDataSaved = false
        alertView.delegate = self
        alertView.showAlert( title: AppMessages.areYouSure, message: English.AddNewMemberFormAlert.tapBackButton)
    }
    
    @IBAction func btnSelectMotherName(_ sender: UIButton) {
        if entryT != .newHouseHold {
        fetchMemberForMotherFather(gender: .female)
        }
      }
    
    @IBAction func btnSelectFatherName_action(_ sender: UIButton) {
        if entryT != .newHouseHold {
        fetchMemberForMotherFather(gender: .male)
        }
    }
    
    @IBAction func btn_parent_stayInSameHH_action(_ sender: UIButton) {
        
        if sender.isSelected {

            stackViewSelectFather.isHidden = true
            stackViewSelectMotherDetail.isHidden = true
        }else{
            stackViewSelectFather.isHidden = false
            stackViewSelectMotherDetail.isHidden = false

        }
        btnSelectFatherName.isUserInteractionEnabled = true
        sender.isSelected = !sender.isSelected
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
    }
    
    @IBAction func btn_enterAge_action(_ sender: UIButton) {
        let dobFor = dobType.init(rawValue: sender.tag) ?? .personal
        let  enterAgeView = Bundle.main.loadNibNamed("EnterAgeAndCalculateDOBView", owner: self, options: nil)?.first as? EnterAgeAndCalculateDOBView
        
        enterAgeView?.showView(objFormClass: self, dobFor: dobFor)
        
        
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
        let predicate = NSPredicate(format: "hh_tin = %@ AND gender_id != %@ AND new_tin != %@ ", modelHH.hh_tin ?? "","\(antiGender.rawValue)",memberTin)
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
        if indexPath.row == 0 {
            return 0
        }
        
       return UITableView.automaticDimension
    }
////    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{

        if indexPath.row == 0 {
            return 0
        }

         return UITableView.automaticDimension

    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerView.backgroundColor = ProjectColor.colorPrimary
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         return 150//UITableView.automaticDimension
    }
    
}

//MARK:PickerViewCommonDelegate

extension AddNewHouseHoldForm_TVC:PickerViewCommonDelegate{
    
    func didPickComponent(component: String) {
        tapedButton.setTitle(component, for: .normal)
        tapedButton.setTitleColor(ProjectColor.colorPrimary, for: .normal)
        tapedButton.titleLabel?.textColor = ProjectColor.colorPrimary
        
        if tapedButton == btn_ed_motherTounge{
            let mtCode = component.getDropDownItem_id(aray: LanguageModal.langObj.mother_toungeArr)
            stackView_enterOtherMotherTongue.isHidden = mtCode != "999"
            constraintHeight_enterOtherMotherTongue.constant = mtCode == "999" ? 50 : 0
            updatecellSize()
        }
        else if tapedButton == btn_pd_Natinality {
            if util.isCountryIndia(countryName: component) {
                stackHeight_pd_passportEntry.constant = 60
                lbl_pd_messageNote.isHidden = false
            }else{
                stackHeight_pd_passportEntry.constant = 0
                tf_edu_enterOtherMotherTongue.text = ""
                lbl_pd_messageNote.isHidden = true
                btn_PD.isSelected = false
                
            }
            updateCell(clickedButton: btn_PD)
            return
        }
      
       else if ((tapedButton == btn_pd_birthPlaceCountry )||(tapedButton ==  btn_PaddCountry ) || (tapedButton == btn_ptAdd_Country) || (tapedButton == btn_parentDetail_BirthCountry) || (tapedButton == btn_ParentDetail_motherBirthCountry) || (tapedButton == btnLastResidenceCountry))  {
            var isEnableButton = false
            let btnState = findNextORPrevButton(sender: tapedButton, tagToFind: tapedButton.tag+1)
            let btnDistrict = findNextORPrevButton(sender: tapedButton, tagToFind: tapedButton.tag+2)
            
            if util.isCountryIndia(countryName: component) {
                isEnableButton = true
            }else{
                
                btnState.setTitle("", for: .normal)
                btnDistrict.setTitle("", for: .normal)
                btnState.titleLabel?.text = ""
                btnDistrict.titleLabel?.text = ""
                
                isEnableButton = false
                if tapedButton ==  btn_PaddCountry {
                    let btnSubDistrict = findNextORPrevButton(sender: tapedButton, tagToFind: tapedButton.tag+3)
                    btnSubDistrict.setTitle("", for: .normal)
                    btnSubDistrict.isEnabled = false
                }
            }
            
            btnState.isEnabled = isEnableButton
            btnDistrict.isEnabled = isEnableButton
            btnState.isUserInteractionEnabled = isEnableButton
            
            btnDistrict.isUserInteractionEnabled = isEnableButton
            
            btn_pd_Natinality.isUserInteractionEnabled = true
            
        }
        else if ((tapedButton == btn_pd_birthPlaceState )||(tapedButton ==  btn_ptAdd_State ) || (tapedButton == btn_ptAdd_State) || (tapedButton == btn_parentDeatil_BirthState) || (tapedButton == btn_ParentDetail_motherBirthState) || (tapedButton == btn_padState))  {
            let stateCode = DBManager_CountryStateDistrict().getStateCode(stateName: component)
            let nextButton = findNextORPrevButton(sender: tapedButton, tagToFind: tapedButton.tag+1)
            nextButton.isUserInteractionEnabled = true
            
            if stateCode == util.notKnownDistrictCode {
                nextButton.isUserInteractionEnabled = false
            }
            
            
            nextButton.setTitle("", for: .normal)
        }
        else if ((tapedButton == btn_pd_birthPlaceDistrict )||(tapedButton ==  btn_ptAdd_District ) || (tapedButton == btn_padDistrict) || (tapedButton == btn_ParentDetail_motherBirthDistrict) || (tapedButton == btn_ParentDetail_motherBirthDistrict))  {
            
            
            let nextButton = findNextORPrevButton(sender: tapedButton, tagToFind: tapedButton.tag+1)
            var isEnableTahsilButton = true
            
            
            nextButton.isUserInteractionEnabled = isEnableTahsilButton
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
            
            alertView.showAlert( title: AppMessages.areYouSure, message: English.AddNewMemberFormAlert.doYouWantAddMoreMember)
            //entryT = .addNewMemberExitHH
            
            break
        case .addNewMemberExitHH:
            
            
            //self.backAccordingCondition()
            alertView.alertWithoutButton( message:English.AddNewMemberFormAlert.newMemberAddedSuccesFully)
            break
          
        case .editDetail:
            
            //modelMemberDetail.memberStatus = MemberStatusCode.available
//            modelMemberDetail.member_completionStatus = MemberCompletionStatusCode.completed
//            do {
//                try context.save()
//            } catch  {
//
//            }
            
            
            //self.backAccordingCondition()
            alertView.alertWithoutButton( message:English.AddNewMemberFormAlert.memberUpdatedSuccess)
            break
        }
       
    }
  
}
extension AddNewHouseHoldForm_TVC:FormDataSavingManagementProtocoll{
    func hhDataUpdated() {
        checkAndOpenSignatureView()
    }
    func dataSavedInMemberTable() {
        checkAndOpenSignatureView()
    }
    
    func houseHolddataSaved () {
        //entryT = .addNewMemberExitHH
        let formsaveMV = FormDataSavingManagement.init(formClass: self)
        formsaveMV.delegate = self
        formsaveMV.saveMemberdataInNewHH()
        
    }
    
    }

