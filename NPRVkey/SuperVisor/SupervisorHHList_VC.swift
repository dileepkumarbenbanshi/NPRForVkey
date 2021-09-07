//
//  SupervisorHHList_VC.swift
//  NPR-2020
//
//  Created by Dileep on 20/11/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class SupervisorHHList_VC: UIViewController {
    @IBOutlet weak var tblView:UITableView!
   
    
    @IBOutlet weak var lblDistrict: UILabel!
    @IBOutlet weak var labelTotalHouseHold: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblSubDistrict: UILabel!
    @IBOutlet weak var lblWard: UILabel!
    
    @IBOutlet weak var lblTownVillage: UILabel!
    @IBOutlet weak var lblBlock: UILabel!
    @IBOutlet weak var viewHeader: UIView!
   
    
    //var arayHouseHoldListModel:[NPR2021MemberDetails] = []
    var skipSelctedHHModel : NPR_2021hh_Details?
    var skipHHSelectedStatus = ""
    var arayMemberDetail:[NPR2021MemberDetails] = []
    var araySearchedMember:[NPR2021MemberDetails] = []
    var arayHHList:[NPR_2021hh_Details] = []
    var arayTotalHHList :[NPR_2021hh_Details] = []
    
    var selectedIndexPath = IndexPath.init(row: -1, section: 0)
    var isSelectedCell = false
    
    
    var tableViewData = [CellData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       viewPrepare()
        Utils().vKeySetup(enable:false)
//        self.tblView.register(UINib(nibName: "IncompleteHouseholdSubCell", bundle: nil), forCellReuseIdentifier:"SV_HHLIst_TVC")
        
    }
    
    func viewPrepare()  {
        
        viewHeader.layer.borderColor = ProjectColor.colorPrimary.cgColor
        tblView?.keyboardDismissMode = .onDrag
        
        lblTownVillage.text = singleton().selectEBListModel.ebTown_name ?? ""
        lblWard.text = singleton().selectEBListModel.ebWard_code ?? ""
        lblSubDistrict.text = singleton().selectEBListModel.ebTahsil_name ?? ""
        lblDistrict.text = singleton().selectEBListModel.ebDistrict_name ?? ""
        lblState.text = singleton().selectEBListModel.ebState_name ?? ""
        lblBlock.text = singleton().selectEBListModel.eb_block_number ?? ""
        labelTotalHouseHold.text = "Total Household - \(arayHHList.count)"
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.getHouseHoldList()
    }
    
    func getHouseHoldList()  {
// memberStatus
        
        print("EbNumber",singleton().selectEBListModel.eb_number ?? "")
        let predicateHH = NSPredicate(format: "ebNumber = %@",singleton().selectEBListModel.eb_number ?? "")
        guard let arayHouseHold = DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicateHH) as? [NPR_2021hh_Details] else {
            return
        }
        

        arayTotalHHList = arayHouseHold
        arayHHList = arayTotalHHList
        
        updateTblList()
    }

    
    func updateTblList()  {
       
        tblView.reloadData()
        labelTotalHouseHold.text = "Total Household - \(arayHHList.count)"
    }
    
    
    @IBAction func btnUpload_action(_ sender: UIButton) {
        
       
        self.navigateToController(identifier: "UploadDataVC", storyBoardName: storyBoardName.main)
        
    }
    
    @IBAction func btnSwitchHLB_action(_ sender: UIButton) {
        if self.is_VC_inNavigationStcak() {
            self.navigationController?.popViewController(animated: true)
        }else{
            
            self.navigateToController(identifier: "AssignEBViewController", storyBoardName: storyBoardName.main)
        }
        
        
    }
    
    
    
    func fetchedMemberDetailData(modelSelectedHH:NPR_2021hh_Details ,Completion:@escaping(Bool) -> Void )  {
        
        
        DBManagerMemberDetail().fetchedHHMembers(modelSelectedHH: modelSelectedHH) { (arayMemberD) in
            
            self.arayMemberDetail = arayMemberD
            Completion(true)
        }
        }
    
}


extension SupervisorHHList_VC:UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return arayHHList.count
       }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
             return 1
         
        
    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let dataIndex = indexPath.row-1
             if indexPath.row == 0 {
                if #available(iOS 13.0, *) {
                    let contentCell = tableView.dequeueReusableCell(withIdentifier: "SV_HHLIst_TVC") as! IncompleteHouseholdTableViewCell
                
                
                let dictModel = arayHHList[indexPath.section]
                contentCell.cellSetUP(model: dictModel)
                    contentCell.btnRightArrow.tag = indexPath.section
                contentCell.btnRightArrow.addTarget(self, action: #selector(SupervisorHHList_VC.onTapArrow(_:)), for: .touchUpInside)
                
               
                return contentCell
                } else {
                    // Fallback on earlier versions
                }
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
