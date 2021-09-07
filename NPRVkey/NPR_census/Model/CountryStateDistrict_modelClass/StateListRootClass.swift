//
//  StateListRootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 16, 2020

import Foundation


class StateListRootClass : NSObject, NSCoding{

    var statecode : String!
    var statename : String!
    var statenamenl : String!
    var statenamesl : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        statecode = dictionary["statecode"] as? String
        statename = dictionary["statename"] as? String
        statenamenl = dictionary["statenamenl"] as? String
        statenamesl = dictionary["statenamesl"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if statecode != nil{
            dictionary["statecode"] = statecode
        }
        if statename != nil{
            dictionary["statename"] = statename
        }
        if statenamenl != nil{
            dictionary["statenamenl"] = statenamenl
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
        statecode = aDecoder.decodeObject(forKey: "statecode") as? String
        statename = aDecoder.decodeObject(forKey: "statename") as? String
        statenamenl = aDecoder.decodeObject(forKey: "statenamenl") as? String
        statenamesl = aDecoder.decodeObject(forKey: "statenamesl") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if statecode != nil{
            aCoder.encode(statecode, forKey: "statecode")
        }
        if statename != nil{
            aCoder.encode(statename, forKey: "statename")
        }
        if statenamenl != nil{
            aCoder.encode(statenamenl, forKey: "statenamenl")
        }
        if statenamesl != nil{
            aCoder.encode(statenamesl, forKey: "statenamesl")
        }
    }
}