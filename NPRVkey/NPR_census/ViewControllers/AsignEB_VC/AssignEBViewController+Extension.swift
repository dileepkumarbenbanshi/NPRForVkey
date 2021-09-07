//
//  AssignEBViewController+Extension.swift
//  NPR_census
//
//  Created by Dileep on 01/09/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import CoreData


extension AssignEBViewController:AgreeViewDelegate {
    
    func onTapAgree() {
        
        
        self.view.showLoader()
           
        getEBList()
        if !util.isEnumerator() {
            self.setConnectionWithDelegate(selectedEBModel: singleton().selectEBListModel)
        }
        
    }
    
    func onTapDisafree () {
        
       // AlertView().alertWithoutButton( message: AppMessages().agreeImportant)
        AlertView().showAlertWithSingleButton( title: "", message: LanguageModal.langObj.contact_to_your_supervisor)
    }
    
    func tapEBDownLoad()  {
        
        if !Reachability.shared.isConnected {
            AlertView().alertWithoutButton( message: AppMessages.networkConnection)
            self.view.removeLoaderView()
            return
        }
        isDownloadingSelectedEB = true
        let pickerView = UINib.loadAgreeView(AgreeView.self) as! AgreeView
        pickerView.delegate = self
        singleton().NPRRect.addSubViewToParentWindow(view: pickerView, withFrame:  CGRect(x: 0, y: UIScreen.main.bounds.height,  width: UIScreen.main.bounds.width, height: pickerView.frame.height + 50), isCenter: false)
        singleton().NPRRect.animateView(view: pickerView, key: true)
    }
    
    
    func loadInhavited()  {
        if UnHabitedVM().shouldOpenExpHHPopup {
            let inHavitedView = Bundle.main.loadNibNamed("InhavitedView", owner: self, options: nil)?.first as? InhavitedView
            inHavitedView?.delegate = self
            inHavitedView?.lodInhavitedView()
        }
       
        
    }
    func isHlbOpenFirstTime() -> Bool {
        return true
        
    }
    func dataDownloadedAlertAndGetDB() {
        
        
        DispatchQueue.main.async {
            
        self.view.removeLoaderView()
        AlertView().alertWithoutButton( message: AppMessages.ebDownloadedSuccessFully)
        //navigateToMainScreen()
            self.getDBEbList()
        }
    }
    
}


extension AssignEBViewController : InhavitedViewDelegate{
    func saveExpectedHH_number() {
        self.navigateToMainScreen()
    }
    
    func saveExpectedHHNumberZero() {
        self.navigateToMainScreen()
        
    }
    
    func popUpHaveToShowAgain() {
        
    }
    
    
}
