//
//  HouseHoldDetail_TVC.swift
//  NPR_census
//
//  Created by Dileep on 17/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

 protocol shiftButtonDelegate {
    func shiftButtonTaped(sender:UIButton)
    
     
}

class HouseHoldDetail_TVC: UITableViewCell {

    
    @IBOutlet weak var stackViewDied: UIStackView!
    @IBOutlet weak var stackViewMoved: UIStackView!
    @IBOutlet weak var stackViewAvailble: UIStackView!
    @IBOutlet weak var mainStack: UIStackView!
    @IBOutlet weak var stackViewContener: UIStackView!
    @IBOutlet weak var stackViewStatus: UIStackView!
    @IBOutlet weak var btnDied: UIButton!
    @IBOutlet weak var btnMoved: UIButton!
    @IBOutlet weak var stackViewShift: UIStackView!
    @IBOutlet weak var stackViewMemberStatus: StackView!
    
    @IBOutlet weak var btnShift: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var stackDeleteButton: UIStackView!
    @IBOutlet weak var lblMemberStatus: UILabel!
    @IBOutlet weak var lblMemberStatusValue: UILabel!
    @IBOutlet weak var lblHouseNumber: UILabel!
    @IBOutlet weak var lblHouseholdNumber: UILabel!
    @IBOutlet weak var lblSERefNumber: UILabel!
    @IBOutlet weak var btnAvailable: UIButton!
    @IBOutlet weak var lblMemberName: UILabel!
    
    @IBOutlet weak var lblLastName: UILabel!
    @IBOutlet weak var lblMidleName: UILabel!
    @IBOutlet weak var lblMaritalStatus: UILabel!
    @IBOutlet weak var lblBirthPlaceCountry: UILabel!
    @IBOutlet weak var lblBirthPlaceState: UILabel!
    @IBOutlet weak var lblDOB: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblRelName: UILabel!
    @IBOutlet weak var lblBirthPlace: UILabel!
    
    @IBOutlet weak var stackViewEdit: UIStackView!
//    @IBOutlet weak var lblPermanentAdd: UILabel!
//    @IBOutlet weak var lblTehsil: UILabel!
//    @IBOutlet weak var lblBlock: UILabel!
//    @IBOutlet weak var lblCity: UILabel!
    
    @IBOutlet weak var lblPresentAdd: UILabel!
    @IBOutlet weak var lblNationality: UILabel!
    @IBOutlet weak var lblPassportNumber: UILabel!
    @IBOutlet weak var lblBirthPlaceDist: UILabel!
    
   //MARK:Education Qualification Outlet
    
    @IBOutlet weak var lblQualification: UILabel!
    @IBOutlet weak var lblOccupation: UILabel!
    @IBOutlet weak var lblMotherTougue: UILabel!
    
    //MARK:Present Address Outlet
    
    @IBOutlet weak var lblAddHouseNo: UILabel!
    @IBOutlet weak var lblAddVillageTown: UILabel!
    @IBOutlet weak var lblAddPin: UILabel!
    @IBOutlet weak var lblAddSubDist: UILabel!
    @IBOutlet weak var lblAddDist: UILabel!
    @IBOutlet weak var lblAddState: UILabel!
    
    
    //MARK:Permanent Address Outlet
    
    @IBOutlet weak var lblPaddHouseNo: UILabel!
    @IBOutlet weak var lblPaddVillageTown: UILabel!
    @IBOutlet weak var lblPaddPin: UILabel!
    @IBOutlet weak var lblPaddSubDist: UILabel!
    @IBOutlet weak var lblPaddDist: UILabel!
    @IBOutlet weak var lblPaddState: UILabel!
    @IBOutlet weak var lblPaddCountry: UILabel!
    @IBOutlet weak var lblStayAtpresentAdd: UILabel!
    @IBOutlet weak var lblStayAtpresentAddYear: UILabel!
    @IBOutlet weak var lblLastResidencyCountry: UILabel!
    @IBOutlet weak var lblLastResidencyState: UILabel!
    @IBOutlet weak var lblLastResidencyDistrict: UILabel!
    
    //MARK:Father Detail Outlet
    @IBOutlet weak var lblFatherName: UILabel!
    @IBOutlet weak var lblFatherDob: UILabel!
    @IBOutlet weak var lblFatherBirthCountry: UILabel!
    @IBOutlet weak var lblFatherBirthState: UILabel!
    @IBOutlet weak var lblFatherBirthDistrict: UILabel!
   
    //MARK:Mother Detail Outlet
    @IBOutlet weak var lblMotherName: UILabel!
    @IBOutlet weak var lblMotherDob: UILabel!
    @IBOutlet weak var lblMotherBirthCountry: UILabel!
    @IBOutlet weak var lblMotherBirthState: UILabel!
    @IBOutlet weak var lblMotherBirthDistrict: UILabel!
    @IBOutlet weak var lblSpouseName: UILabel!
    //MARK:ID Outlet
    @IBOutlet weak var lblAadhar: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var lblVoterID: UILabel!
    @IBOutlet weak var lblDLNumber: UILabel!
    
    
//Titles OutLet
    
    @IBOutlet weak var lblMemberStatus_title: UILabel!
    
    @IBOutlet weak var lblPassportNo_title: UILabel!
    @IBOutlet weak var btnAvailable_title: UIButton!
    @IBOutlet weak var btnMovedOut_title: UIButton!
    @IBOutlet weak var btnDied_title: UIButton!
    @IBOutlet weak var btnShift_title: UIButton!
    @IBOutlet weak var lblDobPlace_title: UILabel!
    
    @IBOutlet weak var lblNationality_title: UILabel!
    @IBOutlet weak var lblDobDistrict_title: UILabel!
    @IBOutlet weak var lblDobState_title: UILabel!
    @IBOutlet weak var lblDobCountry_title: UILabel!
    @IBOutlet weak var lblMaritalStatus_title: UILabel!
    @IBOutlet weak var lblDob_title: UILabel!
    @IBOutlet weak var lblSex_title: UILabel!
    @IBOutlet weak var lblRelationship_title: UILabel!
    @IBOutlet weak var lblName_title: UILabel!
    @IBOutlet weak var lblLastName_title: UILabel!
    @IBOutlet weak var lblMidleName_title: UILabel!
    
    @IBOutlet weak var seRefrenceNO_title: UILabel!
    @IBOutlet weak var censusHHN_title: UILabel!
    @IBOutlet weak var lblCensusHN_title: UILabel!
    
    
    // Education Qualification
    @IBOutlet weak var lblEdu_title: UILabel!
    
    @IBOutlet weak var lblMotherTongue_title: UILabel!
    @IBOutlet weak var lblOccupation_title: UILabel!
    
    
    // Present Address
    @IBOutlet weak var lblPtAddState_title: UILabel!
    @IBOutlet weak var lblPtAddCountry_title: UILabel!
    @IBOutlet weak var lblPtAddDistrict_title: UILabel!
    @IBOutlet weak var lblPtAddSubDistrict_title: UILabel!
    @IBOutlet weak var lblPtAddPinCode_title: UILabel!
    @IBOutlet weak var lblPtAddTownVillage_title: UILabel!
    @IBOutlet weak var lblPtHouseAndLocality_title: UILabel!
    
    
    // Permanent Address
    @IBOutlet weak var lblStayingAtPresentAdd_title: UILabel!
    @IBOutlet weak var lblStayingAtPresentAddYear_title: UILabel!
    @IBOutlet weak var lblLastResidencyCountry_title: UILabel!
    @IBOutlet weak var lblLastResidencyState_title: UILabel!
    @IBOutlet weak var lblLastResidencyDistrict_title: UILabel!
    
    @IBOutlet weak var lblPdAddState_title: UILabel!
    @IBOutlet weak var lblPdAddCountry_title: UILabel!
    @IBOutlet weak var lblPdAddDistrict_title: UILabel!
    @IBOutlet weak var lblPdAddSubDistrict_title: UILabel!
    @IBOutlet weak var lblPdAddPinCode_title: UILabel!
    @IBOutlet weak var lblPdAddTownVillage_title: UILabel!
    @IBOutlet weak var lblPdAddHouseAndLocality_title: UILabel!

    // Father Detail
    @IBOutlet weak var lblFatherName_title: UILabel!
    @IBOutlet weak var lblFatherDob_title: UILabel!
    @IBOutlet weak var lblFatherDobCountry_title: UILabel!
    @IBOutlet weak var lblFatherDobState_title: UILabel!
    @IBOutlet weak var lblFatherDobDistrict_title: UILabel!
    
    // Mother Detail
    @IBOutlet weak var lblMotherName_title: UILabel!
    @IBOutlet weak var lblMotherDob_title: UILabel!
    @IBOutlet weak var lblMotherDobCountry_title: UILabel!
    @IBOutlet weak var lblMotherDobState_title: UILabel!
    @IBOutlet weak var lblMotherDobDistrict_title: UILabel!
    @IBOutlet weak var lblSpouseName_title: UILabel!
    
    // ID Detail
    @IBOutlet weak var lblAadhar_title: UILabel!
    @IBOutlet weak var lblMobile_title: UILabel!
    @IBOutlet weak var lblVoter_title: UILabel!
    @IBOutlet weak var lblDL_title: UILabel!
    
    
    var delegate:shiftButtonDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func cellPutValues(memberDetailModel:NPR2021MemberDetails,headGender:String) {
       // btnEdit.isHidden = true
        if util.isEnumerator() {
            setTagLabel()
        }
       
       setPersonalDetail(memberDetailModel: memberDetailModel, headGender: headGender)
       
    }
    
    //MARK:Member Detail
    
    func setPersonalDetail(memberDetailModel:NPR2021MemberDetails,headGender:String)  {
        if util.isEnumerator() {
            setMemberStatus(memberModel: memberDetailModel)
        }
        
        
       // lblMemberStatusValue.text =
        lblHouseNumber.text = memberDetailModel.censusHouse_number
        lblHouseholdNumber.text = memberDetailModel.censusHH_number
        lblSERefNumber.text = memberDetailModel.selfEnumerationRef_number
        var name = ""
        
        if memberDetailModel.language?.IsSelectedLangauge_nonEnglish ?? false {
            name = (((memberDetailModel.first_name_sl?.count != 0) && ( memberDetailModel.first_name_sl != nil)) ? memberDetailModel.first_name_sl ?? "" : memberDetailModel.first_name) ?? ""
        }else{
            name = (((memberDetailModel.first_name?.count != 0) && ( memberDetailModel.first_name != nil)) ? memberDetailModel.first_name ?? "" : memberDetailModel.first_name_sl) ?? ""
        }
        
        lblMemberName.text = name
       
        if util.isEnumerator() {
            
        
        var mName = ""
        
        if memberDetailModel.language?.IsSelectedLangauge_nonEnglish ?? false {
            mName = (((memberDetailModel.midle_name_sl?.count != 0) && ( memberDetailModel.midle_name_sl != nil)) ? memberDetailModel.midle_name_sl ?? "" : memberDetailModel.midle_name) ?? ""
        }else{
            mName = (((memberDetailModel.midle_name?.count != 0) && ( memberDetailModel.midle_name != nil)) ? memberDetailModel.midle_name ?? "" : memberDetailModel.midle_name_sl) ?? ""
        }
        lblMidleName.text = mName
        
        var lName = ""
        
        if memberDetailModel.language?.IsSelectedLangauge_nonEnglish ?? false {
            lName = (((memberDetailModel.last_name_sl?.count != 0) && ( memberDetailModel.last_name_sl != nil)) ? memberDetailModel.last_name_sl ?? "" : memberDetailModel.last_name) ?? ""
        }else{
            lName = (((memberDetailModel.last_name?.count != 0) && ( memberDetailModel.last_name != nil)) ? memberDetailModel.last_name ?? "" : memberDetailModel.last_name_sl) ?? ""
        }
        lblLastName.text = lName
        }
        lblMaritalStatus.text = memberDetailModel.marital_status?.getName_by_ID(aray: English().maritalStatusList())
        lblBirthPlaceCountry.text = DBManager_CountryStateDistrict().getCountryName(countryCode: memberDetailModel.birthCountryCode ?? "083")
        lblBirthPlaceState.text = DBManager_CountryStateDistrict().getStateName(stateCode: memberDetailModel.birthStateCode ?? "")//memberDetailModel.birthStateName
        
       let dob = FormDateMangement().updateDobByStatus(strStatus: memberDetailModel.dob_type ?? "", strDate: memberDetailModel.dob ?? "")
       
        lblDOB.text = dob
        lblGender.text = memberDetailModel.gender_id?.getName_by_ID(aray: English().genderList())
        if let arayRelation = memberDetailModel.gender_id?.getRealtionShipAray() {
        lblRelName.text =  memberDetailModel.rel_code?.getName_by_ID(aray: arayRelation)
        }
        //lblRelName.text = memberDetailModel.relName
        
        lblBirthPlace.text = memberDetailModel.birthAddress
       // lblBlock.text = memberDetailModel.block_no
       
              
        
        var spouseName = ""
        
        if memberDetailModel.language?.IsSelectedLangauge_nonEnglish ?? false {
            spouseName = ((memberDetailModel.nameSL?.count != 0) ? memberDetailModel.spouseName_sl ?? "" : memberDetailModel.spouseName) ?? ""
        }else{
            spouseName = ((memberDetailModel.spouseName?.count != 0) ? memberDetailModel.name ?? "" : memberDetailModel.spouseName_sl) ?? ""
        }
        
        lblSpouseName.text = spouseName
        
        
       
        
        lblNationality.text = DBManager_CountryStateDistrict().getCountryName(countryCode: memberDetailModel.nationality ?? "")
        lblBirthPlaceCountry.text = DBManager_CountryStateDistrict().getCountryName(countryCode: memberDetailModel.birthCountryCode ?? "")
        lblBirthPlace.text = memberDetailModel.birthAddress
        lblBirthPlaceDist.text = DBManager_CountryStateDistrict().getDistrictName(stateCode: memberDetailModel.birthStateCode ?? "", districtCode: memberDetailModel.birthDistrictCode ?? "")//memberDetailModel.bithDistrictName
        lblAddSubDist.text = DBManager_CountryStateDistrict().getSubDistrictName(stateCode: memberDetailModel.address_stateCode ?? "", districtCode:memberDetailModel.districtCode ?? "" , tahsilCode: memberDetailModel.address_subDistrictCode ?? "")
        
        
        
         let stackViews = stackViewContener.subviews
        
        for  stackView in stackViews {
            let tagStack = stackView.tag
            
            if (tagStack % 2 == 0) {
                stackView.backgroundColor = UIColor.white
            }
            else{
                stackView.backgroundColor = UIColor.init(named: "colorLightPink")
            }
            
        }
        if util.isEnumerator() {
            lblPassportNumber.text = memberDetailModel.passpord_id ?? ""
        }
       
        setQualificationEducation(memberDetailModel: memberDetailModel)
    }
    
    func setQualificationEducation(memberDetailModel:NPR2021MemberDetails)  {
       
        lblQualification.text = memberDetailModel.edu_code?.getName_by_ID(aray: LanguageModal.langObj.education_qualification)
        lblOccupation.text = memberDetailModel.occu_code?.getName_by_ID(aray: LanguageModal.langObj.occupationArr)
        
        if memberDetailModel.motherToungeode == "999" {
            lblMotherTougue.text = memberDetailModel.otherMotherTounge ?? ""
        }else{
        lblMotherTougue.text =  memberDetailModel.motherToungeode?.getName_by_ID(aray: LanguageModal.langObj.mother_toungeArr)
        }
        
        setPresentAddress(memberDetailModel: memberDetailModel)
    }
    
    
    func setPresentAddress(memberDetailModel:NPR2021MemberDetails)  {
        
        lblAddHouseNo.text = memberDetailModel.address_line1 ?? ""
        
        lblAddVillageTown.text = singleton().selectEBListModel.ebTown_name ?? ""
//        if let pinCode = modelHH.addressPinCode  {
//            tf_ptAd_pinCode.text = pinCode
//            tf_ptAd_houseNumber.text = modelHH.addressHNLocality ?? ""
//        }
        
        lblAddPin.text = memberDetailModel.pinCode ?? ""
        lblAddSubDist.text = DBManager_CountryStateDistrict().getSubDistrictName(stateCode: singleton().selectEBListModel.ebState_code ?? "", districtCode: singleton().selectEBListModel.ebDistrict_code ?? "", tahsilCode: singleton().selectEBListModel.ebTahsil_code ?? "")
        lblAddDist.text = DBManager_CountryStateDistrict().getDistrictName(stateCode: singleton().selectEBListModel.ebState_code ?? "", districtCode: singleton().selectEBListModel.ebDistrict_code ?? "")
        lblAddState.text = DBManager_CountryStateDistrict().getStateName(stateCode: singleton().selectEBListModel.ebState_code ?? "")
        
       setPermanentAddress(memberDetailModel: memberDetailModel)
    }
    
    func setPermanentAddress(memberDetailModel:NPR2021MemberDetails)  {
        
        lblPaddHouseNo.text =  memberDetailModel.paddre_line1?.count ?? 0 > 0 ? memberDetailModel.paddre_line1 : memberDetailModel.paddre_line1_sl
       
        
            lblPaddVillageTown.text =  memberDetailModel.paddress_town?.count ?? 0 > 0 ? memberDetailModel.paddress_town : memberDetailModel.paddress_town_sl
     
        lblPaddPin.text = memberDetailModel.ppinCode ?? ""
        lblPaddSubDist.text = DBManager_CountryStateDistrict().getSubDistrictName(stateCode: memberDetailModel.paddress_stateCode ?? "", districtCode: memberDetailModel.paddre_districtCode ?? "", tahsilCode: memberDetailModel.paddre_tahsilCode ?? "")//memberDetailModel.paddre_tahsilCode ?? ""  .ge
        lblPaddDist.text = DBManager_CountryStateDistrict().getDistrictName(stateCode: memberDetailModel.paddress_stateCode ?? "", districtCode: memberDetailModel.paddre_districtCode ?? "")
        lblPaddState.text = DBManager_CountryStateDistrict().getStateName(stateCode: memberDetailModel.paddress_stateCode ?? "")
        lblPaddCountry.text = DBManager_CountryStateDistrict().getCountryName(countryCode: memberDetailModel.paddress_countryCode ?? "")
        
        
        if  memberDetailModel.duration_inYear?.count == 0 || memberDetailModel.duration_inYear == "0"{
            lblStayAtpresentAddYear.text = ""
            lblLastResidencyState.text = ""
            lblLastResidencyDistrict.text = ""
            lblStayAtpresentAdd.text = LanguageModal.langObj.yes
        }else{
            lblStayAtpresentAdd.text = LanguageModal.langObj.no
            lblStayAtpresentAddYear.text = memberDetailModel.duration_inYear
            
            lblLastResidencyState.text = DBManager_CountryStateDistrict().getStateName(stateCode: memberDetailModel.lastResidencyState ?? "")
            lblLastResidencyDistrict.text = DBManager_CountryStateDistrict().getDistrictName(stateCode: memberDetailModel.lastResidencyState ?? "", districtCode: memberDetailModel.lastResidencyDistrict ?? "")
        }
        
        lblLastResidencyCountry.text =  DBManager_CountryStateDistrict().getCountryName(countryCode: memberDetailModel.lastResidencyCountry ?? "")
        setFatherDetail(memberDetailModel: memberDetailModel)
    }
    func setFatherDetail(memberDetailModel:NPR2021MemberDetails)  {
        
        lblFatherName.text = memberDetailModel.father_name?.count ?? 0 > 0 ? memberDetailModel.father_name : memberDetailModel.father_name_sl
        var name = ""
        
        if memberDetailModel.language?.IsSelectedLangauge_nonEnglish ?? false {
            name = ((memberDetailModel.father_name_sl?.count != 0) ? memberDetailModel.father_name_sl ?? "" : memberDetailModel.father_name) ?? ""
        }else{
            name = ((memberDetailModel.father_name?.count != 0) ? memberDetailModel.father_name ?? "" : memberDetailModel.father_name_sl) ?? ""
        }
        
        lblFatherName.text  = name
        var fatherDob = FormDateMangement().updateDobByStatus(strStatus: memberDetailModel.father_dobType ?? "", strDate: memberDetailModel.father_dob ?? "")
        if fatherDob.count == 0 {
            fatherDob = memberDetailModel.father_dob ?? ""
        }
        lblFatherDob.text = fatherDob
        lblFatherBirthDistrict.text = DBManager_CountryStateDistrict().getDistrictName(stateCode: memberDetailModel.fatherBirthStateCode ?? "", districtCode: memberDetailModel.fatherBirthDistrictCode ?? "")
        lblFatherBirthState.text = DBManager_CountryStateDistrict().getStateName(stateCode: memberDetailModel.fatherBirthStateCode ?? "")
        lblFatherBirthCountry.text = DBManager_CountryStateDistrict().getCountryName(countryCode: memberDetailModel.fatherBirthCountryCode ?? "")
        setMotherDetail(memberDetailModel: memberDetailModel)
    }
    func setMotherDetail(memberDetailModel:NPR2021MemberDetails)  {
        
       
        var name = ""
        
        if memberDetailModel.language?.IsSelectedLangauge_nonEnglish ?? false {
            name = ((memberDetailModel.motherName_sl?.count != 0) ? memberDetailModel.motherName_sl ?? "" : memberDetailModel.motherName) ?? ""
        }else{
            name = ((memberDetailModel.motherName?.count != 0) ? memberDetailModel.motherName ?? "" : memberDetailModel.motherName_sl) ?? ""
        }
        
        lblMotherName.text = name
        var motherDob = FormDateMangement().updateDobByStatus(strStatus: memberDetailModel.mother_dobType ?? "", strDate: memberDetailModel.mother_dob ?? "")
        if motherDob.count == 0 {
            motherDob = memberDetailModel.mother_dob ?? ""
        }
        lblMotherDob.text = motherDob
        lblMotherBirthDistrict.text = DBManager_CountryStateDistrict().getDistrictName(stateCode: memberDetailModel.mother_birthStateCode ?? "", districtCode: memberDetailModel.mother_birthDistrictCode ?? "")
        lblMotherBirthState.text = DBManager_CountryStateDistrict().getStateName(stateCode: memberDetailModel.mother_birthStateCode ?? "")
        lblMotherBirthCountry.text = DBManager_CountryStateDistrict().getCountryName(countryCode: memberDetailModel.mother_birthCountryCode  ?? "")
        setIDDetail(memberDetailModel: memberDetailModel)
    }
    
    func setIDDetail(memberDetailModel:NPR2021MemberDetails)  {
        let maskedAdhar = memberDetailModel.aadhar?.maskAadhar()
        let maskedMobile = memberDetailModel.mobile?.maskMobile()
//let maskedVoter =
        
        lblAadhar.text = maskedAdhar
        lblMobile.text = maskedMobile 
        lblVoterID.text = memberDetailModel.voter_id ?? ""
        lblDLNumber.text = memberDetailModel.driving_lincence ?? ""
    }
    
    
    func setMemberStatus(memberModel:NPR2021MemberDetails)  {
       
        let memberStatus = MemberLivingStatusCode.init(rawValue: memberModel.memberStatus ?? "")
        
        btnAvailable.isSelected = false
        btnDied.isSelected = false
        btnMoved.isSelected = false
        stackDeleteButton.isHidden = true
        stackViewEdit.isHidden = true
        
       // btnEdit.isEnabled = btnEdit.isSelected
       
        switch  memberStatus{
        case .newMember:
           // btnAvailable.isSelected = false
            lblMemberStatusValue.text = LanguageModal.langObj.new_member
            stackDeleteButton.isHidden = false
            //stackViewEdit.isHidden = true
            break
        case .available:
            //btnAvailable.isSelected = false
            lblMemberStatusValue.text = LanguageModal.langObj.available//"Available"
            
           // stackViewEdit.isHidden = true
            break
        case .migratedOut:
            //btnMoved.isSelected = false
           
            lblMemberStatusValue.text = "Moved Out"
            lblMemberStatusValue.text = LanguageModal.langObj.migrated_out
            break
           
        case .dead :
            
           // btnDied.isSelected = true
           
            lblMemberStatusValue.text = "Died"
            lblMemberStatusValue.text = LanguageModal.langObj.dead
            break
            
        case .notAvailable :
            
          lblMemberStatusValue.text = "Not Available"
            lblMemberStatusValue.text = LanguageModal.langObj.not_available
            break
            
        case .lockedMember :
            
          lblMemberStatusValue.text = "Locked"
            
            lblMemberStatusValue.text = LanguageModal.langObj.locked
            break
        default:
            
            btnAvailable.isSelected = false
            btnDied.isSelected = false
            btnMoved.isSelected = false
            lblMemberStatusValue.text = ""
            stackViewEdit.isHidden = true
            
            break
        }
         //btnEdit.isEnabled = btnEdit.isSelected
        statusChangableORNot(memberModel: memberModel)
        setDeleteButton(memberModel: memberModel)
    }
    
    //Status Option will show for locked member , not started , moved out , died and  Available
    func statusChangableORNot(memberModel:NPR2021MemberDetails)  {
      
        var ishideAvailable = false
        var ishideMovedstack = false
        var ishideDiedStack = false
        
        
        let memberStatus = MemberLivingStatusCode.init(rawValue: memberModel.memberStatus ?? "")
        let memberCompletionStatus = MemberCompletionStatus.init(rawValue: memberModel.member_completionStatus ?? "")
        if memberCompletionStatus == .uploaded {
            
            if memberStatus == .lockedMember {
               
                ishideAvailable = false
                ishideMovedstack = false
                ishideDiedStack = false
            }else{
               
                ishideAvailable = true
                ishideMovedstack = true
                ishideDiedStack = true
            }
        }else if memberStatus == .newMember {
            
            ishideAvailable = false
            ishideMovedstack = true
            ishideDiedStack = true
        }else{
            
            ishideAvailable = false
            ishideMovedstack = false
            ishideDiedStack = false
        }
       statusHideShow(isHideAva: ishideAvailable, isHideMv: ishideMovedstack, isHideDeid: ishideDiedStack)
    }
    
    func statusHideShow(isHideAva:Bool,isHideMv:Bool,isHideDeid:Bool)  {
        
        stackViewDied.isHidden = isHideDeid
        stackViewMoved.isHidden = isHideMv
        stackViewAvailble.isHidden = isHideAva
           
        
    }
    
    func setDeleteButton(memberModel:NPR2021MemberDetails)  {
        
        if memberModel.memberStatus == MemberStatusCode.newMember {
            
            stackDeleteButton.isHidden = false
            
            if memberModel.member_completionStatus ?? "" == MemberCompletionStatusCode.uploaded {
                stackDeleteButton.isHidden = true
            }
        }else{
            stackDeleteButton.isHidden = true
        }
    }
    
    @IBAction func btnShiftAction(_ sender: UIButton) {
        delegate?.shiftButtonTaped(sender: sender)
        
    }
    
    
    func setTagLabel()  {
        
        lblMemberStatus_title.text = LanguageModal.langObj.member_status
        lblMemberStatus.text = LanguageModal.langObj.status
        btnAvailable_title.setTitle(LanguageModal.langObj.available, for: .normal)
        btnMovedOut_title.setTitle(LanguageModal.langObj.migrated_out, for: .normal)
        btnDied_title.setTitle(LanguageModal.langObj.member_died, for: .normal)
        btnShift_title.setTitle(LanguageModal.langObj.shift, for: .normal)
        
        lblCensusHN_title.text = LanguageModal.langObj.census_house_no
        censusHHN_title.text = LanguageModal.langObj.census_household_no
        seRefrenceNO_title.text = LanguageModal.langObj.self_enu_ref_no
        lblName_title.text = LanguageModal.langObj.first_name
        lblMidleName_title.text = LanguageModal.langObj.middle_name
        lblLastName_title.text = LanguageModal.langObj.last_name
        lblRelationship_title.text = LanguageModal.langObj.relationship
        lblSex_title.text = LanguageModal.langObj.sex
        lblDOB.text = LanguageModal.langObj.dob
        lblMaritalStatus_title.text = LanguageModal.langObj.marital_status
        lblDobCountry_title.text = LanguageModal.langObj.birth_address1
        lblDobState_title.text = LanguageModal.langObj.birth_address2
        lblDobDistrict_title.text = LanguageModal.langObj.birth_address3
        lblNationality_title.text = LanguageModal.langObj.nationality
        lblPassportNo_title.text = LanguageModal.langObj.passport
        
        // Education/Occupation
        
        lblEdu_title.text = LanguageModal.langObj.education
        lblOccupation_title.text = LanguageModal.langObj.occupation
        lblMotherTongue_title.text = LanguageModal.langObj.mother_tounge
        
        // Present Address
        
        lblPtHouseAndLocality_title.text = LanguageModal.langObj.current_house
        lblPtAddTownVillage_title.text = LanguageModal.langObj.current_village
        lblPtAddPinCode_title.text = LanguageModal.langObj.current_pincode
        lblPtAddSubDistrict_title.text = LanguageModal.langObj.current_sub_district
        lblPtAddDistrict_title.text = LanguageModal.langObj.current_district
        lblPtAddState_title.text = LanguageModal.langObj.current_state
        
        
        // Permanent Address
        
        lblPdAddHouseAndLocality_title.text = LanguageModal.langObj.permanent_address6
        lblPdAddTownVillage_title.text = LanguageModal.langObj.permanent_address5
        lblPdAddSubDistrict_title.text = LanguageModal.langObj.permanent_address4
        lblPdAddDistrict_title.text = LanguageModal.langObj.permanent_address3
        lblPdAddState_title.text = LanguageModal.langObj.permanent_address2
        lblPdAddCountry_title.text = LanguageModal.langObj.permanent_address
        lblPdAddPinCode_title.text = LanguageModal.langObj.permanent_address7
        lblStayingAtPresentAdd_title.text = LanguageModal.langObj.wheater_staying_at_present_addres_since_birth
        lblStayingAtPresentAddYear_title.text = LanguageModal.langObj.years_of_staying
        lblLastResidencyCountry_title.text = LanguageModal.langObj.place_of_last_residence
        lblLastResidencyState_title.text = LanguageModal.langObj.place_of_last_residence2
        lblLastResidencyDistrict_title.text = LanguageModal.langObj.place_of_last_residence3
        
        // Father Detail
        
        lblFatherName_title.text = LanguageModal.langObj.f_name
        lblFatherDob_title.text = LanguageModal.langObj.f_dob
        lblFatherDobCountry_title.text = LanguageModal.langObj.f_birth_address
        lblFatherDobState_title.text = LanguageModal.langObj.f_birth_address2
        lblFatherDobDistrict_title.text = LanguageModal.langObj.f_birth_address3
        
        // Mother Detail
        
        lblMotherName_title.text = LanguageModal.langObj.m_name
        lblMotherDob_title.text = LanguageModal.langObj.m_dob
        lblMotherDobCountry_title.text = LanguageModal.langObj.m_birth_address
        lblMotherDobState_title.text = LanguageModal.langObj.m_birth_address2
        lblMotherDobDistrict_title.text = LanguageModal.langObj.m_birth_address3
        lblSpouseName_title.text = LanguageModal.langObj.s_name
        
        // ID Detail
        lblAadhar_title.text = LanguageModal.langObj.aadhaar
        lblMobile_title.text = LanguageModal.langObj.mobile
        lblVoter_title.text = LanguageModal.langObj.voter_id
        lblDL_title.text = LanguageModal.langObj.driving_licence
        
        
    }
    
}
