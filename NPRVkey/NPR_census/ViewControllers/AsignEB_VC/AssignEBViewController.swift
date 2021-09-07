//
//  AssignEBViewController.swift
//  NPR Screen
//
//  Created by mac on 06/08/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class AssignEBViewController: UIViewController {
    var arayDBEBList = [EB]()
    var selectedEBIndex = -1
    var isDownloadingSelectedEB = false
    var is_hitHLBAPiFirstTime = true
    var isTapedRefreshButton = false
    
    @IBOutlet var totalHoseholdsLeftLabel: UILabel!
    @IBOutlet var totalOriginalLeftLabel: UILabel!
    @IBOutlet var totalNewLeftLabel: UILabel!
    
    @IBOutlet var stateLeftLabel: UILabel!
    @IBOutlet var districtLeftLabel: UILabel!
    @IBOutlet var subDistrictLeftLabel: UILabel!
    @IBOutlet var townOrVillageLeftLabel: UILabel!
    @IBOutlet var wardLeftLabel: UILabel!
    @IBOutlet var blockLeftLabel: UILabel!
    @IBOutlet var jurisdictionTopLabel: UILabel!
    @IBOutlet var appName: UILabel!
    @IBOutlet var languageLabel: UILabel!
    @IBOutlet var selectHLBLabel: UILabel!
    @IBOutlet var notDownloadedLabel: UILabel!
    @IBOutlet var downLoadedLabel: UILabel!
    @IBOutlet var uploadedLabel: UILabel!
    
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.showLoader()
        
        //self.view.addSubview(vwBGindicator)
        
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
    }
    func fetcAllData()  {
        
       // getDBEbList()
        
//        self.view.showLoader()
//        let objAssignEBDelegate = AssignEB_ViewModel()
//
//        objAssignEBDelegate.delegate = self
//
//        objAssignEBDelegate.checkCountryStateDistrictAndDownload()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        arayDBEBList.removeAll()
        is_hitHLBAPiFirstTime = true
        getDBEbList()
        
        appName.text = AppMessages.App_Name
       // languageLabel.text = LanguageModal.currentLanguage
        selectHLBLabel.text = LanguageModal.langObj.select_eb
        notDownloadedLabel.text = LanguageModal.langObj.not_downloaded
        downLoadedLabel.text = LanguageModal.langObj.downloaded
        uploadedLabel.text = LanguageModal.langObj.uploaded
       // callJsonFile()
        
    }
    
    
    @IBAction func btnEbSyncRefresh(_ sender: UIButton) {
        if !Reachability.shared.isConnected {
            AlertView().alertWithoutButton( message: AppMessages.networkConnection)
            return
        }
        isTapedRefreshButton = true
        isDownloadingSelectedEB = false
        getEBList()
        
    }
    
    func navigateToMainScreen(){
        
        DispatchQueue.main.async {
            self.view.removeLoaderView()
            self.view.removeLoaderView()
            if util.isEnumerator(){
                //self.navigateToController(identifier: "MainVC", storyBoardName: "Main")
                let controller = self.storyboard?.instantiateViewController(withIdentifier: "MainVC") as! MainViewController
                controller.isFromHlbList = true
                self.navigateToController(vc: controller)
            }
            else{
                self.navigateToController(identifier: "SupervisorHHList_VC", storyBoardName: "SuperVisor")
            }
            
               }
        
    }

    func makeAllEBInActive(modelEBList:[EB]){
         for i in 0..<modelEBList.count {
               DBManagerHousehold().updateEB_Active_Flag(modelEBList: modelEBList[i], value: "0")
         }
     }
    
    
    // Fetch EB List if in DataBase
    func getDBEbList()  {
        
        //callJsonFile()
        let arayEBList  = DataBaseManager().fetchDBData(entityName: EntityName.eb) as! [EB]
        
        arayDBEBList = arayEBList.sorted(by: {$0.eb_number ?? "" < $1.eb_number ?? ""})
        
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print("Path URLs ", urls)
        
        if arayDBEBList.count == 0 && is_hitHLBAPiFirstTime {  // EB List Downloaded or not
            getEBList()
        }
        else{
            //// if EBList have in database then realosd tableview
            
           // self.makeAllEBInActive(modelEBList: arayDBEBList)
                //self.setupSideMenu
            DispatchQueue.main.async {
                self.view.removeLoaderView()
                  self.tblView.reloadData()
                self.view.removeLoaderView()
                self.view.removeLoaderView()
                
            }
        }
 
    }
    
   // Get Eb List From API
    func getEBList()  {
        if !Reachability.shared.isConnected {
            AlertView().alertWithoutButton( message: AppMessages.networkConnection)
            return
        }
        
        NPRURLRequestSession().downloadEBList(params: ["":""]) { (success, result, error) in
            if success {
            guard let aray = result as? [[String:Any]] else {
                          return
                       }
                       
          // Pass  Respoce aray to Model Class
          let objEBManagement =  EBManagementClass(ebResponce: aray)
          objEBManagement.delegate = self
            objEBManagement.isDownloadingSelectedEB = self.isDownloadingSelectedEB
            objEBManagement.ebDataManagement()
            
        }
            else {
                DispatchQueue.main.async {
                    AlertView().alertWithoutButton( message: ErrorMessage.errorMessage(code: error?.code ?? 0))
                    self.view.removeLoaderView()
                }
            }
        }
    }
   
    // Set For Download EB data 2019
   func setConnectionWithDelegate(selectedEBModel:EB) {
    is_hitHLBAPiFirstTime = false
        SharedClass.shared.selectEBListModel = selectedEBModel
    Singleton().selectEBListModel = selectedEBModel
         let objDownLodVM = DownloadOldData_ViewModel()
         objDownLodVM.delegate = self
        objDownLodVM.downLoadOlddataForThisEB(ebModel: selectedEBModel)
      
    //objDownLodVM.getJsonFromFile()
    }
    
    // Set For Download EB data 2021
    func sdelegateConnectionFor2021DataDownload(selectedEBModel:EB)  {
        
        
        let objDownLodVM = DownloadOldData_ViewModel()
        objDownLodVM.delegate = self
       //objDownLodVM.downLoadOlddataForThisEB(ebModel:EB)
        objDownLodVM.download2021OldDataForThisEB(ebModel: selectedEBModel)
    }
 
    func callJsonFile()  {
       // self.view.showLoader()
        let objDownLodVM = DownloadOldData_ViewModel()
             objDownLodVM.delegate = self
            //objDownLodVM.downLoadOlddataForThisEB(ebModel: selectedEBModel)
       let featchedData = DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats)
        if featchedData.count == 0 {
           objDownLodVM.getJsonFromFile()
        }
        else{
            //navigateToMainScreen()
            getDBEbList()
        }
    }
    
    
    
}

extension AssignEBViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arayDBEBList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contentCell:AssignEBTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AssignEBTableViewCell") as! AssignEBTableViewCell
        let ebListModel = arayDBEBList[indexPath.row]
        
        var color = UIColor.systemRed
        
        contentCell.labelEB.text = ebListModel.eb_number
        if ebListModel.is_eb_downloaded {
            color = UIColor.init(named: "green") ?? UIColor()//ProjectColor.green
            contentCell.imgDownloadData.image = UIImage.init(named: "ic_rightArrow")
            contentCell.imgDownloadData.tintColor = UIColor.init(named: "green")
        }
        else {
            color = UIColor.systemRed
            if #available(iOS 13.0, *) {
                contentCell.imgDownloadData.image = UIImage(systemName: "arrow.down")
            } else {
                // Fallback on earlier versions
            }
            
            
        }
        
        if ebListModel.is_eb_uploaded  {
            color = ProjectColor.colorPrimary
        }
        contentCell.imgDownloadData.tintColor = color
        contentCell.labelEB.textColor = color
        contentCell.lblEnumeratorName.textColor = color
        if  util.isEnumerator() {
            
            contentCell.lblEnumeratorName.text = ""
           //
        }else{
            
            contentCell.lblEnumeratorName.text = ebListModel.enumerator_name ?? ""
        }
        return contentCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let modelEB_atndex = arayDBEBList[indexPath.row]
        singleton().activeEB = modelEB_atndex.eb_block_number ?? ""
        singleton().selectEBListModel = modelEB_atndex
        SharedClass.shared.selectEBListModel = modelEB_atndex
        selectedEBIndex = indexPath.row
        if modelEB_atndex.is_eb_downloaded {
            isDownloadingSelectedEB = false
            
            if UnHabitedVM().shouldOpenExpHHPopup {
              loadInhavited()
            }else{
                navigateToMainScreen()
            }
            DBManagerHousehold().updateEB_Active_Flag(modelEBList: modelEB_atndex, value: "1")
           
            
    }
        else{ 
            
            isDownloadingSelectedEB = true
            self.tapEBDownLoad()
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DeviceType.IS_IPAD ? 140 : 70
    }
    
    
    
}


extension AssignEBViewController:NPR2019DataDownLoadDelegate {
    
    func oldDataDownloadANDSaved() {
        singleton().selectEBListModel.is_eb_downloaded = true
        
        do {
            try context.save()
        } catch  {
          
           
        }
        //if util.isEnumerator() {
            sdelegateConnectionFor2021DataDownload(selectedEBModel:singleton().selectEBListModel)
//        }
//        else{
//            self.dataDownloadedAlertAndGetDB()
//        }
        
       
    }
    
   
    func data2021DownloadANDSaved () {
        
//        DispatchQueue.main.async {
//        AlertView().alertWithoutButton( message: AppMessages.ebDownloadedSuccessFully)
//        //navigateToMainScreen()
//            self.getDBEbList()
//        }
        
        self.dataDownloadedAlertAndGetDB()
    }
}

extension AssignEBViewController : EBManagememntProtocol {
    func ebNotExistMore() {
                DispatchQueue.main.async {
                AlertView().alertWithoutButton( message: AppMessages.ebDoesNotExist)
               
                   self.getDBEbList()
                }
    }
    
    func ebExistYet() {
        self.setConnectionWithDelegate(selectedEBModel: singleton().selectEBListModel)
    }
    
    func ebSavedSuccessFully() {
        getDBEbList()
        DispatchQueue.main.async {
            
        self.view.removeLoaderView()
            if self.isTapedRefreshButton {
                AlertView().alertWithoutButton( message: LanguageModal.langObj.eb_update)
                
                    self.isTapedRefreshButton = false
            }
        }
        
    }
    
    func countryStateDistrictSaved() {
        getDBEbList()
    }
    
    
    
}
