//
//  HouseholdMemberDetail_ViewController.swift
//  NPR_census
//
//  Created by admin on 13/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class HouseholdMemberDetail_ViewController: UIViewController {
    @IBOutlet weak var lblBlockNo: UILabel!
    
    @IBOutlet weak var tf_numberSplitHH: UITextField!
    @IBOutlet weak var btnHouseType: UIButton!
    @IBOutlet weak var lblMemberCount: UIButton!
    @IBOutlet weak var lblHouseHoldNumber: UILabel!
    
    @IBOutlet var viewPopUp: UIView!
    // @IBOutlet weak var tbl_MemberList: UITableView!
    var tableLoaded = false
    var modelData = [HouseHoldMemberDetail_modelClass]()
    var arayMembersModel = [NPR2021MemberDetails]()
    var hhModel = NPR_2021hh_Details()
    
    
    var selectedIndexPath = IndexPath.init(row: -1, section: 0)
    var isSelectedCell = false
    var buttonStatusChange:UIButton!
    var isChangeMemberStatus = false
    var isTapedDeleteButton = false
    
    
    @IBOutlet weak var tbl_houseoldList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        viewPopUp.frame = self.view.frame
        
        self.view.addSubview(viewPopUp)
        viewPopUp.isHidden = true
        viewPopUp.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
         
        // Do any additional setup after loading the view.
    }
    
    
    
    
    func fetchHHMembers()  {
        
        DBManagerMemberDetail().fetchedHHMembers(modelSelectedHH: hhModel) { (arayhhMembers) in
            self.arayMembersModel = arayhhMembers
            self.viewPrepare()
        }
    }
    
    func viewPrepare()  {
        
        lblMemberCount.setTitle("Total Member : \(arayMembersModel.count)", for: .normal)
        lblBlockNo.text = "Block No - \(singleton().selectEBListModel.eb_block_number ?? "")"
        lblHouseHoldNumber.text =  "Household Number  - \(arayMembersModel[0].hh_Number ?? "")"
//        btnHouseType.setTitle("House Type : \(arayMembersModel[0].hh_type ?? "") ", for: .normal)
        tbl_houseoldList.reloadData()
         btnHouseType.setTitle("Type of Household : Normal ", for: .normal)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        fetchHHMembers()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Button Action
    @IBAction func btnDismisPopup_action(_ sender: UIButton) {
        viewPopUp.isHidden = true
    }
    
    @available(iOS 13.0, *)
    @IBAction func btnOk_action(_ sender: UIButton) {
        
        DBManagerMemberDetail().fetchMembers_currentalyLeaveinHH(modelSelectedHH: hhModel) { (arayExistMemberInHH) in
            
            let intNumberSplit = Int(self.tf_numberSplitHH.text ?? "") ?? 0
            
            if intNumberSplit    >= 2 && intNumberSplit <= arayExistMemberInHH.count{
                self.viewPopUp.isHidden = true
            //self.navigateToController(identifier: "SplitHouseHold_VC", storyBoardName: "NPR")
                self.tf_numberSplitHH.text = ""
                self.tf_numberSplitHH.resignFirstResponder()
            let vc = self.storyboard?.instantiateViewController(identifier: ClassID.splitHousehold) as? SplitHouseHold_VC
                vc?.arayMemberModel = self.arayMembersModel
                vc?.hhModel = self.hhModel
            self.navigationController?.pushViewController(vc!, animated: true)
            }else{
                
                var strMessage = ""
                
                if arayExistMemberInHH.count > 2 {
                   strMessage = "\(English.SplitView().splitNumberAlert) 2 to \(arayExistMemberInHH.count)"
                }
                else{
                    strMessage = "\(English.SplitView().splitNumberGreter)"
                }
                AlertView().alertWithoutButton(vc: self, message: strMessage)
            }
            
        }
        
        
    }
    
    @IBAction func btnBack_action(_ sender: UIButton) {
        
        if hhModel.respondentName?.count ?? 0 == 0  && isChangeMemberStatus {
            
            //self.navigateToRespondentSignature()
            
            DBManagerHousehold().updateHHStatus_dependONMember(houseHoldModel: hhModel) { (isUpdated) in

                self.navigateToRespondentSignature()

            }
        }else{
            self.navigationController?.popViewController(animated: true)
        }
       
           
       }
    @IBAction func btnSplit_action(_ sender: UIButton) {
        
        
        DBManagerMemberDetail().fetchOldMembers_currentalyLiveinHH(modelSelectedHH: hhModel) { (arayMemberLiveinHH) in
           
            if arayMemberLiveinHH.count > 1 {
                self.viewPopUp.isHidden = false
                self.tf_numberSplitHH.addDonButton_TextFields()
            }else{
                AlertView().showAlertWithSingleButton(vc: self, title: "", message: English.SplitView().availableMember)
                
                
            }
        }
        
        
        
        
        
    }
    @IBAction func btnRefresh_action(_ sender: UIButton) {
        
    }
    
    @IBAction func btn_addMember_action(_ sender: UIButton) {
        
       // self.navigateToController(identifier: ClassID.addNewMemberForm, storyBoardName: storyBoardName.npr)
        
        
        guard  let objHHMemberDetail = storyBoard.npr.instantiateViewController(withIdentifier: ClassID.addNewMemberForm) as? AddNewHouseHoldForm_TVC else {
            return
        }
        
        objHHMemberDetail.isEditingDetail = false
        objHHMemberDetail.entryT = .addNewMemberExitHH
        objHHMemberDetail.strMemberName = "New Member"
        objHHMemberDetail.modelHH = hhModel
//       let hhHeadModel = arayMembersModel.filter({$0.rel_code == "01"})
//        objHHMemberDetail.strHHNumber = hhHeadModel[0].hh_Number ?? ""
//
//        objHHMemberDetail.strHouseNumber = hhHeadModel[0].censusHouse_number ?? ""
//       // objHHMemberDetail.strHHNumber
//        objHHMemberDetail.modelHH = hhModel
        self.navigateToController(vc: objHHMemberDetail)
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
    
}

extension HouseholdMemberDetail_ViewController:UITableViewDataSource,UITableViewDelegate{
    
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
        //cell.btnDropDown.tag = indexPath.section
        //cell.btnDropDown.addTarget(self, action: #selector(HouseholdMemberDetail_ViewController.btnDropDown_click(_:)), for: .touchUpInside)
        arayMembersModel[indexPath.section].censusHH_number = hhModel.census_hhNo
        arayMembersModel[indexPath.section].censusHouse_number = hhModel.census_hNo
        do {
            try context.save()
        } catch  {
            
        }
        cell.lblMemberName.text = arayMembersModel[indexPath.section].name
        cell.lblSerialNumber.text = arayMembersModel[indexPath.section].sloMember
        return cell
        }
        else{
            
        let cell:HouseHoldDetail_TVC = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.houseHoldDetailList, for: indexPath) as! HouseHoldDetail_TVC
//        cell.mainStack.backgroundColor = .brown
        
       let modelMemberDetail = arayMembersModel[indexPath.section]
      // cell.cellValueSetUP(memberDetailModel: modelMemberDetail)
        if #available(iOS 13.0, *) {
            cell.btnAvailable.addTarget(self, action: #selector(HouseholdMemberDetail_ViewController.btnMemberStatus_action(_:)), for: .touchUpInside)
        } else {
            
        }
        
        
        if #available(iOS 13.0, *) {
            cell.btnMoved.addTarget(self, action: #selector(HouseholdMemberDetail_ViewController.btnMemberStatus_action(_:)), for: .touchUpInside)
        } else {
            // Fallback on earlier versions
        }
        
        if #available(iOS 13.0, *) {
            cell.btnDied.addTarget(self, action: #selector(HouseholdMemberDetail_ViewController.btnMemberStatus_action(_:)), for: .touchUpInside)
        } else {
            // Fallback on earlier versions
        }
        
        if #available(iOS 13.0, *) {
            cell.btnEdit.addTarget(self, action: #selector(HouseholdMemberDetail_ViewController.btnEdit_action(_:)), for: .touchUpInside)
            cell.btnEdit.tag = indexPath.section
        } else {
            //cell.btnEdit.addTarget(self, action: #selector(HouseholdMemberDetail_ViewController.on(_:)), for: .touchUpInside)
            
        }
            cell.btnDelete.tag = indexPath.section
            if #available(iOS 13.0, *) {
                
                cell.btnDelete.addTarget(self, action: #selector(HouseholdMemberDetail_ViewController.btnDelete_action(_:)), for: .touchUpInside)
                //cell.btnEdit.tag = indexPath.section
            } else {
                //cell.btnEdit.addTarget(self, action: #selector(HouseholdMemberDetail_ViewController.on(_:)), for: .touchUpInside)
                
            }
        
            let hhHeadModel = arayMembersModel.filter({$0.rel_code == "01"})
            
            cell.cellPutValues(memberDetailModel: modelMemberDetail, headGender: hhHeadModel[0].gender_id ?? "0")
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



@available(iOS 13.0, *)
extension HouseholdMemberDetail_ViewController {
    
    @objc func btnMemberStatus_action(_ sender: UIButton){
    
        buttonStatusChange = sender
  
        let buttonPosition = sender.convert(CGPoint.zero, to: self.tbl_houseoldList)
            let indexPath = self.tbl_houseoldList.indexPathForRow(at: buttonPosition)!
        let cell = tbl_houseoldList.cellForRow(at: indexPath) as? HouseHoldDetail_TVC
   
       var status = ""
        
        cell?.btnAvailable.isSelected = false
   
    
        switch sender.tag {
        case 10:
            
            status = "Available"
           
//            cell?.btnEdit.isUserInteractionEnabled = true
           // cell?.btnEdit.isSelected = true
            cell?.btnAvailable.isSelected = true
            cell?.btnDied.isSelected = false
            cell?.btnMoved.isSelected = false
            cell?.stackViewEdit.isHidden = false
            //statusChangeAfterYes(sender: buttonStatusChange)
            
            return
            
        case 11:
            status = "Moved Out"
            
            break
            case 12:
            
                status = "Died"
            break
            
        default:
            
            status = "Died"
            break
        }
        
        
        
    
        
       
        alertForStatusChange(status: status, indexPath: indexPath)
    
    }
    
    
    func alertForStatusChange(status:String,indexPath:IndexPath)  {
        
        DBManagerMemberDetail().fetchMembers_currentalyLeaveinHH(modelSelectedHH: hhModel) { (arayCurrentalyLeaveINHH) in
           
            if arayCurrentalyLeaveINHH.count > 1 {
                
                let alertView = AlertView()
                alertView.delegate = self
                alertView.showAlert(vc: self, title: "Are You Sure", message: "To mark member   \(self.arayMembersModel[indexPath.section].name ?? "")  as \(status)")
            }
            else{
                
                AlertView().showAlertWithSingleButton(vc: self, title: "", message: English.HouseholdDetail.atLeastOneMemberINHH)
            }
        }
        
        
        
        
        
        
    }
    
    
    
    @objc func btnEdit_action(_ sender: UIButton) {
    
        
        let modelMemberDetail = arayMembersModel[sender.tag]
        
        guard let addNewMemberForm = self.storyboard?.instantiateViewController(identifier: ClassID.addNewMemberForm) as? AddNewHouseHoldForm_TVC else { return }
        addNewMemberForm.modelMemberDetail = modelMemberDetail
        addNewMemberForm.isEditingDetail = true
        addNewMemberForm.entryT = .editDetail
        addNewMemberForm.modelHH = hhModel
        self.navigationController?.pushViewController(addNewMemberForm, animated: true)
    }
    
    
    
    
    
    @objc func onTapSkip(_ sender: UIButton){
        
//       let pickerView = Bundle.main.loadNibNamed("SkipHHView", owner: self, options: nil)?.first as? SkipHHView
//           pickerView?.delegate = self
//        skipSelctedHHModel = arayHHList[sender.tag]
//            pickerView?.loadSKipView()
    }
    
}

