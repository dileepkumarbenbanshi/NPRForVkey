//
//  IncompleteHouseholdViewController.swift
//  NPR Screen
//
//  Created by mac on 06/08/20.
//  Copyright © 2020 mac. All rights reserved.
//

class IncompleteHouseholdViewController: UIViewController {
    @IBOutlet var totalHouseholdsLeftLabel: UILabel!
    @IBOutlet var dobLabel: UILabel!
    @IBOutlet var headLabel: UILabel!
    @IBOutlet var mobileLabel: UILabel!
    @IBOutlet var aadhaarLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    
    
    @IBOutlet weak var incompleteHouseholdTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var labelTotalHouseHold: UILabel!
    @IBOutlet weak var imageViewCircleName: UIImageView!
    @IBOutlet weak var imageViewCicleAadhaar: UIImageView!
    @IBOutlet weak var imageViewCircleMobile: UIImageView!
    @IBOutlet weak var imageViewCircleHead: UIImageView!
    @IBOutlet weak var imageViewCircleDOB: UIImageView!
    var btnSearchType:UIButton?
    @IBOutlet weak var btnAddHH: UIButton!
    @IBOutlet weak var tfSearch: UITextField!
    
    //var arayHouseHoldListModel:[NPR2021MemberDetails] = []
    var skipSelctedHHModel : NPR_2021hh_Details?
    var skipHHSelectedStatus = ""
    var arayMemberDetail:[NPR2021MemberDetails] = []
    var araySearchedMember:[NPR2021MemberDetails] = []
    var arayHHList:[NPR_2021hh_Details] = []
    var arayTotalHHList :[NPR_2021hh_Details] = []
    
    var selectedIndexPath = IndexPath.init(row: -1, section: -1)
    var isSelectedCell = false
    
    
    var tableViewData = [CellData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       viewPrepare()
        
        
    }
    
    
    
    func viewPrepare()  {
        
        //searchBar.setupDonButton_TextFields
        tfSearch.addDoneButton()
        self.incompleteHouseholdTableView.register(UINib(nibName: "IncompleteHouseholdSubCell", bundle: nil), forCellReuseIdentifier:"IncompleteHouseholdSubCell")
        
        totalHouseholdsLeftLabel.text = LanguageModal.langObj.total_households
        nameLabel.text = LanguageModal.langObj.name_of_person
        aadhaarLabel.text = LanguageModal.langObj.aadhaar
        mobileLabel.text = LanguageModal.langObj.mobile
        dobLabel.text = LanguageModal.langObj.dob
        headLabel.text = LanguageModal.langObj.head
        searchBar.placeholder = LanguageModal.langObj.search
        
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        self.getHouseHoldList()
        incompleteHouseholdTableView.keyboardDismissMode = .onDrag
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
       
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
    }
    
    func getHouseHoldList()  {
// memberStatus
        
        let predicateHH = NSPredicate(format: "ebNumber = %@",singleton().selectEBListModel.eb_number!)
        guard let arayTotalHouseHoldINEB = DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicateHH) as? [NPR_2021hh_Details] else {
            return
        }
        
           // self.viewSetUpForInhavited(hhCount: arayTotalHouseHoldINEB.count)
        
        
      let  arayHouseHold =  arayTotalHouseHoldINEB.filter({$0.hh_completed == HHCompletionStatusCode.notStarted || $0.hh_completed == HHCompletionStatusCode.inComplete })
       let sortedHH = arayHouseHold.sorted(by: {$0.houseHoldhNo ?? "0" < $1.houseHoldhNo ?? "1"})
        
        arayTotalHHList = sortedHH
        arayHHList = arayTotalHHList
        
        updateTblList()
    }

    func updateTblList()  {
        selectedIndexPath = IndexPath.init(row: -1, section: -1)
        incompleteHouseholdTableView.reloadData()
        self.labelTotalHouseHold.text = "\(arayHHList.count)"
    }
    
    @IBAction func onTapRadioButtons(_ sender: UIButton) {
        tfSearch.resignFirstResponder()
        tfSearch.text = ""
        btnSearchType = sender
        
        if sender.tag == 101 {
            
            self.handleRadioButtonSelection(tag: sender.tag, placeHoder: "Search using Name", selectedImage: UIImage(named: "ic_circle_fill")!, UnselectedImage: UIImage(named: "ic_circle")!)
            tfSearch.keyboardType = .namePhonePad
            tfSearch.returnKeyType = .default
        }
        if sender.tag == 102 {
            self.handleRadioButtonSelection(tag: sender.tag, placeHoder: "Search using Aadhaar", selectedImage: UIImage(named: "ic_circle_fill")!, UnselectedImage: UIImage(named: "ic_circle")!)
            tfSearch.keyboardType = .phonePad
            tfSearch.returnKeyType = .done
        }
        if sender.tag == 103 {
            self.handleRadioButtonSelection(tag: sender.tag, placeHoder: "Search using Mobile Number", selectedImage: UIImage(named: "ic_circle_fill")!, UnselectedImage: UIImage(named: "ic_circle")!)
            tfSearch.keyboardType = .phonePad
            tfSearch.returnKeyType = .done
        }
        if sender.tag == 104 {
            self.handleRadioButtonSelection(tag: sender.tag, placeHoder: "Search using Head of HH", selectedImage: UIImage(named: "ic_circle_fill")!, UnselectedImage: UIImage(named: "ic_circle")!)
            tfSearch.keyboardType = .namePhonePad
            tfSearch.returnKeyType = .default
        }
        if sender.tag == 105 {
            self.handleRadioButtonSelection(tag: sender.tag, placeHoder: "Search using DOB", selectedImage: UIImage(named: "ic_circle_fill")!, UnselectedImage: UIImage(named: "ic_circle")!)
            tfSearch.keyboardType = .phonePad
            tfSearch.returnKeyType = .done
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
               tfSearch.placeholder = placeHoder
           }
       }
    
    @IBAction func onTapAddHousehold(_ sender: Any) {
       if UnHabitedVM().expHHPopupInInconcompleteHH {
        openExpectedHHPopup()
       }else if UnHabitedVM().isInhavitedAndUploaded{
        AlertView().alertWithoutButton( message: English.IncompleHHOrViewEditPage.cantAddNewHHinThisHLB)
       }
       else {
        
        self.navigateToController(identifier: ClassID.addNewHouseHold, storyBoardName: storyBoardName.npr)
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
//        self.navigateToController(identifier: "HouseholdMemberDetail_ViewController", storyBoardName: "NPR")
        
        let storyBoard = UIStoryboard.init(name: storyBoardName.npr, bundle: nil)
      let objController = storyBoard.instantiateViewController(withIdentifier:"HouseholdMemberDetail_ViewController") as? HouseholdMemberDetail_ViewController
        objController?.arayMembersModel = arayMemberDetail
        objController?.hhModel = arayHHList[selectedIndexPath.section]
       self.navigationController?.pushViewController(objController!, animated: true)
        
    }
    
    
    func fetchedMemberDetailData(modelSelectedHH:NPR_2021hh_Details ,Completion:@escaping(Bool) -> Void )  {
        
        
        DBManagerMemberDetail().fetchedHHMembers(modelSelectedHH: modelSelectedHH) { (arayMemberD) in
            
            self.arayMemberDetail = arayMemberD
            Completion(true)
        }
        }
    
}


extension IncompleteHouseholdViewController:UITableViewDelegate, UITableViewDataSource {
    
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
                if #available(iOS 13.0, *) {
//                    let contentCell = tableView.dequeueReusableCell(withIdentifier: "IncompleteHouseholdTableViewCell") as! IncompleteHouseholdTableViewCell
                    let contentCell = tableView.dequeueReusableCell(withIdentifier: "IncompleteHouseholdTableViewCell", for: indexPath) as! IncompleteHouseholdTableViewCell
                
                contentCell.buttonSkip.tag = indexPath.section
                let dictModel = arayHHList[indexPath.section]
                contentCell.cellSetUP(model: dictModel)
                contentCell.setSkipButton(modelHH: dictModel)
                //contentCell.buttonDropDown.addTarget(self, action: #selector(IncompleteHouseholdViewController.onTapDropDown(_:)), for: .touchUpInside)
                
                contentCell.buttonSkip.addTarget(self, action: #selector(IncompleteHouseholdViewController.onTapSkip(_:)), for: .touchUpInside)
                return contentCell
                } else {
                    // Fallback on earlier versions
                }
             }
             else{
                let contentCell:IncompleteHouseholdSubCell = tableView.dequeueReusableCell(withIdentifier: "IncompleteHouseholdSubCell") as! IncompleteHouseholdSubCell
                
                let modelMember = arayMemberDetail[indexPath.row-1]
                
                contentCell.minHeight = DeviceType.IS_IPAD ? 100 : 40
                   
                let dictModel = arayHHList[indexPath.section]
                
                contentCell.cellSetUP(modelMember: modelMember, hhModel: dictModel)
                
                    contentCell.containerViewBottomConstraint.constant = arayMemberDetail.count == indexPath.row ? 8:0
                   contentCell.buttonArrowHeightConstraint.constant = arayMemberDetail.count == indexPath.row ? 35:0
                   contentCell.buttonArrow.isHidden = arayMemberDetail.count == indexPath.row ? false:true
                   contentCell.buttonArrow.tag = indexPath.section
                   contentCell.buttonInfo.addTarget(self, action: #selector(IncompleteHouseholdViewController.onTapInfo_toolTip(_:)), for: .touchUpInside)
                contentCell.buttonArrow.addTarget(self, action: #selector(IncompleteHouseholdViewController.onTapArrow(_:)), for: .touchUpInside)
                
                 return contentCell
             }
        return UITableViewCell()
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
                
            //    let sections = IndexSet.init(integer: indexPath.section)
//                tableView.reloadSections(sections, with: .automatic)
                
                tableView.reloadData()
                tableView.scrollToRow(at: indexPath, at: .top, animated: false)
                
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

