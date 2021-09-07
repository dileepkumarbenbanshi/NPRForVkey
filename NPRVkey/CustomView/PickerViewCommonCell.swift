//
//  PickerViewCommonCell.swift
//  NPR-2020
//
//  Created by Dileep on 13/12/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class PickerViewCommonCell: UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
