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
    
    @IBOutlet weak var lblTitle: UILabel!
    
    
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
         

        if araySplitedMembers.count > 0 {
        
        DBManagerMemberDetail().fetchedHHMembers(modelSelectedHH: hhModel) { (arayHHMembers) in
            //self.arayMemberModel = arayHHMembers
            self.arayMemberModel = arayHHMembers.filter({$0.memberStatus == MemberStatusCode.notStarted || $0.memberStatus == MemberStatusCode.available
                })
            }
            
        }
        
        DBManagerMemberDetail().fetchMembers_currentalyLeaveinHH(modelSelectedHH: hhModel) { (arayHHMembers)  in
             
            self.arayMemberModel = arayHHMembers.filter({$0.memberStatus != MemberStatusCode.newMember
            })
            self.viewPrepare()
        }
    }
    
    func viewPrepare()  {
        
        totalMember = arayMemberModel.count
        lblTotalMembers.text = "\(LanguageModal.langObj.total_members) \(arayMemberModel.count )"
        lblBlockNo.text = "\(LanguageModal.langObj.block_no) \(arayMemberModel[0].block_no ?? "")"
        lblHouseHoldNo.text = "\(LanguageModal.langObj.hh_no) \(arayMemberModel[0].hh_Number?.hhNumber() ?? "")"

        lblNewHouseHoldNumber.text = "\(LanguageModal.langObj.selected_member_move_in_new_household).- \(strNewHH)"
        tblView.reloadData()
        memberSelected = 0
        araySplitedMembers.removeAll()
        remainMemberUpdate()
        
        btnNext.setTitle(LanguageModal.langObj.next, for: .normal)
        lblSelectedMembers.text = LanguageModal.langObj.selected_members_are + "\(araySplitedMembers.count)"
        lblBackTitle.text = LanguageModal.langObj.hh_summary
        lblTitle.text = LanguageModal.langObj.split
        
    }
   
 
     @IBAction func btnNext_action(_ sender: UIButton) {
        if araySplitedMembers.count > 0 {
            
        
        self.createNewHouseHold { (saved) in
            print("saved member in Splited new HH")
            self.updateHHAfterSplit { (updated) in
                print("saved member After HH")
                self.featchHHMembers()
                
                let alertView = AlertView()
               if self.arayMemberModel.count == 1 {
                alertView.delegate = self
                alertView.showAlertWithSingleButton( title:"", message: LanguageModal.langObj.one_member_should_be_available_to_split)
                }
               else{
                alertView.delegate = self
                
                alertView.showAlert( title: "", message: LanguageModal.langObj.spliting_completed)
               }
                }
        }
        }else{
            AlertView().alertWithoutButton( message: LanguageModal.langObj.select_any_member_to_split, time: 3.0)
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
        
        
        var name = ""
        
        if hhModel.language?.IsSelectedLangauge_nonEnglish ?? false {
           name = ((modelMember.nameSL?.count != 0 && modelMember.nameSL != nil ) ? modelMember.nameSL ?? "" : modelMember.name) ?? ""
        }else{
            name = ((modelMember.name?.count != 0) ? modelMember.name ?? "" : modelMember.nameSL) ?? ""
        }
       
        
        cell.lblMemberName.text = name
        let gender = gender.init(rawValue: Int (modelMember.gender_id ?? "0") ?? 0) ?? .male
        
        
        cell.lblRelation.text = modelMember.rel_code?.getName_by_ID(aray: English().getRelationShipAray(gender: gender))
        
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
            AlertView().alertWithoutButton( message: English.SplitView().atleastOneMemberLeftInsameHH)
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
        lblRemainingMember.text = "\(LanguageModal.langObj.remaning_members)  \(totalMember - memberSelected)"
        
        lblSelectedMembers.text = "\(LanguageModal.langObj.selected_members_are) \(memberSelected)"
        
    }
}
