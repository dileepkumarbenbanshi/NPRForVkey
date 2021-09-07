//
//  HHMemberListForHeadSelection.swift
//  NPR-2020
//
//  Created by Dileep on 06/01/21.
//  Copyright © 2021 admin. All rights reserved.
//

import UIKit

protocol HeadChangeDelegate {
    
    func headChanged()
    
    
}

class HHMemberListForHeadSelection: UIView {
    
    let windows =  UIApplication.shared.keyWindow
    @IBOutlet weak var tblView: UITableView!
    var arayModelList = [NPR2021MemberDetails]()
    var modelHH = NPR_2021hh_Details()
    var seletedMemberModel = NPR2021MemberDetails()
    var vc = UIViewController()
    var selectedIndexPath = NSIndexPath()
    
    var delegate:HeadChangeDelegate?
    
    override func awakeFromNib() {
        
        tblView.dataSource = self
        tblView.delegate = self
        self.tblView.register(UINib(nibName: "Headselect_TVC", bundle: nil), forCellReuseIdentifier:"Headselect_TVC")
        //self.frame.size = CGSize.init
        window?.addSubview(self)
    }
    
    
    
    func loadHeadChangeList(hhModel:NPR_2021hh_Details, vc:UIViewController)  {
       
        modelHH = hhModel
        //pickerView.reloadAllComponents()
        
        tblView.reloadData()
        self.vc = vc
        self.frame = vc.view.frame
        
        
            self.viewPrepare()
                
    }
    
    func viewPrepare()  {
        self.windows?.addSubview(self)
        
        //self.backgroundColor = UIColor.init(white: 0.3, alpha: 0.9)
        DBManagerMemberDetail().fetchedHHMembers(modelSelectedHH: modelHH) { (arayHHMembers) in
            //self.arayMemberModel = arayHHMembers
            self.arayModelList = arayHHMembers.filter({$0.memberStatus == MemberStatusCode.notStarted || $0.memberStatus == MemberStatusCode.available || $0.memberStatus == MemberStatusCode.newMember})
            
            self.arayModelList = self.arayModelList.filter({$0.rel_code != "01"})
                self.tblView.reloadData()
        }
        
    }

    
    
    @IBAction func btnCancelTap(_ sender: UIButton) {
        
        self.removeFromSuperview()
    }
    
    
    @IBAction func btnOkTap(_ sender: UIButton) {
        let alertView = AlertView()
        alertView.delegate = self
        
        
        alertView.showAlert(vc: vc, title: AppMessages().areYouSure, message: "\(seletedMemberModel.name ?? "")\(English.HouseholdDetail.headSelectionC) \(modelHH.houseHoldhNo ?? "")")
    }
    
   @objc func btnRadioTap(sender:UIButton)  {
        
    seletedMemberModel = arayModelList[sender.tag]
    selectedIndexPath = NSIndexPath.init(row: sender.tag, section: 0)
    tblView.reloadData()
    }
    
    func updateHeadDetal_forHH()  {
        
       
        modelHH.headName = seletedMemberModel.name
        modelHH.head_DOB = seletedMemberModel.dob
        
        do {
            try context.save()
        } catch  {
            
        }
        
        fetchMember_inOrder()
    }
    
    func fetchMember_inOrder()  {
       
        DBManagerMemberDetail().fetchedHHMembers(modelSelectedHH: modelHH) { (arayMembersModel) in
            
            let arayModel_inOrder  = arayMembersModel.sorted(by: {$0.sloMember ?? "0" < $1.sloMember ?? "1"})
            
                self.updateRelationShip_withNewHead(sortedAray: arayModel_inOrder)
        }
        
    }
    
    func updateRelationShip_withNewHead(sortedAray:[NPR2021MemberDetails])  {
        
        var index = 0
        
        for modelMember in sortedAray {
            modelMember.sloMember = String(format: AppFormat.threeDigitFormat, index+1)
            if index == 0 {
                modelMember.rel_code = "01"
                modelMember.relName = modelMember.rel_code?.getDropDownItem_id(aray: English().relationship_to_head_male())
            }else{
                modelMember.rel_code = ""
                
                
            }
            do {
                try context.save()
            } catch  {
                
            }
            index = index + 1
            
            if index == sortedAray.count {
                
                self.removeFromSuperview()
                delegate?.headChanged()
            }
        }
        
    }
    
}



extension HHMemberListForHeadSelection:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return arayModelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Headselect_TVC") as? Headselect_TVC
        let model = arayModelList[indexPath.row]
        cell?.lblName.text = model.name
        cell?.lblRelation.text = model.relName
        cell?.lblSerialNo.text = model.sloMember//String(format: AppFormat.threeDigitFormat, indexPath.row+1 )
            
        cell?.btnRadio.tag = indexPath.row
        cell?.btnRadio.addTarget(self, action: #selector(HHMemberListForHeadSelection.btnRadioTap(sender:)), for: .touchUpInside)
        if indexPath == selectedIndexPath as IndexPath {
            cell?.btnRadio.isSelected = true
        }else{
            cell?.btnRadio.isSelected = false
        }
      return cell ?? PickerViewCommonCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.removeFromSuperview()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 50
    }
    
}


extension HHMemberListForHeadSelection:AlertViewDelegate {
    func alertTapedYes() {
        
        seletedMemberModel.rel_code = "01"
        seletedMemberModel.sloMember = String(format: AppFormat.threeDigitFormat, 0)
        do {
            try context.save()
        } catch  {
            
        }
       updateHeadDetal_forHH()
    }
    
    
}
