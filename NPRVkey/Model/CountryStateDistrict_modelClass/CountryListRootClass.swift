//
//  CountryListRootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 16, 2020

import Foundation


class CountryListRootClass : NSObject, NSCoding{

    var country : String!
    var createdOn : String!
    var id : String!
    var lastUpdOn : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        country = dictionary["country"] as? String
        createdOn = dictionary["createdOn"] as? String
        id = dictionary["id"] as? String
        lastUpdOn = dictionary["lastUpdOn"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if country != nil{
            dictionary["country"] = country
        }
        if createdOn != nil{
            dictionary["createdOn"] = createdOn
        }
        if id != nil{
            dictionary["id"] = id
        }
        if lastUpdOn != nil{
            dictionary["lastUpdOn"] = lastUpdOn
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        country = aDecoder.decodeObject(forKey: "country") as? String
        createdOn = aDecoder.decodeObject(forKey: "createdOn") as? String
        id = aDecoder.decodeObject(forKey: "id") as? String
        lastUpdOn = aDecoder.decodeObject(forKey: "lastUpdOn") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if country != nil{
            aCoder.encode(country, forKey: "country")
        }
        if createdOn != nil{
            aCoder.encode(createdOn, forKey: "createdOn")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if lastUpdOn != nil{
            aCoder.encode(lastUpdOn, forKey: "lastUpdOn")
        }
    }
}