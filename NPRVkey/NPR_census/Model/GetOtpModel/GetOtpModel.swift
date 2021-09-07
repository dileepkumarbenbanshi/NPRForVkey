//
//  GetOtpModel.swift
//  NPR-2021
//
//  Created by Dileep on 30/08/21.
//  Copyright © 2021 admin. All rights reserved.
//



import Foundation


class GetOTPModel : NSObject, NSCoding{

    var email : String!
    var phone : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        email = dictionary["email"] as? String
        phone = dictionary["phone"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if email != nil{
            dictionary["email"] = email
        }
        if phone != nil{
            dictionary["phone"] = phone
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        email = aDecoder.decodeObject(forKey: "email") as? String
        phone = aDecoder.decodeObject(forKey: "phone") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if email != nil{
            aCoder.encode(email, forKey: "email")
        }
        if phone != nil{
            aCoder.encode(phone, forKey: "phone")
        }
    }
}
