//
//  AssignEBTableViewCell.swift
//  NPR Screen
//
//  Created by mac on 06/08/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class AssignEBTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var labelEB: UILabel!
    var minHeight: CGFloat?
    @IBOutlet weak var imgDownloadData: UIImageView!
    
    @IBOutlet weak var lblEnumeratorName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
      let size = super.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: horizontalFittingPriority, verticalFittingPriority: verticalFittingPriority)
        guard let minHeight = self.minHeight else { return size }
      return CGSize(width: size.width, height: max(size.height, minHeight))
    }

    
}
