//
//  IncompleteHouseholdTableViewCell.swift
//  NPR Screen
//
//  Created by mac on 10/08/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class IncompleteHouseholdTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var labelHouseHoldNumber: UILabel!
    @IBOutlet weak var labelCensusHouseNumber: UILabel!
    @IBOutlet weak var labelHeadName: UILabel!
    @IBOutlet weak var labelHeadDOB: UILabel!
    @IBOutlet weak var buttonSkip: UIButton!
    @IBOutlet weak var buttonDropDown: UIButton!
    @IBOutlet weak var btnRightArrow: UIButton!
    @IBOutlet weak var lblHHNOTitle: UILabel!
    @IBOutlet weak var imgStatus: UIImageView!
    @IBOutlet weak var lblCensusHHTitle: UILabel!
    var minHeight: CGFloat?
    @IBOutlet weak var btnDelete: UIButton!
    
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
    
    func cellSetUP(model:NPR_2021hh_Details)  {
        
        labelHeadName.text = model.headName
        labelHeadDOB.text = model.head_DOB
        labelHouseHoldNumber.text = model.houseHoldhNo
        labelCensusHouseNumber.text = model.census_hhNo
        setCompletionColor(CompletionStatus: model.hh_completed ?? "")
        if util.isEnumerator() {
            setHHStatusImage(model: model)
        }else{
            labelCensusHouseNumber.text = model.houseHoldhNo
        }
       
        
        
        if model.is_Splited {
            
            self.containerView.setCorner(radius: 5.0)
            self.containerView.layer.borderColor = ProjectColor.colorPrimary.cgColor
            self.containerView.layer.borderWidth = 3.0
        }
        else {
            self.containerView.setCorner(radius: 0.0)
            self.containerView.layer.borderColor = UIColor.clear.cgColor
            self.containerView.layer.borderWidth = 0.0
        }
    
    }
    
    func setHHStatusImage(model:NPR_2021hh_Details)  {
        
        guard let hhStatus = HHStaus.init(rawValue: model.hh_status ?? "") else { return  }
        
        var imageName = ""
        btnDelete.isHidden = true // should be true
        imgStatus.image = UIImage.init(named: "")
        imgStatus.isHidden = false
        
        switch hhStatus {
        
        case .available:
            
            break
        case .locked:
           
           
            imageName =  "lock"
            buttonSkip.isHidden = false
            
            break
           
        case .migratedOut:
            
            imageName =  "figure.walk"
            
            break
            
        case .new:
            imgStatus.isHidden = true
            btnDelete.isHidden = false
            buttonSkip.isHidden = true
            break
            
        case .notAvailable:
           imageName =  "nosign"
            
            break
            
        
        }
        imgStatus?.image =  UIImage.init(systemName: imageName)
    }

    
    func setCompletionColor(CompletionStatus:String)  {
       
        var color = UIColor.red
        
        
        if CompletionStatus == HHCompletionStatusCode.notStarted{
            color = UIColor.red
        } else if CompletionStatus == HHCompletionStatusCode.completed {
            color = ProjectColor.green
//            btnDelete.isHidden = false
//            buttonSkip.isHidden = false
            
        }else if CompletionStatus == HHCompletionStatusCode.uploaded {
            color = ProjectColor.colorPrimary
            if util.isEnumerator() {
                
            
            btnDelete.isHidden = true
            buttonSkip.isHidden = true
            }
        }else if CompletionStatus == HHCompletionStatusCode.inComplete {
            color = ProjectColor.colorAmber
        }
        
        labelHeadName.textColor = color
        labelHeadDOB.textColor = color
        labelHouseHoldNumber.textColor = color
        labelCensusHouseNumber.textColor = color
        lblHHNOTitle.textColor = color
        lblCensusHHTitle.textColor = color
    }
}
