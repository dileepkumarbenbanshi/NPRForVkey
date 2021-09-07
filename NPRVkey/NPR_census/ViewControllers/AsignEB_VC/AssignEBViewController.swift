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
        
        getDBEbList()
       // callJsonFile()
        
    }
    
    
    func navigateToMainScreen(){
        
        DispatchQueue.main.async {
            self.view.removeLoaderView()
            self.view.removeLoaderView()
            if util.isEnumerator(){
                self.navigateToController(identifier: "MainVC", storyBoardName: "Main")
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
        
        if arayDBEBList.count == 0 {  // EB List Downloaded or not
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
        
        NPRURLRequestSession().downloadEBList(params: ["":""]) { (done, result, error) in
          
            guard let aray = result as? [[String:Any]] else {
                          return
                       }
                       
          // Pass  Respoce aray to Model Class
          let objEBManagement =  EBManagementClass(ebResponce: aray)
          objEBManagement.delegate = self
            objEBManagement.ebDataManagement()
            
        }
        

   }
    
   func setConnectionWithDelegate(selectedEBModel:EB) {
        
        SharedClass.shared.selectEBListModel = selectedEBModel
    Singleton().selectEBListModel = selectedEBModel
         let objDownLodVM = DownloadOldData_ViewModel()
         objDownLodVM.delegate = self
        objDownLodVM.downLoadOlddataForThisEB(ebModel: selectedEBModel)
    //objDownLodVM.getJsonFromFile()
    }
    
    
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
        
        contentCell.labelEB.text = ebListModel.eb_number
        if ebListModel.is_eb_downloaded {
            contentCell.labelEB.textColor = UIColor.init(named: "green")
            contentCell.imgDownloadData.image = UIImage.init(named: "ic_rightArrow")
            contentCell.imgDownloadData.tintColor = UIColor.init(named: "green")
        }
        else{
            contentCell.labelEB.textColor = UIColor.systemRed
            contentCell.imgDownloadData.image = UIImage.init(named: "arrow.down")
            contentCell.imgDownloadData.tintColor = UIColor.systemRed
        }
        
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
        
            DBManagerHousehold().updateEB_Active_Flag(modelEBList: modelEB_atndex, value: "1")
           navigateToMainScreen()
            
            
        }
        else{ 
            
       
            self.tapEBDownLoad()
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DeviceType.IS_IPAD ? 140 : 70
    }
    
    /*func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }*/
    
}


extension AssignEBViewController:NPR2019DataDownLoadDelegate {
    
    func oldDataDownloadANDSaved() {
        singleton().selectEBListModel.is_eb_downloaded = true
        
        do {
            try context.save()
        } catch  {
          
           
        }
        if util.isEnumerator() {
            sdelegateConnectionFor2021DataDownload(selectedEBModel:singleton().selectEBListModel)
        }
        else{
            self.dataDownloadedAlertAndGetDB()
        }
        
       
    }
    
   
    func data2021DownloadANDSaved () {
        
//        DispatchQueue.main.async {
//        AlertView().alertWithoutButton(vc: self, message: AppMessages.ebDownloadedSuccessFully)
//        //navigateToMainScreen()
//            self.getDBEbList()
//        }
        
        self.dataDownloadedAlertAndGetDB()
    }
}

extension AssignEBViewController : EBManagememntProtocol {
    func ebSavedSuccessFully() {
        getDBEbList()
    }
    
   
    
    func countryStateDistrictSaved() {
        getDBEbList()
    }
    
    
    
}
