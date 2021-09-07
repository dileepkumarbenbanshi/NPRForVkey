//
//  ProgressViewController.swift
//  NPR Screen
//
//  Created by mac on 07/08/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class ProgressViewController: UIViewController {

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
         let predicate = NSPredicate(format: "is_eb_completed = %d", true)
         if let data = DataBaseManager().fetchDBData(entityName: EntityName.eb, predicate: predicate) as? [EB] {
             totaluploadHLB = data.count
             return totaluploadHLB
         }
         return totaluploadHLB
     }
    
    func getTotalPendingHLB()-> Int{
         var totalPendingHLB = 0
         let predicate = NSPredicate(format: "is_eb_completed = %d", false)
         if let data = DataBaseManager().fetchDBData(entityName: EntityName.eb, predicate: predicate) as? [EB] {
             totalPendingHLB = data.count
             return totalPendingHLB
         }
         return totalPendingHLB
     }
    
    func getTotalNewHousHold()-> Int{
        var totalNewHouseHold = 0
        let predicate = NSPredicate(format: "hh_status = %@", "5")
            if let data = DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicate) as? [NPR_2021hh_Details]{
              totalNewHouseHold = data.count
              return totalNewHouseHold
        }
        return totalNewHouseHold
    }
    
    func getTotalOriginalHouseHold()-> Int{
        var totalOriginalHouseHold = 0
        //let predicate = NSPredicate(format: "relName = %@","HEAD" )
        let predicate = NSPredicate(format: "hh_status != %@", "5")
        if let data = DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicate) as? [NPR_2021hh_Details] {
            totalOriginalHouseHold = data.count
            return totalOriginalHouseHold
        }
         return totalOriginalHouseHold
    }

    func getCurrentHLBNumber()-> String{
         var currentHLBNumber = ""
         let predicate = NSPredicate(format: "eb_active = %@", "1")
         if let data = DataBaseManager().fetchDBData(entityName: EntityName.eb, predicate: predicate) as? [EB] {
            currentHLBNumber = data[0].eb_block_number!
          }
        return currentHLBNumber
    }
    
    func getTotalUpdateHouseHold()-> Int {
        var totalUpdatedHouseHold = 0
        let predicate = NSPredicate(format: "hh_completed = %@", "1")
           if let data = DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicate) as? [NPR_2021hh_Details]{
               totalUpdatedHouseHold = data.count
               return totalUpdatedHouseHold
             }
        return totalUpdatedHouseHold
    }
    
    func getTotalPendingHouseHold()-> Int {
         var totalPendingHouseHold = 0
         let predicate = NSPredicate(format: "hh_completed = %@", "0")
            if let data = DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicate) as? [NPR_2021hh_Details]{
                totalPendingHouseHold = data.count
                return totalPendingHouseHold
              }
         return totalPendingHouseHold
     }
    
    func getTotalAvailableHouseHold()-> Int {
        var totalAvailableHouseHold = 0
        let predicate = NSPredicate(format: "hh_status = %@", "1")
           if let data = DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicate) as? [NPR_2021hh_Details]{
               totalAvailableHouseHold = data.count
               return totalAvailableHouseHold
             }
        return totalAvailableHouseHold
    }
    
    func getTotalMovedHouseHold()-> Int {
        var totalMovedHouseHold = 0
        let predicate = NSPredicate(format: "hh_status = %@", "3")
           if let data = DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicate) as? [NPR_2021hh_Details]{
               totalMovedHouseHold = data.count
               return totalMovedHouseHold
             }
        return totalMovedHouseHold
    }
    
    
    func getTotalLockedHouseHold()-> Int {
        var totalLockedHouseHold = 0
        let predicate = NSPredicate(format: "hh_status = %@", "2")
           if let data = DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicate) as? [NPR_2021hh_Details]{
               totalLockedHouseHold = data.count
               return totalLockedHouseHold
             }
        return totalLockedHouseHold
    }
    
    func getTotalNotAvailableHouseHold()-> Int {
          var totalNotAvailableHouseHold = 0
          let predicate = NSPredicate(format: "hh_status = %@", "4")
             if let data = DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicate) as? [NPR_2021hh_Details]{
                 totalNotAvailableHouseHold = data.count
                 return totalNotAvailableHouseHold
               }
          return totalNotAvailableHouseHold
      }
    
    func getTotalOriginalMember()-> Int{
        var totalOriginalMember = 0
        let predicate = NSPredicate(format: "memberStatus != %@", "4")
           if let data = DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data, predicate: predicate) as? [NPR2021MemberDetails]{
               totalOriginalMember = data.count
               return totalOriginalMember
             }
        return totalOriginalMember
    }
    
    func getAvailableMember()-> Int{
        var totalOriginalMember = 0
        let predicate = NSPredicate(format: "memberStatus = %@", "1")
           if let data = DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data, predicate: predicate) as? [NPR2021MemberDetails]{
               totalOriginalMember = data.count
               return totalOriginalMember
             }
        return totalOriginalMember
    }
    
    func getDiedMember()-> Int{
         var totalOriginalMember = 0
         let predicate = NSPredicate(format: "memberStatus = %@", "2")
            if let data = DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data, predicate: predicate) as? [NPR2021MemberDetails]{
                totalOriginalMember = data.count
                return totalOriginalMember
              }
         return totalOriginalMember
     }
    
    func getMovedOutMember()-> Int{
          var totalOriginalMember = 0
          let predicate = NSPredicate(format: "memberStatus = %@", "3")
             if let data = DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data, predicate: predicate) as? [NPR2021MemberDetails]{
                 totalOriginalMember = data.count
                 return totalOriginalMember
               }
          return totalOriginalMember
      }
    
    func getTotalNewMember()-> Int{
           var totalOriginalMember = 0
           let predicate = NSPredicate(format: "memberStatus = %@", "4")
              if let data = DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data, predicate: predicate) as? [NPR2021MemberDetails]{
                  totalOriginalMember = data.count
                  return totalOriginalMember
                }
           return totalOriginalMember
       }
    
    func getTotalUpdatedMember()-> Int{
            var totalOriginalMember = 0
            //let predicate = NSPredicate(format: "isCompleted = %@ OR isCompleted = %@", "1", "2" )
             let predicate = NSPredicate(format: "isCompleted = %d", true )
               if let data = DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data, predicate: predicate) as? [NPR2021MemberDetails]{
                   totalOriginalMember = data.count
                   return totalOriginalMember
                 }
            return totalOriginalMember
        }
    
    func getMembersYetToUpdate()-> Int{
             var memberYetToUpdate = 0
             let predicate = NSPredicate(format: "isCompleted = %d", false)
                if let data = DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data, predicate: predicate) as? [NPR2021MemberDetails]{
                    memberYetToUpdate = data.count
                    return memberYetToUpdate
                  }
             return memberYetToUpdate
        }
    
     func getMembersWithPassport()-> Int{
                var membersWithPassport = 0
                let predicate = NSPredicate(format: "passpord_id != %@", "")
                   if let data = DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data, predicate: predicate) as? [NPR2021MemberDetails]{
                       membersWithPassport = data.count
                       return membersWithPassport
                     }
                return membersWithPassport
           }

    func getMembersWithAadhaar()-> Int{
           var membersWithAadhaar = 0
           let predicate = NSPredicate(format: "aadhar != %@", "")
             if let data = DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data, predicate: predicate) as? [NPR2021MemberDetails]{
                  membersWithAadhaar = data.count
                 return membersWithAadhaar
              }
                  return membersWithAadhaar
        }
    
    
    func getMembersWithMobile()-> Int{
         var membersWithAadhaar = 0
         let predicate = NSPredicate(format: "mobile != %@", "")
          if let data = DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data, predicate: predicate) as? [NPR2021MemberDetails]{
           membersWithAadhaar = data.count
             return membersWithAadhaar
            }
            return membersWithAadhaar
        }
    
    func getOldMembersWithVoterID()-> Int {
        var oldMembersWithVoterId = 0
         let predicate = NSPredicate(format: "voter_id != %@", "")
          if let data = DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data, predicate: predicate) as? [NPR2021MemberDetails]{
            oldMembersWithVoterId = data.count
            return oldMembersWithVoterId
          }
       return oldMembersWithVoterId
    }
    
    func getNewTotalMembersWithVoterID()-> Int {
        var newMembersWithVoterId = 0
         let predicate = NSPredicate(format: "voter_id != %@ AND memberStatus = %@", "", "4")
          if let data = DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data, predicate: predicate) as? [NPR2021MemberDetails]{
            newMembersWithVoterId = data.count
            return newMembersWithVoterId
          }
       return newMembersWithVoterId
    }
    
    func getOldMembersWithDL()-> Int {
        var oldMembersWithDL = 0
         let predicate = NSPredicate(format: "driving_lincence != %@", "")
          if let data = DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data, predicate: predicate) as? [NPR2021MemberDetails]{
            oldMembersWithDL = data.count
            return oldMembersWithDL
          }
       return oldMembersWithDL
    }
    
    func getNewTotalMembersWithDL()-> Int {
         var oldMembersWithDL = 0
         let predicate = NSPredicate(format: "driving_lincence != %@ AND memberStatus = %@", "", "4")
          if let data = DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data, predicate: predicate) as? [NPR2021MemberDetails]{
            oldMembersWithDL = data.count
            return oldMembersWithDL
          }
       return oldMembersWithDL
    }
    
    
}
