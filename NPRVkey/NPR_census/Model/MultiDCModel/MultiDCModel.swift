//
//  MultiDCModel.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on August 24, 2021

import Foundation


class MultiDCModel : NSObject, NSCoding{

    var baseurl : String!
    var statecode : String!
    var userId : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        baseurl = dictionary["baseurl"] as? String
        statecode = dictionary["statecode"] as? String
        userId = dictionary["user_id"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if baseurl != nil{
            dictionary["baseurl"] = baseurl
        }
        if statecode != nil{
            dictionary["statecode"] = statecode
        }
        if userId != nil{
            dictionary["user_id"] = userId
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        baseurl = aDecoder.decodeObject(forKey: "baseurl") as? String
        statecode = aDecoder.decodeObject(forKey: "statecode") as? String
        userId = aDecoder.decodeObject(forKey: "user_id") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if baseurl != nil{
            aCoder.encode(baseurl, forKey: "baseurl")
        }
        if statecode != nil{
            aCoder.encode(statecode, forKey: "statecode")
        }
        if userId != nil{
            aCoder.encode(userId, forKey: "user_id")
        }
    }
}