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
        
//        let name = model.headName ?? ""
//
//        if name.count > 0 {
//            labelHeadName.text = model.headName
//        }else{
//            labelHeadName.text = model.headName_sl
//        }
        
        
        var headName = ""
        
        if model.language?.IsSelectedLangauge_nonEnglish ?? false {
            headName = ((model.headName_sl?.count != 0 && model.headName_sl != nil ) ? model.headName_sl ?? "" : model.headName) ?? ""
        }else{
            headName = ((model.headName?.count != 0 && model.headName != nil ) ? model.headName ?? "" : model.headName_sl) ?? ""
        }
        labelHeadName.text = headName
        labelHeadDOB.text = model.head_DOB
        labelHouseHoldNumber.text = model.houseHoldhNo
        labelCensusHouseNumber.text = model.census_hhNo
        lblHHNOTitle.text = LanguageModal.langObj.old
        lblCensusHHTitle.text = LanguageModal.langObj.new_hh
        if util.isEnumerator() {
            setHHStatusImage(model: model)
        }else{
            labelCensusHouseNumber.text = model.houseHoldhNo
        }
        setCompletionColor(CompletionStatus: model.hh_completed ?? "")
        
        
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
    
        
        setDeleteButton(modelHH: model)
        setCensussHHNumber(hhModel: model)
        if util.isEnumerator() {
            setSkipButton(modelHH: model)
        }
        
    }
    
    func setCensussHHNumber(hhModel:NPR_2021hh_Details)  {
        
        let censusHhN = hhModel.census_hhNo ?? ""
        lblCensusHHTitle.isHidden = censusHhN.count < 1
        labelCensusHouseNumber.isHidden = censusHhN.count < 1
        
        labelCensusHouseNumber.text = censusHhN
        
    }
    func setHHStatusImage(model:NPR_2021hh_Details)  {
        
        guard let hhStatus = HHStaus.init(rawValue: model.hh_status ?? "") else { return  }
        
        var imageName = "Transparent"
        btnDelete.isHidden = true // should be true
        imgStatus.image = UIImage.init(named: "")
        imgStatus.isHidden = false
        
        switch hhStatus {
        
        case .available:
            buttonSkip.isHidden = false
            imageName = "Transparent"
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
           
            
        }else if CompletionStatus == HHCompletionStatusCode.uploaded {
            color = ProjectColor.colorPrimary
            if util.isEnumerator() {
                
            
            
            }
        }else if CompletionStatus == HHCompletionStatusCode.inComplete {
            color = ProjectColor.colorAmber
        }
        if util.isEnumerator() { buttonSkip.titleLabel?.textColor = color }
        
        labelHeadName.textColor = color
        labelHeadDOB.textColor = color
        labelHouseHoldNumber.textColor = color
        labelCensusHouseNumber.textColor = color
        lblHHNOTitle.textColor = color
        lblCensusHHTitle.textColor = color
        
       // buttonSkip.tintColor = color
       // btnDelete.tintColor = color
    }
    
    
    func setSkipButton(modelHH:NPR_2021hh_Details)  {
        
       
        var isHide = false
        buttonSkip.setTitle(LanguageModal.langObj.skip, for: .normal)
        let isAvailableNewMemberInHH = DBManagerHousehold().isNewMember_inHH(modelSelectedHH: modelHH)
        
      if modelHH.hh_completed == HHCompletionStatusCode.uploaded{
        guard let hhStatus = HHStaus.init(rawValue: modelHH.hh_status ?? "") else { return  }
            if hhStatus == .locked {
                
                isHide = false
            }else{
                
                isHide = true
            }
            
        }
        else if isAvailableNewMemberInHH{
            isHide = true
        }else{
            isHide = false
        }
        print("SkipButton should Hide", isHide)
        if util.isEnumerator() {
            buttonSkip.isHidden = isHide
        }
       
    }
    
    func setDeleteButton(modelHH:NPR_2021hh_Details)  {
        if util.isEnumerator() {
        guard let hhStatus = HHStaus.init(rawValue: modelHH.hh_status ?? "") else { return  }
        
      if modelHH.hh_completed == HHCompletionStatusCode.completed{
            if hhStatus == .new {
                btnDelete.isHidden = false
            }else{
                btnDelete.isHidden = true
            }
            
        }
        else{
            
            btnDelete.isHidden = true
        }
        }
        
    }
    
}
