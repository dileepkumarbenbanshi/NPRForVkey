//
//  HoldHoldMemberList_TVC.swift
//  NPR_census
//
//  Created by Dileep on 17/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class HoldHoldMemberList_TVC: UITableViewCell {

    @IBOutlet weak var btnStatus: UIButton!
    @IBOutlet weak var btnDropDown: UIButton!
    @IBOutlet weak var lblMemberName: UILabel!
    @IBOutlet weak var lblSerialNumber: UILabel!
    
    var hhModel = NPR_2021hh_Details()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func cellValueSetUP(memberDetailModel:NPR2021MemberDetails , index :Int)  {
        if Int(memberDetailModel.sloMember ?? "") != index+1 {
            memberDetailModel.sloMember = "\(index+1)".memberSrNumber()
        }
        memberDetailModel.censusHH_number = hhModel.census_hhNo
        memberDetailModel.censusHouse_number = hhModel.census_hNo
        do {
            try context.save()
        } catch  {
            
        }
        lblSerialNumber.text = memberDetailModel.sloMember
        lblMemberName.text = memberDetailModel.name
        setTextColor(modelMember: memberDetailModel)
    }
  
    
    func setTextColor(modelMember:NPR2021MemberDetails)  {
        
        var textcolor = UIColor.systemPink
        
        let memberCompletionStatus = MemberCompletionStatus.init(rawValue: modelMember.member_completionStatus ?? "")
        let mebberLivingStatus = MemberLivingStatusCode.init(rawValue: modelMember.memberStatus ?? "" )
        
        if memberCompletionStatus == .completed && mebberLivingStatus != .notStarted {
           
        textcolor = ProjectColor.green
        }else if memberCompletionStatus == .uploaded  && mebberLivingStatus != .notStarted{
            textcolor = ProjectColor.colorPrimary
        }
        self.lblMemberName?.textColor = textcolor
        self.lblSerialNumber.textColor = textcolor
        
    }
}
