//
//  HouseHoldDetail_TVC.swift
//  NPR_census
//
//  Created by Dileep on 17/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class HouseHoldDetail_TVC: UITableViewCell {

    
    @IBOutlet weak var mainStack: UIStackView!
    @IBOutlet weak var stackViewContener: UIStackView!
    @IBOutlet weak var stackViewStatus: UIStackView!
    @IBOutlet weak var btnDied: UIButton!
    @IBOutlet weak var btnMoved: UIButton!
    
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
    @IBOutlet weak var lblPermanentAdd: UILabel!
    @IBOutlet weak var lblTehsil: UILabel!
    @IBOutlet weak var lblBlock: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblSpouseName: UILabel!
    @IBOutlet weak var lblPresentAdd: UILabel!
    @IBOutlet weak var lblNationality: UILabel!
    @IBOutlet weak var lblBirthPlaceDist: UILabel!
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
            setMemberStatus(status: memberDetailModel.memberStatus ?? "")
        }
        
        
       // lblMemberStatusValue.text =
        lblHouseNumber.text = memberDetailModel.censusHouse_number
        lblHouseholdNumber.text = memberDetailModel.censusHH_number
        lblSERefNumber.text = memberDetailModel.selfEnumerationRef_number
        lblMemberName.text = memberDetailModel.name
        
        lblMaritalStatus.text = memberDetailModel.marital_status?.getName_by_ID(aray: English().maritalStatusList())
        lblBirthPlaceCountry.text = DBManager_CountryStateDistrict().getCountryName(countryCode: memberDetailModel.birthCountryCode ?? "083")
        lblBirthPlaceState.text = DBManager_CountryStateDistrict().getStateName(stateCode: memberDetailModel.birthStateCode ?? "")//memberDetailModel.birthStateName
        
        lblDOB.text = memberDetailModel.dob
        lblGender.text = memberDetailModel.gender_id?.getName_by_ID(aray: English().genderList())
        if let arayRelation = memberDetailModel.gender_id?.getRealtionShipAray() {
        lblRelName.text =  memberDetailModel.rel_code?.getName_by_ID(aray: arayRelation)
        }
        //lblRelName.text = memberDetailModel.relName
        
        lblBirthPlace.text = memberDetailModel.birthAddress
        lblBlock.text = memberDetailModel.block_no
        lblCity.text = memberDetailModel.paddress_town
              
        lblSpouseName.text = memberDetailModel.spouseName
        
        lblPermanentAdd.text = "\(memberDetailModel.paddre_line1 ?? "")\(memberDetailModel.paddre_line2 ?? "")\(memberDetailModel.paddress_line3 ?? "")\(memberDetailModel.paddress_line4 ?? "")\(memberDetailModel.paddress_line5 ?? "")"
        
        lblPresentAdd.text = "\(memberDetailModel.address_line1 ?? ""),\(memberDetailModel.address_line2 ?? "") , \(memberDetailModel.address_line3 ?? "") , \(memberDetailModel.address_line4 ?? "") , \(memberDetailModel.address_line5 ?? "")"
        
        lblNationality.text = memberDetailModel.nationality_name
      //  lblBirthPlaceCountry.text = memberDetailModel.birthCountryName
        lblBirthPlace.text = memberDetailModel.birthAddress
        lblBirthPlaceDist.text = DBManager_CountryStateDistrict().getDistrictName(stateCode: memberDetailModel.address_stateCode ?? "", districtCode: memberDetailModel.address_district_code ?? "")//memberDetailModel.bithDistrictName
        lblTehsil.text = DBManager_CountryStateDistrict().getSubDistrictName(stateCode: memberDetailModel.address_stateCode ?? "", tahsilCode: memberDetailModel.address_subDistrictCode ?? "")//memberDetailModel.address_subDistrict
            //DBManager_CountryStateDistrict().getSubDistrictName(stateCode: memberDetailModel.address_stateCode ?? "", tahsilCode: memberDetailModel.address_subDistrictCode ?? "")//memberDetailModel.address_subDistrict
        lblPermanentAdd.text = "\(memberDetailModel.paddre_line1 ?? ""),\(memberDetailModel.paddre_line2 ?? "")"
        
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
       
    }
    
    func setMemberStatus(status:String)  {
       
        let memberStatus = MemberLivingStatusCode.init(rawValue: status)
        
        btnAvailable.isSelected = false
        btnDied.isSelected = false
        btnMoved.isSelected = false
        stackDeleteButton.isHidden = true
        stackViewEdit.isHidden = true
        
       // btnEdit.isEnabled = btnEdit.isSelected
        
        switch  memberStatus{
        case .available:
            btnAvailable.isSelected = true
            
            
            lblMemberStatusValue.text = "Available"
            stackViewEdit.isHidden = false
            break
        case .migratedOut:
            btnMoved.isSelected = true
           
            lblMemberStatusValue.text = "Moved Out"
            break
           
        case .dead :
            
            btnDied.isSelected = true
           
            lblMemberStatusValue.text = "Dead"
            break
            
        case .newMember:
            stackDeleteButton.isHidden = false
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
    }
    
        
        
        
    
    
    
    
}
