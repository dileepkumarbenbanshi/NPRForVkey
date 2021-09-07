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
    func tapedCancelHeadChange()
    
    
}

class HHMemberListForHeadSelection: UIView {
    
    @IBOutlet weak var btnOk: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    let windows =  UIApplication.shared.keyWindow
    @IBOutlet weak var tblView: UITableView!
    var arayModelList = [NPR2021MemberDetails]()
    var modelHH = NPR_2021hh_Details()
    var seletedMemberModel = NPR2021MemberDetails()
    var vc = UIViewController()
    var selectedIndexPath = NSIndexPath()
    var isSelectedHead = false
    
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
        
        if modelHH.hh_status == HHStatusCode.notAvailable || modelHH.hh_status == HHStatusCode.migratedOut || modelHH.hh_status == HHStatusCode.migratedOut {
            self.featchMemberOFSkipedHH()
        }
        else{
            self.featchMember()
        }
            
                
    }
    
    func featchMember()  {
        self.windows?.addSubview(self)
        
        //self.backgroundColor = UIColor.init(white: 0.3, alpha: 0.9)
        DBManagerMemberDetail().fetchedHHMembers(modelSelectedHH: modelHH) { (arayHHMembers) in
            //self.arayMemberModel = arayHHMembers
            self.arayModelList = arayHHMembers.filter({$0.memberStatus == MemberStatusCode.notStarted || $0.memberStatus == MemberStatusCode.available || $0.memberStatus == MemberStatusCode.newMember})
            
            self.arayModelList = self.arayModelList.filter({$0.rel_code != "01"})
                self.tblView.reloadData()
        }
        viewPrepare()
    }

    func featchMemberOFSkipedHH()  {
        
        
        DBManagerMemberDetail().fetchedHHMembers(modelSelectedHH: modelHH) { (arayHHMembers) in
            //self.arayMemberModel = arayHHMembers
           
            
            self.arayModelList = self.arayModelList.filter({$0.rel_code != "01"})
                self.tblView.reloadData()
        }
    }
    
    
    func viewPrepare()  {
        
        lblTitle.text = LanguageModal.langObj.select_head_title
        btnCancel.setTitle(LanguageModal.langObj.cancel, for: .normal)
        btnOk.setTitle(LanguageModal.langObj.ok, for: .normal)
    }
    
    @IBAction func btnCancelTap(_ sender: UIButton) {
        
        self.removeFromSuperview()
        isSelectedHead = false
    }
    
    
    @IBAction func btnOkTap(_ sender: UIButton) {
        if !isSelectedHead {
            return
        }
            
        
        let alertView = AlertView()
        
        alertView.delegate = self
//        var name = seletedMemberModel.name
//        if !util.isSelectedLang_english() {
//           name = seletedMemberModel.nameSL
//        }
        
//        alertView.showAlert(vc: vc, title: AppMessages.areYouSure, message: "\(name ?? "")\(English.HouseholdDetail.headSelectionC) \(modelHH.houseHoldhNo ?? "")")
        alertView.showAlert(title: AppMessages.areYouSure, message: LanguageModal.langObj.click_yes_to_mark_as_head)
          
        
    }
    
   @objc func btnRadioTap(sender:UIButton)  {
        
    seletedMemberModel = arayModelList[sender.tag]
    selectedIndexPath = NSIndexPath.init(row: sender.tag, section: 0)
    isSelectedHead = true
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
        DBManagerMemberDetail().fetchMembers_currentalyLeaveinHH(modelSelectedHH: modelHH) { (arayMembersModel) in
            
        
        
//        DBManagerMemberDetail().fetchedHHMembers(modelSelectedHH: modelHH) { (arayMembersModel) in
            
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
               // modelMember.member_completionStatus = MemberCompletionStatusCode.notStarted
            }else{
                modelMember.rel_code = ""
                modelMember.relName = ""
                modelMember.member_completionStatus = MemberCompletionStatusCode.notStarted
                
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
        
       
        var name = ""
        
        if model.language?.IsSelectedLangauge_nonEnglish ?? false {
            name = ((model.nameSL?.count != 0) ? model.nameSL ?? "" : model.name) ?? ""
        }else{
            name = ((model.name?.count != 0) ? model.name ?? "" : model.nameSL) ?? ""
        }
       
        
        cell?.lblName.text = name
        let genderInt = Int(model.gender_id ?? "1" ) ?? 0
        
        let gender = gender.init(rawValue: genderInt)
        
        cell?.lblRelation.text =  model.rel_code?.getName_by_ID(aray:English().getRelationShipAray(gender: gender ?? .male))//model.relName
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
       // self.removeFromSuperview()
        
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
