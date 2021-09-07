//
//  LaunchView_ViewModel.swift
//  NPR_census
//
//  Created by Dileep on 09/01/21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation
protocol LaunchView_ViewModelDelegte{
    func countryStateDistrictSaved()
}
class LaunchView_ViewModel {
    
     var delegate:LaunchView_ViewModelDelegte?
    
    
    
    init() {
        
    }
    func setLanguageFirstTime()  {
        
        UserDefaults().saveUserDefauldValue(key: .language, value: "English")
        
    }
    func checkCountryStateDistrictAndDownload() {
        
        if isCountryDownloaded() && isStateDownloaded() && isDistrictDownloaded() && isTahsilDownloaded() {
           
            delegate?.countryStateDistrictSaved()
               } else {
            
            if !isCountryDownloaded() {
                self.downloadCountryList { (isSavedCountry) in
                    
                
                self.downloadStateList { (isDoneState) in
                    
                    self.downloadDistrict { (isDoneDistrict) in
                        self.downloadTahsil { (isDoneTahsil) in
                            
                            self.setNotKnownForSubDistrict { isSetNotKnownTahsil in
                                self.delegate?.countryStateDistrictSaved()
                            }
                        
                        }
                    }
                }
                
                
                }} else {
                
                if !isStateDownloaded() {
                    self.downloadStateList { (isDoneState) in
                        self.downloadDistrict { (isSavedDistrict) in
                            
                            self.downloadTahsil { (isDoneTahsil) in
                                
                            
                            self.delegate?.countryStateDistrictSaved()
                            }
                        }
                    }
                } else {
                    if !isDistrictDownloaded() {
                       
                        self.downloadDistrict { (isDownloadedDistrict) in
                            self.downloadTahsil { (isDoneTahsil) in
                                
                            
                            self.delegate?.countryStateDistrictSaved()
                            }
                        }
                    } else {
                        
                        self.downloadTahsil { (isDoneTahsil) in
                            
                        
                        self.delegate?.countryStateDistrictSaved()
                        }
                    }
                    
                }
                
            }
            
        }
        
    }
    
    func checkCountryStateDistrictAndDownload2()  {
       
        if isCountryDownloaded() && isStateDownloaded() && isDistrictDownloaded() {
           
            delegate?.countryStateDistrictSaved()
        } else {
            
            if !isCountryDownloaded() { // If Contry Not downloaded
                // Download Country Fist
                downloadCountryList { (isDowLoaded) in
                    
                  // After Country Check downloading  check State Downloaded if Not Download then download State First
                    if !self.isStateDownloaded(){
                        self.downloadStateList { (isDowlodedState) in
                        // After State Download and Save check District table if not downloaded then Download district First
                            if !self.isDistrictDownloaded(){
                                self.downloadDistrict { (isDownLoadedDistrict) in
                                    
                                }
                                
                            }
                            else {
                                self.delegate?.countryStateDistrictSaved()
                            }
                        }
                    }else{
                        
                    }
                }
                
            } else {  /// If State Already Download Then Check District Only
                
                if !isStateDownloaded() {
                    self.downloadStateList { (isSavedState) in
                      
                        if !self.isDistrictDownloaded() {
                            self.downloadDistrict { (isDownLoadDistrict) in
                                
                            }
                        } else {
                            self.delegate?.countryStateDistrictSaved()
                        }
                        
                    }
                    
                } else {
                    
                    if !isDistrictDownloaded() {
                        self.downloadDistrict { (isDownLoadDistrict) in
                            
                        }
                    } else {
                        self.delegate?.countryStateDistrictSaved()
                    }
                    
                }
                
                
            }
        }
        
        
    }
    
  private  func isCountryDownloaded() -> Bool {
        let arayCountryList = DataBaseManager().fetchDBData(entityName: EntityName.country)
        
        if arayCountryList.count > 0 {
            return true
        }
    
    setLanguageFirstTime()
        return false
    }
    
    
    private  func isStateDownloaded() -> Bool {
        let arayStateList = DataBaseManager().fetchDBData(entityName: EntityName.state)
        
        if arayStateList.count > 0 {
            return true
        }
       
        return false
    }
    
    private  func isDistrictDownloaded() -> Bool {
        let arayDistrictList = DataBaseManager().fetchDBData(entityName: EntityName.district)
        
        if arayDistrictList.count > 0 {
            return true
        }
       
        return false
    }
    
    private  func isTahsilDownloaded() -> Bool {
        let arayDistrictList = DataBaseManager().fetchDBData(entityName: EntityName.tahsil)
        
        if arayDistrictList.count > 0 {
            return true
        }
       
        return false
    }
    
  private  func downloadCountryList(completion: @escaping (Bool) -> Void)  {
        
        
        let param = ["orderBy":["country"],"limit":400,"total":true] as [String : Any]
        
    APIManager().downloadCountryList(params: param) { (isDownloaded, response, error) in
            guard let dictResponse = response as? [[String:Any]] else {
                return
            }
            
            DBManager_CountryStateDistrict().saveContryList(arayCountryList: dictResponse) { (isSvaed) in
                completion(true)
            }
            
            
        }
    }
    
  private  func downloadStateList(completion: @escaping (Bool) -> Void)  {
        
    let param = ["orderBy":["statename"],"limit":400,"total":true]  as [String : Any]
    APIManager().downloadStateList(params: param) { (isDownloaded, response, error) in
            guard let dictResponse = response as? [[String:Any]] else {
                return
            }
            
            DBManager_CountryStateDistrict().saveStateList(arayStateList: dictResponse) { (isSvaed) in
                completion(true)
            }
            
            
        }
       
        
    }
    
  private  func downloadDistrict(completion: @escaping (Bool) -> Void)  {
        
        let param = ["orderBy":["districtname"],"limit":1000,"total":true]  as [String : Any]
    APIManager().downloadDistrictList(params: param) { (isDownloaded, response, error) in
                   guard let dictResponse = response as? [[String:Any]] else {
                       return
                   }
                   
                DBManager_CountryStateDistrict().saveDistrictList(arayDistrictList: dictResponse) { (isSvaed) in
                    
                    if isSvaed {
                        completion(true)
                    }
                       
                   }
                   
                   
               }
        
    }
    
    
    private  func downloadTahsil(completion: @escaping (Bool) -> Void)  {
          
        let param = ["orderBy":["tehsilname"],"limit":10000,"total":true] as [String : Any]as [String : Any]
        APIManager().downloadTahsilList(params: param) { (isDownloaded, response, error) in
                     guard let dictResponse = response as? [[String:Any]] else {
                         return
                     }
                     
                  DBManager_CountryStateDistrict().saveTahsilList(arayDistrictList: dictResponse) { (isSvaed) in
                      
                      if isSvaed {
                          completion(true)
                      }
                         
                     }
                     
                     
                 }
          
      }
   
    
    
    
}


extension LaunchView_ViewModel {
    
   private func setNotKnownForSubDistrict(completion: @escaping (Bool) -> Void) {
       
        
       // let arayState = DataBaseManager().fetchDBData(entityName: EntityName.state) as! [State]
        let arayDistrict = DataBaseManager().fetchDBData(entityName: EntityName.district) as! [District]
        
        //for stateModel in arayState {
            for districtModel in arayDistrict {
                
                let tahsilModel = DataBaseManager().openDataBase(entityName: EntityName.tahsil) as? Tahsil
                
                tahsilModel?.id = util.notKnownSubDistrictCode
                tahsilModel?.name = "Not Known"
                tahsilModel?.district_code = districtModel.id ?? ""
                tahsilModel?.state_code = districtModel.stateCode ?? ""
                
                do {
                    try context.save()
                    
                    if districtModel == arayDistrict.last {
                        completion(true)
                    }
                } catch  {
                    
                }
            }
        }
   // }
}
