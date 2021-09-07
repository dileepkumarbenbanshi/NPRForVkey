//
//  UploadDataViewController.swift
//  NPR Screen
//
//  Created by mac on 19/08/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class UploadDataViewController: UIViewController {

    
    var isAvailableHHToUpload = false
    var isAvailableSelectedEB = false
    
    
    ///*****************
    //MARK:View life Cycle
    ///*****************
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    ///*****************
    //MARK:Buttons Action
    ///*****************
    
    @IBAction func onTapBack(_ sender: Any) {
       self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func onTapUpload(_ sender: Any) {
        
        isAvailableHHToUpload = false
        DispatchQueue.main.async {
        self.view.showLoader()
        }
     getEBList()
}
    
    ///*****************
    // MARK: Navigation
    ///*****************
    
    @objc func navigateBack() {
        
        self.navigationController?.popViewController(animated: true)
    }
    func navigateONSignatureView()  {
        self.navigateToController(identifier: "EnumeratorSignatureViewController", storyBoardName: storyBoardName.main)
    }
    
    func isDataAvailableToUpload()  {
        
        let isCompletedHH = getAllCompletedHouseHold().count > 0
        isAvailableHHToUpload = isCompletedHH
        if isCompletedHH {
            navigateONSignatureView()
        }
        else {
            AlertView().alertWithoutButton(vc: self, message: "No Data To Upload")
        }
        
    }
    
    ///*****************
    // MARK: APIs
    ///*****************
    func getEBList()  {
        
        NPRURLRequestSession().downloadEBList(params: ["":""]) { (done, result, error) in
          
            guard let aray = result as? [[String:Any]] else {
                          return
                       }
                       
            if aray.count > 0 {
          let objEBManagement =  EBManagementClass(ebResponce: aray)
          objEBManagement.delegate = self
            objEBManagement.ebDataManagement()
            }else{
                DispatchQueue.main.async {
                    
                    self.view.removeLoaderView()
                }
            }
        }
        

   }
    
    ///*****************
    // MARK: Others
    ///*****************
    
    
    func getAllCompletedHouseHold()-> [NPR_2021hh_Details] {
        
        let predicateHH = NSPredicate(format: "hh_completed = %@ && ebNumber = %@",HHCompletionStatusCode.completed,SharedClass.shared.selectEBListModel.eb_number ?? "" )
        
        guard let arayCompletedHouseHold = DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicateHH) as? [NPR_2021hh_Details] else {
            return [NPR_2021hh_Details]()
        }
       return arayCompletedHouseHold
    }
    
    func isEBStillAvailable() -> Bool  {
        
        let predicateEB = NSPredicate(format: "eb_number = %@",SharedClass.shared.selectEBListModel.eb_number ?? "")
        let ebFound = DataBaseManager().fetchDBData(entityName: EntityName.eb, predicate: predicateEB)
        
        return ebFound.count > 0 ? true :false
        
        
    }
    
    ///*****************
    // MARK: Alert
    ///*****************

    
    func showAlert(message:String)  {
        let alertView = AlertView()
        alertView.delegate = self
         alertView.alertWithoutButton(vc: self, message: message)
        
        
    }
}

extension UploadDataViewController :EBManagememntProtocol {
    func ebSavedSuccessFully() {
       
        DispatchQueue.main.async {
            
            self.view.removeLoaderView()
            if self.isEBStillAvailable() {
                self.isAvailableSelectedEB = true
                self.isDataAvailableToUpload()
            }
            else{
                self.showAlert(message: "HLB not allotted to this user")
            }
               
        }
        
        //self.view.removeLoaderView()
            
        }

    
}

extension UploadDataViewController :AlertViewDelegate {
    func alertTapedYes() {
        
    }
    func alertViewWithoutButtonDissMiss() {
        
            self.popBackToController(toControllerType: AssignEBViewController.self)
        
        
    }
    
    
    
    
}
