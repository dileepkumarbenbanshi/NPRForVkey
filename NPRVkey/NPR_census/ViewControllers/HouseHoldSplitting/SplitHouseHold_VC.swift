//
//  SplitHouseHold_VC.swift
//  NPR_census
//
//  Created by Dileep on 17/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class SplitHouseHold_VC: UIViewController {
    @IBOutlet weak var lblSelectedMembers: UILabel!
    @IBOutlet weak var lblHouseHoldNo: UILabel!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lblRemainingMember: UILabel!
    @IBOutlet weak var lblBlockNo: UILabel!
    @IBOutlet weak var lblTotalMembers: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var lblNewHouseHoldNumber: UILabel!
    var totalMember = 5
    var memberSelected = 0
    var arayMemberModel = [NPR2021MemberDetails]()
    var arayHHMembers = [NPR2021MemberDetails]()
    var hhModel = NPR_2021hh_Details()
    var araySplitedMembers = [NPR2021MemberDetails] ()
    var strNewHH = ""
    var hhComplitionStaus = ""
    
    var strNewHouseNumber = ""
    
    
    
    @IBOutlet weak var lblBackTitle: UILabel!
    @IBOutlet weak var btnTitle: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        featchHHMembers()
    }
    override func viewDidAppear(_ animated: Bool) {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
    }
    
    func featchHHMembers() {
        
       strNewHouseNumber = DBManagerHousehold().getNewHouseNumber()
        strNewHH = DBManagerHousehold().getNewHouseHoldNumber()
        
        DBManagerMemberDetail().fetchOldMembers_currentalyLiveinHH(modelSelectedHH: hhModel) { (arayOldMemberLiveInHH) in
         
            self.arayMemberModel = arayOldMemberLiveInHH
            self.viewPrepare()
        }
        
//        DBManagerMemberDetail().fetchedHHMembers(modelSelectedHH: hhModel) { (arayHHMembers) in
//            //self.arayMemberModel = arayHHMembers
//            self.arayMemberModel = arayHHMembers.filter({$0.memberStatus == MemberStatusCode.notStarted || $0.memberStatus == MemberStatusCode.available || $0.memberStatus == MemberStatusCode.newMember})
//            
//        }
    }
    
    func viewPrepare()  {
        
        totalMember = arayMemberModel.count
        lblTotalMembers.text = "Total Member - \(arayMemberModel.count )"
        lblBlockNo.text = "Block No. - \(arayMemberModel[0].block_no ?? "")"
        lblHouseHoldNo.text = "Household No. - \(arayMemberModel[0].hh_Number ?? "")"

        lblNewHouseHoldNumber.text = "Selected members will move to new household No.- \(strNewHH)"
        tblView.reloadData()
        memberSelected = 0
        araySplitedMembers.removeAll()
        remainMemberUpdate()
        
    }
   
 
     @IBAction func btnNext_action(_ sender: UIButton) {
        
        self.createNewHouseHold { (saved) in
            print("saved member in Splited new HH")
            self.updateHHAfterSplit { (updated) in
                print("saved member After HH")
                self.featchHHMembers()
                
                let alertView = AlertView()
               if self.arayMemberModel.count == 1 {
                alertView.delegate = self
                alertView.showAlertWithSingleButton(vc: self, title: English.SplitView().atleastOneMemberLeftInsameHH, message: English.SplitView.splitDoneTittle)
                }
               else{
                
                
                
                alertView.delegate = self
                
                alertView.showAlert(vc: self, title: "", message: English.SplitView.slitDoneAlert)
               }
                
                
            }
        }
     }
    

    @IBAction func btnChangeLangauge_action(_ sender: UIButton) {
        
    }
    @IBAction func btnBack_action(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
}


extension SplitHouseHold_VC:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arayMemberModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell:SplitHouseHold_TVC = tableView.dequeueReusableCell(withIdentifier: CellIdentifier.splitHouseHold, for: indexPath) as! SplitHouseHold_TVC
        let modelMember = arayMemberModel[indexPath.row]
        cell.btnCheck.tag = indexPath.row
        cell.btnCheck.addTarget(self, action: #selector(SplitHouseHold_VC.onTapCheckButton(_:)), for: .touchUpInside)
        cell.lblOrderNo.text = "\(indexPath.row+1)"
        cell.lblMemberName.text = modelMember.name ?? ""
        cell.lblRelation.text = modelMember.relName ?? ""
        
        /// Check Member selected or not 
        let memberAlreadySelected = araySplitedMembers.filter() { $0 == arayMemberModel[indexPath.row] }
        
        if memberAlreadySelected.count > 0 {
            cell.btnCheck.isSelected = true
        } else {
            cell.btnCheck.isSelected = false
        }
        return cell
    }
    
    
    
    
}



extension SplitHouseHold_VC {
    
  
    @objc func onTapCheckButton(_ sender: UIButton){
        if arayMemberModel.count == 1 {
            AlertView().alertWithoutButton(vc: self, message: English.SplitView().atleastOneMemberLeftInsameHH)
            return
        }
        
        if sender.isSelected {
            if  memberSelected > 0 {
                memberSelected = memberSelected - 1
                
                araySplitedMembers = araySplitedMembers.filter() { $0 != arayMemberModel[sender.tag] }
            }
            
        }else{
            if araySplitedMembers.count == arayMemberModel.count-1
            {
             return
            }
            memberSelected = memberSelected + 1
            araySplitedMembers.append(arayMemberModel[sender.tag])
        }
        remainMemberUpdate()
        sender.isSelected = !sender.isSelected
        
       
        
    }
    
    func remainMemberUpdate()  {
        
        if arayMemberModel.count <= 1 {
            btnNext.isUserInteractionEnabled = false
        }else{
            btnNext.isUserInteractionEnabled = true
        }
        lblRemainingMember.text = " Remaining Member : \(totalMember - memberSelected)"
        
        lblSelectedMembers.text = "Selected Member : \(memberSelected)"
        
    }
}
