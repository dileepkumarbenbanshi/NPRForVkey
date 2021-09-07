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
           
        
          
        self.setConnectionWithDelegate(selectedEBModel: singleton().selectEBListModel)
    }
    
    func onTapDisafree () {
        
       // AlertView().alertWithoutButton(vc: self, message: AppMessages().agreeImportant)
        AlertView().showAlertWithSingleButton(vc: self, title: "", message: AppMessages().agreeImportant)
    }
    
    func tapEBDownLoad()  {
        
        
        let pickerView = UINib.loadAgreeView(AgreeView.self) as! AgreeView
        pickerView.delegate = self
        singleton().NPRRect.addSubViewToParentWindow(view: pickerView, withFrame:  CGRect(x: 0, y: UIScreen.main.bounds.height,  width: UIScreen.main.bounds.width, height: pickerView.frame.height + 50), isCenter: false)
        singleton().NPRRect.animateView(view: pickerView, key: true)
    }
    
    func dataDownloadedAlertAndGetDB() {
        
        
        DispatchQueue.main.async {
        AlertView().alertWithoutButton(vc: self, message: AppMessages.ebDownloadedSuccessFully)
        //navigateToMainScreen()
            self.getDBEbList()
        }
    }
    
}

