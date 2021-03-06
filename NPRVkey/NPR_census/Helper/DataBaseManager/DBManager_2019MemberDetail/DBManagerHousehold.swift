//
//  Download2019Data_DataBaseManager.swift
//  NPR_census
//
//  Created by Dileep on 04/09/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import CoreData
protocol Download2019Data_delegate {
    func dataSavedSuccessFully()
}
class DBManagerHousehold {
    
    var delegate :Download2019Data_delegate?
    
    var savedIndex = 0
    init() {
        savedIndex = 0
    }
    
    
    
    
    }



extension DBManagerHousehold {
    
    func  saveHouseHold(modelDict:NPRDataDownload_modelClassResult, complete:@escaping(Bool)->Void) {
        
        let context  = appDelegate.persistentContainer.viewContext
        
        let nprHHData = DataBaseManager().openDataBase(entityName: EntityName.nprHHStats) as? NPR_2021hh_Details
         
        let oldFormatDate = modelDict.dob ?? ""
        
        let strModifiedDate = oldFormatDate.convertDateFormater()
//        if !util.isEnumerator() {
//            nprHHData?.is_superVisor_login = true
//        }
         nprHHData?.block_no = modelDict.blockno ?? ""
        //let hhInt = Int(modelDict.hh ?? "")
        nprHHData?.houseHoldhNo = modelDict.hh.hhNumber()
        nprHHData?.originalHHNumberSplit = modelDict.hh.hhNumber()
        nprHHData?.originalHHSplitInto = modelDict.hh.hhNumber()
        print("Found HH NO",modelDict.hh ?? "")
        print("Enter HH NO ", nprHHData?.houseHoldhNo ?? "")
        nprHHData?.houseHoldhNo = modelDict.hh.hhNumber()
        nprHHData?.isInEnglish =  (util.isEnumerator() && modelDict.name.count > 0)
       // nprHHData?.houseNo = AppFormat.hhFormat.censusHouseNumber()
        //nprHHData?.census_hNo = modelDict.censusHOuseNumber.censusHouseNumber()
        //nprHHData?.census_hhNo = modelDict.censusHHNumber.censusHHNumber()
         //nprHHData?.houseNo = modelDict.hhNoHh ?? ""
         nprHHData?.sub_eb = modelDict.subebno ?? ""
         nprHHData?.hh_tin = modelDict.tin ?? ""
       // nprHHData?.hh_tin_New = modelDict.hh.hhTin()
        
        if let hhStatus = Int(modelDict.status ?? "") {
            print(hhStatus)
            nprHHData?.hh_status = modelDict.status ?? ""
        }else
        {
            nprHHData?.hh_status = "0"
        }
         
        nprHHData?.hh_completed = HHCompletionStatusCode.notStarted
        
        //nprHHData?.slnohhd = modelDict.hh.hhNumber()
        nprHHData?.discrictCode = modelDict.districtcode
        
        nprHHData?.block_no = modelDict.blockno
        nprHHData?.sub_eb = modelDict.subebno
        nprHHData?.wardID = modelDict.wardid
         nprHHData?.stateCode = modelDict.statecode ?? ""
         nprHHData?.townCode = modelDict.towncode ?? ""
         nprHHData?.tahsil_code = modelDict.tehsilcode ?? ""
        nprHHData?.addressHNLocality = modelDict.addressline1
        nprHHData?.addressPinCode = modelDict.pincode ?? ""
         nprHHData?.head_DOB =  strModifiedDate 
         nprHHData?.headName = modelDict.name ?? ""
        nprHHData?.headName_sl = modelDict.namesl ?? ""
        nprHHData?.headGenderID = modelDict.genderid ?? ""
         nprHHData?.isOpen = false
         //nprHHData?.isUpdated
         nprHHData?.wardID = modelDict.wardid ?? ""
        nprHHData?.addressHNLocality = modelDict.addressline1
        //nprHHData?.isUpdated
       
        nprHHData?.addressPinCode = modelDict.pincode
        nprHHData?.addressBlockId = singleton().selectEBListModel.eb_block_number
        nprHHData?.addressWardID = singleton().selectEBListModel.ebWard_code
        nprHHData?.addressSubDistrict = singleton().selectEBListModel.ebTahsil_code
        nprHHData?.addressDistrict = singleton().selectEBListModel.ebDistrict_code
        nprHHData?.addressState = singleton().selectEBListModel.ebState_code

        nprHHData?.addressCountryName = modelDict.countryname ?? util.countryName
        
        nprHHData?.addressStateName_sl = modelDict.statenamesl ?? ""
        nprHHData?.addressStateName = modelDict.statename ?? ""
        
        nprHHData?.addressDistrictName = modelDict.districtname ?? ""
        nprHHData?.addressDistrictName_sl = modelDict.districtnamesl ?? ""
        if util.isEnumerator(){
        nprHHData?.language = modelDict.languageRow.lanaugeCode() 
        }
        
        nprHHData?.ebNumber     = singleton().selectEBListModel.eb_number//"\(modelDict.statecode ?? "")\(modelDict.districtcode ?? "")\(modelDict.tehsilcode ?? "")\(modelDict.towncode ?? "")\(modelDict.wardid ?? "")\(modelDict.blockno ?? "")\(modelDict.subebno ?? "")"
        nprHHData?.isInEnglish = (util.isEnumerator() && modelDict.name.count > 0)
        
        nprHHData?.hh_tin = nprHHData?.houseHoldhNo?.hhTin()
        
         do {
             try context.save()
             
            print("IndexSaved")
            complete(true)
             
             } catch {
                                   print(" Household list Failed saving")
                 
         }
        
        
        
    }
    
    
    
    func saveNewHouseHold(formClass:AddNewHouseHoldForm_TVC, complete:@escaping(Bool)->Void)  {
        
        
        let context  = appDelegate.persistentContainer.viewContext
       
        let nprHHData = DataBaseManager().openDataBase(entityName: EntityName.nprHHStats) as? NPR_2021hh_Details
        let ebDetailModel  = singleton().selectEBListModel
        
//        if !util.isEnumerator() {
//            nprHHData?.is_superVisor_login = true
//        }
        
        
        let privateMOC = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateMOC.parent = context
        nprHHData?.block_no = singleton().selectEBListModel.eb_block_number
        nprHHData?.houseHoldhNo = formClass.strHHNumber.hhNumber()
        
            nprHHData?.census_hhNo = formClass.tf_pd_houseHoldNO.text?.censusHHNumber()
        
        
       
            nprHHData?.census_hNo = formClass.pd_houseNo.text?.censusHouseNumber()
            nprHHData?.houseNo = nprHHData?.census_hNo
        
       
        nprHHData?.houseHoldhNo = formClass.strHHNumber
        
         nprHHData?.sub_eb = ebDetailModel.ebSubEB_code ?? ""
        nprHHData?.hh_tin = formClass.strHHNumber.hhTin()
        nprHHData?.hh_completed = HHCompletionStatusCode.completed
        //nprHHData?.hh_status = HHStatusCode.new
        nprHHData?.hh_status = HHStatusCode.new
        //nprHHData?.hh_completed
        nprHHData?.houseHoldhNo = formClass.strHHNumber.hhNumber()
        nprHHData?.stateCode = ebDetailModel.ebState_code
         nprHHData?.townCode = ebDetailModel.ebTown_code
        nprHHData?.tahsil_code = ebDetailModel.ebTahsil_code
        nprHHData?.head_DOB = FormDateMangement().dateFormat(type: .personal, formClass: formClass)
        
        if util.isSelectedLang_english() {
            
            nprHHData?.headName = formClass.tf_pd_Name.text ?? ""
        }else{
            nprHHData?.headName_sl = formClass.tf_pd_Name.text ?? ""
        }
        if util.isSelectedLang_english() {
            nprHHData?.instituteName = formClass.strInstituteName
        }else{
            nprHHData?.instituteName_sl = formClass.strInstituteName
        }
        
        nprHHData?.language = LanguageModal.currentLanguage.lanaugeCode()
        nprHHData?.headGenderID = "\(formClass.genderId.rawValue)"
         nprHHData?.isOpen = false
         //nprHHData?.isUpdated
         nprHHData?.wardID = ebDetailModel.ebWard_code ?? ""
        nprHHData?.ebNumber     = singleton().selectEBListModel.eb_number
        
        nprHHData?.hh_tin = nprHHData?.houseHoldhNo?.hhTin()
        //HhType start from 10 in enum
        nprHHData?.hhType = formClass.selectedHouseType?.rawValue ?? "1"
         
         do {
             try context.save()
            
            print("IndexSaved")
            
            complete(true)
             } catch {
                                   print(" Household list Failed saving")
                 
         }
        
        }
        
    
    
    
    
    func savedNewSplitHH(hhModel:NPR_2021hh_Details,strHHID:String,strHN:String,araySelectedMember:[NPR2021MemberDetails], complete:@escaping(Bool)->Void)  {
        
        
        
        let nprHHData = DataBaseManager().openDataBase(entityName: EntityName.nprHHStats) as? NPR_2021hh_Details
        let ebDetailModel  = singleton().selectEBListModel
        
       
        nprHHData?.is_Splited = true
        nprHHData?.splitedFrom = hhModel.houseHoldhNo
        nprHHData?.originalHHNumberSplit = hhModel.originalHHNumberSplit
         nprHHData?.block_no = ebDetailModel.eb_block_number ?? ""
        
        nprHHData?.hh_completed = HHCompletionStatusCode.notStarted
        nprHHData?.hh_status = HHStatusCode.old
        nprHHData?.houseHoldhNo = strHHID
         nprHHData?.houseNo = strHN
         nprHHData?.sub_eb = ebDetailModel.ebSubEB_code ?? ""
        nprHHData?.hh_tin = strHHID.hhTin()
       // nprHHData?.hh_tin = nprHHData?.houseHoldhNo?.hhTin()//"\(ebDetailModel.eb_number ?? "")\(strHHID)"
        nprHHData?.hh_completed = HHCompletionStatusCode.notStarted
        nprHHData?.hh_status = HHStatusCode.old
         //nprHHData?.hh_status = modelDict.status ?? ""
        //nprHHData?.hh_completed
       // nprHHData?.slnohhd = hhModel.strMemberNumber
        nprHHData?.stateCode = ebDetailModel.ebState_code ?? ""
        nprHHData?.discrictCode = ebDetailModel.ebDistrict_code ?? ""
         nprHHData?.townCode = ebDetailModel.ebTown_code
        nprHHData?.tahsil_code = ebDetailModel.ebTahsil_code
        nprHHData?.head_DOB = araySelectedMember[0].dob
        nprHHData?.headName = araySelectedMember[0].name ?? ""
        
            nprHHData?.headName_sl = araySelectedMember[0].nameSL ?? ""
        
        nprHHData?.language = araySelectedMember[0].language
        nprHHData?.headGenderID = araySelectedMember[0].gender_id
         nprHHData?.isOpen = false
        nprHHData?.hh_completed = HHCompletionStatusCode.notStarted
        nprHHData?.census_hhNo = hhModel.census_hhNo
        nprHHData?.census_hNo = hhModel.census_hNo
        nprHHData?.houseHoldhNo = strHHID.hhNumber()
         //nprHHData?.isUpdated
         nprHHData?.wardID = ebDetailModel.ebWard_code ?? ""
        nprHHData?.respondentName = ""
        nprHHData?.ebNumber     = singleton().selectEBListModel.eb_number//"\(ebDetailModel.ebState_code ?? "")\(ebDetailModel.ebDistrict_code ?? "")\(ebDetailModel.ebTahsil_code ?? "")\(ebDetailModel.ebTown_code ?? "")\(ebDetailModel.ebWard_code ?? "")\(ebDetailModel.eb_block_number ?? "")\(ebDetailModel.ebSubEB_code ?? "")"
        
        nprHHData?.hh_tin = strHHID.hhTin()
        nprHHData?.houseHoldhNo = strHHID.hhNumber()
       // nprHHData?.hh_tin = nprHHData?.houseHoldhNo?.hhTin()
        
         
         do {
             try context.save()
            print("IndexSaved")
             complete(true)
           
                 //Completion(true)
             
             } catch {
                                   print(" Household list Failed saving")
                 
         }
        
        
        
    }
        
    }



extension DBManagerHousehold {
    
    
    func updateEB_flag_isdownloaded(modelEBList:EB)  {
        modelEBList.is_eb_downloaded = true
        do {
           try context.save()
        }
        catch{}
        
    }
    
    
    func updateEB_Active_Flag(modelEBList:EB, value:String) {
        modelEBList.eb_active = value
        do {
            try context.save()
          }
        catch{}
    }
    
    func updateHHStatusAfterUploaded()  {
        let predicate =  NSPredicate(format: "hh_completed != %@ ",HHCompletionStatusCode.notStarted)
        guard let arayHouseHold = DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicate) as? [NPR_2021hh_Details] else {
            return
        }
        
        
        for modelhh in arayHouseHold {
            
            modelhh.hh_completed = HHCompletionStatusCode.uploaded
            
            do {
                try context.save()
                }
             catch  {
                
            }



         }
    }
  // Update Member status befure update hh status Update
// Cause //because of crash due to race condition
    func updateHHMemberAfterUpoadData()  {
        
        let predicate =  NSPredicate(format: "hh_completed != %@ ",HHCompletionStatusCode.notStarted)
        guard let arayHouseHold = DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicate) as? [NPR_2021hh_Details] else {
            return
        }
        
        
        for modelhh in arayHouseHold {
           
            DBManagerMemberDetail().updateMemberStatusAfterUploadHH(hhModel: modelhh, memberCompletionStatus: .uploaded) { (isSaved) in
                if modelhh == arayHouseHold.last {
                    self.updateHHStatusAfterUploaded()
                }
            }

        }
    }
    
    

    func checkHHCompleted(houseHoldNumber:String ,completionType:String,Completion:@escaping(Bool) -> Void )   {
        
        //censusHH_number
        let hhTin = houseHoldNumber.hhTin()
        
        let predicateIncompleteMembers = NSPredicate(format: "hh_tin = %@ AND member_completionStatus = %@ ", hhTin,MemberCompletionStatusCode.notStarted)
        
        let predicateHH = NSPredicate(format: "hh_tin = %@ ", hhTin)
        let hhModelData =  DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicateHH) as? [NPR_2021hh_Details]
        
      let incompleteMember =  DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data, predicate: predicateIncompleteMembers)
        if incompleteMember.count > 0 {
            
            
            hhModelData?[0].hh_completed = HHCompletionStatusCode.inComplete
            
            do {
                try context.save()
                Completion(true)
    
            } catch  {
                
            }
        }else {
           // Completion(true)
            
            hhModelData?[0].hh_completed = HHCompletionStatusCode.completed
            
            do {
                try context.save()
                Completion(true)
    
            } catch  {
                
            }
        }
        
        
    }
    
    // Mark:update HH status ex. not started , incomplete ,Completed by
    
    func updateHHStatus_dependONMember(houseHoldModel:NPR_2021hh_Details,Completion:@escaping(Bool) -> Void)   {
        
        DBManagerMemberDetail().updateMemberStatusSkipedHH(hhModel: houseHoldModel)
        
        DBManagerMemberDetail().fetchedHHMembers(modelSelectedHH: houseHoldModel) { (arayTotalMember) in
            
            let remainMembers_notStarted = DBManagerMemberDetail().fetchHHMember_byStatus(modelSelectedHH: houseHoldModel, status: MemberStatusCode.notStarted)
            
            if arayTotalMember.count == remainMembers_notStarted.count{
                houseHoldModel.hh_completed = HHCompletionStatusCode.notStarted
            }else if remainMembers_notStarted.count == 0 {
                houseHoldModel.hh_completed = HHCompletionStatusCode.completed
            }else if arayTotalMember.count > remainMembers_notStarted.count{
                houseHoldModel.hh_completed = HHCompletionStatusCode.inComplete
                
            }
            
            do {
                try context.save()
                
                self.updateSkipedHHDependONMember(houseHoldModel: houseHoldModel)
                Completion(true)
            } catch  {
                
            }
          
        }
        
    }
    
    func updateSkipedHHDependONMember(houseHoldModel:NPR_2021hh_Details)  {
      let hhStatus = HHStaus.init(rawValue: houseHoldModel.hh_status ?? "")
        
        if hhStatus == .locked || hhStatus == .migratedOut || hhStatus == .notAvailable{
            houseHoldModel.hh_status = HHStatusCode.available
            do {
                try context.save()
                DBManagerMemberDetail().updateMemberStatusSkipedHH(hhModel: houseHoldModel)
            } catch  {
                
            }
        }
    }
    
    func fetchHHList(predicateHH:NSPredicate, Completion:@escaping(_ arayHHLis:[NPR_2021hh_Details]) -> Void)   {
        
       // let predicateHH = NSPredicate(format: "hh_tin = %@ ", hhTin)
        guard let hhModelDataList =  DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicateHH) as? [NPR_2021hh_Details] else { return  }
        
        Completion(hhModelDataList)
        
    }
    
    func fetchHHDetail(hhTin:String, Completion:@escaping(_ hhModel:NPR_2021hh_Details) -> Void)   {
        
        let predicateHH = NSPredicate(format: "hh_tin = %@ ", hhTin)
        guard let hhModelDataList =  DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicateHH) as? [NPR_2021hh_Details] else { return  }
        if hhModelDataList.count > 0 {
            Completion(hhModelDataList[0])
        }else{
            Completion(NPR_2021hh_Details())
        }
       
        
    }
    
    
    func getNewHouseHoldNumber() -> String {
        let predicate = NSPredicate(format: "ebNumber = %@ ",singleton().selectEBListModel.eb_number ?? "" )
        guard let arayFetched:[NPR_2021hh_Details] = DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicate) as? [NPR_2021hh_Details] else {
            return ""
        }
        
        let sortedArary = arayFetched.sorted(by: {$0.houseHoldhNo ?? "" < $1.houseHoldhNo ?? ""})
       
        
        
        var strSerialNumber = ""
        print(String(format: AppFormat.hhFormat, strSerialNumber))
       
        for i in 0...sortedArary.count+1 {
            
           
            strSerialNumber = String(format: AppFormat.hhFormat, i+1 )
            let existHH = arayFetched.filter({$0.houseHoldhNo == strSerialNumber })
            
            if existHH.count == 0 {
              return strSerialNumber
            }
            
                
            }
    
        
        return strSerialNumber
    }
    

    func getNewHouseNumber() -> String {
        
        let predicate = NSPredicate(format: "ebNumber = %@ ",singleton().selectEBListModel.eb_number ?? "" )
        guard let arayFetched:[NPR_2021hh_Details] = DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicate) as? [NPR_2021hh_Details] else {
            return ""
        }
        
        let sortedArary = arayFetched.sorted(by: {$0.houseNo ?? "" < $1.houseNo ?? ""})
        
        var strSerialNumber = ""
        print(String(format: AppFormat.hhFormat, strSerialNumber))
       
        for i in 0...sortedArary.count+1 {
            
           
            strSerialNumber = String(format: AppFormat.hhFormat, i+1 )
            
            if i == arayFetched.count {
              return strSerialNumber
            }
            else if (strSerialNumber != sortedArary[i].houseNo) {
                print("HH No ",sortedArary[i].houseNo ?? "")
                   return strSerialNumber
                }
                
            }
    
        
        return strSerialNumber
    }
    
   
    
   
    func is_censusHouseholdExist(strCensusHHNo:String)->Bool  {
        
      //  let predicate = NSPredicate(format: "census_hhNo = %@  ",strCensusHHNo.censusHHNumber() )
       // let predicate = NSPredicate(format: "ebNumber = %@ ",singleton().selectEBListModel.eb_number ?? "" )
        
        
        let predicate = NSPredicate(format: "census_hhNo = %@ AND ebNumber = %@ ",strCensusHHNo.censusHHNumber(),singleton().selectEBListModel.eb_number ?? "" )
        let arayHouseHold = DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicate)
        return arayHouseHold.count > 0
            
    }

    
    func isNewMember_inHH(modelSelectedHH:NPR_2021hh_Details) -> Bool   {
        
       var arayNewMemberModel = [NPR2021MemberDetails]()
        
        DBManagerMemberDetail().fetchedHHMembers(modelSelectedHH: modelSelectedHH) { (arayHHMembers) in
            //self.arayMemberModel = arayHHMembers
            arayNewMemberModel = arayHHMembers.filter({$0.memberStatus == MemberStatusCode.newMember })
            
        }
       // print("HH Number \(modelSelectedHH.houseHoldhNo ?? "") , New Member Count \(arayNewMemberModel.count)")
        return arayNewMemberModel.count > 0
    }
    
}
