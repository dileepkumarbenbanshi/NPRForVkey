//
//  IncompleteHouseholdSubCell.swift
//  NPR Screen
//
//  Created by mac on 10/08/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class IncompleteHouseholdSubCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var labelSerialNo: UILabel!
    @IBOutlet weak var labelMemberName: UILabel!
    @IBOutlet weak var labelRelationship: UILabel!
    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var buttonInfo: UIButton!
    @IBOutlet weak var buttonArrow: UIButton!
    @IBOutlet weak var buttonArrowHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerViewBottomConstraint: NSLayoutConstraint!
    var minHeight: CGFloat?
    
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

    
    func cellSetUP(modelMember:NPR2021MemberDetails,hhModel:NPR_2021hh_Details)  {
        updateMemberStaCompletiontus_completedORUploadedHH(hhModel: hhModel, modelMember: modelMember)
        
        self.labelMemberName?.text = modelMember.name
        self.labelSerialNo.text = modelMember.sloMember
        //let arayRelation = headGender.getRealtionShipAray()
        
        let relationCode = modelMember.gender_id ?? ""
        
        let arayRelation = relationCode.getRealtionShipAray()
        self.labelRelationship.text =  modelMember.rel_code?.getName_by_ID(aray: arayRelation)
        
        let memberStatus = MemberLivingStatusCode.init(rawValue: modelMember.memberStatus ?? "")
        modelMember.relName = self.labelRelationship.text ?? ""
        do {
            try context.save()
        } catch  {
            
        }
        self.labelStatus.text = MemberLivingStatusCode.shortCode(memberStatus!)()
        buttonInfo.tag = Int(memberStatus?.rawValue ?? "0") ?? 0
        var textcolor = UIColor.systemPink
        
        let memberCompletionStatus = MemberCompletionStatus.init(rawValue: modelMember.member_completionStatus ?? "")
        
        if memberCompletionStatus == .completed  {
           
        textcolor = ProjectColor.green
        }else if memberCompletionStatus == .uploaded {
            textcolor = ProjectColor.colorPrimary
        }
        self.labelMemberName?.textColor = textcolor
        self.labelSerialNo.textColor = textcolor
        self.labelRelationship.textColor =  textcolor
        self.labelStatus.textColor = textcolor
        
    }
    
    
    func updateMemberStaCompletiontus_completedORUploadedHH(hhModel:NPR_2021hh_Details ,modelMember:NPR2021MemberDetails )  {
       
        if hhModel.hh_completed == HHCompletionStatusCode.completed || hhModel.hh_completed == HHCompletionStatusCode.uploaded{
            
        
        if hhModel.hh_completed == HHCompletionStatusCode.completed {
            modelMember.member_completionStatus = MemberCompletionStatusCode.completed
        }
        else   if hhModel.hh_completed == HHCompletionStatusCode.uploaded{
            modelMember.member_completionStatus = MemberCompletionStatusCode.uploaded
        }
            
            do {
                try context.save()
            } catch  {
                
            }
        }
    }
    
    @IBAction func btnInfo_action(_ sender: UIButton) {
       
       // let memberLiveStatus = MemberLivingStatusCode.init(rawValue: "\(sender.tag)")
        
        //AlertView().showAlertWithSingleButton(vc: , title: <#T##String#>, message: <#T##String#>)
        
        
    }
    
}
