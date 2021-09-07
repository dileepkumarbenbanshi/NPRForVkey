//
//  NPRData2021ModelClassResult.swift
//  Model Generated using http://www.jsoncafe.com/ 
//  Created on January 14, 2021

import Foundation


class NPRData2021ModelClassResult : NSObject, NSCoding{

    var aadhaar : String!
    var addressAddressline1 : String!
    var addressAddressline2 : String!
    var addressAddressline2sl : String!
    var addressDistrict : String!
    var addressState : String!
    var addressTehsilcode : String!
    var birthCountry : String!
    var birthDistrictCode : String!
    var birthStateCode : String!
    var blockno : String!
    var censusHhNo : String!
    var censusHouseNo : String!
    var districtcode : String!
    var dob : String!
    var dobType : String!
    var drivingLicence : String!
    
    var durationInyear : Int!
    var eduCode : String!
    var enumBatchId : String!
    var enumeratedOn : String!
    var enumerator : String!
    var enumSyncedOn : String!
    var fatherBirthCountry : String!
    var fatherBirthDistrict : String!
    var fatherBirthState : String!
    var fatherCode : String!
    var fatherDob : String!
    var fatherName : String!
    var fatherNamesl : String!
    var firstName : String!
    var fotherDobtype : String!
    var genderid : Int!
    var hhCompleted : Int!
    var hhStatus : Int!
    var hhType : Int!
    var isSignUpdated : Int!
    var language : String!
    var lastName : String!
    var lastResidencyCountry : String!
    var lastResidencyDistrict : String!
    var lastResidencyState : String!
    var maritalStatus : Int!
    var memberCompleted : String!
    var memberStatus : Int!
    var midleName : String!
    var mobileNumber : String!
    var motherBirthCountry : String!
    var motherBirthDistrict : String!
    var motherBirthState : String!
    var motherCode : String!
    var motherDob : String!
    var motherDobtype : String!
    var motherName : String!
    var motherNamesl : String!
    var motherTongue : String!
    var name : String!
    var nameRespondent : String!
    var namesl : String!
    var nationality : String!
    var nationalitysl : String!
    var occuCode : Int!
    var oefBirthCountryName : String!
    var oefBirthCountryNamesl : String!
    var oefBirthDistrictName : String!
    var oefBirthDistrictNamesl : String!
    var oefBirthStateName : String!
    var oefBirthStateNamesl : String!
    var oefEduName : String!
    var oefEduNamesl : String!
    var oefNationality : String!
    var oefNationalitysl : String!
    var oefOccuName : String!
    var oefOccuNamesl : String!
    var oefPermanentDistrict : String!
    var oefPermanentDistrictsl : String!
    var oefPermanentState : String!
    var oefPermanentStatesl : String!
    var oefPermanentTehsil : String!
    var oefPermanentTehsilsl : String!
    var oefPresentDistrict : String!
    var oefPresentDistrictsl : String!
    var oefPresentState : String!
    var oefPresentStatesl : String!
    var oefPresentTehsil : String!
    var oefPresentTehsilsl : String!
    var oefRelName : String!
    var oefRelNamesl : String!
    var paddressCountry : String!
    var paddressDistrict : String!
    var paddressline1 : String!
    var paddressline1sl : String!
    var paddressline2 : String!
    var paddressline2sl : String!
    var paddressState : String!
    var paddressTehsil : String!
    var pincode : String!
    var ppincode : String!
    var prevStatus : String!
    var relCode : String!
    var seReference : String!
    var signByEnumBehalfRespondant : String!
    var slnohhd : String!
    var slnoMember : String!
    var slnoRespondent : String!
    var spouseName : String!
    var spouseNamesl : String!
    var statecode : String!
    var stayingSinceBirth : Int!
    var subebno : String!
    var suprBatchId : String!
    var tehsilcode : String!
    var tin : String!
    var tin2019 : String!
    var towncode : String!
    var wardid : String!
    var voterid : String!

    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        aadhaar = dictionary["aadhaar"] as? String
        addressAddressline1 = dictionary["addressAddressline1"] as? String
        addressAddressline2 = dictionary["addressAddressline2"] as? String
        addressAddressline2sl = dictionary["addressAddressline2sl"] as? String
        addressDistrict = dictionary["addressDistrict"] as? String
        addressState = dictionary["addressState"] as? String
        addressTehsilcode = dictionary["addressTehsilcode"] as? String
        birthCountry = dictionary["birthCountry"] as? String
        birthDistrictCode = dictionary["birthDistrictCode"] as? String
        birthStateCode = dictionary["birthStateCode"] as? String
        blockno = dictionary["blockno"] as? String
        censusHhNo = dictionary["censusHhNo"] as? String
        censusHouseNo = dictionary["censusHouseNo"] as? String
        districtcode = dictionary["districtcode"] as? String
        dob = dictionary["dob"] as? String
        dobType = dictionary["dobType"] as? String
        drivingLicence = dictionary["drivingLicense"] as? String
        durationInyear = dictionary["durationInyear"] as? Int
        eduCode = dictionary["eduCode"] as? String
        enumBatchId = dictionary["enumBatchId"] as? String
        enumeratedOn = dictionary["enumeratedOn"] as? String
        enumerator = dictionary["enumerator"] as? String
        enumSyncedOn = dictionary["enumSyncedOn"] as? String
        fatherBirthCountry = dictionary["fatherBirthCountry"] as? String
        fatherBirthDistrict = dictionary["fatherBirthDistrict"] as? String
        fatherBirthState = dictionary["fatherBirthState"] as? String
        fatherCode = dictionary["fatherCode"] as? String
        fatherDob = dictionary["fatherDob"] as? String
        fatherName = dictionary["fatherName"] as? String
        fatherNamesl = dictionary["fatherNamesl"] as? String
        firstName = dictionary["firstName"] as? String
        fotherDobtype = dictionary["fotherDobtype"] as? String
        genderid = dictionary["genderid"] as? Int
        hhCompleted = dictionary["hhCompleted"] as? Int
        hhStatus = dictionary["hhStatus"] as? Int
        hhType = dictionary["hhType"] as? Int
        isSignUpdated = dictionary["isSignUpdated"] as? Int
        language = dictionary["language"] as? String
        lastName = dictionary["lastName"] as? String
        lastResidencyCountry = dictionary["lastResidencyCountry"] as? String
        lastResidencyDistrict = dictionary["lastResidencyDistrict"] as? String
        lastResidencyState = dictionary["lastResidencyState"] as? String
        maritalStatus = dictionary["maritalStatus"] as? Int
        memberCompleted = dictionary["memberCompleted"] as? String
        memberStatus = dictionary["memberStatus"] as? Int
        midleName = dictionary["midleName"] as? String
        mobileNumber = dictionary["mobileNumber"] as? String
        motherBirthCountry = dictionary["motherBirthCountry"] as? String
        motherBirthDistrict = dictionary["motherBirthDistrict"] as? String
        motherBirthState = dictionary["motherBirthState"] as? String
        motherCode = dictionary["motherCode"] as? String
        motherDob = dictionary["motherDob"] as? String
        motherDobtype = dictionary["motherDobtype"] as? String
        motherName = dictionary["motherName"] as? String
        motherNamesl = dictionary["motherNamesl"] as? String
        motherTongue = dictionary["motherTongue"] as? String
        name = dictionary["name"] as? String
        nameRespondent = dictionary["nameRespondent"] as? String
        namesl = dictionary["namesl"] as? String
        nationality = dictionary["nationality"] as? String
        nationalitysl = dictionary["nationalitysl"] as? String
        occuCode = dictionary["occuCode"] as? Int
        oefBirthCountryName = dictionary["oefBirthCountryName"] as? String
        oefBirthCountryNamesl = dictionary["oefBirthCountryNamesl"] as? String
        oefBirthDistrictName = dictionary["oefBirthDistrictName"] as? String
        oefBirthDistrictNamesl = dictionary["oefBirthDistrictNamesl"] as? String
        oefBirthStateName = dictionary["oefBirthStateName"] as? String
        oefBirthStateNamesl = dictionary["oefBirthStateNamesl"] as? String
        oefEduName = dictionary["oefEduName"] as? String
        oefEduNamesl = dictionary["oefEduNamesl"] as? String
        oefNationality = dictionary["oefNationality"] as? String
        oefNationalitysl = dictionary["oefNationalitysl"] as? String
        oefOccuName = dictionary["oefOccuName"] as? String
        oefOccuNamesl = dictionary["oefOccuNamesl"] as? String
        oefPermanentDistrict = dictionary["oefPermanentDistrict"] as? String
        oefPermanentDistrictsl = dictionary["oefPermanentDistrictsl"] as? String
        oefPermanentState = dictionary["oefPermanentState"] as? String
        oefPermanentStatesl = dictionary["oefPermanentStatesl"] as? String
        oefPermanentTehsil = dictionary["oefPermanentTehsil"] as? String
        oefPermanentTehsilsl = dictionary["oefPermanentTehsilsl"] as? String
        oefPresentDistrict = dictionary["oefPresentDistrict"] as? String
        oefPresentDistrictsl = dictionary["oefPresentDistrictsl"] as? String
        oefPresentState = dictionary["oefPresentState"] as? String
        oefPresentStatesl = dictionary["oefPresentStatesl"] as? String
        oefPresentTehsil = dictionary["oefPresentTehsil"] as? String
        oefPresentTehsilsl = dictionary["oefPresentTehsilsl"] as? String
        oefRelName = dictionary["oefRelName"] as? String
        oefRelNamesl = dictionary["oefRelNamesl"] as? String
        paddressCountry = dictionary["paddressCountry"] as? String
        paddressDistrict = dictionary["paddressDistrict"] as? String
        paddressline1 = dictionary["paddressline1"] as? String
        paddressline1sl = dictionary["paddressline1sl"] as? String
        paddressline2 = dictionary["paddressline2"] as? String
        paddressline2sl = dictionary["paddressline2sl"] as? String
        paddressState = dictionary["paddressState"] as? String
        paddressTehsil = dictionary["paddressTehsil"] as? String
        pincode = dictionary["pincode"] as? String
        ppincode = dictionary["ppincode"] as? String
        prevStatus = dictionary["prevStatus"] as? String
        relCode = dictionary["relCode"] as? String
        seReference = dictionary["seReference"] as? String
        signByEnumBehalfRespondant = dictionary["signByEnumBehalfRespondant"] as? String
        slnohhd = dictionary["slnohhd"] as? String
        slnoMember = dictionary["slnoMember"] as? String
        slnoRespondent = dictionary["slnoRespondent"] as? String
        spouseName = dictionary["spouseName"] as? String
        spouseNamesl = dictionary["spouseNamesl"] as? String
        statecode = dictionary["statecode"] as? String
        stayingSinceBirth = dictionary["stayingSinceBirth"] as? Int
        subebno = dictionary["subebno"] as? String
        suprBatchId = dictionary["suprBatchId"] as? String
        tehsilcode = dictionary["tehsilcode"] as? String
        tin = dictionary["tin"] as? String
        tin2019 = dictionary["tin2019"] as? String
        towncode = dictionary["towncode"] as? String
        wardid = dictionary["wardid"] as? String
        voterid = dictionary["voterId"] as? String
        
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if aadhaar != nil{
            dictionary["aadhaar"] = aadhaar
        }
        if addressAddressline1 != nil{
            dictionary["addressAddressline1"] = addressAddressline1
        }
        if addressAddressline2 != nil{
            dictionary["addressAddressline2"] = addressAddressline2
        }
        if addressAddressline2sl != nil{
            dictionary["addressAddressline2sl"] = addressAddressline2sl
        }
        if addressDistrict != nil{
            dictionary["addressDistrict"] = addressDistrict
        }
        if addressState != nil{
            dictionary["addressState"] = addressState
        }
        if addressTehsilcode != nil{
            dictionary["addressTehsilcode"] = addressTehsilcode
        }
        if birthCountry != nil{
            dictionary["birthCountry"] = birthCountry
        }
        if birthDistrictCode != nil{
            dictionary["birthDistrictCode"] = birthDistrictCode
        }
        if birthStateCode != nil{
            dictionary["birthStateCode"] = birthStateCode
        }
        if blockno != nil{
            dictionary["blockno"] = blockno
        }
        if censusHhNo != nil{
            dictionary["censusHhNo"] = censusHhNo
        }
        if censusHouseNo != nil{
            dictionary["censusHouseNo"] = censusHouseNo
        }
        if districtcode != nil{
            dictionary["districtcode"] = districtcode
        }
        if dob != nil{
            dictionary["dob"] = dob
        }
        if dobType != nil{
            dictionary["dobType"] = dobType
        }
        if durationInyear != nil{
            dictionary["durationInyear"] = durationInyear
        }
        if eduCode != nil{
            dictionary["eduCode"] = eduCode
        }
        if enumBatchId != nil{
            dictionary["enumBatchId"] = enumBatchId
        }
        if enumeratedOn != nil{
            dictionary["enumeratedOn"] = enumeratedOn
        }
        if enumerator != nil{
            dictionary["enumerator"] = enumerator
        }
        if enumSyncedOn != nil{
            dictionary["enumSyncedOn"] = enumSyncedOn
        }
        if fatherBirthCountry != nil{
            dictionary["fatherBirthCountry"] = fatherBirthCountry
        }
        if fatherBirthDistrict != nil{
            dictionary["fatherBirthDistrict"] = fatherBirthDistrict
        }
        if fatherBirthState != nil{
            dictionary["fatherBirthState"] = fatherBirthState
        }
        if fatherCode != nil{
            dictionary["fatherCode"] = fatherCode
        }
        if fatherDob != nil{
            dictionary["fatherDob"] = fatherDob
        }
        if fatherName != nil{
            dictionary["fatherName"] = fatherName
        }
        if fatherNamesl != nil{
            dictionary["fatherNamesl"] = fatherNamesl
        }
        if firstName != nil{
            dictionary["firstName"] = firstName
        }
        if fotherDobtype != nil{
            dictionary["fotherDobtype"] = fotherDobtype
        }
        if genderid != nil{
            dictionary["genderid"] = genderid
        }
        if hhCompleted != nil{
            dictionary["hhCompleted"] = hhCompleted
        }
        if hhStatus != nil{
            dictionary["hhStatus"] = hhStatus
        }
        if hhType != nil{
            dictionary["hhType"] = hhType
        }
        if isSignUpdated != nil{
            dictionary["isSignUpdated"] = isSignUpdated
        }
        if language != nil{
            dictionary["language"] = language
        }
        if lastName != nil{
            dictionary["lastName"] = lastName
        }
        if lastResidencyCountry != nil{
            dictionary["lastResidencyCountry"] = lastResidencyCountry
        }
        if lastResidencyDistrict != nil{
            dictionary["lastResidencyDistrict"] = lastResidencyDistrict
        }
        if lastResidencyState != nil{
            dictionary["lastResidencyState"] = lastResidencyState
        }
        if maritalStatus != nil{
            dictionary["maritalStatus"] = maritalStatus
        }
        if memberCompleted != nil{
            dictionary["memberCompleted"] = memberCompleted
        }
        if memberStatus != nil{
            dictionary["memberStatus"] = memberStatus
        }
        if midleName != nil{
            dictionary["midleName"] = midleName
        }
        if mobileNumber != nil{
            dictionary["mobileNumber"] = mobileNumber
        }
        if motherBirthCountry != nil{
            dictionary["motherBirthCountry"] = motherBirthCountry
        }
        if motherBirthDistrict != nil{
            dictionary["motherBirthDistrict"] = motherBirthDistrict
        }
        if motherBirthState != nil{
            dictionary["motherBirthState"] = motherBirthState
        }
        if motherCode != nil{
            dictionary["motherCode"] = motherCode
        }
        if motherDob != nil{
            dictionary["motherDob"] = motherDob
        }
        if motherDobtype != nil{
            dictionary["motherDobtype"] = motherDobtype
        }
        if motherName != nil{
            dictionary["motherName"] = motherName
        }
        if motherNamesl != nil{
            dictionary["motherNamesl"] = motherNamesl
        }
        if motherTongue != nil{
            dictionary["motherTongue"] = motherTongue
        }
        if name != nil{
            dictionary["name"] = name
        }
        if nameRespondent != nil{
            dictionary["nameRespondent"] = nameRespondent
        }
        if namesl != nil{
            dictionary["namesl"] = namesl
        }
        if nationality != nil{
            dictionary["nationality"] = nationality
        }
        if nationalitysl != nil{
            dictionary["nationalitysl"] = nationalitysl
        }
        if occuCode != nil{
            dictionary["occuCode"] = occuCode
        }
        if oefBirthCountryName != nil{
            dictionary["oefBirthCountryName"] = oefBirthCountryName
        }
        if oefBirthCountryNamesl != nil{
            dictionary["oefBirthCountryNamesl"] = oefBirthCountryNamesl
        }
        if oefBirthDistrictName != nil{
            dictionary["oefBirthDistrictName"] = oefBirthDistrictName
        }
        if oefBirthDistrictNamesl != nil{
            dictionary["oefBirthDistrictNamesl"] = oefBirthDistrictNamesl
        }
        if oefBirthStateName != nil{
            dictionary["oefBirthStateName"] = oefBirthStateName
        }
        if oefBirthStateNamesl != nil{
            dictionary["oefBirthStateNamesl"] = oefBirthStateNamesl
        }
        if oefEduName != nil{
            dictionary["oefEduName"] = oefEduName
        }
        if oefEduNamesl != nil{
            dictionary["oefEduNamesl"] = oefEduNamesl
        }
        if oefNationality != nil{
            dictionary["oefNationality"] = oefNationality
        }
        if oefNationalitysl != nil{
            dictionary["oefNationalitysl"] = oefNationalitysl
        }
        if oefOccuName != nil{
            dictionary["oefOccuName"] = oefOccuName
        }
        if oefOccuNamesl != nil{
            dictionary["oefOccuNamesl"] = oefOccuNamesl
        }
        if oefPermanentDistrict != nil{
            dictionary["oefPermanentDistrict"] = oefPermanentDistrict
        }
        if oefPermanentDistrictsl != nil{
            dictionary["oefPermanentDistrictsl"] = oefPermanentDistrictsl
        }
        if oefPermanentState != nil{
            dictionary["oefPermanentState"] = oefPermanentState
        }
        if oefPermanentStatesl != nil{
            dictionary["oefPermanentStatesl"] = oefPermanentStatesl
        }
        if oefPermanentTehsil != nil{
            dictionary["oefPermanentTehsil"] = oefPermanentTehsil
        }
        if oefPermanentTehsilsl != nil{
            dictionary["oefPermanentTehsilsl"] = oefPermanentTehsilsl
        }
        if oefPresentDistrict != nil{
            dictionary["oefPresentDistrict"] = oefPresentDistrict
        }
        if oefPresentDistrictsl != nil{
            dictionary["oefPresentDistrictsl"] = oefPresentDistrictsl
        }
        if oefPresentState != nil{
            dictionary["oefPresentState"] = oefPresentState
        }
        if oefPresentStatesl != nil{
            dictionary["oefPresentStatesl"] = oefPresentStatesl
        }
        if oefPresentTehsil != nil{
            dictionary["oefPresentTehsil"] = oefPresentTehsil
        }
        if oefPresentTehsilsl != nil{
            dictionary["oefPresentTehsilsl"] = oefPresentTehsilsl
        }
        if oefRelName != nil{
            dictionary["oefRelName"] = oefRelName
        }
        if oefRelNamesl != nil{
            dictionary["oefRelNamesl"] = oefRelNamesl
        }
        if paddressCountry != nil{
            dictionary["paddressCountry"] = paddressCountry
        }
        if paddressDistrict != nil{
            dictionary["paddressDistrict"] = paddressDistrict
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
        if paddressState != nil{
            dictionary["paddressState"] = paddressState
        }
        if paddressTehsil != nil{
            dictionary["paddressTehsil"] = paddressTehsil
        }
        if pincode != nil{
            dictionary["pincode"] = pincode
        }
        if ppincode != nil{
            dictionary["ppincode"] = ppincode
        }
        if prevStatus != nil{
            dictionary["prevStatus"] = prevStatus
        }
        if relCode != nil{
            dictionary["relCode"] = relCode
        }
        if seReference != nil{
            dictionary["seReference"] = seReference
        }
        if signByEnumBehalfRespondant != nil{
            dictionary["signByEnumBehalfRespondant"] = signByEnumBehalfRespondant
        }
        if slnohhd != nil{
            dictionary["slnohhd"] = slnohhd
        }
        if slnoMember != nil{
            dictionary["slnoMember"] = slnoMember
        }
        if slnoRespondent != nil{
            dictionary["slnoRespondent"] = slnoRespondent
        }
        if spouseName != nil{
            dictionary["spouseName"] = spouseName
        }
        if spouseNamesl != nil{
            dictionary["spouseNamesl"] = spouseNamesl
        }
        if statecode != nil{
            dictionary["statecode"] = statecode
        }
        if stayingSinceBirth != nil{
            dictionary["stayingSinceBirth"] = stayingSinceBirth
        }
        if subebno != nil{
            dictionary["subebno"] = subebno
        }
        if suprBatchId != nil{
            dictionary["suprBatchId"] = suprBatchId
        }
        if tehsilcode != nil{
            dictionary["tehsilcode"] = tehsilcode
        }
        if tin != nil{
            dictionary["tin"] = tin
        }
        if tin2019 != nil{
            dictionary["tin2019"] = tin2019
        }
        if towncode != nil{
            dictionary["towncode"] = towncode
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
        aadhaar = aDecoder.decodeObject(forKey: "aadhaar") as? String
        addressAddressline1 = aDecoder.decodeObject(forKey: "addressAddressline1") as? String
        addressAddressline2 = aDecoder.decodeObject(forKey: "addressAddressline2") as? String
        addressAddressline2sl = aDecoder.decodeObject(forKey: "addressAddressline2sl") as? String
        addressDistrict = aDecoder.decodeObject(forKey: "addressDistrict") as? String
        addressState = aDecoder.decodeObject(forKey: "addressState") as? String
        addressTehsilcode = aDecoder.decodeObject(forKey: "addressTehsilcode") as? String
        birthCountry = aDecoder.decodeObject(forKey: "birthCountry") as? String
        birthDistrictCode = aDecoder.decodeObject(forKey: "birthDistrictCode") as? String
        birthStateCode = aDecoder.decodeObject(forKey: "birthStateCode") as? String
        blockno = aDecoder.decodeObject(forKey: "blockno") as? String
        censusHhNo = aDecoder.decodeObject(forKey: "censusHhNo") as? String
        censusHouseNo = aDecoder.decodeObject(forKey: "censusHouseNo") as? String
        districtcode = aDecoder.decodeObject(forKey: "districtcode") as? String
        dob = aDecoder.decodeObject(forKey: "dob") as? String
        dobType = aDecoder.decodeObject(forKey: "dobType") as? String
        durationInyear = aDecoder.decodeObject(forKey: "durationInyear") as? Int
        eduCode = aDecoder.decodeObject(forKey: "eduCode") as? String
        enumBatchId = aDecoder.decodeObject(forKey: "enumBatchId") as? String
        enumeratedOn = aDecoder.decodeObject(forKey: "enumeratedOn") as? String
        enumerator = aDecoder.decodeObject(forKey: "enumerator") as? String
        enumSyncedOn = aDecoder.decodeObject(forKey: "enumSyncedOn") as? String
        fatherBirthCountry = aDecoder.decodeObject(forKey: "fatherBirthCountry") as? String
        fatherBirthDistrict = aDecoder.decodeObject(forKey: "fatherBirthDistrict") as? String
        fatherBirthState = aDecoder.decodeObject(forKey: "fatherBirthState") as? String
        fatherCode = aDecoder.decodeObject(forKey: "fatherCode") as? String
        fatherDob = aDecoder.decodeObject(forKey: "fatherDob") as? String
        fatherName = aDecoder.decodeObject(forKey: "fatherName") as? String
        fatherNamesl = aDecoder.decodeObject(forKey: "fatherNamesl") as? String
        firstName = aDecoder.decodeObject(forKey: "firstName") as? String
        fotherDobtype = aDecoder.decodeObject(forKey: "fotherDobtype") as? String
        genderid = aDecoder.decodeObject(forKey: "genderid") as? Int
        hhCompleted = aDecoder.decodeObject(forKey: "hhCompleted") as? Int
        hhStatus = aDecoder.decodeObject(forKey: "hhStatus") as? Int
        hhType = aDecoder.decodeObject(forKey: "hhType") as? Int
        isSignUpdated = aDecoder.decodeObject(forKey: "isSignUpdated") as? Int
        language = aDecoder.decodeObject(forKey: "language") as? String
        lastName = aDecoder.decodeObject(forKey: "lastName") as? String
        lastResidencyCountry = aDecoder.decodeObject(forKey: "lastResidencyCountry") as? String
        lastResidencyDistrict = aDecoder.decodeObject(forKey: "lastResidencyDistrict") as? String
        lastResidencyState = aDecoder.decodeObject(forKey: "lastResidencyState") as? String
        maritalStatus = aDecoder.decodeObject(forKey: "maritalStatus") as? Int
        memberCompleted = aDecoder.decodeObject(forKey: "memberCompleted") as? String
        memberStatus = aDecoder.decodeObject(forKey: "memberStatus") as? Int
        midleName = aDecoder.decodeObject(forKey: "midleName") as? String
        mobileNumber = aDecoder.decodeObject(forKey: "mobileNumber") as? String
        motherBirthCountry = aDecoder.decodeObject(forKey: "motherBirthCountry") as? String
        motherBirthDistrict = aDecoder.decodeObject(forKey: "motherBirthDistrict") as? String
        motherBirthState = aDecoder.decodeObject(forKey: "motherBirthState") as? String
        motherCode = aDecoder.decodeObject(forKey: "motherCode") as? String
        motherDob = aDecoder.decodeObject(forKey: "motherDob") as? String
        motherDobtype = aDecoder.decodeObject(forKey: "motherDobtype") as? String
        motherName = aDecoder.decodeObject(forKey: "motherName") as? String
        motherNamesl = aDecoder.decodeObject(forKey: "motherNamesl") as? String
        motherTongue = aDecoder.decodeObject(forKey: "motherTongue") as? String
        name = aDecoder.decodeObject(forKey: "name") as? String
        nameRespondent = aDecoder.decodeObject(forKey: "nameRespondent") as? String
        namesl = aDecoder.decodeObject(forKey: "namesl") as? String
        nationality = aDecoder.decodeObject(forKey: "nationality") as? String
        nationalitysl = aDecoder.decodeObject(forKey: "nationalitysl") as? String
        occuCode = aDecoder.decodeObject(forKey: "occuCode") as? Int
        oefBirthCountryName = aDecoder.decodeObject(forKey: "oefBirthCountryName") as? String
        oefBirthCountryNamesl = aDecoder.decodeObject(forKey: "oefBirthCountryNamesl") as? String
        oefBirthDistrictName = aDecoder.decodeObject(forKey: "oefBirthDistrictName") as? String
        oefBirthDistrictNamesl = aDecoder.decodeObject(forKey: "oefBirthDistrictNamesl") as? String
        oefBirthStateName = aDecoder.decodeObject(forKey: "oefBirthStateName") as? String
        oefBirthStateNamesl = aDecoder.decodeObject(forKey: "oefBirthStateNamesl") as? String
        oefEduName = aDecoder.decodeObject(forKey: "oefEduName") as? String
        oefEduNamesl = aDecoder.decodeObject(forKey: "oefEduNamesl") as? String
        oefNationality = aDecoder.decodeObject(forKey: "oefNationality") as? String
        oefNationalitysl = aDecoder.decodeObject(forKey: "oefNationalitysl") as? String
        oefOccuName = aDecoder.decodeObject(forKey: "oefOccuName") as? String
        oefOccuNamesl = aDecoder.decodeObject(forKey: "oefOccuNamesl") as? String
        oefPermanentDistrict = aDecoder.decodeObject(forKey: "oefPermanentDistrict") as? String
        oefPermanentDistrictsl = aDecoder.decodeObject(forKey: "oefPermanentDistrictsl") as? String
        oefPermanentState = aDecoder.decodeObject(forKey: "oefPermanentState") as? String
        oefPermanentStatesl = aDecoder.decodeObject(forKey: "oefPermanentStatesl") as? String
        oefPermanentTehsil = aDecoder.decodeObject(forKey: "oefPermanentTehsil") as? String
        oefPermanentTehsilsl = aDecoder.decodeObject(forKey: "oefPermanentTehsilsl") as? String
        oefPresentDistrict = aDecoder.decodeObject(forKey: "oefPresentDistrict") as? String
        oefPresentDistrictsl = aDecoder.decodeObject(forKey: "oefPresentDistrictsl") as? String
        oefPresentState = aDecoder.decodeObject(forKey: "oefPresentState") as? String
        oefPresentStatesl = aDecoder.decodeObject(forKey: "oefPresentStatesl") as? String
        oefPresentTehsil = aDecoder.decodeObject(forKey: "oefPresentTehsil") as? String
        oefPresentTehsilsl = aDecoder.decodeObject(forKey: "oefPresentTehsilsl") as? String
        oefRelName = aDecoder.decodeObject(forKey: "oefRelName") as? String
        oefRelNamesl = aDecoder.decodeObject(forKey: "oefRelNamesl") as? String
        paddressCountry = aDecoder.decodeObject(forKey: "paddressCountry") as? String
        paddressDistrict = aDecoder.decodeObject(forKey: "paddressDistrict") as? String
        paddressline1 = aDecoder.decodeObject(forKey: "paddressline1") as? String
        paddressline1sl = aDecoder.decodeObject(forKey: "paddressline1sl") as? String
        paddressline2 = aDecoder.decodeObject(forKey: "paddressline2") as? String
        paddressline2sl = aDecoder.decodeObject(forKey: "paddressline2sl") as? String
        paddressState = aDecoder.decodeObject(forKey: "paddressState") as? String
        paddressTehsil = aDecoder.decodeObject(forKey: "paddressTehsil") as? String
        pincode = aDecoder.decodeObject(forKey: "pincode") as? String
        ppincode = aDecoder.decodeObject(forKey: "ppincode") as? String
        prevStatus = aDecoder.decodeObject(forKey: "prevStatus") as? String
        relCode = aDecoder.decodeObject(forKey: "relCode") as? String
        seReference = aDecoder.decodeObject(forKey: "seReference") as? String
        signByEnumBehalfRespondant = aDecoder.decodeObject(forKey: "signByEnumBehalfRespondant") as? String
        slnohhd = aDecoder.decodeObject(forKey: "slnohhd") as? String
        slnoMember = aDecoder.decodeObject(forKey: "slnoMember") as? String
        slnoRespondent = aDecoder.decodeObject(forKey: "slnoRespondent") as? String
        spouseName = aDecoder.decodeObject(forKey: "spouseName") as? String
        spouseNamesl = aDecoder.decodeObject(forKey: "spouseNamesl") as? String
        statecode = aDecoder.decodeObject(forKey: "statecode") as? String
        stayingSinceBirth = aDecoder.decodeObject(forKey: "stayingSinceBirth") as? Int
        subebno = aDecoder.decodeObject(forKey: "subebno") as? String
        suprBatchId = aDecoder.decodeObject(forKey: "suprBatchId") as? String
        tehsilcode = aDecoder.decodeObject(forKey: "tehsilcode") as? String
        tin = aDecoder.decodeObject(forKey: "tin") as? String
        tin2019 = aDecoder.decodeObject(forKey: "tin2019") as? String
        towncode = aDecoder.decodeObject(forKey: "towncode") as? String
        wardid = aDecoder.decodeObject(forKey: "wardid") as? String
    }

    /**
     * NSCoding required method.
     * Encodes mode properties into the decoder
     */
    @objc func encode(with aCoder: NSCoder)
    {
        if aadhaar != nil{
            aCoder.encode(aadhaar, forKey: "aadhaar")
        }
        if addressAddressline1 != nil{
            aCoder.encode(addressAddressline1, forKey: "addressAddressline1")
        }
        if addressAddressline2 != nil{
            aCoder.encode(addressAddressline2, forKey: "addressAddressline2")
        }
        if addressAddressline2sl != nil{
            aCoder.encode(addressAddressline2sl, forKey: "addressAddressline2sl")
        }
        if addressDistrict != nil{
            aCoder.encode(addressDistrict, forKey: "addressDistrict")
        }
        if addressState != nil{
            aCoder.encode(addressState, forKey: "addressState")
        }
        if addressTehsilcode != nil{
            aCoder.encode(addressTehsilcode, forKey: "addressTehsilcode")
        }
        if birthCountry != nil{
            aCoder.encode(birthCountry, forKey: "birthCountry")
        }
        if birthDistrictCode != nil{
            aCoder.encode(birthDistrictCode, forKey: "birthDistrictCode")
        }
        if birthStateCode != nil{
            aCoder.encode(birthStateCode, forKey: "birthStateCode")
        }
        if blockno != nil{
            aCoder.encode(blockno, forKey: "blockno")
        }
        if censusHhNo != nil{
            aCoder.encode(censusHhNo, forKey: "censusHhNo")
        }
        if censusHouseNo != nil{
            aCoder.encode(censusHouseNo, forKey: "censusHouseNo")
        }
        if districtcode != nil{
            aCoder.encode(districtcode, forKey: "districtcode")
        }
        if dob != nil{
            aCoder.encode(dob, forKey: "dob")
        }
        if dobType != nil{
            aCoder.encode(dobType, forKey: "dobType")
        }
        if durationInyear != nil{
            aCoder.encode(durationInyear, forKey: "durationInyear")
        }
        if eduCode != nil{
            aCoder.encode(eduCode, forKey: "eduCode")
        }
        if enumBatchId != nil{
            aCoder.encode(enumBatchId, forKey: "enumBatchId")
        }
        if enumeratedOn != nil{
            aCoder.encode(enumeratedOn, forKey: "enumeratedOn")
        }
        if enumerator != nil{
            aCoder.encode(enumerator, forKey: "enumerator")
        }
        if enumSyncedOn != nil{
            aCoder.encode(enumSyncedOn, forKey: "enumSyncedOn")
        }
        if fatherBirthCountry != nil{
            aCoder.encode(fatherBirthCountry, forKey: "fatherBirthCountry")
        }
        if fatherBirthDistrict != nil{
            aCoder.encode(fatherBirthDistrict, forKey: "fatherBirthDistrict")
        }
        if fatherBirthState != nil{
            aCoder.encode(fatherBirthState, forKey: "fatherBirthState")
        }
        if fatherCode != nil{
            aCoder.encode(fatherCode, forKey: "fatherCode")
        }
        if fatherDob != nil{
            aCoder.encode(fatherDob, forKey: "fatherDob")
        }
        if fatherName != nil{
            aCoder.encode(fatherName, forKey: "fatherName")
        }
        if fatherNamesl != nil{
            aCoder.encode(fatherNamesl, forKey: "fatherNamesl")
        }
        if firstName != nil{
            aCoder.encode(firstName, forKey: "firstName")
        }
        if fotherDobtype != nil{
            aCoder.encode(fotherDobtype, forKey: "fotherDobtype")
        }
        if genderid != nil{
            aCoder.encode(genderid, forKey: "genderid")
        }
        if hhCompleted != nil{
            aCoder.encode(hhCompleted, forKey: "hhCompleted")
        }
        if hhStatus != nil{
            aCoder.encode(hhStatus, forKey: "hhStatus")
        }
        if hhType != nil{
            aCoder.encode(hhType, forKey: "hhType")
        }
        if isSignUpdated != nil{
            aCoder.encode(isSignUpdated, forKey: "isSignUpdated")
        }
        if language != nil{
            aCoder.encode(language, forKey: "language")
        }
        if lastName != nil{
            aCoder.encode(lastName, forKey: "lastName")
        }
        if lastResidencyCountry != nil{
            aCoder.encode(lastResidencyCountry, forKey: "lastResidencyCountry")
        }
        if lastResidencyDistrict != nil{
            aCoder.encode(lastResidencyDistrict, forKey: "lastResidencyDistrict")
        }
        if lastResidencyState != nil{
            aCoder.encode(lastResidencyState, forKey: "lastResidencyState")
        }
        if maritalStatus != nil{
            aCoder.encode(maritalStatus, forKey: "maritalStatus")
        }
        if memberCompleted != nil{
            aCoder.encode(memberCompleted, forKey: "memberCompleted")
        }
        if memberStatus != nil{
            aCoder.encode(memberStatus, forKey: "memberStatus")
        }
        if midleName != nil{
            aCoder.encode(midleName, forKey: "midleName")
        }
        if mobileNumber != nil{
            aCoder.encode(mobileNumber, forKey: "mobileNumber")
        }
        if motherBirthCountry != nil{
            aCoder.encode(motherBirthCountry, forKey: "motherBirthCountry")
        }
        if motherBirthDistrict != nil{
            aCoder.encode(motherBirthDistrict, forKey: "motherBirthDistrict")
        }
        if motherBirthState != nil{
            aCoder.encode(motherBirthState, forKey: "motherBirthState")
        }
        if motherCode != nil{
            aCoder.encode(motherCode, forKey: "motherCode")
        }
        if motherDob != nil{
            aCoder.encode(motherDob, forKey: "motherDob")
        }
        if motherDobtype != nil{
            aCoder.encode(motherDobtype, forKey: "motherDobtype")
        }
        if motherName != nil{
            aCoder.encode(motherName, forKey: "motherName")
        }
        if motherNamesl != nil{
            aCoder.encode(motherNamesl, forKey: "motherNamesl")
        }
        if motherTongue != nil{
            aCoder.encode(motherTongue, forKey: "motherTongue")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if nameRespondent != nil{
            aCoder.encode(nameRespondent, forKey: "nameRespondent")
        }
        if namesl != nil{
            aCoder.encode(namesl, forKey: "namesl")
        }
        if nationality != nil{
            aCoder.encode(nationality, forKey: "nationality")
        }
        if nationalitysl != nil{
            aCoder.encode(nationalitysl, forKey: "nationalitysl")
        }
        if occuCode != nil{
            aCoder.encode(occuCode, forKey: "occuCode")
        }
        if oefBirthCountryName != nil{
            aCoder.encode(oefBirthCountryName, forKey: "oefBirthCountryName")
        }
        if oefBirthCountryNamesl != nil{
            aCoder.encode(oefBirthCountryNamesl, forKey: "oefBirthCountryNamesl")
        }
        if oefBirthDistrictName != nil{
            aCoder.encode(oefBirthDistrictName, forKey: "oefBirthDistrictName")
        }
        if oefBirthDistrictNamesl != nil{
            aCoder.encode(oefBirthDistrictNamesl, forKey: "oefBirthDistrictNamesl")
        }
        if oefBirthStateName != nil{
            aCoder.encode(oefBirthStateName, forKey: "oefBirthStateName")
        }
        if oefBirthStateNamesl != nil{
            aCoder.encode(oefBirthStateNamesl, forKey: "oefBirthStateNamesl")
        }
        if oefEduName != nil{
            aCoder.encode(oefEduName, forKey: "oefEduName")
        }
        if oefEduNamesl != nil{
            aCoder.encode(oefEduNamesl, forKey: "oefEduNamesl")
        }
        if oefNationality != nil{
            aCoder.encode(oefNationality, forKey: "oefNationality")
        }
        if oefNationalitysl != nil{
            aCoder.encode(oefNationalitysl, forKey: "oefNationalitysl")
        }
        if oefOccuName != nil{
            aCoder.encode(oefOccuName, forKey: "oefOccuName")
        }
        if oefOccuNamesl != nil{
            aCoder.encode(oefOccuNamesl, forKey: "oefOccuNamesl")
        }
        if oefPermanentDistrict != nil{
            aCoder.encode(oefPermanentDistrict, forKey: "oefPermanentDistrict")
        }
        if oefPermanentDistrictsl != nil{
            aCoder.encode(oefPermanentDistrictsl, forKey: "oefPermanentDistrictsl")
        }
        if oefPermanentState != nil{
            aCoder.encode(oefPermanentState, forKey: "oefPermanentState")
        }
        if oefPermanentStatesl != nil{
            aCoder.encode(oefPermanentStatesl, forKey: "oefPermanentStatesl")
        }
        if oefPermanentTehsil != nil{
            aCoder.encode(oefPermanentTehsil, forKey: "oefPermanentTehsil")
        }
        if oefPermanentTehsilsl != nil{
            aCoder.encode(oefPermanentTehsilsl, forKey: "oefPermanentTehsilsl")
        }
        if oefPresentDistrict != nil{
            aCoder.encode(oefPresentDistrict, forKey: "oefPresentDistrict")
        }
        if oefPresentDistrictsl != nil{
            aCoder.encode(oefPresentDistrictsl, forKey: "oefPresentDistrictsl")
        }
        if oefPresentState != nil{
            aCoder.encode(oefPresentState, forKey: "oefPresentState")
        }
        if oefPresentStatesl != nil{
            aCoder.encode(oefPresentStatesl, forKey: "oefPresentStatesl")
        }
        if oefPresentTehsil != nil{
            aCoder.encode(oefPresentTehsil, forKey: "oefPresentTehsil")
        }
        if oefPresentTehsilsl != nil{
            aCoder.encode(oefPresentTehsilsl, forKey: "oefPresentTehsilsl")
        }
        if oefRelName != nil{
            aCoder.encode(oefRelName, forKey: "oefRelName")
        }
        if oefRelNamesl != nil{
            aCoder.encode(oefRelNamesl, forKey: "oefRelNamesl")
        }
        if paddressCountry != nil{
            aCoder.encode(paddressCountry, forKey: "paddressCountry")
        }
        if paddressDistrict != nil{
            aCoder.encode(paddressDistrict, forKey: "paddressDistrict")
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
        if paddressState != nil{
            aCoder.encode(paddressState, forKey: "paddressState")
        }
        if paddressTehsil != nil{
            aCoder.encode(paddressTehsil, forKey: "paddressTehsil")
        }
        if pincode != nil{
            aCoder.encode(pincode, forKey: "pincode")
        }
        if ppincode != nil{
            aCoder.encode(ppincode, forKey: "ppincode")
        }
        if prevStatus != nil{
            aCoder.encode(prevStatus, forKey: "prevStatus")
        }
        if relCode != nil{
            aCoder.encode(relCode, forKey: "relCode")
        }
        if seReference != nil{
            aCoder.encode(seReference, forKey: "seReference")
        }
        if signByEnumBehalfRespondant != nil{
            aCoder.encode(signByEnumBehalfRespondant, forKey: "signByEnumBehalfRespondant")
        }
        if slnohhd != nil{
            aCoder.encode(slnohhd, forKey: "slnohhd")
        }
        if slnoMember != nil{
            aCoder.encode(slnoMember, forKey: "slnoMember")
        }
        if slnoRespondent != nil{
            aCoder.encode(slnoRespondent, forKey: "slnoRespondent")
        }
        if spouseName != nil{
            aCoder.encode(spouseName, forKey: "spouseName")
        }
        if spouseNamesl != nil{
            aCoder.encode(spouseNamesl, forKey: "spouseNamesl")
        }
        if statecode != nil{
            aCoder.encode(statecode, forKey: "statecode")
        }
        if stayingSinceBirth != nil{
            aCoder.encode(stayingSinceBirth, forKey: "stayingSinceBirth")
        }
        if subebno != nil{
            aCoder.encode(subebno, forKey: "subebno")
        }
        if suprBatchId != nil{
            aCoder.encode(suprBatchId, forKey: "suprBatchId")
        }
        if tehsilcode != nil{
            aCoder.encode(tehsilcode, forKey: "tehsilcode")
        }
        if tin != nil{
            aCoder.encode(tin, forKey: "tin")
        }
        if tin2019 != nil{
            aCoder.encode(tin2019, forKey: "tin2019")
        }
        if towncode != nil{
            aCoder.encode(towncode, forKey: "towncode")
        }
        if wardid != nil{
            aCoder.encode(wardid, forKey: "wardid")
        }
    }
}
