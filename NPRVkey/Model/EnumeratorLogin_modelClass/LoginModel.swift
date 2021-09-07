//
//  LoginModel.swift
//  Created by mac on 05/08/20.

import Foundation

class LoginModel : NSObject, NSCoding{

    var accessToken : String!
    var otp : String!
    var phone : String!
    var status : Int!
    var deviceId: String!
    var email:String!
    var message:String!
    var userType:String!
    
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        accessToken = dictionary["accessToken"] as? String
        otp = dictionary["otp"] as? String
        phone = dictionary["phone"] as? String
        status = dictionary["status"] as? Int
        deviceId = dictionary["deviceId"] as? String
        email = dictionary["email"] as? String
        message = dictionary["message"] as? String
        userType = dictionary["userType"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if accessToken != nil{
            dictionary["accessToken"] = accessToken
        }
        if otp != nil{
            dictionary["otp"] = otp
        }
        if phone != nil{
            dictionary["phone"] = phone
        }
        if status != nil{
            dictionary["status"] = status
        }
        if deviceId != nil{
            dictionary["deviceId"] = deviceId
        }
        if email != nil{
                  dictionary["email"] = email
            }
        if message != nil{
                   dictionary["message"] = message
            }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        accessToken = aDecoder.decodeObject(forKey: "accessToken") as? String
        otp = aDecoder.decodeObject(forKey: "otp") as? String
        phone = aDecoder.decodeObject(forKey: "phone") as? String
        status = aDecoder.decodeObject(forKey: "status") as? Int
        deviceId = aDecoder.decodeObject(forKey: "deviceId") as? String
        email = aDecoder.decodeObject(forKey: "email") as? String
        message = aDecoder.decodeObject(forKey: "message") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if accessToken != nil{
            aCoder.encode(accessToken, forKey: "accessToken")
        }
        if otp != nil{
            aCoder.encode(otp, forKey: "otp")
        }
        if phone != nil{
            aCoder.encode(phone, forKey: "phone")
        }
        if status != nil{
            aCoder.encode(status, forKey: "status")
        }
        if deviceId != nil{
            aCoder.encode(deviceId, forKey: "deviceId")
        }
        if email != nil{
            aCoder.encode(email, forKey: "email")
        }
        if message != nil{
            aCoder.encode(message, forKey: "message")
        }
    }
}
