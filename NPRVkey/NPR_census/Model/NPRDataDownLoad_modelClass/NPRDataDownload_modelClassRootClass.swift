//
//  NPRDataDownload_modelClassRootClass.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 1, 2020

import Foundation


class NPRDataDownload_modelClassRootClass : NSObject, NSCoding{

    var limit : Int!
        var offset : Int!
        var result : [NPRDataDownload_modelClassResult]!
        var total : Int!


        /**
         * Instantiate the instance using the passed dictionary values to set the properties values
         */
        init(fromDictionary dictionary: [String:Any]){
            limit = dictionary["limit"] as? Int
            offset = dictionary["offset"] as? Int
            total = dictionary["total"] as? Int
            result = [NPRDataDownload_modelClassResult]()
            if let resultArray = dictionary["result"] as? [[String:Any]]{
                for dic in resultArray{
                    let value = NPRDataDownload_modelClassResult(fromDictionary: dic)
                    result.append(value)
                }
            }
        }

        /**
         * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
         */
        func toDictionary() -> [String:Any]
        {
            var dictionary = [String:Any]()
            if limit != nil{
                dictionary["limit"] = limit
            }
            if offset != nil{
                dictionary["offset"] = offset
            }
            if total != nil{
                dictionary["total"] = total
            }
            if result != nil{
                var dictionaryElements = [[String:Any]]()
                for resultElement in result {
                    dictionaryElements.append(resultElement.toDictionary())
                }
                dictionary["result"] = dictionaryElements
            }
            return dictionary
        }

        /**
         * NSCoding required initializer.
         * Fills the data from the passed decoder
         */
        @objc required init(coder aDecoder: NSCoder)
        {
            limit = aDecoder.decodeObject(forKey: "limit") as? Int
            offset = aDecoder.decodeObject(forKey: "offset") as? Int
            result = aDecoder.decodeObject(forKey: "result") as? [NPRDataDownload_modelClassResult]
            total = aDecoder.decodeObject(forKey: "total") as? Int
        }

        /**
         * NSCoding required method.
         * Encodes mode properties into the decoder
         */
        @objc func encode(with aCoder: NSCoder)
        {
            if limit != nil{
                aCoder.encode(limit, forKey: "limit")
            }
            if offset != nil{
                aCoder.encode(offset, forKey: "offset")
            }
            if result != nil{
                aCoder.encode(result, forKey: "result")
            }
            if total != nil{
                aCoder.encode(total, forKey: "total")
            }
        }
    }

