//
//  SplitHouseHold_TVC.swift
//  NPR_census
//
//  Created by Dileep on 17/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class SplitHouseHold_TVC: UITableViewCell {

    @IBOutlet weak var lblOrderNo: UILabel!
    @IBOutlet weak var lblMemberName: UILabel!
    @IBOutlet weak var lblRelation: UILabel!
    @IBOutlet weak var btnCheck: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
