//
//  DistrictListRootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 16, 2020

import Foundation


class DistrictListRootClass : NSObject, NSCoding{

    var cpsuId : String!
    var districtcode : String!
    var districtname : String!
    var districtnamenl : String!
    var districtnamesl : String!
    var langCode : String!
    var statecode : String!
    var statenamesl : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        cpsuId = dictionary["cpsuId"] as? String
        districtcode = dictionary["districtcode"] as? String
        districtname = dictionary["districtname"] as? String
        districtnamenl = dictionary["districtnamenl"] as? String
        districtnamesl = dictionary["districtnamesl"] as? String
        langCode = dictionary["langCode"] as? String
        statecode = dictionary["statecode"] as? String
        statenamesl = dictionary["statenamesl"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if cpsuId != nil{
            dictionary["cpsuId"] = cpsuId
        }
        if districtcode != nil{
            dictionary["districtcode"] = districtcode
        }
        if districtname != nil{
            dictionary["districtname"] = districtname
        }
        if districtnamenl != nil{
            dictionary["districtnamenl"] = districtnamenl
        }
        if districtnamesl != nil{
            dictionary["districtnamesl"] = districtnamesl
        }
        if langCode != nil{
            dictionary["langCode"] = langCode
        }
        if statecode != nil{
            dictionary["statecode"] = statecode
        }
        if statenamesl != nil{
            dictionary["statenamesl"] = statenamesl
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        cpsuId = aDecoder.decodeObject(forKey: "cpsuId") as? String
        districtcode = aDecoder.decodeObject(forKey: "districtcode") as? String
        districtname = aDecoder.decodeObject(forKey: "districtname") as? String
        districtnamenl = aDecoder.decodeObject(forKey: "districtnamenl") as? String
        districtnamesl = aDecoder.decodeObject(forKey: "districtnamesl") as? String
        langCode = aDecoder.decodeObject(forKey: "langCode") as? String
        statecode = aDecoder.decodeObject(forKey: "statecode") as? String
        statenamesl = aDecoder.decodeObject(forKey: "statenamesl") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if cpsuId != nil{
            aCoder.encode(cpsuId, forKey: "cpsuId")
        }
        if districtcode != nil{
            aCoder.encode(districtcode, forKey: "districtcode")
        }
        if districtname != nil{
            aCoder.encode(districtname, forKey: "districtname")
        }
        if districtnamenl != nil{
            aCoder.encode(districtnamenl, forKey: "districtnamenl")
        }
        if districtnamesl != nil{
            aCoder.encode(districtnamesl, forKey: "districtnamesl")
        }
        if langCode != nil{
            aCoder.encode(langCode, forKey: "langCode")
        }
        if statecode != nil{
            aCoder.encode(statecode, forKey: "statecode")
        }
        if statenamesl != nil{
            aCoder.encode(statenamesl, forKey: "statenamesl")
        }
    }
}