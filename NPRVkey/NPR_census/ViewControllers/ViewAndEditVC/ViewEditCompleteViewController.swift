//
//  ViewEditCompleteViewController.swift
//  NPR Screen
//
//  Created by mac on 11/08/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class ViewEditCompleteViewController: UIViewController {
    @IBOutlet var totalHouseholdsLeftLabel: UILabel!
    @IBOutlet var dobLabel: UILabel!
    @IBOutlet var headLabel: UILabel!
    @IBOutlet var mobileLabel: UILabel!
    @IBOutlet var aadhaarLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var lblPrevViewName: UILabel!
    @IBOutlet var lblBellowMessage: UILabel!
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var dataTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var labelTotalHouseHold: UILabel!
    @IBOutlet weak var imageViewCircleName: UIImageView!
    @IBOutlet weak var imageViewCicleAadhaar: UIImageView!
    @IBOutlet weak var imageViewCircleMobile: UIImageView!
    @IBOutlet weak var imageViewCircleHead: UIImageView!
    @IBOutlet weak var imageViewCircleDOB: UIImageView!
    var btnSearchType : UIButton?
    
    @IBOutlet weak var tfSearch: UITextField!
    var tableViewData = [CellData]()
    //var arayHouseHoldListModel:[NPR2021MemberDetails] = []
    var arayMemberDetail:[NPR2021MemberDetails] = []
   // var arayHouseHoldList :[NPR_2021hh_Details] = []
    
    var selectedIndexPath = IndexPath.init(row: -1, section: 0)
    var isSelectedCell = false
    var araySearchedMember:[NPR2021MemberDetails] = []
    var arayHHList:[NPR_2021hh_Details] = []
    var arayTotalHHList :[NPR_2021hh_Details] = []
    var skipSelctedHHModel : NPR_2021hh_Details?
    var skipHHSelectedStatus = ""
    var alertType = AlertType.skip
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        dataTableView.keyboardDismissMode = .onDrag
        selectedIndexPath = IndexPath.init(row: -1, section: 0)
        isSelectedCell = false
        viewPrepare()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    func viewPrepare()  {
        
        self.dataTableView.register(UINib(nibName: "IncompleteHouseholdSubCell", bundle: nil), forCellReuseIdentifier:"IncompleteHouseholdSubCell")
        getHouseHoldList()
        setTitle()
        
        lblBellowMessage.text = LanguageModal.langObj.view_edit_not_uploaded_message
        lblTitle.text = LanguageModal.langObj.search_edit
        totalHouseholdsLeftLabel.text = LanguageModal.langObj.total_households
        nameLabel.text = LanguageModal.langObj.name_of_person
        aadhaarLabel.text = LanguageModal.langObj.aadhaar
        mobileLabel.text = LanguageModal.langObj.mobile
        dobLabel.text = LanguageModal.langObj.dob
        headLabel.text = LanguageModal.langObj.head
        searchBar.placeholder = LanguageModal.langObj.search
    }
    func setTitle()  {
        guard let viewControllers = self.navigationController?.viewControllers else{
            return
        }
        
        for vc in viewControllers {
            if let vcMain  = vc as? MainViewController{
               
                if vcMain.isSelectedInCompleteHH ?? false  {
                    lblPrevViewName.text = LanguageModal.langObj.hh_summary//classTitle.incompleteTitle
                }else{
                    lblPrevViewName.text = LanguageModal.langObj.location_particular//classTitle.locationParticular
                }
            }
        }
       
        tfSearch.addDoneButton()
    }
    
    @IBAction func onTapBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func getHouseHoldList()  {
// memberStatus
        
        
        let predicateHH = NSPredicate(format: "ebNumber = %@",singleton().selectEBListModel.eb_number!)
        guard let arayTotalHouseHoldINEB = DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicateHH) as? [NPR_2021hh_Details] else {
            return
        }
        
      let  arayHouseHold =  arayTotalHouseHoldINEB.filter({$0.hh_completed == HHCompletionStatusCode.completed || $0.hh_completed == HHCompletionStatusCode.uploaded })
       let sortedHH = arayHouseHold.sorted(by: {$0.houseHoldhNo ?? "0" < $1.houseHoldhNo ?? "1"})
        
        arayTotalHHList = sortedHH
        isSelectedCell = false
        arayHHList = arayTotalHHList
        self.labelTotalHouseHold.text = "\(self.arayHHList.count)"
        updateTblList()
   
    }

    @objc func onTapDropDown(_ sender: UIButton){
        
          let buttonPosition = sender.convert(CGPoint.zero, to: self.dataTableView)
          let indexPath = self.dataTableView.indexPathForRow(at: buttonPosition)!
          if indexPath.row == 0 {
                     if tableViewData[indexPath.section].opened == true {
                         tableViewData[indexPath.section].opened = false
                         let sections = IndexSet.init(integer: indexPath.section)
                         self.dataTableView.reloadSections(sections, with: .none)
                     }
                     else{
                         tableViewData[indexPath.section].opened = true
                         let Sections = IndexSet.init(integer: indexPath.section)
                         self.dataTableView.reloadSections(Sections, with: .none)
                     }
                 }
      }
    
    
      @IBAction func onTapRadioButtons(_ sender: UIButton) {
        tfSearch.resignFirstResponder()
        tfSearch.text = ""
        btnSearchType = sender
        
        
        
        if sender.tag == 101 {
            
            self.handleRadioButtonSelection(tag: sender.tag, placeHoder: "Search using Name", selectedImage: UIImage(named: "ic_circle_fill")!, UnselectedImage: UIImage(named: "ic_circle")!)
            tfSearch.keyboardType = .namePhonePad
        }
        if sender.tag == 102 {
            self.handleRadioButtonSelection(tag: sender.tag, placeHoder: "Search using Aadhaar", selectedImage: UIImage(named: "ic_circle_fill")!, UnselectedImage: UIImage(named: "ic_circle")!)
            tfSearch.keyboardType = .phonePad
        }
        if sender.tag == 103 {
            self.handleRadioButtonSelection(tag: sender.tag, placeHoder: "Search using Mobile Number", selectedImage: UIImage(named: "ic_circle_fill")!, UnselectedImage: UIImage(named: "ic_circle")!)
            tfSearch.keyboardType = .phonePad
        }
        if sender.tag == 104 {
            self.handleRadioButtonSelection(tag: sender.tag, placeHoder: "Search using Head of HH", selectedImage: UIImage(named: "ic_circle_fill")!, UnselectedImage: UIImage(named: "ic_circle")!)
            tfSearch.keyboardType = .namePhonePad
        }
        if sender.tag == 105 {
            self.handleRadioButtonSelection(tag: sender.tag, placeHoder: "Search using DOB", selectedImage: UIImage(named: "ic_circle_fill")!, UnselectedImage: UIImage(named: "ic_circle")!)
            tfSearch.keyboardType = .phonePad
        }
        tfSearch.becomeFirstResponder()
     }
    
    func handleRadioButtonSelection(tag:Int, placeHoder:String, selectedImage:UIImage, UnselectedImage:UIImage){
        if tag == 101 {
            self.imageViewCircleName.image = selectedImage
            self.imageViewCicleAadhaar.image = UnselectedImage
            self.imageViewCircleMobile.image = UnselectedImage
            self.imageViewCircleHead.image = UnselectedImage
            self.imageViewCircleDOB.image = UnselectedImage
            self.tfSearch.placeholder = placeHoder
        }
        if tag == 102 {
            self.imageViewCircleName.image = UnselectedImage
            self.imageViewCicleAadhaar.image = selectedImage
            self.imageViewCircleMobile.image = UnselectedImage
            self.imageViewCircleHead.image = UnselectedImage
            self.imageViewCircleDOB.image = UnselectedImage
            self.tfSearch.placeholder = placeHoder
        }
        if tag == 103 {
            self.imageViewCircleName.image = UnselectedImage
            self.imageViewCicleAadhaar.image = UnselectedImage
            self.imageViewCircleMobile.image = selectedImage
            self.imageViewCircleHead.image = UnselectedImage
            self.imageViewCircleDOB.image = UnselectedImage
            self.tfSearch.placeholder = placeHoder
        }
        if tag == 104 {
            self.imageViewCircleName.image = UnselectedImage
            self.imageViewCicleAadhaar.image = UnselectedImage
            self.imageViewCircleMobile.image = UnselectedImage
            self.imageViewCircleHead.image = selectedImage
            self.imageViewCircleDOB.image = UnselectedImage
            self.tfSearch.placeholder = placeHoder
        }
        if tag == 105 {
            self.imageViewCircleName.image = UnselectedImage
            self.imageViewCicleAadhaar.image = UnselectedImage
            self.imageViewCircleMobile.image = UnselectedImage
            self.imageViewCircleHead.image = UnselectedImage
            self.imageViewCircleDOB.image = selectedImage
            self.tfSearch.placeholder = placeHoder
        }
    }
 
    @IBAction func onTapRefresh(_ sender: Any) {
        
        let searchType = Utils.searchType.init(rawValue: btnSearchType?.tag ?? 0)
        btnSearchType = UIButton()
        
        switch searchType {
        case .head:
            imageViewCircleHead.image = UIImage.init(named: "ic_circle")
            
            break
        case .name:
            imageViewCircleName.image = UIImage.init(named: "ic_circle")
            break
            
        case .aadhar:
            imageViewCicleAadhaar.image = UIImage.init(named: "ic_circle")
            break
        case .mobile:
            imageViewCircleMobile.image = UIImage.init(named: "ic_circle")
            break
        
        case .dob:
            imageViewCircleDOB.image = UIImage.init(named: "ic_circle")
            break
            
        case .none:
            
            
            return
        }
        
        tfSearch.placeholder = "Search"
        arayHHList = arayTotalHHList
        btnSearchType?.isSelected = false
        tfSearch.text = ""
        searchBar.resignFirstResponder()
        updateTblList()
        
    }
    @objc func onTapArrow(_ sender: UIButton){
          //self.navigateToController(identifier: "HouseholdMemberDetail_ViewController", storyBoardName: "NPR")
        
        let buttonPosition = sender.convert(CGPoint.zero, to: self.dataTableView)
        let indexPath = self.dataTableView.indexPathForRow(at: buttonPosition)!
        
        let objStoryBoard:UIStoryboard = UIStoryboard.init(name: "NPR", bundle: nil)
        
        guard let vc = objStoryBoard.instantiateViewController(identifier:ClassID.hhMemberDetail ) as? HouseholdMemberDetail_ViewController else {
            return
        }
        vc.arayMembersModel = arayMemberDetail
        vc.hhModel = arayHHList[indexPath.section]
        vc.isCameFromEditPage = true
        self.navigationController?.pushViewController(vc, animated: true)
        
      }
    
    func fetchedMemberDetailData(modelSelectedHH:NPR_2021hh_Details ,Completion:@escaping(Bool) -> Void )  {
        
        
        DBManagerMemberDetail().fetchedHHMembers(modelSelectedHH: modelSelectedHH) { (arayMemberD) in
            
            self.arayMemberDetail = arayMemberD
            Completion(true)
        }
        }
        
        
    
    
}

@available(iOS 13.0, *)
extension ViewEditCompleteViewController:UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arayHHList.count
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSelectedCell &&  selectedIndexPath.section == section {
             return arayMemberDetail.count+1
         }else {
             return 1
         }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let dataIndex = indexPath.row-1
             if indexPath.row == 0 {
                let contentCell:IncompleteHouseholdTableViewCell = tableView.dequeueReusableCell(withIdentifier: "IncompleteHouseholdTableViewCell") as! IncompleteHouseholdTableViewCell
                contentCell.buttonSkip.tag = indexPath.section
                contentCell.btnDelete.tag = indexPath.section
                let dictModel = arayHHList[indexPath.section]
                contentCell.cellSetUP(model: dictModel)
               
                //contentCell.buttonDropDown.addTarget(self, action: #selector(IncompleteHouseholdViewController.onTapDropDown(_:)), for: .touchUpInside)
                contentCell.buttonSkip.addTarget(self, action: #selector(ViewEditCompleteViewController.onTapSkip(_:)), for: .touchUpInside)
                
                contentCell.btnDelete.addTarget(self, action: #selector(ViewEditCompleteViewController.onTapDeleteHH(_:)), for: .touchUpInside)
                
                return contentCell
             }
             else{
                guard  let contentCell:IncompleteHouseholdSubCell = tableView.dequeueReusableCell(withIdentifier: "IncompleteHouseholdSubCell") as? IncompleteHouseholdSubCell else {
                    return UITableViewCell()
                }
                
                let modelMember = arayMemberDetail[indexPath.row-1]
                
                
                let dictModel = arayHHList[indexPath.section]
                contentCell.cellSetUP(modelMember: modelMember, hhModel: dictModel)
                
                    contentCell.containerViewBottomConstraint.constant = arayMemberDetail.count == indexPath.row ? 8:0
                   contentCell.buttonArrowHeightConstraint.constant = arayMemberDetail.count == indexPath.row ? 35:0
                   contentCell.buttonArrow.isHidden = arayMemberDetail.count == indexPath.row ? false:true
                   contentCell.buttonArrow.addTarget(self, action: #selector(IncompleteHouseholdViewController.onTapArrow(_:)), for: .touchUpInside)
                contentCell.buttonInfo.addTarget(self, action: #selector(ViewEditCompleteViewController.onTapInfo_toolTip(_:)), for: .touchUpInside)
                
                 return contentCell
             }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        if selectedIndexPath == indexPath && (isSelectedCell && indexPath.row == 0){
            isSelectedCell = false
            selectedIndexPath = indexPath
            tableView.reloadData()
        }
        
        else if indexPath.row == 0{
            
           
            selectedIndexPath = indexPath
            isSelectedCell = true
            fetchedMemberDetailData(modelSelectedHH: arayHHList[indexPath.section]) { (isFetched) in
                
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadData()
                tableView.reloadSections(sections, with: .automatic)
                
            }
           
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension//DeviceType.IS_IPAD ? 220 : 110 //UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
