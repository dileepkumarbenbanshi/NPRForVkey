//
//  AgreeView.swift
//  NPR_census
//
//  Created by mac on 24/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

@objc protocol AgreeViewDelegate{
    func onTapAgree() ->Void
    @objc optional func onTapDisafree()
}

class AgreeView: UIView {

    var delegate: AgreeViewDelegate?
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblStateName: UILabel!
    @IBOutlet weak var lblDistrict: UILabel!
    @IBOutlet weak var lblDistrictName: UILabel!
    
    @IBOutlet weak var lblSubDistrict: UILabel!
    @IBOutlet weak var lblSubDistrictName: UILabel!
    @IBOutlet weak var lblTown_village: UILabel!
    @IBOutlet weak var lblTown_villageName: UILabel!
    
    @IBOutlet weak var lblWard: UILabel!
    @IBOutlet weak var lblWardNumber: UILabel!
    @IBOutlet weak var lblBlock: UILabel!
    @IBOutlet weak var lblBlockNumber: UILabel!
    
    @IBOutlet weak var btnAgree: UIButton!
    @IBOutlet weak var btnDisAgree: UIButton!
    
    
    override func awakeFromNib() {
        self.containerView.cornerRadiusV = 3
        viewPrepare()
    }
    
    
    func viewPrepare()  {
        
        let ebModel = singleton().selectEBListModel
        
        lblStateName.text = ebModel.ebState_name
        lblDistrictName.text = ebModel.ebDistrict_name
        lblSubDistrictName.text = ebModel.ebTahsil_name
        lblWardNumber.text = ebModel.ebWard_code
        lblBlockNumber.text = ebModel.eb_block_number
       
    }
    @IBAction func onTapDisAgree(_ sender: UIButton) {
       
        singleton().NPRRect.removeSubviewFromParentWidnow()
        delegate?.onTapDisafree?()
    }
    
    @IBAction func onTapAgree(_ sender: Any) {
        singleton().NPRRect.removeSubviewFromParentWidnow()
        delegate?.onTapAgree()
    }
}
