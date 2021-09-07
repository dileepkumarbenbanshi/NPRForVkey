//
//  Headselect_TVC.swift
//  NPR-2020
//
//  Created by Dileep on 06/01/21.
//  Copyright © 2021 admin. All rights reserved.
//

import UIKit

class Headselect_TVC: UITableViewCell {

    @IBOutlet weak var btnRadio: UIButton!
    @IBOutlet weak var lblRelation: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSerialNo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
