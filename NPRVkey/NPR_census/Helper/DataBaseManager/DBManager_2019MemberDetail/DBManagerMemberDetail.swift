//
//  Download2019Data_DataBaseManager.swift
//  NPR_census
//
//  Created by Dileep on 04/09/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import CoreData
protocol DBManager2019MemberDetail_delegate {
    func dataSavedSuccessFully()
}
class DBManagerMemberDetail {
    
    var delegate :Download2019Data_delegate?
    
    var savedIndex = 0
    init() {
        savedIndex = 0
    }
    
    func saveHHMemberDetail(hhModel:NPRDataDownload_modelClassResult,Completion:@escaping(Bool) -> Void ){
           
        
         let nprData = DataBaseManager().openDataBase(entityName: EntityName.npr2021Data) as? NPR2021MemberDetails
        let oldFormatDate = hhModel.dob ?? ""
        
        let strModifiedDate = oldFormatDate.convertDateFormater()
//        if !util.isEnumerator() {
//            nprData?.is_superVisor_login = true
//        }
        
        nprData?.birthCountryName = "India"
        nprData?.aadhar = hhModel.aadhaarNo
        var strLang = "English"
        
        if let LangCode =  hhModel.languageRow  {
            strLang = LangCode
        }
        nprData?.name = hhModel.name ?? ""
        nprData?.language = strLang.lanaugeCode()
        nprData?.address_line1 = hhModel.addressline1 ?? ""
        nprData?.address_line1_sl = hhModel.addressline1sl ?? ""
        nprData?.address_line2 = hhModel.addressline2 ?? ""
        nprData?.address_line3 = hhModel.addressline3 ?? ""
        nprData?.address_line4 = hhModel.addressline4 ?? ""
        nprData?.address_line5 = hhModel.addressline5 ?? ""
        nprData?.address_line2_sl = hhModel.addressline2sl ?? ""
        nprData?.address_line3_sl = hhModel.addressline3sl ?? ""
        nprData?.address_line4_sl = hhModel.addressline4sl ?? ""
        nprData?.address_line5_sl = hhModel.addressline5sl ?? ""
    
        //nprData?.address_state_sl    = hhModel.statenamesl
       
        nprData?.address_subDistrictCode = hhModel.tehsilcode
        nprData?.address_subDistrict = DBManager_CountryStateDistrict().getSubDistrictName(stateCode: hhModel.statecode, districtCode: hhModel.districtcode, tahsilCode: hhModel.tehsilcode)
       // nprData?.address_subDistrict_sl = hhModel.tehsilsl
        
        nprData?.address_districtName_sl = hhModel.districtnamesl ?? ""
        nprData?.address_district = hhModel.districtname ?? ""
        nprData?.address_district_code = hhModel.districtcode ?? ""
        
        nprData?.districtName_sl = hhModel.districtnamesl ?? ""
        nprData?.address_district  = hhModel.districtname ?? ""  // should add in
        nprData?.address_district_code = hhModel.districtcode ?? ""
        
        nprData?.address_state    = hhModel.statename
        nprData?.address_stateName_sl    = hhModel.statenamesl
        nprData?.address_stateCode = hhModel.statecode ?? ""
        nprData?.address_stateName_sl = hhModel.statenamesl ?? ""
        
        
        nprData?.is_HH_completed = false
        //hh type Temporary Hard Value because not key in DownloadedData
        
        if (hhModel.hhType == "") || (hhModel.hhType == nil) {
            nprData?.hh_type = "1"
        }else{
            nprData?.hh_type = hhModel.hhType
        }
        
        
        nprData?.memberStatus = MemberCompletionStatusCode.notStarted
        nprData?.member_completionStatus = MemberCompletionStatusCode.notStarted
        //nprData?.addressCountry_sl = hhModel.countrynamesl
       
        nprData?.block_no          = hhModel.blockno ?? ""
        
        
        nprData?.hh_Number = hhModel.hh.hhNumber()//String(format: AppFormat.hhFormat, hhInt! )
        
       // nprData?.censusHouse_number = String(format: AppFormat.hhFormat, hNInt ?? 0 )
        
        nprData?.dob                = strModifiedDate
        nprData?.dobForSearch = strModifiedDate
        nprData?.died               = ""//hhModel.
        nprData?.dob_type             = hhModel.dobType ?? ""
       
        nprData?.duration_inYear = ""
        
        nprData?.driving_lincence = ""//hhModel.ddriv
        
        
       // nprData?.edu_code = //hhModel.    //Not available
        nprData?.eduName  = hhModel.eduname  ?? "" // have  to add in DB
        
        
        nprData?.eduName_sl  = hhModel.edunamesl ?? ""
        nprData?.enumerator  = ""
        nprData?.father_dob = ""//hhModel.father
        nprData?.father_name = hhModel.fathernm ?? ""
        nprData?.father_dob = ""
        nprData?.father_code = ""
        nprData?.father_name_sl = hhModel.fathernmsl ?? ""
        nprData?.father_dobType = ""
       
        
        nprData?.gender_id = hhModel.genderid ?? ""
        nprData?.genderID_enu = ""
        nprData?.hh_status  = ""
        
        
        nprData?.id  = ""
        nprData?.imei  = ""
        nprData?.ipAddress = ""
        //nprData?.isStarted
        nprData?.is_signUpdated = ""
       // nprData?.institution_name = hhModel.in = ""
        nprData?.institution_name_sl = ""
        //nprData?.isFault = ""
        //nprData?.isDeleted = ""
        nprData?.lattitude = ""
        nprData?.longitute = ""
        nprData?.latest_master = ""
        nprData?.lastResidencyState = ""
        nprData?.lastResidencyDistrict = ""
        // nprData?.last_resident_state_sl = ""
        nprData?.last_resident_district_sl = ""
        nprData?.driving_lincence = ""
        nprData?.m_id  = ""
        nprData?.mobile = hhModel.phoneNumber ?? ""
        nprData?.migrated = hhModel.mstatusid ?? ""  // need to discuss
        
        nprData?.mother_dob = ""
        nprData?.motherName = hhModel.mothernm ?? ""
        nprData?.motherName_sl = hhModel.mothernmsl ?? ""
        nprData?.mother_code = ""
        
        nprData?.motherTounge = ""
        nprData?.marital_status = hhModel.mstatusid ?? ""
        nprData?.name = hhModel.name ?? ""
        nprData?.nameSL = hhModel.namesl ?? ""
        nprData?.first_name = hhModel.firstName ?? ""
        nprData?.first_name_sl = hhModel.firstnamesl ?? ""
        nprData?.midle_name = hhModel.middleName ?? ""
        nprData?.midle_name_sl = hhModel.middlenamesl ?? ""
        nprData?.last_name = hhModel.lastName ?? ""
        nprData?.last_name_sl = hhModel.lastnamesl ?? ""
        nprData?.new_tin = hhModel.tin ?? ""
        nprData?.nationality_name = hhModel.natname ?? ""
        nprData?.nationality_sl = hhModel.natname ?? ""
        nprData?.name_on_cardSL = hhModel.nameOnCard ?? ""
        nprData?.name_responded = hhModel.nameRespondent ?? ""
        nprData?.name_instant_langauge  = ""
        nprData?.occuName = hhModel.occuname ?? ""
      //  nprData?.occuName_sl = hhModel.occunamesl ?? ""
        nprData?.pinCode = hhModel.pincode ?? ""
        nprData?.ppinCode = hhModel.ppincode ?? ""
        nprData?.passpord_id = ""
        nprData?.paddre_line1 = hhModel.paddressline1 ?? ""
        nprData?.paddre_line1_sl = hhModel.paddressline1sl ?? ""
        
        
        nprData?.paddre_line2 = hhModel.paddressline2 ?? ""
        nprData?.paddre_line2_sl = hhModel.paddressline2sl ?? ""
        nprData?.paddress_line3 = hhModel.paddressline3 ?? ""
        nprData?.paddress_line3_sl = hhModel.paddressline3sl ?? ""
        nprData?.paddress_line4 = hhModel.paddressline4 ?? ""
        nprData?.paddress_line4_sl = hhModel.paddressline4sl ?? ""
        nprData?.paddress_line5 = hhModel.paddressline5 ?? ""
        nprData?.paddress_line5_sl = hhModel.paddressline5sl ?? ""
        nprData?.paddress_town  = ""
        nprData?.paddress_town_sl  = ""
        nprData?.panCard_number  = ""
        nprData?.rel_code = hhModel.relCode ?? ""
        nprData?.relName = hhModel.relname ?? ""
        nprData?.relNameSL = hhModel.relnamesl ?? ""
        nprData?.resident_id = hhModel.residentid ?? ""
        nprData?.rationCard_number = hhModel.rationCardNo ?? ""
        nprData?.sloHHD  = ""
       
        nprData?.sloMember = hhModel.slnomember.memberSrNumber()
        nprData?.slNo_responded = hhModel.slnoRespondent ?? ""
        nprData?.spouseName = hhModel.spousenm ?? ""
        nprData?.spouseName_sl = hhModel.spousenmsl ?? ""
        nprData?.sub_eb = hhModel.subebno ?? ""
       // nprData?.super_ok
        nprData?.splitFrom = ""
        nprData?.splitInto = ""
      //  nprData?.superVisor = hhModel.su
        nprData?.sper_sync_on = ""
        
        nprData?.super_remark = ""
        nprData?.spouseBirthPlace  = ""
        nprData?.sign_responded = ""
        nprData?.name_responded = hhModel.nameRespondent
       nprData?.secondaryLangauge = ""
        nprData?.is_HH_completed = false
        nprData?.staying_since_birthdate = ""
        
        nprData?.sign_by_enum_onBehalf_of_responded = ""
        nprData?.selfEnumerationRef_number = ""
        
        nprData?.old_tin = hhModel.tin ?? ""
        nprData?.userID = ""
        nprData?.voter_id = ""
        //
        
        nprData?.ebNumber     = singleton().selectEBListModel.eb_number//"\(hhModel.statecode ?? "")\(hhModel.districtcode ?? "")\(hhModel.tehsilcode ?? "")\(hhModel.towncode ?? "")\(hhModel.wardid ?? "")\(hhModel.blockno ?? "")\(hhModel.subebno ?? "")"
        
        nprData?.hh_tin = hhModel.hhNoHh.hhTin()
        nprData?.hh_tin = hhModel.hh.hhTin()
        nprData?.new_tin = hhModel.slnomember.memberTin(hhNumber: hhModel.hhNoHh) //"\(nprData?.hh_tin ?? "")\(hhModel.slnomember ?? "")"
        nprData?.tin = hhModel.tin
        nprData?.hh_Number = hhModel.hh.hhNumber()
        
        if !util.isEnumerator() {

           
            nprData?.hh_tin = hhModel.hh.hhTin()
           // nprData?.censusHH_number = hhModel.censusHHNumber.censusHHNumber()
           // nprData?.censusHouse_number = hhModel.censusHOuseNumber.censusHouseNumber()
        }
        
        do {
            context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
                           try context.save()
                           
                   
            if hhModel.relCode == "01" {
                DBManagerHousehold().saveHouseHold(modelDict: hhModel) { (isSavedHouseHold) in
                    Completion(true)
                }
                
            }else{
                Completion(true)
            }
            

                       } catch {
                           print("Member Detail Failed saving")
                        Completion(true)
                        
                       }
            }
    
   
    
    func manageMemberDetailData(arayResult:[NPRDataDownload_modelClassResult],modelThisHH:NPRDataDownload_modelClassResult,Completion:@escaping(Bool) -> Void )   {
        
        
        
        var index = 0
        //var arrayModiMemberNumber : [NPRDataDownload_modelClassResult]
        
        let arayFiltered:[NPRDataDownload_modelClassResult] = arayResult.filter({$0.hh == modelThisHH.hh})
        
          
          for modelDict in arayFiltered {

            

            modelDict.slnomember = "\(index+1)".memberSrNumber()
           // modelDict.slnomember = "%05d\(index+1)"

            saveHHMemberDetail(hhModel: modelDict) { (isSaved) in
                index = index+1
                if index == arayFiltered.count {
                    Completion(true)
                }
            }
            }
        
    }
    
    
    func fetchedHHMembers(modelSelectedHH:NPR_2021hh_Details ,Completion:@escaping([NPR2021MemberDetails]) -> Void )  {
        
        
        let predicate = NSPredicate(format: "hh_tin = %@",modelSelectedHH.hh_tin ?? "" )
        
        guard let  arayMemberD = DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data,predicate: predicate) as? [NPR2021MemberDetails] else {
            return
        }
       // let membersInOrder = arayMemberD.filter({$0.new_tin ?? "" < $1.new_tin ?? ""})
        
     let arayMemberSorted = arayMemberD.sorted(by: {$0.sloMember ?? "0" < $1.sloMember ?? "1"})
    Completion(arayMemberSorted)
    }
    
    
    func fetchHHMember_byStatus(modelSelectedHH:NPR_2021hh_Details,status:String) -> [NPR2021MemberDetails] {
       
        let predicate = NSPredicate(format: "hh_tin = %@ AND memberStatus = %@ ", modelSelectedHH.hh_tin ?? "",status)
        
        guard let  arayMemberD = DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data,predicate: predicate) as? [NPR2021MemberDetails] else {
            return [NPR2021MemberDetails] ()
        }
       
    return arayMemberD
    }
    
    func searchMembers(predicate:NSPredicate ,Completion:@escaping([NPR2021MemberDetails]) -> Void )  {
        
        
        
        guard let  arayMemberD = DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data,predicate: predicate) as? [NPR2021MemberDetails] else {
            return
        }
       
    Completion(arayMemberD)
    }
    
    func fetchMembers_currentalyLeaveinHH(modelSelectedHH:NPR_2021hh_Details ,Completion:@escaping([NPR2021MemberDetails]) -> Void )  {
        
      DBManagerMemberDetail().fetchedHHMembers(modelSelectedHH: modelSelectedHH) { (arayHHMembers) in
            //self.arayMemberModel = arayHHMembers
            let arayMemberModel = arayHHMembers.filter({$0.memberStatus == MemberStatusCode.notStarted || $0.memberStatus == MemberStatusCode.available || $0.memberStatus == MemberStatusCode.newMember})
            
            Completion(arayMemberModel)
        }
       
   
    }
    
    
    func fetchOldMembers_currentalyLiveinHH(modelSelectedHH:NPR_2021hh_Details ,Completion:@escaping([NPR2021MemberDetails]) -> Void )  {
        
      
        
        DBManagerMemberDetail().fetchedHHMembers(modelSelectedHH: modelSelectedHH) { (arayHHMembers) in
            //self.arayMemberModel = arayHHMembers
            let arayMemberModel = arayHHMembers.filter({$0.memberStatus == MemberStatusCode.notStarted || $0.memberStatus == MemberStatusCode.available })
            
            Completion(arayMemberModel)
        }
       
   
    }
    
    
    
    
    }




extension DBManagerMemberDetail {
    
    
    func updateMemberStatusAfterSkipHH(hhModel:NPR_2021hh_Details,hhStatus:String,Completion:@escaping(Bool)-> Void ) {
       
        
        let memberStatus = Utils().memberStatus_dependOn_hhStatus(hhStatus: hhStatus)
        
        
        fetchedHHMembers(modelSelectedHH: hhModel) { (arayMembersModel) in
           
            for modelmember in arayMembersModel {
                
                modelmember.memberStatus = memberStatus.rawValue
                modelmember.member_completionStatus = MemberCompletionStatusCode.completed
                modelmember.isUpdatedMemberStatus = false
                do {
                    try context.save()
                    
                    if modelmember == arayMembersModel.last {
                        Completion(true)
                    }
                } catch  {
                    
                }
            }
          
            
        }
        
       
    }
    
    func updateMemberStatusAfterUploadHH(hhModel:NPR_2021hh_Details,memberCompletionStatus:MemberCompletionStatus,Completion:@escaping(Bool)-> Void ) {
       
        
       // let memberStatus = Utils().memberStatus_dependOn_hhStatus(hhStatus: hhStatus)
        
        
        fetchedHHMembers(modelSelectedHH: hhModel) { (arayMembersModel) in
           
            for modelmember in arayMembersModel {
                
               // modelmember.member_completionStatus = memberCompletionStatus.rawValue
                 modelmember.member_completionStatus = MemberCompletionStatusCode.uploaded
                
                
                
                do {
                    try context.save()
                    
                    if modelmember == arayMembersModel.last {
                        Completion(true)
                    }
                } catch  {
                    
                }
            }
         
            
        }
        
       
    }
    
   
    func updateMemberStatusSkipedHH(hhModel:NPR_2021hh_Details)  {
        
        let hhStatus = hhModel.hh_status ?? ""
        
        
        if hhModel.hh_status ?? "" == HHStatusCode.locked  || hhModel.hh_status ?? "" == HHStatusCode.migratedOut  || hhModel.hh_status ?? "" == HHStatusCode.notAvailable {
            
        
        fetchedHHMembers(modelSelectedHH: hhModel) { (totalMemberModel) in
          
            for memberModel in totalMemberModel {
                let memberLivingStatus = MemberLivingStatusCode.init(rawValue: memberModel.memberStatus ?? "")
                if (memberLivingStatus == .migratedOut && hhStatus == HHStatusCode.migratedOut && memberModel.isUpdatedMemberStatus)  || (memberLivingStatus == .notAvailable && hhStatus == HHStatusCode.notAvailable) || (memberLivingStatus == .lockedMember && hhStatus == HHStatusCode.locked){
                    
                    memberModel.memberStatus = MemberStatusCode.notStarted
                    memberModel.member_completionStatus = MemberCompletionStatusCode.notStarted
                    memberModel.isUpdatedMemberStatus = false
                    do {
                        try context.save()
                    } catch  {
                        
                    }
                }
            }
            
        }
        }
        
    }
    
    func deletMembersDeleteHH(hhModel:NPR_2021hh_Details,Completion:@escaping(Bool)-> Void ) {
       
        
       // let memberStatus = Utils().memberStatus_dependOn_hhStatus(hhStatus: hhStatus)
        
        
        fetchedHHMembers(modelSelectedHH: hhModel) { (arayMembersModel) in
            if arayMembersModel.count == 0 {
                Completion(true)
                return
            }
            for modelmember in arayMembersModel {
                
                context.delete(modelmember)
                
                do {
                    try context.save()
                    
                    if modelmember == arayMembersModel.last {
                        Completion(true)
                    }
                } catch  {
                    
                }
            }
         
            
        }
        
       
    }
    
  
    func updateMemberRemark_bySuperVisor(hhModel:NPR_2021hh_Details,remark:String,Completion:@escaping(Bool)-> Void ) {
       
        fetchedHHMembers(modelSelectedHH: hhModel) { (arayMembersModel) in
           
            for modelmember in arayMembersModel {
                
                modelmember.super_remark = remark
                modelmember.memberStatus = HHCompletionStatusCode.inComplete
                
                do {
                    try context.save()
                    
                    if modelmember == arayMembersModel.last {
                        Completion(true)
                    }
                } catch  {
                    
                }
            }
         
            
        }
        
       
    }
    func getNewMemberSerialNumber(hhNumber:String) -> String {
        
        let predicate = NSPredicate.init(format: "hh_tin = %@", hhNumber.hhTin())
        guard var hhMembers = DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data, predicate: predicate) as? [NPR2021MemberDetails] else{
            return ""
        }
        
       hhMembers = hhMembers.sorted(by: {$0.sloMember ?? "0" < $1.sloMember ?? "1"})
        var serialNumber = ""
        for i in 0...hhMembers.count {
            serialNumber = "\(i+1)".memberSrNumber()
            if i == hhMembers.count {
             return serialNumber
            }
            else if hhMembers[i].sloMember != serialNumber {
                return serialNumber
            }
        }
        return serialNumber
    }
    
    
}






