//
//  SV_HHMemberDetail_VC.swift
//  NPR-2020
//
//  Created by Dileep on 21/11/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class SV_HHMemberDetail_VC: UIViewController {

    @IBOutlet weak var lblBlockNo: UILabel!
    
    @IBOutlet weak var btnHouseType: UIButton!
    @IBOutlet weak var lblMemberCount: UIButton!
    @IBOutlet weak var lblHouseHoldNumber: UILabel!
    @IBOutlet weak var lblRemark: UILabel!
    
    @IBOutlet weak var stackRemark: UIStackView!
    @IBOutlet var viewPopUp: UIView!
    // @IBOutlet weak var tbl_MemberList: UITableView!
    var tableLoaded = false
    var modelData = [HouseHoldMemberDetail_modelClass]()
    var arayMembersModel = [NPR2021MemberDetails]()
    var hhModel = NPR_2021hh_Details()
    
    var selectedIndexPath = IndexPath.init(row: -1, section: 0)
    var isSelectedCell = false
    var buttonStatusChange:UIButton!
    
    
    @IBOutlet weak var tbl_houseoldList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.showLoader()
        
         
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
         fetchHHMembers()
    }
    
    func fetchHHMembers()  {
        
        DBManagerMemberDetail().fetchedHHMembers(modelSelectedHH: hhModel) { (arayhhMembers) in
            self.arayMembersModel = arayhhMembers
            self.viewPrepare()
        }
    }
    
    func viewPrepare()  {
        
        tbl_houseoldList.reloadData()
        self.view.removeLoaderView()
        lblMemberCount.setTitle("Total Member : \(arayMembersModel.count)", for: .normal)
        if arayMembersModel.count > 0 {
            
        
        lblBlockNo.text = "Block No - \(singleton().selectEBListModel.eb_block_number ?? "")"
        lblHouseHoldNumber.text =  "Household Number  - \(arayMembersModel[0].hh_Number ?? "")"
//        btnHouseType.setTitle("House Type : \(arayMembersModel[0].hh_type ?? "") ", for: .normal)
        
         btnHouseType.setTitle("Type of Household : Normal ", for: .normal)
            
            setRemark()
    }
    }
    
    func setRemark()  {
        
        if hhModel.hh_completed == HHCompletionStatusCode.uploaded {
            stackRemark.isHidden = true
            lblRemark.isHidden = false
            
        }
        else{
            stackRemark.isHidden = false
            lblRemark.isHidden = false
            
        }
        
        lblRemark.text = hhModel.superVisor_remrk
    }
    
    
    // MARK: - Button Action
    @IBAction func btnDismisPopup_action(_ sender: UIButton) {
        viewPopUp.isHidden = true
    }
    
    @available(iOS 13.0, *)
    @IBAction func btnOk_action(_ sender: UIButton) {
        viewPopUp.isHidden = true
        //self.navigateToController(identifier: "SplitHouseHold_VC", storyBoardName: "NPR")
        
        let vc = self.storyboard?.instantiateViewController(identifier: ClassID.splitHousehold) as? SplitHouseHold_VC
        vc?.arayMemberModel = arayMembersModel
        vc?.hhModel = hhModel
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
    @IBAction func btnBack_action(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
           
       }
    
    
    @objc func btnDropDown_click(_ sender: UIButton){
        
        sender.isSelected = !sender.isSelected
        modelData[sender.tag].opened =  !modelData[sender.tag].opened
        
        let sections = IndexSet.init(integer: sender.tag)
        self.tbl_houseoldList.reloadSections(sections, with: .automatic)
    }
    
    
    
    func getIndexPath(section:Int) -> IndexPath {
       let indexPath = IndexPath.init(row: 0, section: section)
        return indexPath
    }
    
    @IBAction func btnOK_click(_ sender: UIButton) {
        
        remarkSave(remark: "OK")
        
    }
    
    @IBAction func btnRemark_click(_ sender: UIButton) {
      //let remarkView = SV_RemarkView()
        let remarkView = Bundle.main.loadNibNamed("SV_RemarkView", owner: self, options: nil)?.first as? SV_RemarkView
        
        remarkView?.delgate = self
        remarkView?.vc = self
        remarkView?.load_SV_RemarkView()
    }
    
    func remarkSave(remark:String)  {
       
        hhModel.superVisor_remrk = remark
        hhModel.hh_completed = HHCompletionStatusCode.completed
        hhModel.superVisor_remrkOn = Date().superVisorRemarkOn
        do {
            try context.save()
            setRemark()
            alertAfterSaveRemark()
        } catch  {
            
        }
        
    }
    
    func alertAfterSaveRemark()  {
        let alertView = AlertView()
        alertView.alertWithoutButton(vc: self, message: English.superVisorHHDetail.remarkSaved)
        alertView.delegate = self
    }
}

extension SV_HHMemberDetail_VC:UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return arayMembersModel.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
       if isSelectedCell &&  selectedIndexPath.section == section {
            return 2
        }
       else{
        return 1
        }
        
    }
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
       
        
       if indexPath.row == 0 {
        
        let cell:HoldHoldMemberList_TVC = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.houseHoldDetai_memberList, for: indexPath) as! HoldHoldMemberList_TVC
        
        
        cell.lblMemberName.text = arayMembersModel[indexPath.section].name
        cell.lblSerialNumber.text = arayMembersModel[indexPath.section].sloMember
        return cell
        }
        else{
            
        let cell:HouseHoldDetail_TVC = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.houseHoldDetailList, for: indexPath) as! HouseHoldDetail_TVC
       // cell.mainStack.backgroundColor = .brown
        
       let modelMemberDetail = arayMembersModel[indexPath.section]
      // cell.cellValueSetUP(memberDetailModel: modelMemberDetail)
     
            let hhHeadModel = arayMembersModel.filter({$0.rel_code == "01"})
            
            cell.cellPutValues(memberDetailModel: modelMemberDetail, headGender: hhHeadModel[0].gender_id ?? "0")
            cell.mainStack.backgroundColor = .white
        return cell
        }
    
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
      
        if selectedIndexPath == indexPath && (isSelectedCell && indexPath.row == 0 ) {
            isSelectedCell = false
            selectedIndexPath = indexPath
            tableView.reloadData()
        }
//        else if selectedIndexPath == indexPath && isSelectedCell{
//            isSelectedCell = false
//            let sections = IndexSet.init(integer: indexPath.section)
//            tableView.reloadSections(sections, with: .automatic)
//        }
         else if indexPath.row == 0{
            selectedIndexPath = indexPath
            
            
            isSelectedCell = true
                tableView.reloadData()
            
           let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .automatic)
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
//        if indexPath.row == 1 {
//            return DeviceType.IS_IPAD ? 1400 : 950
//        }
        
        return UITableView.automaticDimension
    }
}


//MARK:Custom Delegates

extension SV_HHMemberDetail_VC:SV_RemarkDelegate{
    func tap_svRemarkSubmit(remark: String) {
        remarkSave(remark: remark)
    }
    
    
}

extension SV_HHMemberDetail_VC:AlertViewDelegate {
    func alertTapedYes() {
        
    }
    func alertViewWithoutButtonDissMiss() {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
