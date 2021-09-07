//
//  TahsilListRootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 17, 2020

import Foundation


class TahsilListRootClass : NSObject, NSCoding{

    var districtcode : String!
    var statecode : String!
    var tehsilcode : String!
    var tehsilname : String!
    var tehsilnamenl : String!
    var tehsilnamesl : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        districtcode = dictionary["districtcode"] as? String
        statecode = dictionary["statecode"] as? String
        tehsilcode = dictionary["tehsilcode"] as? String
        tehsilname = dictionary["tehsilname"] as? String
        tehsilnamenl = dictionary["tehsilnamenl"] as? String
        tehsilnamesl = dictionary["tehsilnamesl"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if districtcode != nil{
            dictionary["districtcode"] = districtcode
        }
        if statecode != nil{
            dictionary["statecode"] = statecode
        }
        if tehsilcode != nil{
            dictionary["tehsilcode"] = tehsilcode
        }
        if tehsilname != nil{
            dictionary["tehsilname"] = tehsilname
        }
        if tehsilnamenl != nil{
            dictionary["tehsilnamenl"] = tehsilnamenl
        }
        if tehsilnamesl != nil{
            dictionary["tehsilnamesl"] = tehsilnamesl
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        districtcode = aDecoder.decodeObject(forKey: "districtcode") as? String
        statecode = aDecoder.decodeObject(forKey: "statecode") as? String
        tehsilcode = aDecoder.decodeObject(forKey: "tehsilcode") as? String
        tehsilname = aDecoder.decodeObject(forKey: "tehsilname") as? String
        tehsilnamenl = aDecoder.decodeObject(forKey: "tehsilnamenl") as? String
        tehsilnamesl = aDecoder.decodeObject(forKey: "tehsilnamesl") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if districtcode != nil{
            aCoder.encode(districtcode, forKey: "districtcode")
        }
        if statecode != nil{
            aCoder.encode(statecode, forKey: "statecode")
        }
        if tehsilcode != nil{
            aCoder.encode(tehsilcode, forKey: "tehsilcode")
        }
        if tehsilname != nil{
            aCoder.encode(tehsilname, forKey: "tehsilname")
        }
        if tehsilnamenl != nil{
            aCoder.encode(tehsilnamenl, forKey: "tehsilnamenl")
        }
        if tehsilnamesl != nil{
            aCoder.encode(tehsilnamesl, forKey: "tehsilnamesl")
        }
    }
}