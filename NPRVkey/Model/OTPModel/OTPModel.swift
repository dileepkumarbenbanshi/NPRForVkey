//
//  OTPModel.swift
//  NPR_census
//
//  Created by mac on 09/09/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

class OTPModel : NSObject, NSCoding{

    var errorCode : Int!
    var message : String!
    var status : Int!
    //var activeDataArr: NSArray!
    var activeData:[ActiveDeviceModel]!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        errorCode = dictionary["errorCode"] as? Int
        message = dictionary["message"] as? String
        status = dictionary["status"] as? Int
        //activeDataArr = NSArray()
        activeData = [ActiveDeviceModel]()
    }

    func setActiveData(arr:NSArray?){
        if let resultArr = arr {
            for dic in resultArr{
               let dic = ActiveDeviceModel(fromDictionary: dic as! [String : Any])
                activeData.append(dic)
            }
        }
    }
    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if errorCode != nil{
            dictionary["errorCode"] = errorCode
        }
        if message != nil{
            dictionary["message"] = message
        }
        if status != nil{
            dictionary["status"] = status
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        errorCode = aDecoder.decodeObject(forKey: "errorCode") as? Int
        message = aDecoder.decodeObject(forKey: "message") as? String
        status = aDecoder.decodeObject(forKey: "status") as? Int
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if errorCode != nil{
            aCoder.encode(errorCode, forKey: "errorCode")
        }
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
    }
}
