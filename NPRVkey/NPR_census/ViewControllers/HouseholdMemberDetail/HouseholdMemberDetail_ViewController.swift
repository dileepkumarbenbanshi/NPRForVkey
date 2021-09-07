//
//  HouseholdMemberDetail_ViewController.swift
//  NPR_census
//
//  Created by admin on 13/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class HouseholdMemberDetail_ViewController: UIViewController {
    
    @IBOutlet weak var lblInstituteName: UILabel!
    @IBOutlet weak var lblInstituteNameTitle: UILabel!
    @IBOutlet weak var stackViewInstiTutionName: UIStackView!
    @IBOutlet weak var lblEnterNoOfHH_title: UILabel!
    @IBOutlet weak var lblSplit_title: UILabel!
    @IBOutlet weak var lblRefresh_title: UILabel!
    @IBOutlet weak var lblAdd_title: UILabel!
    
    @IBOutlet weak var btn_okSplit: UIButton!
    @IBOutlet weak var lblBlockNo: UILabel!
    
    @IBOutlet weak var stackViewSplit: UIStackView!
    @IBOutlet weak var stackViewAddMember: UIStackView!
    @IBOutlet weak var tf_numberSplitHH: UITextField!
    @IBOutlet weak var btnHouseType: UIButton!
    @IBOutlet weak var lblMemberCount: UIButton!
    @IBOutlet weak var lblHouseHoldNumber: UILabel!
    @IBOutlet weak var btnEditHouseType: UIButton!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblPrevPageName: UILabel!
    @IBOutlet var viewPopUp: UIView!
    // @IBOutlet weak var tbl_MemberList: UITableView!
    var tableLoaded = false
    var modelData = [HouseHoldMemberDetail_modelClass]()
    var arayMembersModel = [NPR2021MemberDetails]()
    var hhModel = NPR_2021hh_Details()
    let alertView = AlertView()
    var btnTaped = UIButton()
    var selectedIndexPath = IndexPath.init(row: -1, section: 0)
    var isSelectedCell = false
    var buttonStatusChange:UIButton!
    var isChangeMemberStatus = false
    var isTapedDeleteButton = false
    var isTapedShiftMember = false
    var isCameFromEditPage = false
    
    var selectedMemberToDelete = NPR2021MemberDetails()
    var tapedButtonTypeAlert =  tapedButtonType.init(rawValue: 3)
    
    enum tapedButtonType:Int {
        case deleteBuuton = 1 , shift ,none
             
    }
    @IBOutlet weak var tbl_houseoldList: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

       viewPopUp.frame = self.view.frame
        
        self.view.addSubview(viewPopUp)
        viewPopUp.isHidden = true
        viewPopUp.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
         
        // Do any additional setup after loading the view.
        indexPathSelecNone()
        alertView.delegate = self
    }

    func fetchHHMembers()  {
        
        DBManagerMemberDetail().fetchedHHMembers(modelSelectedHH: hhModel) { (arayhhMembers) in
            self.arayMembersModel = arayhhMembers
            self.viewPrepare()
        }
    }
    
    func viewPrepare()  {
        lblEnterNoOfHH_title.text = LanguageModal.langObj.expected_hh_to_split
        tf_numberSplitHH.placeholder = LanguageModal.langObj.expected_hh_to_split
        btn_okSplit.setTitle(LanguageModal.langObj.OK, for: .normal)
        lblAdd_title.text = LanguageModal.langObj.button_add_member
        lblRefresh_title.text = LanguageModal.langObj.refresh
        lblSplit_title.text = LanguageModal.langObj.split
        lblMemberCount.setTitle("\(LanguageModal.langObj.total_members) \(arayMembersModel.count)", for: .normal)
        lblBlockNo.text = "\(LanguageModal.langObj.block_no) \(singleton().selectEBListModel.eb_block_number ?? "")"
        lblHouseHoldNumber.text =  "\(LanguageModal.langObj.hh_number)  - \(arayMembersModel[0].hh_Number ?? "")"
//        btnHouseType.setTitle("House Type : \(arayMembersModel[0].hh_type ?? "") ", for: .normal)
        tbl_houseoldList.reloadData()
        lblTitle.text = LanguageModal.langObj.hh_member_details
        var strInstiTutionName = ""
        
        if hhModel.language?.IsSelectedLangauge_nonEnglish ?? false {
            strInstiTutionName = ((hhModel.instituteName_sl?.count != 0) && (hhModel.instituteName_sl != nil) ? hhModel.instituteName_sl ?? "" : hhModel.instituteName) ?? ""
        }else{
            strInstiTutionName = ((hhModel.instituteName?.count != 0) && (hhModel.instituteName != nil)  ? hhModel.instituteName ?? "" : hhModel.instituteName_sl) ?? ""
        }
        
        lblInstituteNameTitle.text = "\(LanguageModal.langObj.name_of_institue) :  \(strInstiTutionName)"
        lblInstituteName.text = strInstiTutionName
        lblInstituteName.isHidden = true
        stackViewInstiTutionName.isHidden = (strInstiTutionName.count == 0  )
        
        var strTitle = ""
        
        if isCameFromEditPage {
            strTitle  = LanguageModal.langObj.search_edit
        }else{
            strTitle  = LanguageModal.langObj.hh_summary
        }
        lblPrevPageName.text = strTitle
        lblTitle.text = LanguageModal.langObj.hh_member_details
        hideSplitAndAddMemberOption()
        tbl_houseoldList.reloadData()
        
        guard let houseType = HouseType.init(rawValue: hhModel.hhType ?? "1") else { return  }
        
        
        let houseTypeDecode = util.houseTypeDecode(houseType:houseType)
        
        btnHouseType.setTitle("\(LanguageModal.langObj.hh_type) : \(houseTypeDecode ) ", for: .normal)
        setEditHouseTypeButton()
        
        var splitButtonShouldHide = true
        
        if (hhModel.hh_status == HHStatusCode.old ||  hhModel.hh_status == HHStatusCode.available){
            splitButtonShouldHide = false
            if hhModel.hh_completed == HHCompletionStatusCode.uploaded {
                splitButtonShouldHide = true
            }
            
        }
        
        stackViewSplit.isHidden = splitButtonShouldHide
    }
    
    func setEditHouseTypeButton() {
        
        let predicate = NSPredicate(format: "hh_tin = %@ AND hh_completed = %@ AND hh_status = %@",hhModel.hh_tin ?? "" , HHCompletionStatusCode.completed,HHStatusCode.new)
       //let predicate = NSPredicate(format: "hh_completed = %@",HHCompletionStatusCode.notStarted)
           if let data = DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicate) as? [NPR_2021hh_Details]{
               
            if data.count > 0 {
                btnEditHouseType.isHidden = false
            }else{
                btnEditHouseType.isHidden = true
            }
             }
        
    }
    
    func indexPathSelecNone()  {
        
        selectedIndexPath = IndexPath.init(row: -1, section: 0)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
        fetchHHMembers()
    }

    func hideSplitAndAddMemberOption()  {
        var haveToHideSplit = false
        var haveToHideAddMember = false
        
        if hhModel.hh_completed == HHCompletionStatusCode.uploaded && hhModel.hh_status != HHStatusCode.locked {
            haveToHideAddMember = true
            haveToHideSplit = true
        }else if hhModel.hh_completed == HHCompletionStatusCode.completed && hhModel.hh_status ?? "" == HHStatusCode.new {
            haveToHideSplit = true
        }
        
        stackViewSplit.isHidden = haveToHideSplit
        stackViewAddMember.isHidden = haveToHideAddMember
    }
    
    // MARK: - Button Action
    @IBAction func btnDismisPopup_action(_ sender: UIButton) {
        viewPopUp.isHidden = true
        tf_numberSplitHH.text = ""
    }
    
    @available(iOS 13.0, *)
    @IBAction func btnOk_action(_ sender: UIButton) {
        
        DBManagerMemberDetail().fetchMembers_currentalyLeaveinHH(modelSelectedHH: hhModel) { (arayExistMemberInHH) in
            
            let intNumberSplit = Int(self.tf_numberSplitHH.text ?? "") ?? 0
            
            if intNumberSplit    >= 2 && intNumberSplit <= arayExistMemberInHH.count && intNumberSplit    <= 99{
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
                    strMessage = "\(LanguageModal.langObj.expected_hh_can_not_be_more_than)-\(arayExistMemberInHH.count)"
                }
                else{
                   // strMessage = "\(English.SplitView().atleastTwoMemberShouldAvailble)"
                    if intNumberSplit == 0 {
                        strMessage = LanguageModal.langObj.expected_hh_can_not_be_zero
                    }else{
                        strMessage = LanguageModal.langObj.expected_hh_can_not_be_one
                    }
                    
                }
                AlertView().alertWithoutButton( message: strMessage)
            }
        }
    }
    
    @IBAction func btnBack_action(_ sender: UIButton) {
        
        self.checkAndOpenSignatureView ()
        
       
           
       }
    @IBAction func btnSplit_action(_ sender: UIButton) {
        
        tf_numberSplitHH.delegate = self
        DBManagerMemberDetail().fetchOldMembers_currentalyLiveinHH(modelSelectedHH: hhModel) { (arayMemberLiveinHH) in
           
            if arayMemberLiveinHH.count > 1 {
                self.viewPopUp.isHidden = false
               // self.tf_numberSplitHH.addDonButton_TextFields()
            }else{
                AlertView().showAlertWithSingleButton( title: "", message: LanguageModal.langObj.one_member_should_be_available_to_split)
                
                
            }
        }
        
        
    }
    @IBAction func btnRefresh_action(_ sender: UIButton) {
        isSelectedCell = false
        tbl_houseoldList.reloadData()
    }
    
    @IBAction func btn_addMember_action(_ sender: UIButton) {
        
       // self.navigateToController(identifier: ClassID.addNewMemberForm, storyBoardName: storyBoardName.npr)
        
        
        guard  let objHHMemberDetail = storyBoard.npr.instantiateViewController(withIdentifier: ClassID.addNewMemberForm) as? AddNewHouseHoldForm_TVC else {
            return
        }
        
        objHHMemberDetail.isEditingDetail = false
        objHHMemberDetail.entryT = .addNewMemberExitHH
        objHHMemberDetail.strMemberName = LanguageModal.langObj.new_member
        objHHMemberDetail.modelHH = hhModel
//       let hhHeadModel = arayMembersModel.filter({$0.rel_code == "01"})
//        objHHMemberDetail.strHHNumber = hhHeadModel[0].hh_Number ?? ""
//
//        objHHMemberDetail.strHouseNumber = hhHeadModel[0].censusHouse_number ?? ""
//       // objHHMemberDetail.strHHNumber
//        objHHMemberDetail.modelHH = hhModel
        self.navigateToController(vc: objHHMemberDetail)
    }
    
    @IBAction func btnEditHouseType_action(_ sender: UIButton) {
        
        guard let addNewMemberForm = self.storyboard?.instantiateViewController(identifier: ClassID.changeHHType) as? ChangeHouseTypeVC else { return }
       
        addNewMemberForm.hhModel = hhModel
        self.navigationController?.pushViewController(addNewMemberForm, animated: true)
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
        
       
//        cell.lblMemberName.text = arayMembersModel[indexPath.section].name
//        cell.lblSerialNumber.text = arayMembersModel[indexPath.section].sloMember
        cell.hhModel = hhModel
        cell.cellValueSetUP(memberDetailModel: arayMembersModel[indexPath.section], index: indexPath.section)
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
            
            let hhHeadModels = arayMembersModel.filter({$0.rel_code == "01"})
            var hhHeadModel = NPR2021MemberDetails()
            if hhHeadModels.count > 0 {
               hhHeadModel = hhHeadModels[0]
            }else{
                hhHeadModel = arayMembersModel[0]
            }
             
            
            
            cell.stackViewShift.isHidden = shiftWillHide(memberModel: modelMemberDetail)
            cell.btnShift.tag = indexPath.section
            cell.cellPutValues(memberDetailModel: modelMemberDetail, headGender: hhHeadModel.gender_id ?? "0")
            cell.delegate = self
        return cell
        }
    
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
      
        if selectedIndexPath == indexPath && (isSelectedCell && indexPath.row == 0 ) {
            isSelectedCell = false
            selectedIndexPath = indexPath
            tableView.reloadData()
        }

         else if indexPath.row == 0{
            selectedIndexPath = indexPath
            
            
            isSelectedCell = true
                tableView.reloadData()
            
           let sections = IndexSet.init(integer: indexPath.section)
            tableView.reloadSections(sections, with: .automatic)
        }
    }
    
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{

        
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
            status = LanguageModal.langObj.as_migrated
            break
            case 12:
            
                status = "Died"
                status = LanguageModal.langObj.as_dead
            break
            
        default:
            
            status = "Died"
            status = LanguageModal.langObj.as_dead
            break
        }
        isTapedDeleteButton = false
        isTapedShiftMember = false
        if hhModel.hh_status == HHStatusCode.migratedOut || hhModel.hh_status == HHStatusCode.locked || hhModel.hh_status == HHStatusCode.notAvailable {
            alertStatusChangeForSkipHH(status: status, indexPath: indexPath)
        }else{
            
            alertForStatusChange(status: status, indexPath: indexPath)
        }
   
    
    }
   
    
    
func alertForStatusChange(status:String,indexPath:IndexPath)  {
    let alertView = AlertView()
    alertView.delegate = self
        DBManagerMemberDetail().fetchMembers_currentalyLeaveinHH(modelSelectedHH: hhModel) { (arayCurrentalyLeaveINHH) in
            if arayCurrentalyLeaveINHH.count > 1{
                
                alertView.showAlert( title: LanguageModal.langObj.are_you_sure, message: "\(LanguageModal.langObj.to_mark_member)   \(self.arayMembersModel[indexPath.section].name ?? "")   \(status)")
            }
           else if arayCurrentalyLeaveINHH.count == 1 && !(arayCurrentalyLeaveINHH.last == self.arayMembersModel[indexPath.section]) {
                
            alertView.showAlert( title: LanguageModal.langObj.are_you_sure, message: "\(LanguageModal.langObj.to_mark_member)   \(self.arayMembersModel[indexPath.section].name ?? "")   \(status)")
            }
//           else if arayCurrentalyLeaveINHH.count == 0{
//
//                alertView.showAlert( title: "Are You Sure", message: "To mark member   \(self.arayMembersModel[indexPath.section].name ?? "")  as \(status)")
//            }
            else{
                
                AlertView().showAlertWithSingleButton( title: "", message: English.HouseholdDetail.atLeastOneMemberINHH)
            }
        }
 
    }
    
    func alertStatusChangeForSkipHH(status:String,indexPath:IndexPath)  {
        isTapedShiftMember = false
        isTapedDeleteButton = false
        let alertView = AlertView()
        alertView.delegate = self
        
        alertView.showAlert( title: LanguageModal.langObj.are_you_sure, message: "\(LanguageModal.langObj.to_mark_member)  \(self.arayMembersModel[indexPath.section].name ?? "")  as \(status)")
                
        alertView.showAlert( title: LanguageModal.langObj.are_you_sure, message: "\(LanguageModal.langObj.to_mark_member)   \(self.arayMembersModel[indexPath.section].name ?? "")  as \(status)")
               
    }
    
    func alertForDeleteMember(indexPath:IndexPath)  {
            
            DBManagerMemberDetail().fetchMembers_currentalyLeaveinHH(modelSelectedHH: hhModel) { (arayCurrentalyLeaveINHH) in
               
                if arayCurrentalyLeaveINHH.count != 1 {
                    
                    let alertView = AlertView()
                    alertView.delegate = self
                    alertView.showAlert( title: LanguageModal.langObj.are_you_sure, message: "\(English.HouseholdDetail.deleteMember)   \(self.arayMembersModel[indexPath.section].name ?? "") ")
                }
                else{
                    
                    AlertView().showAlertWithSingleButton( title: "", message: English.HouseholdDetail.atLeastOneMemberINHH)
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
        

    }
    
}

