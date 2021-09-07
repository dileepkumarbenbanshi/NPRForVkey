//
//  Singleton.swift
//  NPR_census
//
//  Created by mac on 21/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration

class Singleton: NSObject {
    static let sharedInstance = Singleton()
    var NPRRect: NPRRectView!
    var RequestManager:NPRURLRequestSession!
    var Alert:NPRAlert!
    var userId = ""
    var activeEB = ""
    
     var email = ""
    var authToken = "zk2W9_j1G63WF9nJctjhmSyzlLEIbCXWeeYvnfRRyhDRd8MsEgIrT7T1s_hx1wgM"
    var userName = "ec_31010068003_testing"
    var logInPassword = "Admin@1234"
    var deviceID = "A4322SDDF"
    var selectEBListModel = EB()
    
    override init() {
               super.init()
               NPRRect = NPRRectView()
               Alert = NPRAlert()
               RequestManager = NPRURLRequestSession()
           }
        
        func isConnectedToNetwork() -> Bool {
            var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
            zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
            zeroAddress.sin_family = sa_family_t(AF_INET)
            
            let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
                $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                    SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
                }
            }
            var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
            if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
                return false
            }
            let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
            let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
            let ret = (isReachable && !needsConnection)
            return ret
        }
        
        func authenticateWithCredentials(userId: String, password:String)-> String{
            let userPasswordString = "\(userId):\(password)"
            let userPasswordData = userPasswordString.data(using: .utf8)
            let base64EncodedCredential = userPasswordData?.base64EncodedString()
            return base64EncodedCredential!
        }
        
        func getCredentials()-> (userId:String,password:String){
            guard let dic = self.getFromUserDefaults(withKey:"User_Credentials") as? NSDictionary else {
                return ("","")
            }
            return(dic["userId"] as! String, dic["Password"] as! String)
        }
        
        func calculateTextheight(withConstrainedWidth width: CGFloat, font: UIFont, text:String) -> CGFloat {
              let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
            let boundingBox = text.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
              return ceil(boundingBox.height)
          }
        
        func saveToUserDefaults(withKeyValue value:Any,key:String){
            UserDefaults.standard.set(value,forKey: key)
        }
        
        func getFromUserDefaults(withKey key:String)->Any?{
            return UserDefaults.standard.object(forKey: key)
        }
        
        func getDeviceInfo()-> (deviceId: String, deviceName:String, deviceVersion:String, appVersion:String){
                   let deviceId = UIDevice.current.identifierForVendor?.uuidString
                   let deviceName = UIDevice.current.name
                   let deviceVersion = UIDevice.current.systemVersion
                   let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
                   //let deviceModelName = UIDevice.current.model
                   return (deviceId ?? "", deviceName, deviceVersion,appVersion)
               }
    
    func getDeviceIDORAccessToken()-> (deviceId:String, accessToken:String){
        guard let dic = self.getFromUserDefaults(withKey:"Device_Info") as? NSDictionary else {
            return ("","")
        }
        //return ("","")
              return(dic["deviceId"] as! String, dic["accessToken"] as! String)
          }
      
         func getPasswordOrToken(apiType:APIType) -> String {
           switch apiType {
           case .DeviceManagement:
             return singleton().getCredentials().password
            
         default:
           return singleton().getDeviceIDORAccessToken().accessToken
           }
        }
    
    func convertToBase64(image: UIImage) -> String {
      return image.pngData()!
        .base64EncodedString()
     }
    
    func getCurrentDateAndTime() -> String{
        let date = Date()
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month,.day,.hour,.minute,.second], from: date)
        let year = components.year
        let month = components.month
        let day = components.day
        let hour = components.hour
        let minute = components.minute
        let second = components.second
        let todayDate = String(day!) + "-" + String(month!) + "-" + String(year!)
        let currenTime = String(hour!) + ":" + String(minute!) + ":" +  String(second!)
        return ("\(todayDate) \(currenTime)")
    }
    
    
    func getCurrentTimeStamp()-> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let date = Date()
        let formattedString = dateFormatter.string(from: date)
        return formattedString
    }
    
   

}
    



    func singleton() -> Singleton {
        return Singleton.sharedInstance
    }

