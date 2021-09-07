//
//  EnumeratorSignatureViewController.swift
//  NPR Screen
//
//  Created by mac on 19/08/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class EnumeratorSignatureViewController: UIViewController {

    @IBOutlet weak var stackViewRespondentCheck: UIStackView!
    @IBOutlet weak var chooseRespondentConstraintHeight: NSLayoutConstraint!
    @IBOutlet weak var signatureView: NPRDrawSignatureView!
    @IBOutlet weak var buttonClear: UIButton!
    @IBOutlet weak var buttonSave: UIButton!
    @IBOutlet weak var lblUserType: UILabel!
    @IBOutlet weak var lblSignType: UILabel!
    @IBOutlet weak var lblSignBellow: UILabel!
    @IBOutlet weak var lblHHNumber: UILabel!
    @IBOutlet weak var lblCensusHN: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnSignConsentRespondent: UIButton!
    @IBOutlet weak var btnUnableSignConsentRespondent: UIButton!
    @IBOutlet weak var btnRespondentName: UIButton!
    
    @IBOutlet weak var btnTick_unableRespondent: UIButton!
    @IBOutlet weak var btnTickConsent: UIButton!
    
    var isRespondentSign = false
    var modelHHRespondent = NPR_2021hh_Details()
    var strEnuSignBehalfOFRespondent = "Enumerator on behalf of"
    var strSelectedRespondent = ""
    var strRespondentName = ""
    
    
    
    
    var signatureImage = UIImage()
    var isSuperVisor = false
    
    var arrayCompletedHHMembers = [NPR2021MemberDetails]()
    var arrayCompletedHH = [NPR_2021hh_Details]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.signatureView.delegate = self
        self.updateSaveButton(isHidden: true)
        viewPrepare()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
    }
    
    override func viewDidLayoutSubviews() {
        if isRespondentSign {
            chooseRespondentConstraintHeight.constant = 30
            stackViewRespondentCheck.isHidden = false
            viewPrepareForRespondent()
        }
        else{
            chooseRespondentConstraintHeight.constant = 0
            stackViewRespondentCheck.isHidden = true
        }
    }
    
    func viewPrepareForRespondent()  {
        
        if isRespondentSign {
            let strRespondent = English.signatureRespondent.signature_consent
            let strUnableRespondent = English.signatureRespondent.respondant_unable_to_sign_consent
            
            btnSignConsentRespondent.setTitle(strRespondent, for: .normal)
            btnUnableSignConsentRespondent.setTitle(strUnableRespondent, for: .normal)
            
            btnUnableSignConsentRespondent.titleLabel?.lineBreakMode = .byCharWrapping
            btnUnableSignConsentRespondent.titleLabel?.numberOfLines = 0
            
            btnSignConsentRespondent.titleLabel?.lineBreakMode = .byCharWrapping
            btnSignConsentRespondent.titleLabel?.numberOfLines = 0
            
            lblTitle.text = "Respondent Signature"
            
            fetchAllAvailableRespondentList()
        }
    }
    
    func viewPrepare()  {
        
        if !util.isEnumerator() {
            lblUserType.text = "Supervisor Signature"
            lblSignType.text = "Supervisor Sign below"
            
            
        }
        
    }
    
    func fetchAllAvailableRespondentList()  {
       // memberStatus
        DBManagerMemberDetail().fetchedHHMembers(modelSelectedHH: modelHHRespondent) { (arayMembers) in
            
            self.arrayCompletedHHMembers = arayMembers.filter({$0.memberStatus == MemberStatusCode.notStarted || $0.memberStatus == MemberStatusCode.available || $0.memberStatus == MemberStatusCode.newMember})
        }
        
        
    }
    
    func updateSaveButton(isHidden:Bool){
        self.buttonSave.isHidden = isHidden
    }

    func updateSignBelowLable()  {
        
        
        
        if btnTick_unableRespondent.isSelected {
            lblSignBellow.text = "Signed By \(strEnuSignBehalfOFRespondent) \(strSelectedRespondent)"
        }
        else{
            lblSignBellow.text = "Signed By \(strSelectedRespondent)"
        }
    }
    // MARK: Butttons Actions
    
    @IBAction func onTapBack(_ sender: Any) {
        
      // self.navigationController?.popViewController(animated: true)
        
        self.popTwoView()
        
        
    }
    
    
    @IBAction func onTapClear(_ sender: Any) {
        self.buttonSave.isHidden = true
        self.signatureView.clear()
    }
    
    
    @IBAction func onTapSave(_ sender: Any) {
        
        if isRespondentSign {
            if !isvalidRespondentSign() {
               return 
            }
        }
        
        if let signatureImage = self.signatureView.getSignature(scale: 10) {
                   //UIImageWriteToSavedPhotosAlbum(signatureImage, nil, nil, nil)
                   self.signatureImage = signatureImage
                   self.signatureView.clear()
            arrayCompletedHH = self.geAllCompletedHouseHold()
            if util.isEnumerator() {
                if isRespondentSign {
                    self.respondentSignatureSave()
                }else{
                    self.getAlLmembersOFCompletedHH()
                }
                
            }
            else{
                self.requestForUpload()
            }
            
            
            
        }
    }
    
    
    
    
    
    @IBAction func btnSignConsent_click(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
       updateSignBelowLable()
        
    }
    
    
    @IBAction func btn_unableCnsentRespondent(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
       updateSignBelowLable()
        
    }
    
    
    @IBAction func btnChooseRespondent_click(_ sender: UIButton) {
       
        
        let pickerRespondentList = Bundle.main.loadNibNamed("PickerViewRespondentList", owner: self, options: nil)?.first as? PickerViewRespondentList
        pickerRespondentList?.delegate = self
        pickerRespondentList?.loadPicker(arayMemberList: arrayCompletedHHMembers,view:view)
        
    }
    
    func isValidTosave_respondent()  {
       
        
    }
    
    func geAllCompletedHouseHold()-> [NPR_2021hh_Details] {
        
        let predicateHH = NSPredicate(format: "hh_completed = %@ && ebNumber = %@",HHCompletionStatusCode.completed,singleton().selectEBListModel.eb_number!)
        
        guard let arayCompletedHouseHold = DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicateHH) as? [NPR_2021hh_Details] else {
            return [NPR_2021hh_Details]()
        }
       return arayCompletedHouseHold
    }
    
    func fetchedMemberDetailData(modelSelectedHH:NPR_2021hh_Details ,Completion:@escaping([NPR2021MemberDetails]) -> Void )  {
        
        let predicate = NSPredicate(format: "hh_tin = %@",modelSelectedHH.hh_tin ?? "" )
        
        guard let  arayMemberD = DataBaseManager().fetchDBData(entityName: EntityName.npr2021Data,predicate: predicate) as? [NPR2021MemberDetails] else {
            return
        }
        
    Completion(arayMemberD)
    }
    
    
    func getAlLmembersOFCompletedHH()  {
        
        for hhDictAtIndex in arrayCompletedHH {
        
        self.fetchedMemberDetailData(modelSelectedHH: hhDictAtIndex) { (arayMembersInHH) in
            
            self.arrayCompletedHHMembers.append(contentsOf: arayMembersInHH)
            
            if hhDictAtIndex == self.arrayCompletedHH.last {
                if util.isEnumerator() {
                self.getEBList()
                }
            }
        }
        
    }
        
    }
    
    func getAllRecordData()-> NSMutableArray{
           let recordArr = NSMutableArray()
           if self.arrayCompletedHHMembers.count > 0 {
              for i in 0..<self.arrayCompletedHHMembers.count {
                   let recordDic = NSMutableDictionary()
//                   recordDic.setValue(self.arrayCompletedHHMembers[i].address_district_code, forKey: "addressDistrict")
//                   recordDic.setValue(self.arrayCompletedHHMembers[i].address_stateCode, forKey: "addressState")
                   
                   recordDic.setValue(self.arrayCompletedHHMembers[i].address_line1, forKey: "addressAddressline1")
                   recordDic.setValue(self.arrayCompletedHHMembers[i].address_line2, forKey: "addressAddressline2")
               // let blockNo = self.arrayCompletedHHMembers[i].block_no ?? ""
                
                recordDic.setValue(singleton().selectEBListModel.eb_block_number, forKey: "blockno") // "0051"
                
                   recordDic.setValue(self.arrayCompletedHHMembers[i].censusHH_number, forKey: "censusHhNo")
                   recordDic.setValue(self.arrayCompletedHHMembers[i].censusHouse_number, forKey: "censusHouseNo")
                recordDic.setValue(singleton().selectEBListModel.ebDistrict_code, forKey: "districtcode") // "11"
                   recordDic.setValue("03", forKey: "hhCompleted")//"03"
               // recordDic.setValue(self.arrayCompletedHHMembers[i].hh_status, forKey: "hhStatus") //"5"
                 recordDic.setValue("5", forKey: "hhStatus")
                   recordDic.setValue(self.arrayCompletedHHMembers[i].hh_type, forKey: "hhType") //"1"
//                   recordDic.setValue(self.arrayCompletedHHMembers[i].is_signUpdated, forKey: "isSignUpdated")
                
//                recordDic.setValue("0", forKey: "isSignUpdated")
//                recordDic.setValue(self.arrayCompletedHHMembers[i].name_responded, forKey: "nameRespondent")
                   recordDic.setValue(self.arrayCompletedHHMembers[i].name_responded, forKey: "nameRespondent")
                   recordDic.setValue(self.arrayCompletedHHMembers[i].pinCode, forKey: "pincode")
                //   recordDic.setValue("493613", forKey: "ppincode")
                   recordDic.setValue(self.getAllResidentData(), forKey: "residents")
                   recordDic.setValue(self.arrayCompletedHHMembers[i].sign_by_enum_onBehalf_of_responded, forKey: "signByEnumBehalfRespondant")
                   recordDic.setValue("", forKey: "signature")
                   recordDic.setValue(self.arrayCompletedHHMembers[i].slNo_responded, forKey: "slnoRespondent")
                recordDic.setValue(self.arrayCompletedHHMembers[i].hh_Number, forKey: "slnohhd")
                //recordDic.setValue("0001", forKey: "slnohhd")
                recordDic.setValue(singleton().selectEBListModel.ebState_code, forKey: "statecode")
                   recordDic.setValue(singleton().selectEBListModel.ebSubEB_code, forKey: "subebno") //"00"
                   recordDic.setValue(singleton().selectEBListModel.ebTahsil_code, forKey: "tehsilcode")
                   recordDic.setValue(singleton().selectEBListModel.ebTown_code, forKey: "towncode")
                   recordDic.setValue(singleton().selectEBListModel.ebWard_code, forKey: "wardid")
                   recordArr.add(recordDic)
              }
           }
           return recordArr
       }
    
   
    
       
       func getAllResidentData()-> NSMutableArray{
        
           let residentArr = NSMutableArray()
           if self.arrayCompletedHHMembers.count > 0 {
            
                 for i in 0..<self.arrayCompletedHHMembers.count {
                    
                    let residentDic = NSMutableDictionary()
                  
                    residentDic.setValue(self.arrayCompletedHHMembers[i].duration_inYear, forKey: "durationInyear")
                    
                    
                    residentDic.setValue(self.arrayCompletedHHMembers[i].dob, forKey: "dob") //"08-10-1979"
                    
                    residentDic.setValue(self.arrayCompletedHHMembers[i].father_name, forKey: "fatherName")
                    residentDic.setValue(self.arrayCompletedHHMembers[i].dob_type, forKey: "dobType")
                   
                    //residentDic.setValue(self.arrayCompletedHHMembers[i].enumerated_on, forKey: "enumeratedOn") //"2020-10-08T13:04:13.044Z"
                    residentDic.setValue("2020-10-08T13:04:13.044Z", forKey: "enumeratedOn")
                    
                    
                  //  residentDic.setValue(self.arrayCompletedHHMembers[i].father_dob, forKey: "fatherDob")
                 //   residentDic.setValue(self.arrayCompletedHHMembers[i].father_dobType, forKey: "fotherDobtype")
                    residentDic.setValue(self.arrayCompletedHHMembers[i].gender_id, forKey: "genderid")
                    residentDic.setValue("en", forKey: "language")
                    residentDic.setValue(self.arrayCompletedHHMembers[i].marital_status, forKey: "maritalStatus")
                    residentDic.setValue(self.arrayCompletedHHMembers[i].member_completionStatus, forKey: "memberCompleted")
                    residentDic.setValue(self.arrayCompletedHHMembers[i].memberStatus, forKey: "memberStatus") //"4"
                    residentDic.setValue(self.arrayCompletedHHMembers[i].mobile, forKey: "mobileNumber")//"8120380387"
//                    residentDic.setValue(self.arrayCompletedHHMembers[i].mother_dob, forKey: "motherDob")
//                    residentDic.setValue(self.arrayCompletedHHMembers[i].mother_code, forKey: "motherCode")
                    residentDic.setValue(self.arrayCompletedHHMembers[i].motherName, forKey: "motherName")
                    residentDic.setValue(self.arrayCompletedHHMembers[i].mother_dobType, forKey: "motherDobtype")
                    
                    residentDic.setValue(self.arrayCompletedHHMembers[i].name, forKey: "name") //"Prateek"
                    
                    
                    
                    residentDic.setValue(self.arrayCompletedHHMembers[i].paddre_line1, forKey: "paddressline1")//"CHHACHHANPAIRI"
                    residentDic.setValue(self.arrayCompletedHHMembers[i].address_line1_sl, forKey: "paddressline1sl")
                    residentDic.setValue(self.arrayCompletedHHMembers[i].paddress_line2, forKey: "paddressline2")
                    residentDic.setValue(self.arrayCompletedHHMembers[i].address_line2_sl, forKey: "paddressline2sl")
                    residentDic.setValue(self.arrayCompletedHHMembers[i].ppinCode, forKey: "ppincode")//"493661"
                   // residentDic.setValue("493613", forKey: "ppincode")
                    
                   // residentDic.setValue(self.arrayCompletedHHMembers[i].rel_code ?? "", forKey: "relCode") //"01"
                    
                    
                    residentDic.setValue(self.arrayCompletedHHMembers[i].tin, forKey: "tin")
                    
                    residentDic.setValue(self.arrayCompletedHHMembers[i].sloMember, forKey: "slnoMember") //"001"
                    residentDic.setValue(self.arrayCompletedHHMembers[i].staying_since_birthdate, forKey: "stayingSinceBirth")
                    //"872211008000400000019189001"
                    //residentDic.setValue("", forKey: "slnoMember")
                    let memberStatus = MemberLivingStatusCode.init(rawValue: self.arrayCompletedHHMembers[i].memberStatus ?? "")
                    
                    switch memberStatus {
                    case .available,.newMember:
                        residentDic.setValue(self.arrayCompletedHHMembers[i].edu_code, forKey: "eduCode") //"14"
                    //    residentDic.setValue("14", forKey: "eduCode")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].occu_code, forKey: "occuCode")//"1"
                    //    residentDic.setValue("1", forKey: "occuCode")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].rel_code, forKey: "relCode")
                        
                        residentDic.setValue(self.arrayCompletedHHMembers[i].birthCountryCode, forKey: "birthCountry")//"083"
                        residentDic.setValue(self.arrayCompletedHHMembers[i].birthStateCode, forKey: "birthStateCode")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].birthDistrictCode, forKey: "birthDistrictCode")
                        
                       
                        // Parent Detail
                        
                        
                        residentDic.setValue(self.arrayCompletedHHMembers[i].father_name, forKey: "fatherName")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].father_dob, forKey: "fatherDob")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].father_dobType, forKey: "fatherDobtype")
                        
//                        residentDic.setValue(self.arrayCompletedHHMembers[i].father_code, forKey: "fatherCode")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].fatherBirthCountryCode, forKey: "fatherBirthCountry")//"083"
                        residentDic.setValue(self.arrayCompletedHHMembers[i].fatherBirthStateCode, forKey: "fatherBirthState")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].fatherBirthDistrictCode, forKey: "fatherBirthDistrict")
                        
                        // Parent Detail
                        
                        
                        residentDic.setValue(self.arrayCompletedHHMembers[i].motherName, forKey: "motherName")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].mother_dob, forKey: "motherDob")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].mother_dobType, forKey: "motherDobtype")
                        
//                        residentDic.setValue(self.arrayCompletedHHMembers[i].father_code, forKey: "fatherCode")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].mother_birthCountryCode, forKey: "motherBirthCountry")//"083"
                        residentDic.setValue(self.arrayCompletedHHMembers[i].mother_birthStateCode, forKey: "motherBirthState")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].mother_birthDistrictCode, forKey: "motherBirthDistrict")
                       
                        
                        residentDic.setValue(self.arrayCompletedHHMembers[i].nationality, forKey: "nationality")
                        
                        residentDic.setValue(self.arrayCompletedHHMembers[i].paddress_countryCode, forKey: "paddressCountry")//"083"
                        residentDic.setValue(self.arrayCompletedHHMembers[i].paddre_districtCode, forKey: "paddressDistrict")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].paddress_stateCode, forKey: "paddressState")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].paddre_tahsilCode, forKey: "paddressTehsil")
                        
                        
//                        residentDic.setValue(self.arrayCompletedHHMembers[i].motherToungeode, forKey: "motherTongue") //"068"
                        
                        residentDic.setValue(self.arrayCompletedHHMembers[i].motherToungeode, forKey: "motherTongue")
                        residentDic.setValue(singleton().selectEBListModel.ebTahsil_code, forKey: "addressTehsilcode")
                        residentDic.setValue(singleton().selectEBListModel.ebState_code, forKey: "addressState")
                        residentDic.setValue(singleton().selectEBListModel.ebDistrict_code, forKey: "addressDistrict")
                        
                        
                        // Last Residency
                        
//                        residentDic.setValue(self.arrayCompletedHHMembers[i].lastResidencyCountry, forKey: "lastResidencyCountry")
//                        residentDic.setValue(self.arrayCompletedHHMembers[i].lastResidencyState, forKey: "lastResidencyState")
//                        residentDic.setValue(self.arrayCompletedHHMembers[i].lastResidencyDistrict, forKey: "lastResidencyDistrict")
                        
                        
                        
                        
                        break
                        
                    case .dead ,.lockedMember,.migratedOut,.notAvailable:
                        
                        residentDic.setValue(self.arrayCompletedHHMembers[i].occuName, forKey: "oefOccuName")
                        
                        residentDic.setValue(self.arrayCompletedHHMembers[i].eduName, forKey: "oefEduName")
                       
                        if (self.arrayCompletedHHMembers[i].rel_code == "") {
                            
                            residentDic.setValue("12", forKey: "relCode")
                            
                        }
                        else{
                            residentDic.setValue(self.arrayCompletedHHMembers[i].rel_code, forKey: "relCode")
                        }
                        
                        residentDic.setValue(self.arrayCompletedHHMembers[i].relName, forKey: "oefRelName")
                        
                        residentDic.setValue(self.arrayCompletedHHMembers[i].birthCountryName, forKey: "oefBirthCountryName")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].birthStateName, forKey: "oefBirthStateName")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].birthDistrictName, forKey: "oefBirthDistrictName")
                        
                        
                        residentDic.setValue(self.arrayCompletedHHMembers[i].nationality, forKey: "oefNationality")
                       
                        
                        residentDic.setValue(self.arrayCompletedHHMembers[i].paddress_country, forKey: "oefPermanentCountry")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].stateName_sl, forKey: "oefPermanentStatesl")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].paddress_state, forKey: "oefPermanentState")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].paddre_district, forKey: "oefPermanentDistrict")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].paddre_tahsil, forKey: "oefPermanentTehsil")
                        residentDic.setValue("", forKey: "oefPermanentTehsilsl")
                        
                        residentDic.setValue(self.arrayCompletedHHMembers[i].districtName, forKey: "oefPresentDistrict")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].districtName_sl, forKey: "oefPresentDistrictsl")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].address_state, forKey: "oefPresentState")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].stateName_sl, forKey: "oefPresentStatesl")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].paddre_tahsil, forKey: "oefPresentTehsil")
                       // residentDic.setValue(self.arrayCompletedHHMembers[i].paddre_tahsil, forKey: "oefPresentTehsilsl")
                        
                        residentDic.setValue(self.arrayCompletedHHMembers[i].relNameSL, forKey: "oefRelNamesl")
                        
                        
                        
                        break
                        
                    case .notStarted :
                        
                        break
                    default:
                        
                     break
                    }
                    
                   
                   
                    
                    residentArr.add(residentDic)
                }
             }
           return residentArr
       }
    func superVisorUploadParameter()  {
        
    }
    
    func superVisorAllRecord_param() -> NSMutableArray {
       
        let residentArr = NSMutableArray()
        if self.arrayCompletedHH.count > 0 {
              for i in 0..<self.arrayCompletedHH.count {
                 let residentDic = NSMutableDictionary()
               
                 
                residentDic.setValue(self.arrayCompletedHH[i].block_no, forKey: "blockno")
                residentDic.setValue(self.arrayCompletedHH[i].discrictCode, forKey: "districtcode")
                //residentDic.setValue(self.arrayCompletedHH[i].h_id, forKey: "slnohhd")
                residentDic.setValue(self.arrayCompletedHH[i].stateCode, forKey: "statecode")
                residentDic.setValue(self.arrayCompletedHH[i].sub_eb, forKey: "subebno")
                residentDic.setValue(self.arrayCompletedHH[i].superVisor_remrk, forKey: "superRemarks")
                residentDic.setValue(self.arrayCompletedHH[i].houseHoldhNo, forKey: "slnohhd")
                residentDic.setValue("2020-11-23T14:14:01.842Z", forKey: "superRemarksOn")
                residentDic.setValue(singleton().getCredentials().userId, forKey: "supervisor")
                residentDic.setValue(self.arrayCompletedHH[i].tahsil_code, forKey: "tehsilcode")
                residentDic.setValue(self.arrayCompletedHH[i].townCode, forKey: "towncode")
                residentDic.setValue(self.arrayCompletedHH[i].wardID, forKey: "wardid")
                
               
                 
                 residentArr.add(residentDic)
             }
          }
        return residentArr
    
        
}
    
    
    func getIndexIfEBNotExist(arr:[[String : Any]]) -> Int{
        var index = -1
        for i in 0..<arr.count {
            let ebNumber =  "\(arr[i]["statecode"] ?? "")\(arr[i]["districtcode"] ?? "")\(arr[i]["tehsilcode"] ?? "")\(arr[i]["towncode"] ?? "")\(arr[i]["ward"] ?? "")\(arr[i]["blockno"] ?? "")\(arr[i]["subebno"] ?? "")"
            
            if !self.ebExistInDataBase(ebNumber: ebNumber) {
               index = i
               return index
            }
        }
        return index
    }
    
    
    func ebExistInDataBase(ebNumber:String) -> Bool{
        let predicate = NSPredicate(format: "ebEnumerator contains[c] %@", ebNumber)
        if let _ = DataBaseManager().fetchDBData(entityName: EntityName.eb, predicate: predicate) as? [EB] {
            return true
        }
        else{
            return false
        }
    }
    
    
    func getEBList()  {
        
         self.view.showLoader()
         APIManager().downloadEBList(params: ["":""]) { (success, responseData, error) in
            DispatchQueue.main.async {self.view.removeLoaderView()}
           if success {
                if let data = responseData as? [[String:Any]] {
                    let index = self.getIndexIfEBNotExist(arr: data)
                    if index != -1 {
                        print("no service will hit")
                        print("Do updatation in database")
                    }
                    else{
                        print("Service Continue")
                            self.requestForExpectedHouseHold()
                    }
                }
           }
           else{
                if error?.localizedDescription == AppMessages.Not_Connected_To_Internet {
                  singleton().Alert.show(title: AppMessages.App_Name, message: AppMessages.Not_Connected_To_Internet, delay: 5.0)
               }
                if error?.localizedDescription == AppMessages.Server_Response {
                   //let serverMessage = responseData.object(forKey:"message") as? String ?? ""
                   singleton().Alert.show(title: AppMessages.App_Name, message: AppMessages.UnAuthorized_Access, delay: 5.0)
               }
           }
        }
    }
    
    
    func requestForEBStartDate()  {
        
        let dictParam = [Param_Key.StateCode: singleton().selectEBListModel.ebState_code ?? "",
                         Param_Key.DistrictCode: singleton().selectEBListModel.ebDistrict_code ?? "",
                         Param_Key.TehsilCode: singleton().selectEBListModel.ebTahsil_code ?? "",
                         Param_Key.TownCode: singleton().selectEBListModel.ebTown_code ?? "",
                         Param_Key.WardID: singleton().selectEBListModel.ebWard_code ?? "",
                         Param_Key.BlockNo: singleton().selectEBListModel.eb_block_number ?? "",
                         Param_Key.SubEBNo: singleton().selectEBListModel.ebSubEB_code ?? "",
                         Param_Key.NPREnumStarted: singleton().getCurrentTimeStamp()]
         self.view.showLoader()
         APIManager().postEBStartDate(params: dictParam) { (success, responseData, error) in
            DispatchQueue.main.async {self.view.removeLoaderView()}
           if success {
            self.requestForUpload()
           }
           else{
                if error?.localizedDescription == AppMessages.Not_Connected_To_Internet {
                  singleton().Alert.show(title: AppMessages.App_Name, message: AppMessages.Not_Connected_To_Internet, delay: 5.0)
                    
               }
                if error?.localizedDescription == AppMessages.Server_Response {
                   //let serverMessage = responseData.object(forKey:"message") as? String ?? ""
                   singleton().Alert.show(title: AppMessages.App_Name, message: AppMessages.UnAuthorized_Access, delay: 5.0)
               }
            
           }
            
        }
    }
    
    func requestForExpectedHouseHold()  {
        
        let dictParam = [Param_Key.StateCode: singleton().selectEBListModel.ebState_code ?? "",
                         Param_Key.DistrictCode: singleton().selectEBListModel.ebDistrict_code ?? "",
                         Param_Key.TehsilCode: singleton().selectEBListModel.ebTahsil_code ?? "",
                         Param_Key.TownCode: singleton().selectEBListModel.ebTown_code ?? "",
                         Param_Key.WardID: singleton().selectEBListModel.ebWard_code ?? "",
                         Param_Key.BlockNo: singleton().selectEBListModel.eb_block_number ?? "",
                         Param_Key.SubEBNo: singleton().selectEBListModel.ebSubEB_code ?? ""]
        DispatchQueue.main.async {
            self.view.showLoader()
        }
         
         APIManager().postExpectedHouseHold(params: dictParam) { (success, responseData, error) in
            //DispatchQueue.main.async {self.view.removeLoaderView()}
           if success {
           // self.requestForEBStartDate()
            self.requestForUpload()
           }
           else{
                if error?.localizedDescription == AppMessages.Not_Connected_To_Internet {
                  singleton().Alert.show(title: AppMessages.App_Name, message: AppMessages.Not_Connected_To_Internet, delay: 5.0)
               }
                if error?.localizedDescription == AppMessages.Server_Response {
                   //let serverMessage = responseData.object(forKey:"message") as? String ?? ""
                   singleton().Alert.show(title: AppMessages.App_Name, message: AppMessages.UnAuthorized_Access, delay: 5.0)
               }
            
           }
            
        }
    }
    
       func requestForUpload(){
        
        var recordData = NSMutableArray()
        if !util.isEnumerator() {
            recordData = superVisorAllRecord_param()
        }else{
            
            
            recordData = self.getAllRecordData()
        }
        
        let timeStamp = (NSDate().timeIntervalSince1970)*1000
       // let timeStamp = "20201021T150827675Z"
        let batchID = "\(singleton().selectEBListModel.eb_number ?? "")_\(singleton().getCredentials().userId )_\(timeStamp)"
        
       // Param_Key.Signature: singleton().convertToBase64(image: self.signatureImage)
        let dictParam = [Param_Key.BatchID: batchID,
                         Param_Key.Record: recordData,
                         Param_Key.Signature: singleton().convertToBase64(image: self.signatureImage),
                         Param_Key.SignedON: singleton().getCurrentTimeStamp()/*"2020-10-08T13:04:13.044Z"*/] as [String : Any]
             //let  json = singleton().convertToJson(data: dictParam)
        //self.view.showLoader()
        print("Upload Data",dictParam)
        APIManager().postUploadDataRequest(params: dictParam) { (success, responseData, error) in
               // DispatchQueue.main.async {self.view.removeLoaderView()}
               if success {
               // self.requestForEBCompletation()
                
                DispatchQueue.main.async {self.view.removeLoaderView()
                    let alertView = AlertView()
                    alertView.delegate = self
                  //  alertView.showAlertWithSingleButton(vc: self, title: "", message: "Data Uploaded Successfully")
                    alertView.alertWithoutButton(vc: self, message: "Data Uploaded Successfully")
                    
                        DBManagerHousehold().updateHHStatusAfterUploaded()
                   
                }
                
                
               }
               else{
                    if error?.localizedDescription == AppMessages.Not_Connected_To_Internet {
                      singleton().Alert.show(title: AppMessages.App_Name, message: AppMessages.Not_Connected_To_Internet, delay: 5.0)
                        self.view.removeLoaderView()
                   }
                    if error?.localizedDescription == AppMessages.Server_Response {
                       //let serverMessage = responseData.object(forKey:"message") as? String ?? ""
                       singleton().Alert.show(title: AppMessages.App_Name, message: AppMessages.UnAuthorized_Access, delay: 5.0)
                        self.view.removeLoaderView()
                   }
               }
           }
       }
    
    func requestForEBCompletation()  {
        
        let dictParam = [Param_Key.StateCode: singleton().selectEBListModel.ebState_code ?? "",
                         Param_Key.DistrictCode: singleton().selectEBListModel.ebDistrict_code ?? "",
                         Param_Key.TehsilCode: singleton().selectEBListModel.ebTahsil_code ?? "",
                         Param_Key.TownCode: singleton().selectEBListModel.ebTown_code ?? "",
                         Param_Key.WardID: singleton().selectEBListModel.ebWard_code ?? "",
                         Param_Key.BlockNo: singleton().selectEBListModel.eb_block_number ?? "",
                         Param_Key.SubEBNo: singleton().selectEBListModel.ebSubEB_code ?? "",
                         Param_Key.NPREnumCompletion: ""]
         self.view.showLoader()
        APIManager().postEBCompletation(params: dictParam) { (success, responseData, error) in
           // DispatchQueue.main.async {self.view.removeLoaderView()}
           if success {
               
           }
           else{
                if error?.localizedDescription == AppMessages.Not_Connected_To_Internet {
                  singleton().Alert.show(title: AppMessages.App_Name, message: AppMessages.Not_Connected_To_Internet, delay: 5.0)
               }
                if error?.localizedDescription == AppMessages.Server_Response {
                   //let serverMessage = responseData.object(forKey:"message") as? String ?? ""
                   singleton().Alert.show(title: AppMessages.App_Name, message: AppMessages.UnAuthorized_Access, delay: 5.0)
               }
            }
        }
    }
 
}

extension EnumeratorSignatureViewController : NPRSignatureDelegate {
    
    func didStart(_ view : NPRDrawSignatureView) {
          self.buttonSave.isHidden = false
          print("Started Drawing")
      }
    
      func didFinish(_ view : NPRDrawSignatureView) {
          print("Finished Drawing")
      }
    
}





extension EnumeratorSignatureViewController:PickerViewCommonDelegate {
    
    func didPickComponent(component: String) {
       strSelectedRespondent = component
        btnRespondentName.setTitle(component, for: .normal)
        updateSignBelowLable()
        strRespondentName = component
    }
    
    func cancelPicker() {
        
    }
    
    func isvalidRespondentSign()->Bool  {
        if btnTickConsent.isSelected && !strSelectedRespondent.isEmpty {
           return true
        }else {
            var strAlertMessage = ""
            
            if !btnTickConsent.isSelected && strSelectedRespondent.isEmpty{
                strAlertMessage = English.signatureRespondent.tickRespondent_chhoseRespont
            }else if !btnTickConsent.isSelected {
                strAlertMessage = English.signatureRespondent.tickRespondent
            }else{
                strAlertMessage = English.signatureRespondent.chooseRespondent
            }
            
            AlertView().alertWithoutButton(vc: self, message: strAlertMessage)
        }
      return false
    }
    func respondentSignatureSave()  {
        for viewcontroller in self.navigationController!.viewControllers {
            if viewcontroller is HouseholdMemberDetail_ViewController  {
                modelHHRespondent.respondentName = strRespondentName
                
                do {
                    try context.save()
                } catch  {
                    
                }
              
                
                viewcontroller.navigationController?.popViewController(animated: true)
            }
        }
        
    }
    
    
}



