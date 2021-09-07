//
//  LocationParitcularTableViewCell.swift
//  NPR Screen
//
//  Created by mac on 07/08/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class LocationParitcularTableViewCell: UITableViewCell {

    var minHeight: CGFloat?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
         let size = super.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: horizontalFittingPriority, verticalFittingPriority: verticalFittingPriority)
        guard let minHeight = self.minHeight else { return size }
         return CGSize(width: size.width, height: max(size.height, minHeight))
       }
    
}
