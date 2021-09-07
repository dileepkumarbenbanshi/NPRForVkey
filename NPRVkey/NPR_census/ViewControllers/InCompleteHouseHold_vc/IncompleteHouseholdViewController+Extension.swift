//
//  IncompleteHouseholdViewController+Extension.swift
//  NPR-2020
//
//  Created by Dileep on 16/10/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

extension IncompleteHouseholdViewController {
 
    @objc func onTapDropDown(_ sender: UIButton){
        
        let buttonPosition = sender.convert(CGPoint.zero, to: self.incompleteHouseholdTableView)
        let indexPath = self.incompleteHouseholdTableView.indexPathForRow(at: buttonPosition)!
        
        if indexPath.row == 0 {
            if sender.isSelected {
                       
                       let sections = IndexSet.init(integer: indexPath.section)
                       self.incompleteHouseholdTableView.reloadSections(sections, with: .none)
                   }
                   else{
                      
                      
                    fetchedMemberDetailData(modelSelectedHH: arayHHList[indexPath.section]) { (done) in
                         let Sections = IndexSet.init(integer: indexPath.section)
                        self.incompleteHouseholdTableView.reloadSections(Sections, with: .automatic)
                    }
                       
                   }
               }
        sender.isSelected = !sender.isSelected
    }
    
    @objc func onTapSkip(_ sender: UIButton){
        
       let pickerView = Bundle.main.loadNibNamed("SkipHHView", owner: self, options: nil)?.first as? SkipHHView
           pickerView?.delegate = self
        skipSelctedHHModel = arayHHList[sender.tag]
            pickerView?.loadSKipView()
    }
    
    
    
    
}

extension IncompleteHouseholdViewController:SkipHHDelegate {
    func onTapOK(statusSelectedCode: String, skipSelectedStatus: String) {
       
        if statusSelectedCode.count == 0 {
            showSkipAlert()
        }
        else{
            
            let alertView = AlertView()
            alertView.delegate = self
           
            skipHHSelectedStatus = statusSelectedCode
            alertView.showAlert(vc: self, title: "Are You Sure", message:  "To Skip Household Number - \(skipSelctedHHModel?.houseHoldhNo ?? "")  due to \(skipSelectedStatus) ?")
            
            
            
        }
         
    }
    
    func showSkipAlert()  {
        
        let alert = UIAlertController.init(title: nil, message: "Select reason for Skipping the household -", preferredStyle: .alert)
        
                alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension IncompleteHouseholdViewController:AlertViewDelegate {
    
    func alertTapedYes() {
        
        skipSelctedHHModel?.hh_completed = HHCompletionStatusCode.completed
        skipSelctedHHModel?.hh_status = skipHHSelectedStatus
        
        do {
            try context.save()
            
            DBManagerMemberDetail().updateMemberStatusAfterSkipHH(hhModel: skipSelctedHHModel!, hhStatus: skipHHSelectedStatus) { (isChanged) in
              
                self.getHouseHoldList()
            }
            
            
        } catch  {
            
        }
        
    }
    
    
    
}

extension IncompleteHouseholdViewController:UISearchBarDelegate {
   
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        
        return true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    

    
    

    func searchMembers_in_db(predicateHH:NSPredicate )  {
        
        guard let  araySearchedMembers = DataBaseManager().fetchDBData(entityName:EntityName.npr2021Data ,predicate: predicateHH) as? [NPR2021MemberDetails] else {
            return
        }
        if araySearchedMembers.count == 0 {
               self.arayHHList.removeAll()
                self.updateTblList()
            
        }else
        {
            self.findHouseHold_onSearchMember(araySearchedMebers: araySearchedMembers)
        }
        
 
    }
    
    
    func   searchByHead_in_db(predicateHH:NSPredicate )  {
        
        
        guard let  araySearchedMembers = DataBaseManager().fetchDBData(entityName:EntityName.nprHHStats ,predicate: predicateHH) as? [NPR_2021hh_Details] else {
            return
        }
        if araySearchedMembers.count == 0 {
               self.arayHHList.removeAll()
                //self.updateTblList()
            
        }else{
            //self.arayHHList = araySearchedMembers
            
            arayHHList = araySearchedMembers.filter({$0.hh_completed == HHCompletionStatusCode.inComplete || $0.hh_completed == HHCompletionStatusCode.notStarted})
        }
        updateTblList()
        
    }
    
    
    
    func findHouseHold_onSearchMember(araySearchedMebers:[NPR2021MemberDetails])   {
        
        var araySearchedHH = [NPR_2021hh_Details]()
        
        for modelIndex in arayTotalHHList {
           
            
           let foundMembers = araySearchedMebers.filter({$0.hh_tin == modelIndex.hh_tin})
            
            if foundMembers.count > 0 {
                araySearchedHH.append(modelIndex)
                
               // if modelIndex == arayTotalHHList.last {
                    
                arayHHList = araySearchedHH.filter({$0.hh_completed == HHCompletionStatusCode.notStarted || $0.hh_completed == HHCompletionStatusCode.inComplete})
                   // arayHHList = araySearchedHH
                    
                    self.updateTblList()
                    //
               // }
            }
            
        }
    }
    
    
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String){
        
        if searchText == "" || searchText == nil{
          arayHHList = arayTotalHHList
            updateTblList()
            return
        }
        
        serachMember(strSearch: searchText)
        
    }
    
    func serachMember(strSearch:String)  {
        
        let searchType = Utils.searchType.init(rawValue: btnSearchType?.tag ?? 0)
        
       
        var predicateHH = NSPredicate()
        
        switch searchType {
        case .head:
           
            let predicateHH = NSPredicate(format: "headName CONTAINS[c] %@ AND ebNumber =%@", strSearch,singleton().selectEBListModel.eb_number ?? "" )
           searchByHead_in_db(predicateHH: predicateHH)
            updateTblList()
            return
        case .name:
            //strSearchType = "name"
            predicateHH = NSPredicate(format: "name CONTAINS[c] %@ AND ebNumber =%@", strSearch,singleton().selectEBListModel.eb_number ?? "")
            break
            
        case .aadhar:
           // strSearchType = "aadhar"
            predicateHH = NSPredicate(format: "SELF.aadhar CONTAINS[c] %@ AND ebNumber =%@", strSearch,singleton().selectEBListModel.eb_number ?? "")
            break
        case .mobile:
            //strSearchType = "mobile"
            predicateHH = NSPredicate(format: "mobile CONTAINS[c] %@ AND ebNumber =%@", strSearch,singleton().selectEBListModel.eb_number ?? "")
            break
        
        case .dob:
            //strSearchType = "dob"
            predicateHH = NSPredicate(format: "dob CONTAINS[c] %@ AND ebNumber =%@", strSearch,singleton().selectEBListModel.eb_number ?? "")
            break
            
        case .none:
            AlertView().showAlertWithSingleButton(vc: self, title: "", message: "Select Search Type")
            //arayHHList = arayTotalHHList.filter { ($0.headName?.contains(strSearch))!}
            return
        }
        
        
        
//        if let  arayHHListSerached = arayTotalHHList.filtered(using: predicateHH) as? [NPR2021MemberDetails]{
//
//        }
       
//        let predicate2:NSPredicate = NSPredicate(format: "member_completionStatus=%@",MemberCompletionStatusCode.)
//        let compound:NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [predicateHH,predicate2])
        
        searchMembers_in_db(predicateHH: predicateHH)
        
        
    }
    
}
///MARK:ButtonInfo Tap Action

extension IncompleteHouseholdViewController {
    
    @objc func onTapInfo_toolTip(_ sender: UIButton){

        guard let memberLiveStatus = MemberLivingStatusCode.init(rawValue: "\(sender.tag)") else { return  }
        
        let strToolTipDetail = MemberLivingStatusCode.dcodeDetail(memberLiveStatus)()
        
        AlertView().alertWithoutButton(vc: self, message: strToolTipDetail)
        
        //singleton().Alert.show(title: AppMessages.App_Name, message: strToolTipDetail, delay: 1.0)
    }
    
    
}
