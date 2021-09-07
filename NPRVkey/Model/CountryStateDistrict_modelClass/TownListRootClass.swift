//
//  TownListRootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 16, 2020

import Foundation


class TownListRootClass : NSObject, NSCoding{

    var districtcode : String!
    var statecode : String!
    var tehsilcode : String!
    var towncode : String!
    var townname : String!
    var townnamenl : String!
    var townnamesl : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        districtcode = dictionary["districtcode"] as? String
        statecode = dictionary["statecode"] as? String
        tehsilcode = dictionary["tehsilcode"] as? String
        towncode = dictionary["towncode"] as? String
        townname = dictionary["townname"] as? String
        townnamenl = dictionary["townnamenl"] as? String
        townnamesl = dictionary["townnamesl"] as? String
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
        if towncode != nil{
            dictionary["towncode"] = towncode
        }
        if townname != nil{
            dictionary["townname"] = townname
        }
        if townnamenl != nil{
            dictionary["townnamenl"] = townnamenl
        }
        if townnamesl != nil{
            dictionary["townnamesl"] = townnamesl
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
        towncode = aDecoder.decodeObject(forKey: "towncode") as? String
        townname = aDecoder.decodeObject(forKey: "townname") as? String
        townnamenl = aDecoder.decodeObject(forKey: "townnamenl") as? String
        townnamesl = aDecoder.decodeObject(forKey: "townnamesl") as? String
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
        if towncode != nil{
            aCoder.encode(towncode, forKey: "towncode")
        }
        if townname != nil{
            aCoder.encode(townname, forKey: "townname")
        }
        if townnamenl != nil{
            aCoder.encode(townnamenl, forKey: "townnamenl")
        }
        if townnamesl != nil{
            aCoder.encode(townnamesl, forKey: "townnamesl")
        }
    }
}