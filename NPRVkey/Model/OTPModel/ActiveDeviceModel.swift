//
//  RootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 9, 2020

import Foundation


class ActiveDeviceModel : NSObject, NSCoding{

    var application : Int!
    var deviceId : String!
    var deviceType : Int!
    var enrolledOn : String!
    var manufacturer : String!
    var model : String!
    var serialNumber : String!
    var status : Int!
    var userId : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        application = dictionary["application"] as? Int
        deviceId = dictionary["deviceId"] as? String
        deviceType = dictionary["deviceType"] as? Int
        enrolledOn = dictionary["enrolledOn"] as? String
        manufacturer = dictionary["manufacturer"] as? String
        model = dictionary["model"] as? String
        serialNumber = dictionary["serialNumber"] as? String
        status = dictionary["status"] as? Int
        userId = dictionary["userId"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if application != nil{
            dictionary["application"] = application
        }
        if deviceId != nil{
            dictionary["deviceId"] = deviceId
        }
        if deviceType != nil{
            dictionary["deviceType"] = deviceType
        }
        if enrolledOn != nil{
            dictionary["enrolledOn"] = enrolledOn
        }
        if manufacturer != nil{
            dictionary["manufacturer"] = manufacturer
        }
        if model != nil{
            dictionary["model"] = model
        }
        if serialNumber != nil{
            dictionary["serialNumber"] = serialNumber
        }
        if status != nil{
            dictionary["status"] = status
        }
        if userId != nil{
            dictionary["userId"] = userId
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        application = aDecoder.decodeObject(forKey: "application") as? Int
        deviceId = aDecoder.decodeObject(forKey: "deviceId") as? String
        deviceType = aDecoder.decodeObject(forKey: "deviceType") as? Int
        enrolledOn = aDecoder.decodeObject(forKey: "enrolledOn") as? String
        manufacturer = aDecoder.decodeObject(forKey: "manufacturer") as? String
        model = aDecoder.decodeObject(forKey: "model") as? String
        serialNumber = aDecoder.decodeObject(forKey: "serialNumber") as? String
        status = aDecoder.decodeObject(forKey: "status") as? Int
        userId = aDecoder.decodeObject(forKey: "userId") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if application != nil{
            aCoder.encode(application, forKey: "application")
        }
        if deviceId != nil{
            aCoder.encode(deviceId, forKey: "deviceId")
        }
        if deviceType != nil{
            aCoder.encode(deviceType, forKey: "deviceType")
        }
        if enrolledOn != nil{
            aCoder.encode(enrolledOn, forKey: "enrolledOn")
        }
        if manufacturer != nil{
            aCoder.encode(manufacturer, forKey: "manufacturer")
        }
        if model != nil{
            aCoder.encode(model, forKey: "model")
        }
        if serialNumber != nil{
            aCoder.encode(serialNumber, forKey: "serialNumber")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if userId != nil{
            aCoder.encode(userId, forKey: "userId")
        }
    }
}
