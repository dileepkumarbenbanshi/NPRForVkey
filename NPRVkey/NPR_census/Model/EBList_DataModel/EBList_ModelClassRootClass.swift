//
//  EBList_ModelClassRootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 1, 2020

import Foundation


class EBList_ModelClassRootClass : NSObject, NSCoding{

    var blockno : String!
    var districtcode : String!
    var districtname : String!
    var districtnamesl : String!
    var enumerator : String!
    var enumStartedOn : String!
    var expHH : Int!
    var name :String?
    
    var statecode : String!
    var stateLanguageCode : String!
    
    var statename : String!
    var statenamesl : String!
    var startDate : String!
    var endDate : String!
    var subebno : String!
    var tehsilcode : String!
    var tehsilname : String!
    var tehsilnamesl : String!
    var towncode : String!
    var townname : String!
    var townnamesl : String!
    var ward : String!
    var ebCompletedOn : String!
    

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        blockno = dictionary["blockno"] as? String
        districtcode = dictionary["districtcode"] as? String
        districtname = dictionary["districtname"] as? String
        districtnamesl = dictionary["districtnamesl"] as? String
        enumerator = dictionary["enumerator"] as? String
        enumStartedOn = dictionary["enumStartedOn"] as? String
        expHH = dictionary["expHH"] as? Int
        
        if !util.isEnumerator() {
            name = dictionary["name"] as? String
        }else{
            startDate = dictionary["npr_start_date"] as? String
           endDate = dictionary["npr_end_date"] as? String
        }
        
        statecode = dictionary["statecode"] as? String
        statename = dictionary["statename"] as? String
        statenamesl = dictionary["statenamesl"] as? String
        subebno = dictionary["subebno"] as? String
        tehsilcode = dictionary["tehsilcode"] as? String
        tehsilname = dictionary["tehsilname"] as? String
        tehsilnamesl = dictionary["tehsilnamesl"] as? String
        towncode = dictionary["towncode"] as? String
        townname = dictionary["townname"] as? String
        townnamesl = dictionary["townnamesl"] as? String
        ward = dictionary["ward"] as? String
        stateLanguageCode = dictionary["state_language_codes"] as? String
        ebCompletedOn = ""
        if let ebCompletedon = dictionary["enumCompletedOn"] as? String {
            ebCompletedOn = ebCompletedon
            
        }
        if let enumStarted = dictionary["enumStartedOn"] as? String {
            enumStartedOn = enumStarted
            
        }else{
            enumStartedOn = ""
        }
        
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if blockno != nil{
            dictionary["blockno"] = blockno
        }
        if districtcode != nil{
            dictionary["districtcode"] = districtcode
        }
        if districtname != nil{
            dictionary["districtname"] = districtname
        }
        if districtnamesl != nil{
            dictionary["districtnamesl"] = districtnamesl
        }
        if enumerator != nil{
            dictionary["enumerator"] = enumerator
        }
        if enumStartedOn != nil{
            dictionary["enumStartedOn"] = enumStartedOn
        }
        if expHH != nil{
            dictionary["expHH"] = expHH
        }
        if statecode != nil{
            dictionary["statecode"] = statecode
        }
        if statename != nil{
            dictionary["statename"] = statename
        }
        if statenamesl != nil{
            dictionary["statenamesl"] = statenamesl
        }
        if subebno != nil{
            dictionary["subebno"] = subebno
        }
        if tehsilcode != nil{
            dictionary["tehsilcode"] = tehsilcode
        }
        if tehsilname != nil{
            dictionary["tehsilname"] = tehsilname
        }
        if tehsilnamesl != nil{
            dictionary["tehsilnamesl"] = tehsilnamesl
        }
        if towncode != nil{
            dictionary["towncode"] = towncode
        }
        if townname != nil{
            dictionary["townname"] = townname
        }
        if townnamesl != nil{
            dictionary["townnamesl"] = townnamesl
        }
        if ward != nil{
            dictionary["ward"] = ward
        }
        return dictionary
    }

    /**
     * NSCoding required initializer.
     * Fills the data from the passed decoder
     */
    @objc required init(coder aDecoder: NSCoder)
    {
        blockno = aDecoder.decodeObject(forKey: "blockno") as? String
        districtcode = aDecoder.decodeObject(forKey: "districtcode") as? String
        districtname = aDecoder.decodeObject(forKey: "districtname") as? String
        districtnamesl = aDecoder.decodeObject(forKey: "districtnamesl") as? String
        enumerator = aDecoder.decodeObject(forKey: "enumerator") as? String
        enumStartedOn = aDecoder.decodeObject(forKey: "enumStartedOn") as? String
        expHH = aDecoder.decodeObject(forKey: "expHH") as? Int
        statecode = aDecoder.decodeObject(forKey: "statecode") as? String
        statename = aDecoder.decodeObject(forKey: "statename") as? String
        statenamesl = aDecoder.decodeObject(forKey: "statenamesl") as? String
        subebno = aDecoder.decodeObject(forKey: "subebno") as? String
        tehsilcode = aDecoder.decodeObject(forKey: "tehsilcode") as? String
        tehsilname = aDecoder.decodeObject(forKey: "tehsilname") as? String
        tehsilnamesl = aDecoder.decodeObject(forKey: "tehsilnamesl") as? String
        towncode = aDecoder.decodeObject(forKey: "towncode") as? String
        townname = aDecoder.decodeObject(forKey: "townname") as? String
        townnamesl = aDecoder.decodeObject(forKey: "townnamesl") as? String
        ward = aDecoder.decodeObject(forKey: "ward") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if blockno != nil{
            aCoder.encode(blockno, forKey: "blockno")
        }
        if districtcode != nil{
            aCoder.encode(districtcode, forKey: "districtcode")
        }
        if districtname != nil{
            aCoder.encode(districtname, forKey: "districtname")
        }
        if districtnamesl != nil{
            aCoder.encode(districtnamesl, forKey: "districtnamesl")
        }
        if enumerator != nil{
            aCoder.encode(enumerator, forKey: "enumerator")
        }
        if enumStartedOn != nil{
            aCoder.encode(enumStartedOn, forKey: "enumStartedOn")
        }
        if expHH != nil{
            aCoder.encode(expHH, forKey: "expHH")
        }
        if statecode != nil{
            aCoder.encode(statecode, forKey: "statecode")
        }
        if statename != nil{
            aCoder.encode(statename, forKey: "statename")
        }
        if statenamesl != nil{
            aCoder.encode(statenamesl, forKey: "statenamesl")
        }
        if subebno != nil{
            aCoder.encode(subebno, forKey: "subebno")
        }
        if tehsilcode != nil{
            aCoder.encode(tehsilcode, forKey: "tehsilcode")
        }
        if tehsilname != nil{
            aCoder.encode(tehsilname, forKey: "tehsilname")
        }
        if tehsilnamesl != nil{
            aCoder.encode(tehsilnamesl, forKey: "tehsilnamesl")
        }
        if towncode != nil{
            aCoder.encode(towncode, forKey: "towncode")
        }
        if townname != nil{
            aCoder.encode(townname, forKey: "townname")
        }
        if townnamesl != nil{
            aCoder.encode(townnamesl, forKey: "townnamesl")
        }
        if ward != nil{
            aCoder.encode(ward, forKey: "ward")
        }
    }
}
