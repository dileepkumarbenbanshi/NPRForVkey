//
//  HHMemberListForHeadSelection.swift
//  NPR-2020
//
//  Created by Dileep on 06/01/21.
//  Copyright © 2021 admin. All rights reserved.
//

import UIKit

protocol selectouseHoldShiftMember {
    
    func memberShiftedSuccessfully()
    func cancelButtonTaped()

}

class SplitViewHouseHoldList: UIView {
    
    @IBOutlet weak var lblMemberName_title: UILabel!
    @IBOutlet weak var lblHHNO_title: UILabel!
    @IBOutlet weak var lblSelectHH_title: UILabel!
    let windows =  UIApplication.shared.keyWindow
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblHHNumber: UILabel!
    @IBOutlet weak var lblMemberName: UILabel!
    var arayModelList = [NPR_2021hh_Details]()
    var modelHH = NPR_2021hh_Details()
    var originalHH = NPR_2021hh_Details()
    
    var modelMember = NPR2021MemberDetails()
    
    var seletedHHShiftTo = NPR_2021hh_Details()
    var vc = UIViewController()
    var selectedIndexPath = NSIndexPath()
    var isSelectedHead = false
    
    var delegate:selectouseHoldShiftMember?
    
    override func awakeFromNib() {
        
        tblView.dataSource = self
        tblView.delegate = self
        self.tblView.register(UINib(nibName: "Headselect_TVC", bundle: nil), forCellReuseIdentifier:"Headselect_TVC")
        //self.frame.size = CGSize.init
        window?.addSubview(self)
    }
    
    func loadHouseHoldList(hhModel:NPR_2021hh_Details,memberModel:NPR2021MemberDetails, vc:UIViewController)  {
       
        modelHH = hhModel
        self.modelMember = memberModel
        //pickerView.reloadAllComponents()
        
        tblView.reloadData()
        self.vc = vc
        self.frame = vc.view.frame
        self.viewPrepare()
                
    }
    
    func viewPrepare()  {
        
        self.windows?.addSubview(self)
        getOrinalHH()
        lblHHNumber.text = modelHH.houseHoldhNo?.hhNumber()
        lblMemberName.text = modelMember.name ?? ""
        var arayHHNumbers = originalHH.originalHHSplitInto?.components(separatedBy: ",") ?? [""]
        
        if arayHHNumbers.count > 1 {
        
        arayHHNumbers = arayHHNumbers.sorted(by: {$0 < $1})
        for hhNumber in arayHHNumbers {
            
        DBManagerHousehold().fetchHHDetail(hhTin: hhNumber.hhTin()) { (hhModel) in
            if hhModel != self.modelHH {
                if (hhModel.hh_completed == HHCompletionStatusCode.notStarted ) || (hhModel.hh_completed == HHCompletionStatusCode.inComplete ) {
                    self.arayModelList.append(hhModel)
                }
           
            }
            
            if hhNumber == arayHHNumbers.last{
                self.tblView.reloadData()
            }
        }
        }
        }
    }
    
    
    func getOrinalHH()  {
        
        if modelHH.houseHoldhNo == modelHH.originalHHNumberSplit {
            self.originalHH = modelHH
        }else{
        DBManagerHousehold().fetchHHDetail(hhTin: modelHH.originalHHNumberSplit?.hhTin() ?? "") { (originalHHModel) in
            self.originalHH = originalHHModel
        }
        }
    }
    //MARK:Button Actions
    @IBAction func btnCancelTap(_ sender: UIButton) {
        
        dismissView()
    }
    
    
    @IBAction func btnOkTap(_ sender: UIButton) {
        if !isSelectedHead {
            return
        }
            
        
        let alertView = AlertView()
        
        alertView.delegate = self
        
        alertView.showAlert( title: AppMessages.areYouSure, message: "\(modelMember.name ?? "")\(English.HouseholdDetail.shiftMemberIntoHH) \(seletedHHShiftTo.houseHoldhNo ?? "")")
            
    }
    
   @objc func btnRadioTap(sender:UIButton)  {
        
    seletedHHShiftTo = arayModelList[sender.tag]
    selectedIndexPath = NSIndexPath.init(row: sender.tag, section: 0)
    isSelectedHead = true
    tblView.reloadData()
    }
    
    func dismissView() {
        
        self.removeFromSuperview()
        isSelectedHead = false
    }
    
    func updateMembrHHDetail()  {
        let memberSrNumber = DBManagerMemberDetail().getNewMemberSerialNumber(hhNumber: seletedHHShiftTo.houseHoldhNo?.hhNumber() ?? "")
        modelMember.hh_tin = seletedHHShiftTo.houseHoldhNo?.hhTin()
        modelMember.hh_Number = seletedHHShiftTo.houseHoldhNo?.hhNumber()
        modelMember.sloHHD = seletedHHShiftTo.houseHoldhNo?.hhNumber()
       
        modelMember.rel_code = ""
        modelMember.memberStatus = MemberStatusCode.notStarted
        modelMember.sloMember = memberSrNumber
        
        do {
            try context.save()
        } catch  {
           print("Failled to save ")
        }
        dismissView()
        
        DBManagerHousehold().updateHHStatus_dependONMember(houseHoldModel: modelHH) { (isSaved) in
            self.updateToShiftedHHStatus()
        }
        }
    
    func updateToShiftedHHStatus()  {
      
        DBManagerHousehold().updateHHStatus_dependONMember(houseHoldModel: seletedHHShiftTo) { (isSaved) in
            self.updateCurrentHhMemberserialNumber()
        }
        
    }
    
    func updateCurrentHhMemberserialNumber()  {
        
        DBManagerMemberDetail().fetchedHHMembers(modelSelectedHH: modelHH) { (araYMemberInHH) in
         
            for index in 1...araYMemberInHH.count {
                let model = araYMemberInHH[index-1]
                
                model.sloMember = "\(index)".memberSrNumber()
                
                
                do {
                    try context.save()
                } catch  {
                    
                }
                if index == araYMemberInHH.count {
                    self.delegate?.memberShiftedSuccessfully()
                }
            }
        }
        
    }
    func fetchHHDetail(hhNumber:String, Completion:@escaping(_ hhModel:NPR_2021hh_Details) -> Void)  {
        
        DBManagerHousehold().fetchHHDetail(hhTin: hhNumber) { (hhModel) in
            
        }
        }
    }
extension SplitViewHouseHoldList:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return self.arayModelList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Headselect_TVC") as? Headselect_TVC
        
        let hhModel = arayModelList[indexPath.row]
        cell?.lblSerialNo.text = hhModel.houseHoldhNo
       
        
         var name = ""
         
         if hhModel.language?.IsSelectedLangauge_nonEnglish ?? false {
            name = ((hhModel.headName_sl?.count != 0 && hhModel.headName_sl != nil ) ? hhModel.headName_sl ?? "" : hhModel.headName) ?? ""
         }else{
             name = ((hhModel.headName?.count != 0) ? hhModel.headName ?? "" : hhModel.headName_sl) ?? ""
         }
        
         
         cell?.lblName.text = name
        
        cell?.lblRelation.isHidden = true
        //String(format: AppFormat.threeDigitFormat, indexPath.row+1 )
            
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
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 50
    }
    
}


extension SplitViewHouseHoldList:AlertViewDelegate,HeadChangeDelegate {
    
    
    func alertTapedYes() {
        if modelMember.rel_code == "01" {
            openHeadChangeView()
        }else{
            updateMembrHHDetail()
        }
        
    }
    
    
    func openHeadChangeView()  {
        let objmembersListForHead = Bundle.main.loadNibNamed("HHMemberListForHeadSelection", owner: self, options: nil)?.first as? HHMemberListForHeadSelection
        objmembersListForHead?.delegate = self
        
        objmembersListForHead?.loadHeadChangeList(hhModel: modelHH, vc: self.vc)
    }
    
    func headChanged() {
        updateMembrHHDetail()
    }
    
    func tapedCancelHeadChange() {
        self.dismissView()
    }
}

