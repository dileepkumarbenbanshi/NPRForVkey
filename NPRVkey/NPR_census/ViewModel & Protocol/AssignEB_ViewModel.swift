//
//  AssignEB_ViewModel.swift
//  NPR_census
//
//  Created by Dileep on 16/09/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation


protocol AssignEB_ViewModelDelegate {
    func countryStateDistrictSaved()
}
class AssignEB_ViewModel {
    
     var delegate:AssignEB_ViewModelDelegate?
    
    
    
    init() {
        
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
                            
                        
                        self.delegate?.countryStateDistrictSaved()
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
