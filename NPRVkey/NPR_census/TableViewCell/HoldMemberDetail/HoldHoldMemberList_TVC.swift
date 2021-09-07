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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func cellValueSetUP(memberDetailModel:NPR2021MemberDetails)  {
        //lblRelation.text = memberDetailModel.relName
        //lblMemberName.text = memberDetailModel.name
        
    }
    
}
