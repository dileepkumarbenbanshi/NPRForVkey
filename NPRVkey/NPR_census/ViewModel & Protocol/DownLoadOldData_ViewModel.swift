//
//  DownLoadOldData_ViewModel.swift
//  NPR_census
//
//  Created by Dileep on 04/09/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
@objc protocol NPR2019DataDownLoadDelegate {
    func oldDataDownloadANDSaved ()
    
     func data2021DownloadANDSaved()
    
}

class DownloadOldData_ViewModel {
    
     var delegate :NPR2019DataDownLoadDelegate?
    var funcEntryCount = 0
    var savedIndex = 0
    
    
    private var arayResultModel = [NPRDataDownload_modelClassResult]()
    private var arayModifiedModel = [NPRDataDownload_modelClassResult]()
    private var arayHouseHoldNumberList = [""]
    
    
    func parameter(ebModel:EB) -> [String:Any] {
       
        let dictCriteria =  ["statecode":"\(ebModel.ebState_code ?? "")","districtcode":"\(ebModel.ebDistrict_code ?? "")","tehsilcode":"\(ebModel.ebTahsil_code ?? "")","towncode":"\(ebModel.ebTown_code ?? "")","wardid":"\(ebModel.ebWard_code ?? "")","blockno":"\(ebModel.eb_block_number ?? "")"]
            
        let dictParam =  ["criteria":dictCriteria,"limit":"500000","total":true] as [String : Any]
        return dictParam
    }
    
    func getJsonFromFile() {
        
        if let path = Bundle.main.path(forResource: "TestingData", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                print("JsonData",jsonResult)
                guard let arayResultModel = NPRDataDownload_modelClassRootClass.init(fromDictionary: jsonResult as! [String : Any]).result else {
                                    return
                                }
                let arayHHSorted : [NPRDataDownload_modelClassResult] = arayResultModel.sorted(by: {$0.hh < $1.hh})
                DispatchQueue.main.async {
                    //self.dataPassToDB(arayResult: arayHHSorted, ebModel: )
                }
                                
                               // self.filterHouseHold(arayResultModel: arayResultModel)
              } catch {
                   // handle error
              }
        }
    }
     func downLoadOlddataForThisEB(ebModel:EB)  {
     
        let dictParam = parameter(ebModel: ebModel) // Pass EB Model and prepare Parameter
       
        APIManager().callAPI_download2019Data(params: dictParam) { (success, response, error) in
            
            if success {
                //print("Download Data", response)
                guard let dictResponse = response as? [String:Any] else {
                    return
                }
                
               // print("downloadedData",dictResponse)
                guard let arayResultModel = NPRDataDownload_modelClassRootClass.init(fromDictionary: dictResponse).result else {
                    return
                }
                
                if arayResultModel.count == 0 {
                    self.delegate?.oldDataDownloadANDSaved()
                    
                    
                    return
                }
                let arayHHSorted : [NPRDataDownload_modelClassResult] = arayResultModel.sorted(by: {$0.hh < $1.hh})
                
                self.dataPassToDB(arayResult: arayHHSorted, ebModel: ebModel)
                
                 
                
            }else if error != nil {
               print("Download Data error", error!)
                self.delegate?.oldDataDownloadANDSaved()
            }
        }
         
    
    }
    
    
    
    func download2021OldDataForThisEB(ebModel:EB)  {
        
        let dictParam = parameter(ebModel: ebModel) // Pass EB Model and prepare Parameter
       
        APIManager().callAPI_download2021Data(params: dictParam) { (success, response, error) in
            
            if success {
                //print("Download Data", response)
                guard let dictResponse = response as? [String:Any] else {
                    return
                }
                
               // print("downloadedData",dictResponse)
                guard let arayResultModel = NPRData2021ModelClassRootClass.init(fromDictionary: dictResponse).result else {
                    return
                }
                
                if arayResultModel.count == 0 {
                    self.delegate?.data2021DownloadANDSaved()
                    
                    
                    return
                }
                
                let arayHead : [NPRData2021ModelClassResult] = arayResultModel.filter({$0.relCode == "01"})
                
                let arayHHSorted : [NPRData2021ModelClassResult] = arayHead.sorted(by: {$0.slnohhd < $1.slnohhd})
                
                self.data2021PassToDB(arayResult: arayResultModel, ebModel: ebModel)
                
                 
                
            }else if error != nil {
               print("Download Data error", error!)
                self.delegate?.oldDataDownloadANDSaved()
            }
        }
         
        
    }
    
    func manageNpr2021Data(arayHHSorted : [NPRData2021ModelClassResult] ,arayTotalData:[NPRData2021ModelClassResult]) {
        
        for hhModel in arayHHSorted {
            
            let predicateHH = NSPredicate(format: "hh_tin = %@ ", hhModel.slnohhd.hhTin())
            guard let hhModelDataList =  DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicateHH) as? [NPR_2021hh_Details] else { return
                
                
            }
            
            
            
        }
    }
    
    func updateHH(hhModel:NPR_2021hh_Details,aray2021Data:[NPRData2021ModelClassResult])  {
        
        
    }
    
    
    func data2021PassToHHDB(hhModel:NPR_2021hh_Details,headDetail:NPRData2021ModelClassResult )  {
        
         
    }
    func dataPassToDB(arayResult:[NPRDataDownload_modelClassResult],ebModel:EB)  {
        
        DispatchQueue.main.async {
       // var index = 0
        
            if arayResult.count > 0 {
            let dictModel = arayResult[self.savedIndex]
            let objDBManager = DBManagerMemberDetail()
           // objDBManager.delegate = self
           // index = index+1
            
            objDBManager.saveHHMemberDetail(hhModel: dictModel) { (saved) in
                self.savedIndex = self.savedIndex+1
                print("Index Found",self.savedIndex)
                if self.savedIndex == arayResult.count {
                    DBManagerHousehold().updateEB_flag_isdownloaded(modelEBList: ebModel)
                   self.delegate?.oldDataDownloadANDSaved()
                }else{
                    self.dataPassToDB(arayResult: arayResult, ebModel: ebModel)
                }
                
            }
            }
        }
       // }
        
    }
    
    
    
    func data2021PassToDB(arayResult:[NPRData2021ModelClassResult],ebModel:EB)  {
        
        DispatchQueue.main.async {
       // var index = 0
        
            if arayResult.count > 0 {
            let dictModel = arayResult[self.savedIndex]
            let objDBManager = DBManagerMemberDetail()
            objDBManager.delegate = self
           // index = index+1
            
            objDBManager.save2021HHMemberDetail(hhModel: dictModel) { (saved) in
                self.savedIndex = self.savedIndex+1
                print("Index Found",self.savedIndex)
                if self.savedIndex == arayResult.count {
                   // DBManagerHousehold().updateEB_flag_isdownloaded(modelEBList: ebModel)
                   self.delegate?.data2021DownloadANDSaved()
                }else{
                    self.data2021PassToDB(arayResult: arayResult, ebModel: ebModel)
                }

            }
            }
        }
       // }
        
    }
    
     func getHouseHoldNumberList()  {
       
        var arayHouseHold = [""]
        
        for modelDict in arayResultModel {
            arayHouseHold.append(modelDict.hh)
        }
        let setHouseHold = Set(arayHouseHold)
        self.arayHouseHoldNumberList = setHouseHold.sorted()
        
        
        
       
    }
    
    func filterHouseHold(arayResultModel:[NPRDataDownload_modelClassResult])  {
 
        
        funcEntryCount = funcEntryCount+1
        print("funcEntryCount",funcEntryCount)
        
        let arayAllMemberOFHH :[NPRDataDownload_modelClassResult] = arayResultModel.filter({$0.relCode == "01"})
        
          let arayHHSorted : [NPRDataDownload_modelClassResult] = arayAllMemberOFHH.sorted(by: {$0.hh < $1.hh})
        
        
        DispatchQueue.main.async {
            let dataBaseManager = DBManagerHousehold()
            
            dataBaseManager.delegate = self
            //dataBaseManager.saveHousehold(arayHHModel: arayHHSorted, arayResult: arayResultModel)
        
        }
        }
    
    
    
    
}

extension DownloadOldData_ViewModel :Download2019Data_delegate {
    func dataSavedSuccessFully() {
        self.delegate?.oldDataDownloadANDSaved()
    }
    
    
}
