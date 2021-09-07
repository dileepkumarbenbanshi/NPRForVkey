//
//  APIManager.swift
//  NPR_census
//
//  Created by Dileep on 27/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

protocol APIManagerDelegate {
    func getWebserviceResponce(result:NSDictionary)
    func getWebserviceError(result:NSString)
}

class APIManager {
    //let api = APIs()
   
    var delegate : APIManagerDelegate?
    

    
    func getWebserviceResponce(result:NSDictionary){
        
       self.delegate?.getWebserviceResponce(result: result)
    }
    
    func getWebserviceError(error:NSString){
        
        self.delegate?.getWebserviceError(result: error )
    }
    
    
    
    func getJsonFromFile( fileName:String,finished: @escaping (Bool,Any,CustomServiceError?) -> Void) {
        
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                print("JsonData",jsonResult)
                
                finished(true,jsonResult,nil)
               
                                
                               
              } catch {
                   // handle error
              }
        }
    }
    
    
    }









extension APIManager  {
    
    
    public func downloadCountryList( params:[String: Any],finished: @escaping (Bool,Any,CustomServiceError?) -> Void) {
//        self.request(BaseUrl.url + EndPoint.country_List , httpMethod: RequestType.POST.rawValue, apiType: APIType.NonDeviceManagement, parameter: params) { (success, result, error) in
//            finished(success,result, error)
//        }
        
        getJsonFromFile(fileName: "Country") { (success, result, error) in
            finished(success,result, error)
        }
    }
    public func downloadStateList( params:[String: Any],finished: @escaping (Bool,Any,CustomServiceError?) -> Void) {
//        self.request(BaseUrl.url + EndPoint.state_List , httpMethod: RequestType.POST.rawValue, apiType: APIType.NonDeviceManagement, parameter: params) { (success, result, error) in
//            finished(success,result, error)
//        }
        
        getJsonFromFile(fileName: "State") { (success, result, error) in
            finished(success,result, error)
        }
    }
    
    public func downloadDistrictList( params:[String: Any],finished: @escaping (Bool,Any,CustomServiceError?) -> Void) {
//        self.request(BaseUrl.url + EndPoint.district_List , httpMethod: RequestType.POST.rawValue, apiType: APIType.NonDeviceManagement, parameter: params) { (success, result, error) in
//            finished(success,result, error)
//        }
        
        getJsonFromFile(fileName: "District") { (success, result, error) in
            finished(success,result, error)
        }
    }
    public func downloadTahsilList( params:[String: Any],finished: @escaping (Bool,Any,CustomServiceError?) -> Void) {
//        self.request(BaseUrl.url + EndPoint.Tahsil_List , httpMethod: RequestType.POST.rawValue, apiType: APIType.NonDeviceManagement, parameter: params) { (success, result, error) in
//            finished(success,result, error)
//        }
        
        getJsonFromFile(fileName: "Tehsil") { (success, result, error) in
            finished(success,result, error)
        }
    }
    
    
    public func downloadEBList( params:[String: String],finished: @escaping (Bool,Any,CustomServiceError?) -> Void) {
        self.request(BaseUrl.url + EndPoint.ebList , httpMethod: RequestType.POST.rawValue, apiType: APIType.NonDeviceManagement, parameter: params) { (success, result, error) in
            finished(success,result, error)
        }
    }
    
    
    public func postEBStartDate( params:[String: String],finished: @escaping (Bool,Any,CustomServiceError?) -> Void) {
        self.request(BaseUrl.url + EndPoint.EB_Start_Date , httpMethod: RequestType.POST.rawValue, apiType: APIType.NonDeviceManagement, parameter: params) { (success, result, error) in
            finished(success,result, error)
        }
    }
    
    public func postExpectedHouseHold( params:[String: String],finished: @escaping (Bool,Any,CustomServiceError?) -> Void) {
        self.request(BaseUrl.url + EndPoint.Expected_HH , httpMethod: RequestType.POST.rawValue, apiType: APIType.NonDeviceManagement, parameter: params) { (success, result, error) in
            finished(success,result, error)
        }
    }
    
    public func postEBCompletation( params:[String: String],finished: @escaping (Bool,Any,CustomServiceError?) -> Void) {
        self.request(BaseUrl.url + EndPoint.EB_Completation , httpMethod: RequestType.POST.rawValue, apiType: APIType.NonDeviceManagement, parameter: params) { (success, result, error) in
            finished(success,result, error)
        }
    }
    
    public func postEnrollementRequest( params:[String: String],finished: @escaping (Bool,Any,CustomServiceError?) -> Void) {
        self.request(BaseUrl.url + EndPoint.Device_Enroll , httpMethod: RequestType.POST.rawValue, apiType: APIType.DeviceManagement, parameter: params) { (success, result, error) in
            finished(success,result, error)
        }
    }
    
    
    public func postActiveDeviceRequest(finished: @escaping (Bool,Any,CustomServiceError?) -> Void) {
           self.request(BaseUrl.url + EndPoint.Active_Device , httpMethod: RequestType.POST.rawValue, apiType: APIType.DeviceManagement, parameter: [:]) { (success, result, error) in
               finished(success,result, error)
           }
       }
       
       public func postUploadDataRequest(params:[String: Any],finished: @escaping (Bool,Any,CustomServiceError?) -> Void) {
        var endUrl = EndPoint.Upload_Data
        if !util.isEnumerator() {
            endUrl = EndPoint.Super_UploadData
        }
        
            self.request(BaseUrl.url + endUrl , httpMethod: RequestType.POST.rawValue, apiType: APIType.NonDeviceManagement, parameter: params) { (success, result, error) in
                finished(success,result, error)
            }
        }
    
    public func callAPI_download2019Data( params:[String: Any],finished: @escaping (Bool,Any,CustomServiceError?) -> Void) {
        var endPoint = EndPoint.super_downloadEb
        
        if util.isEnumerator() {
           endPoint = EndPoint.npr_2019Data_download
        }
        self.request(BaseUrl.url + endPoint  , httpMethod: RequestType.POST.rawValue, apiType: APIType.NonDeviceManagement, parameter: params) { (success, result, error) in
            finished(success,result, error)
        }
    }
    
    public func callAPI_download2021Data( params:[String: Any],finished: @escaping (Bool,Any,CustomServiceError?) -> Void) {
        var endPoint = EndPoint.super_downloadEb
        
        if util.isEnumerator() {
           endPoint = EndPoint.npr_2021Data_download
        }
        self.request(BaseUrl.url + endPoint  , httpMethod: RequestType.POST.rawValue, apiType: APIType.NonDeviceManagement, parameter: params) { (success, result, error) in
            finished(success,result, error)
        }
    }

   
    public func postHLODataDownload( params:[String: Any],finished: @escaping (Bool,Any,CustomServiceError?) -> Void) {
       
        
        
          let endPoint = EndPoint.hloDataDownload
        
        self.request(BaseUrl.url + endPoint  , httpMethod: RequestType.POST.rawValue, apiType: APIType.NonDeviceManagement, parameter: params) { (success, result, error) in
            finished(success,result, error)
        }
    }
    
    public func postDeEnrollementRequest( params:[String: String],finished: @escaping (Bool,Any,CustomServiceError?) -> Void) {
             self.request(BaseUrl.url + EndPoint.Device_De_Enroll , httpMethod: RequestType.POST.rawValue, apiType: APIType.DeviceManagement, parameter: params) { (success, result, error) in
             finished(success,result, error)
             }
         }
    
    public func postVerifyOTPRequest( params:[String: String],finished: @escaping (Bool,Any,CustomServiceError?) -> Void) {
        self.request(BaseUrl.url + EndPoint.Verify_OTP , httpMethod: RequestType.POST.rawValue, apiType: APIType.DeviceManagement, parameter: params) { (success, result, error) in
        finished(success,result, error)
        }
    }
    
   private func getPassword(apiType:APIType) -> String {
        
   
    
    switch apiType {
    case .DeviceManagement:
        return singleton().getCredentials().1
        
    default:
        return Singleton.sharedInstance.authToken
        
    }
    }
    
    
    private  func request(_ requestURL: String, httpMethod: String,apiType:APIType, parameter: [String : Any], _ completionBlock: ((Bool, Any, CustomServiceError?) -> Void)!) {
            print("URL:-----> \(requestURL)")
            print("PARAMS:----->  \(parameter)")
           
            if !singleton().isConnectedToNetwork() {
                let customErr = CustomServiceError.init(localizedTitle: "Connection Error!", localizedDescription: AppMessages.Connected_To_Internet, code: 502)
                completionBlock(false, [:], customErr)
                return
             }
            var request = URLRequest(url: URL(string: requestURL)!,timeoutInterval: Double.infinity)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            // Non_Device_Managment
            if apiType == APIType.NonDeviceManagement{
                request.addValue(Application.AppCode, forHTTPHeaderField: "X-Palmyra-Application")
                request.addValue(singleton().getDeviceIDORAccessToken().deviceId, forHTTPHeaderField: "X-Palmyra-device")
                request.addValue("Basic \(singleton().authenticateWithCredentials(userId: singleton().getCredentials().userId, password: singleton().getPasswordOrToken(apiType: apiType)))", forHTTPHeaderField: "Authorization")
            }
            else{ // Device Managment
                request.addValue("Basic \(singleton().authenticateWithCredentials(userId: singleton().getCredentials().userId, password: singleton().getPasswordOrToken(apiType: apiType)))", forHTTPHeaderField: "Authorization")
            }
        
        
            do {
                let strJsonObject = try JSONSerialization.data(withJSONObject: parameter, options: JSONSerialization.WritingOptions())
                print(strJsonObject)
                request.httpBody = strJsonObject
    //          let postData = strJsonObject.data(using: .utf8)// This will print the below json.
            }
            catch{}
    //        let encoder = JSONEncoder()
    //        if let jsonData = try? encoder.encode(parameter) {
    //            request.httpBody = jsonData
    //        }
            request.httpMethod = httpMethod
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                 guard let data = data else {
                   print(String(describing: error))
                   return
                 }
                   do {
                         if let json = try JSONSerialization.jsonObject(with: data, options: []) as? Any {
                           //print("Response:----> \(json)")
                        if (response as? HTTPURLResponse)?.statusCode == 200 {
                            let customErr = CustomServiceError.init(localizedTitle: "SuccessResponse", localizedDescription: AppMessages.Success200, code: 200)
                            completionBlock(true, json, customErr)
                        }
                        else{
                            let customErr = CustomServiceError.init(localizedTitle: "ServerResponse", localizedDescription: AppMessages.Server_Response, code: 409)
                             completionBlock(false, json, customErr)
                           }
                       }
                       else {
                           let jsonStr = NSString(data: data, encoding: String.Encoding.utf8.rawValue)// No error thrown, but not NSDictionary
                           print("Error could not parse JSON: \(jsonStr ?? "")")
                           
                       }
                   } catch let parseError {
                       print(parseError)// Log the error thrown by `JSONObjectWithData`
                       let jsonStr = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
                       print("Error could not parse JSON: '\(jsonStr ?? "")'")
                       let customErr = CustomServiceError.init(localizedTitle: "Failure", localizedDescription: AppMessages.Error400, code: 400)
                       completionBlock(false, [:], customErr)
                   }
                 print("Response:----> \(String(data: data, encoding: .utf8)!)")
                 //print(String(data: data, encoding: .utf8)!)
                 
               }
               task.resume()
               
        }
    
    
    
    
}
