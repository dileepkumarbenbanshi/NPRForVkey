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
    
    var isNoDatatoUploadSouldBackPrevPage = false
    
    enum AlertFor:Int {
        case noOne = 0,completeEB  ,completeEBConfirmation
    }
    var alertFor = AlertFor.init(rawValue: 0)
    @IBOutlet weak var btnUpload_title: UILabel!
    @IBOutlet weak var lblIncompleteHH: UILabel!
    
    @IBOutlet weak var lblpageName_title: UILabel!
    
    @IBOutlet weak var lblSuperVisorView: UILabel!
    @IBOutlet weak var lblSuperVisorView_title: UILabel!
    
    let uploadDataVM = UploadDataViewModel()
    ///*****************
    //MARK:View life Cycle
    ///*****************
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lblSuperVisorView.isHidden = util.isEnumerator()
        lblIncompleteHH.isHidden = !util.isEnumerator()
        setTitle()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    func setTitle()  {
        btnUpload_title.text = LanguageModal.langObj.upload_eb
        lblpageName_title.text = LanguageModal.langObj.upload_eb
        guard let viewControllers = self.navigationController?.viewControllers else{
            return
        }
        
        for vc in viewControllers {
            if let vcMain  = vc as? MainViewController{
               
                if vcMain.isSelectedInCompleteHH ?? false  {
                    lblIncompleteHH.text = LanguageModal.langObj.hh_summary
                }else{
                    lblIncompleteHH.text = LanguageModal.langObj.location_particular
                }
            }else{
                lblSuperVisorView.text = LanguageModal.langObj.sup_view
            }
        }
       
    }
    ///*****************
    //MARK:Buttons Action
    ///*****************
    
    @IBAction func onTapBack(_ sender: Any) {
       self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func onTapUpload(_ sender: UIButton) {
        
        if Reachability.shared.isConnected {
        isAvailableHHToUpload = false
        DispatchQueue.main.async {
        self.view.showLoader()
        }
        if util.isEnumerator() {
            if  uploadDataVM.isValidStartAndEndDate  {
                getEBListFormAPI()
            }else{
                DispatchQueue.main.async {
                self.view.showLoader()
                }
            }
            
        }else{
            
            isDataAvailableToUpload()
        }
        }else{
            AlertView().alertWithoutButton( message: AppMessages.networkConnection)
        }
    }
    
    ///*****************
    // MARK: Navigation
    ///*****************
    
    @objc func navigateBack() {
        
        self.navigationController?.popViewController(animated: true)
    }
    func navigateONSignatureView()  {
        //self.navigateToController(identifier: "EnumeratorSignatureViewController", storyBoardName: storyBoardName.main)
        
        guard let vcSign = self.storyboard?.instantiateViewController(withIdentifier:"EnumeratorSignatureViewController") as? EnumeratorSignatureViewController else {
            return
        }
        vcSign.uploadDelegate = self
        vcSign.isFromFormPage = false
        vcSign.isFromUpload = true
        self.navigateToController(vc: vcSign)
    }
    
    func isDataAvailableToUpload()  {
        let isNetworkConnected = Reachability.shared.isReachable
        if isNetworkConnected  {
            
        
        DispatchQueue.main.async {
        self.view.removeLoaderView()
        }
        let isCompletedHH = getAllCompletedHouseHold().count > 0 || UnHabitedVM().uiEbAbleToUpload
        isAvailableHHToUpload = isCompletedHH
        if isCompletedHH {
            navigateONSignatureView()
        }
        else {
            isNoDatatoUploadSouldBackPrevPage = true
           let alertView = AlertView()
            alertView.delegate = self
            alertView.alertWithoutButton( message: LanguageModal.langObj.no_data_to_upload)
            
        }
        }else{
            
            AlertView().alertWithoutButton( message: AppMessages.networkConnection)
        }
        
    }
    
    ///*****************
    // MARK: APIs
    ///*****************
    func getEBListFormAPI()  {
        
        NPRURLRequestSession().downloadEBList(params: ["":""]) { (success, result, error) in
          
            if success {
            
            guard let aray = result as? [[String:Any]] else {
                DispatchQueue.main.async {
                    
                    self.view.removeLoaderView()
                }
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
            
//            if error != nil {
//
//                DispatchQueue.main.async {
//
//                    self.view.removeLoaderView()
//                }
//            }
                
            }else {
                DispatchQueue.main.async {
                    AlertView().alertWithoutButton( message: ErrorMessage.errorMessage(code: error?.code ?? 0))
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

    
    func ebCompletionAlert()  {
       
        let uploadDataVM = UploadDataViewModel()
        switch alertFor {
        case .completeEB:
            alertFor = .completeEBConfirmation
            showAlert(message: LanguageModal.langObj.eb_completion_alert2_title)
            
            break
        case .completeEBConfirmation:
            uploadDataVM.delegate = self
            uploadDataVM.ebCompletionAPI()
            
            break
            
        default:
            alertFor = .completeEB
            alertWithTwoButton(message: LanguageModal.langObj.eb_mark_as_completed)
            break
        }
    }
    func showAlert(message:String)  {
        DispatchQueue.main.async {
        let alertView = AlertView()
        alertView.delegate = self
         alertView.alertWithoutButton( message: message)
        
        }
    }
    func alertWithTwoButton(message: String)  {
        DispatchQueue.main.async {
        let alertView = AlertView()
        alertView.delegate = self
         alertView.showAlert( title: "", message: message)
    }
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
                self.showAlert(message: LanguageModal.langObj.eb_not_alloted)
            }
               
        }
        
        //self.view.removeLoaderView()
            
        }
}

///*****************
// MARK: Delegates
///*****************
extension UploadDataViewController :AlertViewDelegate ,DataUploadedDelegate{
    func alertTapedYes() {
        
        alertFor = .completeEBConfirmation
        ebCompletionAlert()
    }
    func alertViewWithoutButtonDissMiss() {
        if isNoDatatoUploadSouldBackPrevPage {
            self.navigateBack()
        }
        else
        {
            self.popBackToController(toControllerType: AssignEBViewController.self)
        }
        }
    
    func alertViewTapedNo() {
        alertFor = .noOne
    }
    
    
    
    func DataUploadedSuccessfuly() {
     
        if uploadDataVM.isEBNearToComplete {
            alertFor = .noOne
            ebCompletionAlert()
        }
        
    }
    func DataUploadedFailled() {
        
    }
    
    
}


extension UploadDataViewController:EBCompletionDelegate {
    func ebUpdated() {
        
        DispatchQueue.main.async {
        self.view.removeLoaderView()
            let alertView = AlertView()
            alertView.delegate = self
            alertView.alertWithoutButton( message:LanguageModal.langObj.eb_complete_successfully )
        }
        
        
       
        
//        if self.isControllerInNavigationStack(toControllerType: AssignEBViewController.self) {
//            self.popBackToController(toControllerType: AssignEBViewController.self)
//        }else{
//            self.navigateToController(identifier:"AssignEBViewController" , storyBoardName: storyBoardName.main)
//        }
        
        
    }
    
    
    
}
