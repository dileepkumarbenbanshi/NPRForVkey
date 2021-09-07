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
        lblMemberName.text = memberDetailModel.name
        
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
       
              
        lblSpouseName.text = memberDetailModel.spouseName
        
       // lblPermanentAdd.text = "\(memberDetailModel.paddre_line1 ?? "")\(memberDetailModel.paddre_line2 ?? "")\(memberDetailModel.paddress_line3 ?? "")\(memberDetailModel.paddress_line4 ?? "")\(memberDetailModel.paddress_line5 ?? "")"
        
       // lblPresentAdd.text = "\(memberDetailModel.address_line1 ?? ""),\(memberDetailModel.address_line2 ?? "") , \(memberDetailModel.address_line3 ?? "") , \(memberDetailModel.address_line4 ?? "") , \(memberDetailModel.address_line5 ?? "")"
        
        lblNationality.text = DBManager_CountryStateDistrict().getCountryName(countryCode: memberDetailModel.nationality ?? "")
        lblBirthPlaceCountry.text = DBManager_CountryStateDistrict().getCountryName(countryCode: memberDetailModel.birthCountryCode ?? "")
        lblBirthPlace.text = memberDetailModel.birthAddress
        lblBirthPlaceDist.text = DBManager_CountryStateDistrict().getDistrictName(stateCode: memberDetailModel.birthStateCode ?? "", districtCode: memberDetailModel.birthDistrictCode ?? "")//memberDetailModel.bithDistrictName
        lblAddSubDist.text = DBManager_CountryStateDistrict().getSubDistrictName(stateCode: memberDetailModel.address_stateCode ?? "", districtCode:memberDetailModel.districtCode ?? "" , tahsilCode: memberDetailModel.address_subDistrictCode ?? "")
        
        //memberDetailModel.address_subDistrict
            //DBManager_CountryStateDistrict().getSubDistrictName(stateCode: memberDetailModel.address_stateCode ?? "", tahsilCode: memberDetailModel.address_subDistrictCode ?? "")//memberDetailModel.address_subDistrict
        //lblPermanentAdd.text = "\(memberDetailModel.paddre_line1 ?? ""),\(memberDetailModel.paddre_line2 ?? "")"
        
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
       
        lblQualification.text = memberDetailModel.edu_code?.getName_by_ID(aray: English().education_qualification())
        lblOccupation.text = memberDetailModel.occu_code?.getName_by_ID(aray: English().occupation())
        lblMotherTougue.text = memberDetailModel.motherTounge ?? ""//memberDetailModel.occu_code?.getName_by_ID(aray: English().m)
        
        setPresentAddress(memberDetailModel: memberDetailModel)
    }
    
    
    func setPresentAddress(memberDetailModel:NPR2021MemberDetails)  {
        lblAddHouseNo.text = memberDetailModel.address_line1 ?? ""
        lblAddVillageTown.text = singleton().selectEBListModel.ebTown_name ?? ""
        lblAddPin.text = memberDetailModel.pinCode ?? ""
        lblAddSubDist.text = DBManager_CountryStateDistrict().getSubDistrictName(stateCode: singleton().selectEBListModel.ebState_code ?? "", districtCode: singleton().selectEBListModel.ebDistrict_code ?? "", tahsilCode: singleton().selectEBListModel.ebTahsil_code ?? "")
        lblAddDist.text = DBManager_CountryStateDistrict().getDistrictName(stateCode: singleton().selectEBListModel.ebState_code ?? "", districtCode: singleton().selectEBListModel.ebDistrict_code ?? "")
        lblAddState.text = DBManager_CountryStateDistrict().getStateName(stateCode: singleton().selectEBListModel.ebState_code ?? "")
        
       setPermanentAddress(memberDetailModel: memberDetailModel)
    }
    
    func setPermanentAddress(memberDetailModel:NPR2021MemberDetails)  {
        
        lblPaddHouseNo.text = memberDetailModel.paddre_line1 ?? ""
        lblPaddVillageTown.text = memberDetailModel.paddress_town ?? ""
        lblPaddPin.text = memberDetailModel.ppinCode ?? ""
        lblPaddSubDist.text = DBManager_CountryStateDistrict().getSubDistrictName(stateCode: memberDetailModel.paddress_stateCode ?? "", districtCode: memberDetailModel.paddre_districtCode ?? "", tahsilCode: memberDetailModel.paddre_tahsilCode ?? "")//memberDetailModel.paddre_tahsilCode ?? ""  .ge
        lblPaddDist.text = DBManager_CountryStateDistrict().getDistrictName(stateCode: memberDetailModel.paddress_stateCode ?? "", districtCode: memberDetailModel.paddre_districtCode ?? "")
        lblPaddState.text = DBManager_CountryStateDistrict().getStateName(stateCode: memberDetailModel.paddress_stateCode ?? "")
        lblPaddCountry.text = DBManager_CountryStateDistrict().getCountryName(countryCode: memberDetailModel.paddress_countryCode ?? "")
        if  memberDetailModel.duration_inYear?.count == 0 || memberDetailModel.duration_inYear == "0"{
            lblStayAtpresentAddYear.text = ""
            lblLastResidencyState.text = ""
            lblLastResidencyDistrict.text = ""
        }else{
            lblStayAtpresentAddYear.text = memberDetailModel.duration_inYear
            
            lblLastResidencyState.text = DBManager_CountryStateDistrict().getStateName(stateCode: memberDetailModel.lastResidencyState ?? "")
            lblLastResidencyDistrict.text = DBManager_CountryStateDistrict().getDistrictName(stateCode: memberDetailModel.lastResidencyState ?? "", districtCode: memberDetailModel.lastResidencyDistrict ?? "")
        }
        
        lblLastResidencyCountry.text =  DBManager_CountryStateDistrict().getCountryName(countryCode: memberDetailModel.lastResidencyCountry ?? "")
        setFatherDetail(memberDetailModel: memberDetailModel)
    }
    func setFatherDetail(memberDetailModel:NPR2021MemberDetails)  {
        
        lblFatherName.text = memberDetailModel.father_name ?? ""
        
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
        
        lblMotherName.text = memberDetailModel.motherName ?? ""
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
            lblMemberStatusValue.text = "New Member"
            stackDeleteButton.isHidden = false
            //stackViewEdit.isHidden = true
            break
        case .available:
            //btnAvailable.isSelected = false
            lblMemberStatusValue.text = "Available"
            
           // stackViewEdit.isHidden = true
            break
        case .migratedOut:
            //btnMoved.isSelected = false
           
            lblMemberStatusValue.text = "Moved Out"
            break
           
        case .dead :
            
           // btnDied.isSelected = true
           
            lblMemberStatusValue.text = "Died"
            break
            
        case .notAvailable :
            
          lblMemberStatusValue.text = "Not Available"
            break
            
        case .lockedMember :
            
          lblMemberStatusValue.text = "Locked"
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
    
}
