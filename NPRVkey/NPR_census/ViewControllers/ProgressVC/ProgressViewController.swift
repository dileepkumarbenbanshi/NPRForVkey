//
//  ProgressViewController.swift
//  NPR Screen
//
//  Created by mac on 07/08/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {
//Title Outlet
    @IBOutlet weak var lblPrevPageName: UILabel!
    @IBOutlet weak var lblTotalAsignHlb_title: UILabel!
    @IBOutlet weak var lblTotalUploadedHlb_title: UILabel!
    @IBOutlet weak var lblTotalPendingHlb_title: UILabel!
    @IBOutlet weak var lblEnumStatus_title: UILabel!
    //
    @IBOutlet weak var lblCurentHlbStatus_title: UILabel!
    
    @IBOutlet weak var lblCurentHlbNumber_title: UILabel!
   
    @IBOutlet weak var lblHHStatus_title: UILabel!
    
    //Oroginal HH
    @IBOutlet weak var lblOroginalHH_title: UILabel!
    @IBOutlet weak var lblTotalOriginalHH_title: UILabel!
    @IBOutlet weak var lblTotalHH_title: UILabel!
    @IBOutlet weak var lblAvailableHH_title: UILabel!
    @IBOutlet weak var lblMovedHH_title: UILabel!
    @IBOutlet weak var lblLockedHH_title: UILabel!
    @IBOutlet weak var lblNotAvailableHH_title: UILabel!
    // New HH
    @IBOutlet weak var lblTotalNewHHHeading_title: UILabel!
    @IBOutlet weak var lblTotalNewHH_title: UILabel!
    @IBOutlet weak var lblTotalNewOldHH_title: UILabel!
    @IBOutlet weak var lblTotalUpdatedHH_title: UILabel!
    @IBOutlet weak var lblTotalPendingHH_title: UILabel!
    
    
    //Member Status
    
    @IBOutlet weak var lblMemberStatus_title: UILabel!
    @IBOutlet weak var lblOriginalMember_title: UILabel!
    @IBOutlet weak var lblAvailableMember_title: UILabel!
    @IBOutlet weak var lblDiedMember_title: UILabel!
    @IBOutlet weak var lblMovedMember_title: UILabel!
    @IBOutlet weak var lblNewMember_title: UILabel!
    @IBOutlet weak var lblUpdatedMember_title: UILabel!
    @IBOutlet weak var lblOldNewMember_title: UILabel!
    
    // Member yet to be uploaded
    
    @IBOutlet weak var lblMemberYetToUploaded_title: UILabel!
    @IBOutlet weak var lblMemberWithPassport_title: UILabel!
    @IBOutlet weak var lblMemberWithAadhar_title: UILabel!
    @IBOutlet weak var lblMemberWithMobile_title: UILabel!
    @IBOutlet weak var lblMemberWithVoterID_title: UILabel!
    @IBOutlet weak var lblMemberWithDL_title: UILabel!
    
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var houseHoldStatusContainerViewPrimary: UIView!
    @IBOutlet weak var houseHoldStatusContainerViewSecondary: UIView!
    @IBOutlet weak var labelTotalHLBAssigned: UILabel!
    @IBOutlet weak var labelTotalUploadHLB: UILabel!
    @IBOutlet weak var labelTotalPendingHLB: UILabel!
    @IBOutlet weak var labelHLBNumber: UILabel!
    @IBOutlet weak var labelTotalHousehold: UILabel!
    @IBOutlet weak var labelTotalOriginalHosehold: UILabel!
    @IBOutlet weak var labelTotalNewHousehold: UILabel!
    @IBOutlet weak var labelTotalOriginalHouseholds: UILabel!
    @IBOutlet weak var labelTotalAvailableHousehold: UILabel!
    @IBOutlet weak var labelTotalMovedHousehold: UILabel!
    @IBOutlet weak var labelTotalLockedHouseholds: UILabel!
    @IBOutlet weak var labelTotalNotAvailableHouseholds: UILabel!
    @IBOutlet weak var labelTotalNewHouseholds: UILabel!
    @IBOutlet weak var labelTotalHouseholdsOriginalAndNew: UILabel!
    @IBOutlet weak var labelTotalUpdatedHouseholds: UILabel!
    @IBOutlet weak var labelPendingHouseholds: UILabel!
    @IBOutlet weak var labelTotalOriginalMembers: UILabel!
    @IBOutlet weak var labelAvailableMembers: UILabel!
    @IBOutlet weak var labelDiedMembers: UILabel!
    @IBOutlet weak var labelMovedOutMembers: UILabel!
    @IBOutlet weak var labelTotalNewMembers: UILabel!
    @IBOutlet weak var labelTotalUpdatedMembers: UILabel!
    @IBOutlet weak var labelTotalMembersOriginalAndNew: UILabel!
    @IBOutlet weak var labelMemberYetToUpdate: UILabel!
    @IBOutlet weak var labelMembersWithIndianPassport: UILabel!
    @IBOutlet weak var labelMembersWithAadhaar: UILabel!
    @IBOutlet weak var labelMembersWithMobileNo: UILabel!
    @IBOutlet weak var labelMembersWithVoterID: UILabel!
    @IBOutlet weak var labelMembersWithDrivingLicense: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.layoutIfNeeded()
        self.customize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
    }
    func customize(){
       // self.setStatusBarColor()
        self.containerView.cornerRadiusV = 5
        self.houseHoldStatusContainerViewPrimary.roundCorners([.bottomLeft,.topLeft], radius:5)
        self.houseHoldStatusContainerViewSecondary.roundCorners([.bottomRight,.topRight], radius:5)
        self.fillData()
        setTitle()
        setTagLabel()
    }
    
    func setTitle()  {
        guard let viewControllers = self.navigationController?.viewControllers else{
            return
        }
        
        for vc in viewControllers {
            if let vcMain  = vc as? MainViewController{
               
                if vcMain.isSelectedInCompleteHH ?? false  {
                    lblPrevPageName.text = LanguageModal.langObj.hh_summary
                }else{
                    lblPrevPageName.text = LanguageModal.langObj.location_particular
                }
            }
        }
        
        lblTitle.text = LanguageModal.langObj.progress
        
    }
    override var preferredStatusBarStyle : UIStatusBarStyle {
         return UIStatusBarStyle.lightContent
     }
    
    @IBAction func onTapBack(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
     }
    
    func fillData(){
        //------------------- EB Status --------------//
        self.labelTotalHLBAssigned.text = "\(self.getTotalHLBAssigend())"
        self.labelTotalUploadHLB.text = "\(self.getTotalUploadedHLB())"
        self.labelTotalPendingHLB.text = "\(self.getTotalPendingHLB())"
        
        //------------ Household Status -------------//
        self.labelHLBNumber.text = self.getCurrentHLBNumber()
        self.labelTotalHousehold.text = "\(self.getTotalOriginalHouseHold() + self.getTotalNewHousHold())"
        self.labelTotalOriginalHosehold.text = "\(self.getTotalOriginalHouseHold())"
        self.labelTotalNewHousehold.text = "\(self.getTotalNewHousHold())"
        self.labelTotalOriginalHouseholds.text = "\(self.getTotalOriginalHouseHold())"
        self.labelTotalAvailableHousehold.text = "\(self.getTotalAvailableHouseHold())"
        self.labelTotalMovedHousehold.text = "\(self.getTotalMovedHouseHold())"
        self.labelTotalLockedHouseholds.text = "\(self.getTotalLockedHouseHold())"
        self.labelTotalNotAvailableHouseholds.text = "\(self.getTotalNotAvailableHouseHold())"
        self.labelTotalNewHouseholds.text = "\(self.getTotalNewHousHold())"
        self.labelTotalHouseholdsOriginalAndNew.text = "\(self.getTotalOriginalHouseHold() + self.getTotalNewHousHold())"
        self.labelTotalUpdatedHouseholds.text = "\(self.getTotalUpdateHouseHold())"
        self.labelPendingHouseholds.text = "\(self.getTotalPendingHouseHold())"
        
        //--------------- Member Status -----------//
        self.labelTotalOriginalMembers.text = "\(self.getTotalOriginalMember())"
        self.labelAvailableMembers.text = "\(self.getAvailableMember())"
        self.labelDiedMembers.text = "\(self.getDiedMember())"
        self.labelMovedOutMembers.text = "\(self.getMovedOutMember())"
        self.labelTotalNewMembers.text = "\(self.getTotalNewMember())"
        self.labelTotalUpdatedMembers.text = "\(self.getTotalUpdatedMember())"
        self.labelTotalMembersOriginalAndNew.text = "\(self.getTotalOriginalMember() + self.getTotalNewMember())"
        
        //--------------  Members yet to be updated ----//
        self.labelMemberYetToUpdate.text = "\(self.getMembersYetToUpdate())"
        self.labelMembersWithIndianPassport.text = "\(self.getMembersWithPassport())"
        self.labelMembersWithAadhaar.text = "\(self.getMembersWithAadhaar())"
        self.labelMembersWithMobileNo.text = "\(self.getMembersWithMobile())"
        self.labelMembersWithVoterID.text = "\(self.getOldMembersWithVoterID() + self.getNewTotalMembersWithVoterID())"
        self.labelMembersWithDrivingLicense.text = "\(self.getOldMembersWithDL() + self.getNewTotalMembersWithDL())"
      }
    
    func getTotalHLBAssigend()-> Int{
        var totalAssignedHLB = 0
        if let data = DataBaseManager().fetchDBData(entityName: EntityName.eb) as? [EB] {
            totalAssignedHLB = data.count
            return totalAssignedHLB
        }
        return totalAssignedHLB
    }
    
    func getTotalUploadedHLB()-> Int{
         var totaluploadHLB = 0
        
         let predicate = NSPredicate(format: "is_eb_uploaded = %d",true)
         if let data = DataBaseManager().fetchDBData(entityName: EntityName.eb, predicate: predicate) as? [EB] {
             totaluploadHLB = data.count
             return totaluploadHLB
         }
         return totaluploadHLB
     }
    
    func getTotalPendingHLB()-> Int{
         var totalPendingHLB = 0
        
         totalPendingHLB = getTotalHLBAssigend() - getTotalUploadedHLB()
       
        
         return totalPendingHLB
     }
    
    func getTotalNewHousHold()-> Int{
        var totalNewHouseHold = 0
        let predicate = NSPredicate(format: "ebNumber = %@ AND hh_status = %@" , singleton().selectEBListModel.eb_number ?? "",  HHStatusCode.new)
        
            if let data = DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicate) as? [NPR_2021hh_Details]{
              totalNewHouseHold = data.count
              return totalNewHouseHold
        }
        return totalNewHouseHold
    }
    
    func getTotalOriginalHouseHold()-> Int{
        var totalOriginalHouseHold = 0
        //let predicate = NSPredicate(format: "relName = %@","HEAD" )
        let predicate = NSPredicate(format: "ebNumber = %@ AND hh_status != %@", singleton().selectEBListModel.eb_number ?? "" , HHStatusCode.new)
        
        if let data = DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicate) as? [NPR_2021hh_Details] {
            totalOriginalHouseHold = data.count
            return totalOriginalHouseHold
        }
         return totalOriginalHouseHold
    }

    func getCurrentHLBNumber()-> String{
        
        
       return singleton().selectEBListModel.eb_block_number!
       
        
    }
    
    func getTotalUpdateHouseHold()-> Int {
        var totalUpdatedHouseHold = 0
        totalUpdatedHouseHold = getTotalAvailableHouseHold() + getTotalLockedHouseHold() + getTotalMovedHouseHold() + getTotalNotAvailableHouseHold()
        
        return totalUpdatedHouseHold
    }
    
    func getTotalPendingHouseHold()-> Int {
         var totalPendingHouseHold = 0
        let predicate = NSPredicate(format: "ebNumber = %@ AND hh_status = %@", singleton().selectEBListModel.eb_number ?? "" , HHCompletionStatusCode.notStarted)
        //let predicate = NSPredicate(format: "hh_completed = %@",HHCompletionStatusCode.notStarted)
            if let data = DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicate) as? [NPR_2021hh_Details]{
                totalPendingHouseHold = data.count
                return totalPendingHouseHold
              }
         return totalPendingHouseHold
     }
    
    func getTotalAvailableHouseHold()-> Int {
        var totalAvailableHouseHold = 0
        let predicate = NSPredicate(format: "ebNumber = %@ AND hh_status = %@", singleton().selectEBListModel.eb_number ?? "" , HHStatusCode.available)
           if let data = DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicate) as? [NPR_2021hh_Details]{
               totalAvailableHouseHold = data.count
               return totalAvailableHouseHold
             }
        return totalAvailableHouseHold
    }
    
    func getTotalMovedHouseHold()-> Int {
        var totalMovedHouseHold = 0
        let predicate = NSPredicate(format: "ebNumber = %@ AND hh_status = %@", singleton().selectEBListModel.eb_number ?? "" , HHStatusCode.migratedOut)
        
           if let data = DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicate) as? [NPR_2021hh_Details]{
               totalMovedHouseHold = data.count
               return totalMovedHouseHold
             }
        return totalMovedHouseHold
    }
    
    
    func getTotalLockedHouseHold()-> Int {
        var totalLockedHouseHold = 0
        
        let predicate = NSPredicate(format: "ebNumber = %@ AND hh_status = %@", singleton().selectEBListModel.eb_number ?? "" , HHStatusCode.locked)
           if let data = DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicate) as? [NPR_2021hh_Details]{
               totalLockedHouseHold = data.count
               return totalLockedHouseHold
             }
        return totalLockedHouseHold
    }
    
    func getTotalNotAvailableHouseHold()-> Int {
          var totalNotAvailableHouseHold = 0
          
        let predicate = NSPredicate(format: "ebNumber = %@ AND hh_status = %@", singleton().selectEBListModel.eb_number ?? "" , HHStatusCode.notAvailable)
             if let data = DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicate) as? [NPR_2021hh_Details]{
                 totalNotAvailableHouseHold = data.count
                 return totalNotAvailableHouseHold
               }
          return totalNotAvailableHouseHold
      }
    
    func getTotalOriginalMember()-> Int{
        var totalOriginalMember = 0
        let predicate = NSPredicate(format: "ebNumber = %@ AND memberStatus != %@", singleton().selectEBListModel.eb_number ?? "" , MemberStatusCode.newMember)
       // let predicate = NSPredicate(format: "memberStatus != %@", "4")
           if let data = DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data, predicate: predicate) as? [NPR2021MemberDetails]{
               totalOriginalMember = data.count
               return totalOriginalMember
             }
        return totalOriginalMember
    }
    
    func getAvailableMember()-> Int{
        var totalOriginalMember = 0
        let predicate = NSPredicate(format: "ebNumber = %@ AND memberStatus = %@", singleton().selectEBListModel.eb_number ?? "" , MemberStatusCode.available)
        
           if let data = DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data, predicate: predicate) as? [NPR2021MemberDetails]{
               totalOriginalMember = data.count
               return totalOriginalMember
             }
        return totalOriginalMember
    }
    
    func getDiedMember()-> Int{
         var totalOriginalMember = 0
         
        let predicate = NSPredicate(format: "ebNumber = %@ AND memberStatus = %@", singleton().selectEBListModel.eb_number ?? "" , MemberStatusCode.dead)
            if let data = DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data, predicate: predicate) as? [NPR2021MemberDetails]{
                totalOriginalMember = data.count
                return totalOriginalMember
              }
         return totalOriginalMember
     }
    
    func getMovedOutMember()-> Int{
          var totalOriginalMember = 0
          
        let predicate = NSPredicate(format: "ebNumber = %@ AND memberStatus = %@", singleton().selectEBListModel.eb_number ?? "" , MemberStatusCode.migratedOut)
             if let data = DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data, predicate: predicate) as? [NPR2021MemberDetails]{
                 totalOriginalMember = data.count
                 return totalOriginalMember
               }
          return totalOriginalMember
      }
    
    func getTotalNewMember()-> Int{
           var totalOriginalMember = 0
          
        let predicate = NSPredicate(format: "ebNumber = %@ AND memberStatus = %@", singleton().selectEBListModel.eb_number ?? "" , MemberStatusCode.newMember)
              if let data = DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data, predicate: predicate) as? [NPR2021MemberDetails]{
                  totalOriginalMember = data.count
                  return totalOriginalMember
                }
           return totalOriginalMember
       }
    
    func getTotalUpdatedMember()-> Int{
            var totalOriginalMember = 0
            //let predicate = NSPredicate(format: "isCompleted = %@ OR isCompleted = %@", "1", "2" )
             
        let predicate = NSPredicate(format: "ebNumber = %@ AND memberStatus = %@", singleton().selectEBListModel.eb_number ?? "" , MemberStatusCode.available)
               if let data = DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data, predicate: predicate) as? [NPR2021MemberDetails]{
                   totalOriginalMember = data.count
                   return totalOriginalMember
                 }
            return totalOriginalMember
        }
    
    func getMembersYetToUpdate()-> Int{
             var memberYetToUpdate = 0
            
        let predicate = NSPredicate(format: "ebNumber = %@ AND memberStatus = %@", singleton().selectEBListModel.eb_number ?? "" , MemberStatusCode.notStarted)
                if let data = DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data, predicate: predicate) as? [NPR2021MemberDetails]{
                    memberYetToUpdate = data.count
                    return memberYetToUpdate
                  }
             return memberYetToUpdate
        }
    
     func getMembersWithPassport()-> Int{
                var membersWithPassport = 0
               
        let predicate = NSPredicate(format: "ebNumber = %@ AND passpord_id != %@", singleton().selectEBListModel.eb_number ?? "" , "")
                   if let data = DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data, predicate: predicate) as? [NPR2021MemberDetails]{
                    
                    let arrMembersWithPassport = data.filter({$0.passpord_id?.count ?? 0 > 2})
                       membersWithPassport = arrMembersWithPassport.count
                       return membersWithPassport
                     }
                return membersWithPassport
           }

    func getMembersWithAadhaar()-> Int{
           var membersWithAadhaar = 0
           
        let predicate = NSPredicate(format: "ebNumber = %@ AND aadhar != %@", singleton().selectEBListModel.eb_number ?? "" , "")
             if let data = DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data, predicate: predicate) as? [NPR2021MemberDetails]{
                let arrMembersWithAadhar = data.filter({$0.aadhar?.count ?? 0 > 2})
                  membersWithAadhaar = arrMembersWithAadhar.count
                 return membersWithAadhaar
              }
                  return membersWithAadhaar
        }
    
    
    func getMembersWithMobile()-> Int{
         var membersWithAadhaar = 0
        
        let predicate = NSPredicate(format: "ebNumber = %@ AND mobile != %@", singleton().selectEBListModel.eb_number ?? "" , "")
        
          if let data = DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data, predicate: predicate) as? [NPR2021MemberDetails]{
            
            let arrMembersWithAadhar = data.filter({$0.mobile?.count ?? 0 > 2})
           membersWithAadhaar = arrMembersWithAadhar.count
             return membersWithAadhaar
            }
            return membersWithAadhaar
        }
    
    func getOldMembersWithVoterID()-> Int {
        var oldMembersWithVoterId = 0
         
        let predicate = NSPredicate(format: "ebNumber = %@ AND voter_id != %@", singleton().selectEBListModel.eb_number ?? "" , "")
          if let data = DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data, predicate: predicate) as? [NPR2021MemberDetails]{
            
            let membersWithVoterID = data.filter({$0.voter_id?.count ?? 0 > 2})
            oldMembersWithVoterId = membersWithVoterID.count
            return oldMembersWithVoterId
          }
       return oldMembersWithVoterId
    }
    
    func getNewTotalMembersWithVoterID()-> Int {
        var newMembersWithVoterId = 0
        // let predicate = NSPredicate(format: "voter_id != %@ AND memberStatus = %@", "", "4")
        let predicate = NSPredicate(format: "ebNumber = %@ AND voter_id != %@ AND memberStatus = %@", singleton().selectEBListModel.eb_number ?? "" , "", MemberStatusCode.newMember)
        
          if let data = DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data, predicate: predicate) as? [NPR2021MemberDetails]{
            let membersWithVoterID = data.filter({$0.voter_id?.count ?? 0 > 2})
            
            newMembersWithVoterId = membersWithVoterID.count
            return newMembersWithVoterId
          }
       return newMembersWithVoterId
    }
    
    func getOldMembersWithDL()-> Int {
        var oldMembersWithDL = 0
        let predicate = NSPredicate(format: "ebNumber = %@ AND driving_lincence != %@ AND memberStatus != %@", singleton().selectEBListModel.eb_number ?? "" , "", MemberStatusCode.newMember)
        
        
          if let data = DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data, predicate: predicate) as? [NPR2021MemberDetails]{
            let arrMembersWithDL = data.filter({$0.driving_lincence?.count ?? 0 > 2})
            oldMembersWithDL = arrMembersWithDL.count
            return oldMembersWithDL
          }
       return oldMembersWithDL
    }
    
    func getNewTotalMembersWithDL()-> Int {
         var oldMembersWithDL = 0
        let predicate = NSPredicate(format: "ebNumber = %@ AND driving_lincence = %@ AND memberStatus != %@", singleton().selectEBListModel.eb_number ?? "" , "", MemberStatusCode.newMember)
         
          if let data = DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data, predicate: predicate) as? [NPR2021MemberDetails]{
            let arrMembersWithDL = data.filter({$0.driving_lincence?.count ?? 0 > 2})
            
            oldMembersWithDL = arrMembersWithDL.count
            return oldMembersWithDL
          }
       return oldMembersWithDL
    }
    
    
    func setTagLabel()  {
       
        lblEnumStatus_title.text = LanguageModal.langObj.emulator_status
        lblTotalAsignHlb_title.text = LanguageModal.langObj.total_assigned_eb
        lblTotalUploadedHlb_title.text = LanguageModal.langObj.upload_eb
        lblTotalPendingHlb_title.text = LanguageModal.langObj.pending_eb
        lblCurentHlbStatus_title.text = LanguageModal.langObj.current_eb_status
        lblOroginalHH_title.text = LanguageModal.langObj.total_old_hh
        lblAvailableHH_title.text = LanguageModal.langObj.total_available_households
        lblTotalPendingHH_title.text = LanguageModal.langObj.total_pending_households
        lblNotAvailableHH_title.text = LanguageModal.langObj.total_not_available_hh
        lblTotalNewHH_title.text = LanguageModal.langObj.total_new_hh
        lblLockedHH_title.text = LanguageModal.langObj.total_locked_hh
        lblOroginalHH_title.text = LanguageModal.langObj.total_old_hh
        lblMovedHH_title.text = LanguageModal.langObj.total_migrated_hh
        lblHHStatus_title.text = LanguageModal.langObj.household_status
        lblTotalNewHH_title.text = LanguageModal.langObj.total_new_hh
        lblTotalNewOldHH_title.text = LanguageModal.langObj.total_households_original_new
        lblTotalUpdatedHH_title.text = LanguageModal.langObj.total_updated_households
        lblTotalPendingHH_title.text = LanguageModal.langObj.total_pending_households
        
        // Member Status
        lblTotalHH_title.text = LanguageModal.langObj.total_households
        lblTotalOriginalHH_title.text = LanguageModal.langObj.total_original_household
        lblTotalNewHHHeading_title.text = LanguageModal.langObj.total_new_hh
        lblMemberStatus_title.text = LanguageModal.langObj.member_status
        lblOriginalMember_title.text = LanguageModal.langObj.total_original_members
        lblAvailableMember_title.text = LanguageModal.langObj.available_members
        lblDiedMember_title.text = LanguageModal.langObj.member_died
        lblMovedMember_title.text = LanguageModal.langObj.migrated_member
        lblNewMember_title.text = LanguageModal.langObj.new_member
        lblOldNewMember_title.text = LanguageModal.langObj.total_members_original_new
        lblUpdatedMember_title.text = LanguageModal.langObj.total_updated_members
        
        lblMemberYetToUploaded_title.text = LanguageModal.langObj.members_yet_to_be_udated
        lblMemberWithPassport_title.text = LanguageModal.langObj.member_with_passport
        lblMemberWithAadhar_title.text = LanguageModal.langObj.member_with_aadhaar
        lblMemberWithMobile_title.text = LanguageModal.langObj.members_with_mobile_number
        lblMemberWithVoterID_title.text = LanguageModal.langObj.member_with_voterID
        lblMemberWithDL_title.text = LanguageModal.langObj.member_with_dl
        
        
    }
    
}
