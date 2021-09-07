//
//  NPRDataDownload_modelClassResult.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on September 1, 2020

import Foundation


class NPRDataDownload_modelClassResult : NSObject, NSCoding{

    var aadhaarNo : String!
        var aadhaarStatus : String!
        var actUse : String!
        var addressline1 : String!
        var addressline1sl : String!
        var addressline2 : String!
        var addressline2sl : String!
        var addressline3 : String!
        var addressline3sl : String!
        var addressline4 : String!
        var addressline4sl : String!
        var addressline5 : String!
        var addressline5sl : String!
        var blockno : String!
    
        var censusHHNumber : String!
        var censusHOuseNumber : String!
        var countryname : String!
        var countrynamesl : String!
        var districtcode : String!
        var districtname : String!
        var districtnamesl : String!
        var dob : String!
        var dobType : String!
        var durationinyear : String!
        var eduname : String!
        var edunamesl : String!
        var fathercode : String!
        var fathernm : String!
        var fathernmsl : String!
        var firstName : String!
        var  firstnamesl : String!
        var genderid : String!
        var hh : String!
        var hhNoHh : String!
        var hhType : String!
        var languageRow : String!
        var lastnamesl : String!
        var lastName : String!
    
        var memberStatus : String!
        var  middleName : String!
        var  middlenamesl : String!
        var mothercode : String!
        var mothernm : String!
        var mothernmsl : String!
        var mstatusid : String!
        var name : String!
        var nameSl : String!
    
        var nameOnCard : String!
        var nameOnCardsl : String!
        var nameRespondent : String!
        var nameRespondentsl : String!
        var namesl : String!
        var natname : String!
        var natnamesl : String!
        var occuname : String!
        var occunamesl : String!
        var paddressline1 : String!
        var paddressline1sl : String!
        var paddressline2 : String!
        var paddressline2sl : String!
        var paddressline3 : String!
        var paddressline3sl : String!
        var paddressline4 : String!
        var paddressline4sl : String!
        var paddressline5 : String!
        var paddressline5sl : String!
        var phoneNumber : String!
        var phoneRespondent : String!
        var pincode : String!
        var ppincode : String!
        var rationCardNo : String!
        var relCode : String!
        var relname : String!
        var relnamesl : String!
        var residentid : String!
        var slnomember : String!
        var slnoRespondent : String!
        var sloHHD : String!
    
        //var slnoRespondent : String!
        var spousecode : String!
        var spousenm : String!
        var spousenmsl : String!
        var statecode : String!
        var statename : String!
        var statenamesl : String!
        var status : String!
        var subebno : String!
        var tehsilcode : String!
        var tin : String!
        var towncode : String!
        var villagename : String!
        var villagenamesl : String!
        var wardid : String!


        /**
         * Instantiate the instance using the passed dictionary values to set the properties values
         */
        init(fromDictionary dictionary: [String:Any]){
            aadhaarNo = dictionary["aadhaarNo"] as? String
            aadhaarStatus = dictionary["aadhaarStatus"] as? String
            actUse = dictionary["actUse"] as? String
            addressline1 = dictionary["addressline1"] as? String
            addressline1sl = dictionary["addressline1sl"] as? String
            addressline2 = dictionary["addressline2"] as? String
            addressline2sl = dictionary["addressline2sl"] as? String
            addressline3 = dictionary["addressline3"] as? String
            addressline3sl = dictionary["addressline3sl"] as? String
            addressline4 = dictionary["addressline4"] as? String
            addressline4sl = dictionary["addressline4sl"] as? String
            addressline5 = dictionary["addressline5"] as? String
            addressline5sl = dictionary["addressline5sl"] as? String
            blockno = dictionary["blockno"] as? String
            countryname = dictionary["countryname"] as? String
            countrynamesl = dictionary["countrynamesl"] as? String
            districtcode = dictionary["districtcode"] as? String
            districtname = dictionary["districtname"] as? String
            districtnamesl = dictionary["districtnamesl"] as? String
            dob = dictionary["dob"] as? String
            dobType = dictionary["dobType"] as? String
            durationinyear = dictionary["durationinyear"] as? String
            eduname = dictionary["eduname"] as? String
            edunamesl = dictionary["edunamesl"] as? String
            fathercode = dictionary["fathercode"] as? String
            fathernm = dictionary["fathernm"] as? String
            fathernmsl = dictionary["fathernmsl"] as? String
            genderid = dictionary["genderid"] as? String
            hh = dictionary["hh"] as? String
            if !util.isEnumerator() {
                hh = dictionary["slnohhd"] as? String
            }
            hhType = dictionary["hhType"] as? String
            if let hhNumber = dictionary["hhNoHh"] as? String {
                hhNoHh = hhNumber
            }
            else {
                
                hhNoHh = ""
            }
            if let hhNumberFrom2021API = dictionary["slnohhd"] as? String{
               hh = hhNumberFrom2021API
                hhNoHh = hhNumberFrom2021API
            }
            
            languageRow = dictionary["languageRow"] as? String
            memberStatus = dictionary["memberStatus"] as? String
            mothercode = dictionary["mothercode"] as? String
            mothernm = dictionary["mothernm"] as? String
            mothernmsl = dictionary["mothernmsl"] as? String
            mstatusid = dictionary["mstatusid"] as? String
            name = dictionary["name"] as? String
            nameSl = dictionary["namesl"] as? String
            namesl = dictionary["namesl"] as? String
            firstName = dictionary["firstName"] as? String
            firstnamesl = dictionary["firstnamesl"] as? String
            middleName = dictionary["middleName"] as? String
            middlenamesl = dictionary["middlenamesl"] as? String
            
            lastName = dictionary["lastName"] as? String
            lastnamesl = dictionary["lastnamesl"] as? String
            
            nameOnCard = dictionary["nameOnCard"] as? String
            nameOnCardsl = dictionary["nameOnCardsl"] as? String
            nameRespondent = dictionary["nameRespondent"] as? String
            nameRespondentsl = dictionary["nameRespondentsl"] as? String
            namesl = dictionary["namesl"] as? String
            natname = dictionary["natname"] as? String
            natnamesl = dictionary["natnamesl"] as? String
            occuname = dictionary["occuname"] as? String
            occunamesl = dictionary["occunamesl"] as? String
            paddressline1 = dictionary["paddressline1"] as? String
            paddressline1sl = dictionary["paddressline1sl"] as? String
            paddressline2 = dictionary["paddressline2"] as? String
            paddressline2sl = dictionary["paddressline2sl"] as? String
            paddressline3 = dictionary["paddressline3"] as? String
            paddressline3sl = dictionary["paddressline3sl"] as? String
            paddressline4 = dictionary["paddressline4"] as? String
            paddressline4sl = dictionary["paddressline4sl"] as? String
            paddressline5 = dictionary["paddressline5"] as? String
            paddressline5sl = dictionary["paddressline5sl"] as? String
            phoneNumber = dictionary["phoneNumber"] as? String
            phoneRespondent = dictionary["phoneRespondent"] as? String
            pincode = dictionary["pincode"] as? String
            ppincode = dictionary["ppincode"] as? String
            rationCardNo = dictionary["rationCardNo"] as? String
            relCode = dictionary["relCode"] as? String
            relname = dictionary["relname"] as? String
            relnamesl = dictionary["relnamesl"] as? String
            residentid = dictionary["residentid"] as? String
            slnomember = dictionary["slnomember"] as? String
            if !util.isEnumerator() {
                slnomember = dictionary["slnoMember"] as? String
                censusHHNumber = dictionary["censusHhNo"] as? String
                censusHOuseNumber = dictionary["censusHouseNo"] as? String
            }
            slnoRespondent = dictionary["slnoRespondent"] as? String
            spousecode = dictionary["spousecode"] as? String
            spousenm = dictionary["spousenm"] as? String
            spousenmsl = dictionary["spousenmsl"] as? String
            statecode = dictionary["statecode"] as? String
            statename = dictionary["statename"] as? String
            statenamesl = dictionary["statenamesl"] as? String
            status = dictionary["status"] as? String
            subebno = dictionary["subebno"] as? String
            tehsilcode = dictionary["tehsilcode"] as? String
            tin = dictionary["tin"] as? String
            towncode = dictionary["towncode"] as? String
            villagename = dictionary["villagename"] as? String
            villagenamesl = dictionary["villagenamesl"] as? String
            wardid = dictionary["wardid"] as? String
        }

        /**
         * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
         */
        func toDictionary() -> [String:Any]
        {
            var dictionary = [String:Any]()
            if aadhaarNo != nil{
                dictionary["aadhaarNo"] = aadhaarNo
            }
            if aadhaarStatus != nil{
                dictionary["aadhaarStatus"] = aadhaarStatus
            }
            if actUse != nil{
                dictionary["actUse"] = actUse
            }
            if addressline1 != nil{
                dictionary["addressline1"] = addressline1
            }
            if addressline1sl != nil{
                dictionary["addressline1sl"] = addressline1sl
            }
            if addressline2 != nil{
                dictionary["addressline2"] = addressline2
            }
            if addressline2sl != nil{
                dictionary["addressline2sl"] = addressline2sl
            }
            if addressline3 != nil{
                dictionary["addressline3"] = addressline3
            }
            if addressline3sl != nil{
                dictionary["addressline3sl"] = addressline3sl
            }
            if addressline4 != nil{
                dictionary["addressline4"] = addressline4
            }
            if addressline4sl != nil{
                dictionary["addressline4sl"] = addressline4sl
            }
            if addressline5 != nil{
                dictionary["addressline5"] = addressline5
            }
            if addressline5sl != nil{
                dictionary["addressline5sl"] = addressline5sl
            }
            if blockno != nil{
                dictionary["blockno"] = blockno
            }
            if countryname != nil{
                dictionary["countryname"] = countryname
            }
            if countrynamesl != nil{
                dictionary["countrynamesl"] = countrynamesl
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
            if dob != nil{
                dictionary["dob"] = dob
            }
            if dobType != nil{
                dictionary["dobType"] = dobType
            }
            if durationinyear != nil{
                dictionary["durationinyear"] = durationinyear
            }
            if eduname != nil{
                dictionary["eduname"] = eduname
            }
            if edunamesl != nil{
                dictionary["edunamesl"] = edunamesl
            }
            if fathercode != nil{
                dictionary["fathercode"] = fathercode
            }
            if fathernm != nil{
                dictionary["fathernm"] = fathernm
            }
            if fathernmsl != nil{
                dictionary["fathernmsl"] = fathernmsl
            }
            if genderid != nil{
                dictionary["genderid"] = genderid
            }
            if hh != nil{
                dictionary["hh"] = hh
            }
            if hhNoHh != nil{
                dictionary["hhNoHh"] = hhNoHh
            }
            if memberStatus != nil{
                dictionary["memberStatus"] = memberStatus
            }
            if mothercode != nil{
                dictionary["mothercode"] = mothercode
            }
            if mothernm != nil{
                dictionary["mothernm"] = mothernm
            }
            if mothernmsl != nil{
                dictionary["mothernmsl"] = mothernmsl
            }
            if mstatusid != nil{
                dictionary["mstatusid"] = mstatusid
            }
            if name != nil{
                dictionary["name"] = name
            }
            if nameOnCard != nil{
                dictionary["nameOnCard"] = nameOnCard
            }
            if nameOnCardsl != nil{
                dictionary["nameOnCardsl"] = nameOnCardsl
            }
            if nameRespondent != nil{
                dictionary["nameRespondent"] = nameRespondent
            }
            if nameRespondentsl != nil{
                dictionary["nameRespondentsl"] = nameRespondentsl
            }
            if namesl != nil{
                dictionary["namesl"] = namesl
            }
            if natname != nil{
                dictionary["natname"] = natname
            }
            if natnamesl != nil{
                dictionary["natnamesl"] = natnamesl
            }
            if occuname != nil{
                dictionary["occuname"] = occuname
            }
            if occunamesl != nil{
                dictionary["occunamesl"] = occunamesl
            }
            if paddressline1 != nil{
                dictionary["paddressline1"] = paddressline1
            }
            if paddressline1sl != nil{
                dictionary["paddressline1sl"] = paddressline1sl
            }
            if paddressline2 != nil{
                dictionary["paddressline2"] = paddressline2
            }
            if paddressline2sl != nil{
                dictionary["paddressline2sl"] = paddressline2sl
            }
            if paddressline3 != nil{
                dictionary["paddressline3"] = paddressline3
            }
            if paddressline3sl != nil{
                dictionary["paddressline3sl"] = paddressline3sl
            }
            if paddressline4 != nil{
                dictionary["paddressline4"] = paddressline4
            }
            if paddressline4sl != nil{
                dictionary["paddressline4sl"] = paddressline4sl
            }
            if paddressline5 != nil{
                dictionary["paddressline5"] = paddressline5
            }
            if paddressline5sl != nil{
                dictionary["paddressline5sl"] = paddressline5sl
            }
            if phoneNumber != nil{
                dictionary["phoneNumber"] = phoneNumber
            }
            if phoneRespondent != nil{
                dictionary["phoneRespondent"] = phoneRespondent
            }
            if pincode != nil{
                dictionary["pincode"] = pincode
            }
            if ppincode != nil{
                dictionary["ppincode"] = ppincode
            }
            if rationCardNo != nil{
                dictionary["rationCardNo"] = rationCardNo
            }
            if relCode != nil{
                dictionary["relCode"] = relCode
            }
            if relname != nil{
                dictionary["relname"] = relname
            }
            if relnamesl != nil{
                dictionary["relnamesl"] = relnamesl
            }
            if residentid != nil{
                dictionary["residentid"] = residentid
            }
            if slnomember != nil{
                dictionary["slnomember"] = slnomember
            }
            if slnoRespondent != nil{
                dictionary["slnoRespondent"] = slnoRespondent
            }
            if spousecode != nil{
                dictionary["spousecode"] = spousecode
            }
            if spousenm != nil{
                dictionary["spousenm"] = spousenm
            }
            if spousenmsl != nil{
                dictionary["spousenmsl"] = spousenmsl
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
            if status != nil{
                dictionary["status"] = status
            }
            if subebno != nil{
                dictionary["subebno"] = subebno
            }
            if tehsilcode != nil{
                dictionary["tehsilcode"] = tehsilcode
            }
            if tin != nil{
                dictionary["tin"] = tin
            }
            if towncode != nil{
                dictionary["towncode"] = towncode
            }
            if villagename != nil{
                dictionary["villagename"] = villagename
            }
            if villagenamesl != nil{
                dictionary["villagenamesl"] = villagenamesl
            }
            if wardid != nil{
                dictionary["wardid"] = wardid
            }
            return dictionary
        }

        /**
         * NSCoding required initializer.
         * Fills the data from the passed decoder
         */
        @objc required init(coder aDecoder: NSCoder)
        {
            aadhaarNo = aDecoder.decodeObject(forKey: "aadhaarNo") as? String
            aadhaarStatus = aDecoder.decodeObject(forKey: "aadhaarStatus") as? String
            actUse = aDecoder.decodeObject(forKey: "actUse") as? String
            addressline1 = aDecoder.decodeObject(forKey: "addressline1") as? String
            addressline1sl = aDecoder.decodeObject(forKey: "addressline1sl") as? String
            addressline2 = aDecoder.decodeObject(forKey: "addressline2") as? String
            addressline2sl = aDecoder.decodeObject(forKey: "addressline2sl") as? String
            addressline3 = aDecoder.decodeObject(forKey: "addressline3") as? String
            addressline3sl = aDecoder.decodeObject(forKey: "addressline3sl") as? String
            addressline4 = aDecoder.decodeObject(forKey: "addressline4") as? String
            addressline4sl = aDecoder.decodeObject(forKey: "addressline4sl") as? String
            addressline5 = aDecoder.decodeObject(forKey: "addressline5") as? String
            addressline5sl = aDecoder.decodeObject(forKey: "addressline5sl") as? String
            blockno = aDecoder.decodeObject(forKey: "blockno") as? String
            countryname = aDecoder.decodeObject(forKey: "countryname") as? String
            countrynamesl = aDecoder.decodeObject(forKey: "countrynamesl") as? String
            districtcode = aDecoder.decodeObject(forKey: "districtcode") as? String
            districtname = aDecoder.decodeObject(forKey: "districtname") as? String
            districtnamesl = aDecoder.decodeObject(forKey: "districtnamesl") as? String
            dob = aDecoder.decodeObject(forKey: "dob") as? String
            dobType = aDecoder.decodeObject(forKey: "dobType") as? String
            durationinyear = aDecoder.decodeObject(forKey: "durationinyear") as? String
            eduname = aDecoder.decodeObject(forKey: "eduname") as? String
            edunamesl = aDecoder.decodeObject(forKey: "edunamesl") as? String
            fathercode = aDecoder.decodeObject(forKey: "fathercode") as? String
            fathernm = aDecoder.decodeObject(forKey: "fathernm") as? String
            fathernmsl = aDecoder.decodeObject(forKey: "fathernmsl") as? String
            genderid = aDecoder.decodeObject(forKey: "genderid") as? String
            hh = aDecoder.decodeObject(forKey: "hh") as? String
            hhNoHh = aDecoder.decodeObject(forKey: "hhNoHh") as? String
            memberStatus = aDecoder.decodeObject(forKey: "memberStatus") as? String
            mothercode = aDecoder.decodeObject(forKey: "mothercode") as? String
            mothernm = aDecoder.decodeObject(forKey: "mothernm") as? String
            mothernmsl = aDecoder.decodeObject(forKey: "mothernmsl") as? String
            mstatusid = aDecoder.decodeObject(forKey: "mstatusid") as? String
            name = aDecoder.decodeObject(forKey: "name") as? String
            nameOnCard = aDecoder.decodeObject(forKey: "nameOnCard") as? String
            nameOnCardsl = aDecoder.decodeObject(forKey: "nameOnCardsl") as? String
            nameRespondent = aDecoder.decodeObject(forKey: "nameRespondent") as? String
            nameRespondentsl = aDecoder.decodeObject(forKey: "nameRespondentsl") as? String
            namesl = aDecoder.decodeObject(forKey: "namesl") as? String
            natname = aDecoder.decodeObject(forKey: "natname") as? String
            natnamesl = aDecoder.decodeObject(forKey: "natnamesl") as? String
            occuname = aDecoder.decodeObject(forKey: "occuname") as? String
            occunamesl = aDecoder.decodeObject(forKey: "occunamesl") as? String
            paddressline1 = aDecoder.decodeObject(forKey: "paddressline1") as? String
            paddressline1sl = aDecoder.decodeObject(forKey: "paddressline1sl") as? String
            paddressline2 = aDecoder.decodeObject(forKey: "paddressline2") as? String
            paddressline2sl = aDecoder.decodeObject(forKey: "paddressline2sl") as? String
            paddressline3 = aDecoder.decodeObject(forKey: "paddressline3") as? String
            paddressline3sl = aDecoder.decodeObject(forKey: "paddressline3sl") as? String
            paddressline4 = aDecoder.decodeObject(forKey: "paddressline4") as? String
            paddressline4sl = aDecoder.decodeObject(forKey: "paddressline4sl") as? String
            paddressline5 = aDecoder.decodeObject(forKey: "paddressline5") as? String
            paddressline5sl = aDecoder.decodeObject(forKey: "paddressline5sl") as? String
            phoneNumber = aDecoder.decodeObject(forKey: "phoneNumber") as? String
            phoneRespondent = aDecoder.decodeObject(forKey: "phoneRespondent") as? String
            pincode = aDecoder.decodeObject(forKey: "pincode") as? String
            ppincode = aDecoder.decodeObject(forKey: "ppincode") as? String
            rationCardNo = aDecoder.decodeObject(forKey: "rationCardNo") as? String
            relCode = aDecoder.decodeObject(forKey: "relCode") as? String
            relname = aDecoder.decodeObject(forKey: "relname") as? String
            relnamesl = aDecoder.decodeObject(forKey: "relnamesl") as? String
            residentid = aDecoder.decodeObject(forKey: "residentid") as? String
            slnomember = aDecoder.decodeObject(forKey: "slnomember") as? String
            slnoRespondent = aDecoder.decodeObject(forKey: "slnoRespondent") as? String
            spousecode = aDecoder.decodeObject(forKey: "spousecode") as? String
            spousenm = aDecoder.decodeObject(forKey: "spousenm") as? String
            spousenmsl = aDecoder.decodeObject(forKey: "spousenmsl") as? String
            statecode = aDecoder.decodeObject(forKey: "statecode") as? String
            statename = aDecoder.decodeObject(forKey: "statename") as? String
            statenamesl = aDecoder.decodeObject(forKey: "statenamesl") as? String
            status = aDecoder.decodeObject(forKey: "status") as? String
            subebno = aDecoder.decodeObject(forKey: "subebno") as? String
            tehsilcode = aDecoder.decodeObject(forKey: "tehsilcode") as? String
            tin = aDecoder.decodeObject(forKey: "tin") as? String
            towncode = aDecoder.decodeObject(forKey: "towncode") as? String
            villagename = aDecoder.decodeObject(forKey: "villagename") as? String
            villagenamesl = aDecoder.decodeObject(forKey: "villagenamesl") as? String
            wardid = aDecoder.decodeObject(forKey: "wardid") as? String
        }

        /**
         * NSCoding required method.
         * Encodes mode properties into the decoder
         */
        @objc func encode(with aCoder: NSCoder)
        {
            if aadhaarNo != nil{
                aCoder.encode(aadhaarNo, forKey: "aadhaarNo")
            }
            if aadhaarStatus != nil{
                aCoder.encode(aadhaarStatus, forKey: "aadhaarStatus")
            }
            if actUse != nil{
                aCoder.encode(actUse, forKey: "actUse")
            }
            if addressline1 != nil{
                aCoder.encode(addressline1, forKey: "addressline1")
            }
            if addressline1sl != nil{
                aCoder.encode(addressline1sl, forKey: "addressline1sl")
            }
            if addressline2 != nil{
                aCoder.encode(addressline2, forKey: "addressline2")
            }
            if addressline2sl != nil{
                aCoder.encode(addressline2sl, forKey: "addressline2sl")
            }
            if addressline3 != nil{
                aCoder.encode(addressline3, forKey: "addressline3")
            }
            if addressline3sl != nil{
                aCoder.encode(addressline3sl, forKey: "addressline3sl")
            }
            if addressline4 != nil{
                aCoder.encode(addressline4, forKey: "addressline4")
            }
            if addressline4sl != nil{
                aCoder.encode(addressline4sl, forKey: "addressline4sl")
            }
            if addressline5 != nil{
                aCoder.encode(addressline5, forKey: "addressline5")
            }
            if addressline5sl != nil{
                aCoder.encode(addressline5sl, forKey: "addressline5sl")
            }
            if blockno != nil{
                aCoder.encode(blockno, forKey: "blockno")
            }
            if countryname != nil{
                aCoder.encode(countryname, forKey: "countryname")
            }
            if countrynamesl != nil{
                aCoder.encode(countrynamesl, forKey: "countrynamesl")
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
            if dob != nil{
                aCoder.encode(dob, forKey: "dob")
            }
            if dobType != nil{
                aCoder.encode(dobType, forKey: "dobType")
            }
            if durationinyear != nil{
                aCoder.encode(durationinyear, forKey: "durationinyear")
            }
            if eduname != nil{
                aCoder.encode(eduname, forKey: "eduname")
            }
            if edunamesl != nil{
                aCoder.encode(edunamesl, forKey: "edunamesl")
            }
            if fathercode != nil{
                aCoder.encode(fathercode, forKey: "fathercode")
            }
            if fathernm != nil{
                aCoder.encode(fathernm, forKey: "fathernm")
            }
            if fathernmsl != nil{
                aCoder.encode(fathernmsl, forKey: "fathernmsl")
            }
            if genderid != nil{
                aCoder.encode(genderid, forKey: "genderid")
            }
            if hh != nil{
                aCoder.encode(hh, forKey: "hh")
            }
            if hhNoHh != nil{
                aCoder.encode(hhNoHh, forKey: "hhNoHh")
            }
            if memberStatus != nil{
                aCoder.encode(memberStatus, forKey: "memberStatus")
            }
            if mothercode != nil{
                aCoder.encode(mothercode, forKey: "mothercode")
            }
            if mothernm != nil{
                aCoder.encode(mothernm, forKey: "mothernm")
            }
            if mothernmsl != nil{
                aCoder.encode(mothernmsl, forKey: "mothernmsl")
            }
            if mstatusid != nil{
                aCoder.encode(mstatusid, forKey: "mstatusid")
            }
            if name != nil{
                aCoder.encode(name, forKey: "name")
            }
            if nameOnCard != nil{
                aCoder.encode(nameOnCard, forKey: "nameOnCard")
            }
            if nameOnCardsl != nil{
                aCoder.encode(nameOnCardsl, forKey: "nameOnCardsl")
            }
            if nameRespondent != nil{
                aCoder.encode(nameRespondent, forKey: "nameRespondent")
            }
            if nameRespondentsl != nil{
                aCoder.encode(nameRespondentsl, forKey: "nameRespondentsl")
            }
            if namesl != nil{
                aCoder.encode(namesl, forKey: "namesl")
            }
            if natname != nil{
                aCoder.encode(natname, forKey: "natname")
            }
            if natnamesl != nil{
                aCoder.encode(natnamesl, forKey: "natnamesl")
            }
            if occuname != nil{
                aCoder.encode(occuname, forKey: "occuname")
            }
            if occunamesl != nil{
                aCoder.encode(occunamesl, forKey: "occunamesl")
            }
            if paddressline1 != nil{
                aCoder.encode(paddressline1, forKey: "paddressline1")
            }
            if paddressline1sl != nil{
                aCoder.encode(paddressline1sl, forKey: "paddressline1sl")
            }
            if paddressline2 != nil{
                aCoder.encode(paddressline2, forKey: "paddressline2")
            }
            if paddressline2sl != nil{
                aCoder.encode(paddressline2sl, forKey: "paddressline2sl")
            }
            if paddressline3 != nil{
                aCoder.encode(paddressline3, forKey: "paddressline3")
            }
            if paddressline3sl != nil{
                aCoder.encode(paddressline3sl, forKey: "paddressline3sl")
            }
            if paddressline4 != nil{
                aCoder.encode(paddressline4, forKey: "paddressline4")
            }
            if paddressline4sl != nil{
                aCoder.encode(paddressline4sl, forKey: "paddressline4sl")
            }
            if paddressline5 != nil{
                aCoder.encode(paddressline5, forKey: "paddressline5")
            }
            if paddressline5sl != nil{
                aCoder.encode(paddressline5sl, forKey: "paddressline5sl")
            }
            if phoneNumber != nil{
                aCoder.encode(phoneNumber, forKey: "phoneNumber")
            }
            if phoneRespondent != nil{
                aCoder.encode(phoneRespondent, forKey: "phoneRespondent")
            }
            if pincode != nil{
                aCoder.encode(pincode, forKey: "pincode")
            }
            if ppincode != nil{
                aCoder.encode(ppincode, forKey: "ppincode")
            }
            if rationCardNo != nil{
                aCoder.encode(rationCardNo, forKey: "rationCardNo")
            }
            if relCode != nil{
                aCoder.encode(relCode, forKey: "relCode")
            }
            if relname != nil{
                aCoder.encode(relname, forKey: "relname")
            }
            if relnamesl != nil{
                aCoder.encode(relnamesl, forKey: "relnamesl")
            }
            if residentid != nil{
                aCoder.encode(residentid, forKey: "residentid")
            }
            if slnomember != nil{
                aCoder.encode(slnomember, forKey: "slnomember")
            }
            if slnoRespondent != nil{
                aCoder.encode(slnoRespondent, forKey: "slnoRespondent")
            }
            if spousecode != nil{
                aCoder.encode(spousecode, forKey: "spousecode")
            }
            if spousenm != nil{
                aCoder.encode(spousenm, forKey: "spousenm")
            }
            if spousenmsl != nil{
                aCoder.encode(spousenmsl, forKey: "spousenmsl")
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
            if status != nil{
                aCoder.encode(status, forKey: "status")
            }
            if subebno != nil{
                aCoder.encode(subebno, forKey: "subebno")
            }
            if tehsilcode != nil{
                aCoder.encode(tehsilcode, forKey: "tehsilcode")
            }
            if tin != nil{
                aCoder.encode(tin, forKey: "tin")
            }
            if towncode != nil{
                aCoder.encode(towncode, forKey: "towncode")
            }
            if villagename != nil{
                aCoder.encode(villagename, forKey: "villagename")
            }
            if villagenamesl != nil{
                aCoder.encode(villagenamesl, forKey: "villagenamesl")
            }
            if wardid != nil{
                aCoder.encode(wardid, forKey: "wardid")
            }
        }
    }

