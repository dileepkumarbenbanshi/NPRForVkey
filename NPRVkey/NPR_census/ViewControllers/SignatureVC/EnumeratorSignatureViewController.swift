//
//  EnumeratorSignatureViewController.swift
//  NPR Screen
//
//  Created by mac on 19/08/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
@objc protocol SignatureDelegate {
@objc optional func respondentSignatureCpatered()
 
}

@objc protocol DataUploadedDelegate {
@objc optional func DataUploadedSuccessfuly()
@objc optional func DataUploadedFailled()
 
}
class EnumeratorSignatureViewController: UIViewController {

    @IBOutlet weak var btnChooseRespondent: UIButton!
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
    var strSloRespondent = ""
    
    var delegate:SignatureDelegate?
    var isFromFormPage = false
    var isFromUpload = false
    var uploadDelegate:DataUploadedDelegate?
    
    
    
    
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
            if util.isEnumerator() {
                lblSignType.text = LanguageModal.langObj.enumerator_sign
            }
           
        }
    }
    
    func viewPrepareForRespondent()  {
        
        if isRespondentSign {
            let strRespondent = LanguageModal.langObj.signature_consent
            let strUnableRespondent = LanguageModal.langObj.respondant_unable_to_sign_consent
            
            btnSignConsentRespondent.setTitle(strRespondent, for: .normal)
            btnUnableSignConsentRespondent.setTitle(strUnableRespondent, for: .normal)
            
            btnUnableSignConsentRespondent.titleLabel?.lineBreakMode = .byCharWrapping
            btnUnableSignConsentRespondent.titleLabel?.numberOfLines = 0
            
            btnSignConsentRespondent.titleLabel?.lineBreakMode = .byCharWrapping
            btnSignConsentRespondent.titleLabel?.numberOfLines = 0
            
            lblTitle.text = LanguageModal.langObj.respondent_signature
            
            fetchAllAvailableRespondentList()
            lblCensusHN.text = "\(LanguageModal.langObj.census_house_no) : \(modelHHRespondent.census_hNo ?? "")"
            btnRespondentName.setTitle(LanguageModal.langObj.choose_respondent, for: .normal)
            lblHHNumber.text = "\(LanguageModal.langObj.hh_number) : \(modelHHRespondent.houseHoldhNo ?? "")"
        }
    }
    
    func viewPrepare()  {
        
      //
        if !util.isEnumerator() {
            lblUserType.text = LanguageModal.langObj.sup_signature
            lblSignType.text = LanguageModal.langObj.sup_sign
            //btnRespondentName.setTitle(LanguageModal.langObj.choose_respondent, for: .normal)
            
        }
        buttonClear.setTitle(LanguageModal.langObj.clear, for: .normal)
        
        buttonSave.setTitle(LanguageModal.langObj.button_save, for: .normal)
        strEnuSignBehalfOFRespondent = LanguageModal.langObj.sign_by_enumerator_on_behalf_of
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
            lblSignBellow.text = "\(LanguageModal.langObj.sign_by) \(strEnuSignBehalfOFRespondent) \(strSelectedRespondent)"
        }
        else{
            lblSignBellow.text = "\(LanguageModal.langObj.sign_by) \(strSelectedRespondent)"
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
        
        if let signatureImage = self.signatureView.getSignature(scale: 2) {
                   //UIImageWriteToSavedPhotosAlbum(signatureImage, nil, nil, nil)
                   self.signatureImage = signatureImage
                   self.signatureView.clear()
            arrayCompletedHH = self.geAllCompletedHouseHold()
            if util.isEnumerator() {
                if isRespondentSign {
                    self.respondentSignatureSave()
                }else{
                    DispatchQueue.main.async {self.view.showLoader()}
                    self.prepareForUploadEnumData()
                    
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
    
    
    func prepareForUploadEnumData()  {
        if arrayCompletedHH.count > 0 {
            
        // Check Completed HH count
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
        }else{
          // If No HH means Inhavited EB
            DispatchQueue.main.async {self.view.removeLoaderView()}
            self.navigationController?.popViewController(animated: true)
            uploadDelegate?.DataUploadedSuccessfuly?()
            
           
        }
        
    }
    
    // Set HH Detail
    func getAllRecordData()-> NSMutableArray{
        let nulValue = NSNull()
           let recordArr = NSMutableArray()
           if self.arrayCompletedHH.count > 0 {
              for i in 0..<self.arrayCompletedHH.count {
                   let recordDic = NSMutableDictionary()
//                   recordDic.setValue(self.arrayCompletedHHMembers[i].address_district_code, forKey: "addressDistrict")
//                   recordDic.setValue(self.arrayCompletedHHMembers[i].address_stateCode, forKey: "addressState")
                //recordDic.setValue(singleton().selectEBListModel.ebEnumStartOn, forKey: "enumStartedOn")
               // recordDic.setValue(singleton().selectEBListModel.ebEnumStartOn, forKey: "enumStartedOn")
                recordDic.setValue(self.arrayCompletedHH[i].hhType, forKey: "hhType")
                recordDic.setValue(self.arrayCompletedHH[i].instituteName ?? "", forKey: "institutionName")
                recordDic.setValue(self.arrayCompletedHH[i].instituteName_sl ?? "", forKey: "institutionNamesl")
                
                recordDic.setValue(self.arrayCompletedHH[i].slnoRespondent?.memberSrNumberForUpload(), forKey: "slnoRespondent")
                
               // let blockNo = self.arrayCompletedHHMembers[i].block_no ?? ""
                
                recordDic.setValue(singleton().selectEBListModel.eb_block_number, forKey: "blockno") // "0051"
                
                recordDic.setValue(self.arrayCompletedHH[i].census_hhNo?.censusHHNumberForUpload(), forKey: "censusHhNo")
                   recordDic.setValue(self.arrayCompletedHH[i].census_hNo ?? "", forKey: "censusHouseNo")
                recordDic.setValue(singleton().selectEBListModel.ebDistrict_code, forKey: "districtcode") // "11"
                //self.arrayCompletedHH[i].hh_completed
                recordDic.setValue(HHCompletionStatusCode.uploaded, forKey: "hhCompleted")//"03"
                    // recordDic.setValue("5", forKey: "hhStatus") //"5"
                 recordDic.setValue(self.arrayCompletedHH[i].hh_status, forKey: "hhStatus")
                //recordDic.setValue("1", forKey: "hhType") //"1"
                   recordDic.setValue(self.arrayCompletedHH[i].hhType, forKey: "hhType") //"1"
//                   recordDic.setValue(self.arrayCompletedHHMembers[i].is_signUpdated, forKey: "isSignUpdated")
                
//                recordDic.setValue("0", forKey: "isSignUpdated")
//                recordDic.setValue(self.arrayCompletedHHMembers[i].respondentName_sl, forKey: "nameRespondentsl")
                let isSignUpdated = self.arrayCompletedHH[i].respondentName?.count ?? 0 > 0 ? "1" : "0"
                
                   recordDic.setValue(self.arrayCompletedHH[i].respondentName, forKey: "nameRespondent")
                recordDic.setValue(self.arrayCompletedHH[i].signByEnumBehalfRespondant, forKey: "signByEnumBehalfRespondant")
                recordDic.setValue(self.arrayCompletedHH[i].signRespondet, forKey: "signature")
                recordDic.setValue(isSignUpdated, forKey: "isSignUpdated")
                
               
                let arayResidents = self.getAllResidentData(hhModel: self.arrayCompletedHH[i])
                
                   recordDic.setValue(arayResidents, forKey: "residents")
                  
                  // recordDic.setValue(self.arrayCompletedHH[i].slNo_responded, forKey: "slnoRespondent")
                recordDic.setValue(self.arrayCompletedHH[i].houseHoldhNo, forKey: "slnohhd")
                //recordDic.setValue("0001", forKey: "slnohhd")
                recordDic.setValue(arrayCompletedHH[i].addressPinCode ?? "", forKey: "pincode")
                   recordDic.setValue(self.arrayCompletedHH[i].addressHNLocality ?? "", forKey: "addressAddressline1")
                
                    recordDic.setValue(self.arrayCompletedHH[i].addressHNLocality_sl ?? "", forKey: "addressAddressline1sl")
                
                
                recordDic.setValue(singleton().selectEBListModel.ebTown_name, forKey: "addressAddressline2")
                recordDic.setValue(singleton().selectEBListModel.ebState_code, forKey: "statecode")
                   recordDic.setValue(singleton().selectEBListModel.ebSubEB_code, forKey: "subebno") //"00"
                   recordDic.setValue(singleton().selectEBListModel.ebTahsil_code, forKey: "tehsilcode")
                   recordDic.setValue(singleton().selectEBListModel.ebTown_code, forKey: "towncode")
                   recordDic.setValue(singleton().selectEBListModel.ebWard_code, forKey: "wardid")
                
                
                recordDic.setValue(singleton().selectEBListModel.ebState_code, forKey: "addressState")
                
                recordDic.setValue(singleton().selectEBListModel.ebDistrict_code, forKey: "addressDistrict")
                recordDic.setValue(singleton().selectEBListModel.ebTown_code, forKey: "towncode")
                recordDic.setValue(singleton().selectEBListModel.ebWard_code, forKey: "wardid")
                recordDic.setValue(singleton().selectEBListModel.ebTahsil_code, forKey: "addressTehsilcode")
                //recordDic.setValue(arrayCompletedHH[i].addressHNLocality ?? "", forKey: "addressAddressline1")
                   recordArr.add(recordDic)
                
                
                recordDic.setValue(self.arrayCompletedHH[i].splitedTo ?? "", forKey: "splitsInto")
                recordDic.setValue(self.arrayCompletedHH[i].splitedFrom ?? "", forKey: "splitsFrom")
                //recordDic.setValue(self.arrayCompletedHH[i].SEref ?? "", forKey: "seReference")
                
                
                if (self.arrayCompletedHH[i].census_hhNo?.count == 0)  {
                    recordDic.setValue(nulValue, forKey: "censusHhNo")
                    
                }
              }
           }
        if recordArr.count == 0 {
            let emptyDict = ["":""]
            recordArr.add(emptyDict)
        }
           return recordArr
       }
    
   
    
       // Set Member Detail Data
    func getAllResidentData(hhModel:NPR_2021hh_Details)-> NSMutableArray{
        let nulValue = NSNull()
        
        DBManagerMemberDetail().fetchedHHMembers(modelSelectedHH: hhModel) { (arayMemberInHH) in
            self.arrayCompletedHHMembers = arayMemberInHH
        }
           let residentArr = NSMutableArray()
           if self.arrayCompletedHHMembers.count > 0 {
            
                 for i in 0..<self.arrayCompletedHHMembers.count {
                    
                    let residentDic = NSMutableDictionary()
                 
                    
                    residentDic.setValue(self.arrayCompletedHHMembers[i].old_tin, forKey: "tin2019")
                    
                    residentDic.setValue(self.arrayCompletedHHMembers[i].gender_id, forKey: "genderid")
                    residentDic.setValue(self.arrayCompletedHHMembers[i].marital_status, forKey: "maritalStatus")
                    if self.arrayCompletedHHMembers[i].marital_status?.count == 0 {
                        residentDic.setValue(nulValue, forKey: "maritalStatus")
                    }
                    //self.arrayCompletedHHMembers[i].member_completionStatus
                    residentDic.setValue(MemberCompletionStatusCode.uploaded, forKey: "memberCompleted")
                    
                    residentDic.setValue(self.arrayCompletedHHMembers[i].name ?? "", forKey: "name")
                    residentDic.setValue(self.arrayCompletedHHMembers[i].nameSL ?? "", forKey: "namesl")
                    residentDic.setValue(self.arrayCompletedHHMembers[i].first_name , forKey: "firstName")
                    residentDic.setValue(self.arrayCompletedHHMembers[i].first_name_sl ?? "", forKey: "firstnamesl")
                    
                    residentDic.setValue(self.arrayCompletedHHMembers[i].midle_name , forKey: "midleName")
                    residentDic.setValue(self.arrayCompletedHHMembers[i].midle_name_sl ?? "", forKey: "middlenamesl")
                    residentDic.setValue(self.arrayCompletedHHMembers[i].last_name , forKey: "lastName")
                    residentDic.setValue(self.arrayCompletedHHMembers[i].last_name_sl ?? "", forKey: "lastnamesl")

                    residentDic.setValue(self.arrayCompletedHHMembers[i].memberStatus ?? "", forKey: "memberStatus")
                    residentDic.setValue(self.arrayCompletedHHMembers[i].passpord_id ?? "", forKey: "passport")
                    residentDic.setValue(self.arrayCompletedHHMembers[i].duration_inYear ?? "", forKey: "durationInyear")
                    
                    
                    
                    
                    
                    residentDic.setValue(self.arrayCompletedHHMembers[i].dob ?? "", forKey: "dob") //"08-10-1979"
                    
                    residentDic.setValue(self.arrayCompletedHHMembers[i].father_name ?? "", forKey: "fatherName")
                   // residentDic.setValue(self.arrayCompletedHHMembers[i].father_name_sl ?? "", forKey: "fathernmsl")
                    residentDic.setValue(self.arrayCompletedHHMembers[i].dob_type ?? "", forKey: "dobType")
                   
                    residentDic.setValue(self.arrayCompletedHHMembers[i].enumerated_on ?? "", forKey: "enumeratedOn") //"2020-10-08T13:04:13.044Z"
                    residentDic.setValue(singleton().getCurrentTimeStamp(), forKey: "enumeratedOn")
                    
                    
                  //  residentDic.setValue(self.arrayCompletedHHMembers[i].father_dob, forKey: "fatherDob")
                 //   residentDic.setValue(self.arrayCompletedHHMembers[i].father_dobType, forKey: "fotherDobtype")
                    
                    residentDic.setValue(self.arrayCompletedHHMembers[i].language ?? "", forKey: "language")
                     //"4"
                    //"8120380387"
//                    residentDic.setValue(self.arrayCompletedHHMembers[i].mother_dob, forKey: "motherDob")
                    
                    
                    
                    
                    residentDic.setValue(self.arrayCompletedHHMembers[i].father_name ?? "", forKey: "fatherName")
                    
                    let fatherFoundIndex = self.arrayCompletedHHMembers[i].language?.isEnglishLangCode() ?? false ? self.arrayCompletedHHMembers.filter({$0.father_name == self.arrayCompletedHHMembers[i].father_name}) : self.arrayCompletedHHMembers.filter({$0.father_name_sl == self.arrayCompletedHHMembers[i].father_name_sl})
                    
                    let fatherCode = fatherFoundIndex.count > 0 ? fatherFoundIndex.last?.sloMember : ""
                    
                   // residentDic.setValue(fatherCode?.memberSrNumberForUpload(), forKey: "fatherCode")
                    residentDic.setValue(self.arrayCompletedHHMembers[i].father_name_sl ?? "", forKey: "fatherNamesl")
                    residentDic.setValue(self.arrayCompletedHHMembers[i].father_dob ?? "", forKey: "fatherDob")
                    residentDic.setValue(self.arrayCompletedHHMembers[i].father_dobType ?? "", forKey: "fotherDobtype")
                   
                    
                    if self.arrayCompletedHHMembers[i].father_dobType?.count == 0 {
                        residentDic.setValue(nulValue, forKey: "fotherDobtype")
                    }
//                        residentDic.setValue(self.arrayCompletedHHMembers[i].father_code, forKey: "fatherCode")
                    residentDic.setValue(self.arrayCompletedHHMembers[i].fatherBirthCountryCode ?? "", forKey: "fatherBirthCountry")//"083"
                    residentDic.setValue(self.arrayCompletedHHMembers[i].fatherBirthStateCode ?? "", forKey: "fatherBirthState")
                    residentDic.setValue(self.arrayCompletedHHMembers[i].fatherBirthDistrictCode ?? "", forKey: "fatherBirthDistrict")
                    
                    // Parent Detail
                    residentDic.setValue(self.arrayCompletedHHMembers[i].motherName ?? "", forKey: "motherName")
                    residentDic.setValue(self.arrayCompletedHHMembers[i].motherName_sl ?? "", forKey: "motherNamesl")
                    
                    residentDic.setValue(self.arrayCompletedHHMembers[i].mother_dobType ?? "", forKey: "motherDobtype")
                    
                    if self.arrayCompletedHHMembers[i].mother_dobType?.count == 0 {
                        residentDic.setValue(nulValue, forKey: "motherDobtype")
                    }
                    
                    let motherFoundIndex = self.arrayCompletedHHMembers[i].language?.isEnglishLangCode() ?? false ? self.arrayCompletedHHMembers.filter({$0.motherName == self.arrayCompletedHHMembers[i].motherName}) : self.arrayCompletedHHMembers.filter({$0.motherName_sl == self.arrayCompletedHHMembers[i].motherName_sl})
                    
                    let motherSlo = motherFoundIndex.count > 0 ? fatherFoundIndex.last?.sloMember : ""
                    
                    residentDic.setValue(motherSlo?.memberSrNumberForUpload(), forKey: "motherCode")
                     //"Prateek"
                    residentDic.setValue(self.arrayCompletedHHMembers[i].spouseName ?? "", forKey: "spouseName")
                    residentDic.setValue(self.arrayCompletedHHMembers[i].spouseName_sl ?? "", forKey: "spouseNamesl")
                    let spouseFoundIndex = self.arrayCompletedHHMembers[i].language?.isEnglishLangCode() ?? false ? self.arrayCompletedHHMembers.filter({$0.spouseName == self.arrayCompletedHHMembers[i].spouseName}) : self.arrayCompletedHHMembers.filter({$0.spouseName_sl == self.arrayCompletedHHMembers[i].spouseName_sl})
                    
                    let spouseSlo = spouseFoundIndex.count > 0 ? fatherFoundIndex.last?.sloMember : ""
                    residentDic.setValue(spouseSlo ?? "", forKey: "spousecode")
                    
                    //spousecode
                    if self.arrayCompletedHHMembers[i].spouseName?.count == 0 {
                        residentDic.setValue(nulValue, forKey: "spouseName")
                    }
                    
                    residentDic.setValue(self.arrayCompletedHHMembers[i].motherName ?? "", forKey: "motherName")
                    residentDic.setValue(self.arrayCompletedHHMembers[i].mother_dob ?? "", forKey: "motherDob")
                    residentDic.setValue(self.arrayCompletedHHMembers[i].mother_dobType ?? "", forKey: "motherDobtype")
                    
                    residentDic.setValue(self.arrayCompletedHHMembers[i].mother_birthCountryCode ?? "", forKey: "motherBirthCountry")//"083"
                    residentDic.setValue(self.arrayCompletedHHMembers[i].mother_birthStateCode ?? "", forKey: "motherBirthState")
                    residentDic.setValue(self.arrayCompletedHHMembers[i].mother_birthDistrictCode ?? "", forKey: "motherBirthDistrict")
                    
                    // ID
                    residentDic.setValue(self.arrayCompletedHHMembers[i].aadhar ?? "", forKey: "aadhaar")
                    
                    residentDic.setValue(self.arrayCompletedHHMembers[i].mobile ?? "", forKey: "mobileNumber")
                    
                    residentDic.setValue(self.arrayCompletedHHMembers[i].voter_id ?? "", forKey: "voterId")
                    
                    residentDic.setValue(self.arrayCompletedHHMembers[i].driving_lincence ?? "", forKey: "drivingLicense")
                    
                  
                    
                    
                    
                    
                    
                    
                    //Present Address

                    

                    
                    // Permanent Address
                    residentDic.setValue(self.arrayCompletedHHMembers[i].paddre_line1 ?? "", forKey: "paddressline1")//"CHHACHHANPAIRI"
                    
                    residentDic.setValue(self.arrayCompletedHHMembers[i].address_line1_sl ?? "", forKey: "paddressline1sl")
                  
                    residentDic.setValue(self.arrayCompletedHHMembers[i].paddress_town ?? "", forKey: "paddressline2")
                    
                    residentDic.setValue(self.arrayCompletedHHMembers[i].address_line2_sl ?? "", forKey: "paddressline2sl")
                    residentDic.setValue(self.arrayCompletedHHMembers[i].ppinCode ?? "", forKey: "ppincode")//"493661"
                   // residentDic.setValue("493613", forKey: "ppincode")
                    
                   // residentDic.setValue(self.arrayCompletedHHMembers[i].rel_code ?? "", forKey: "relCode") //"01"
                   // var newTin = self.arrayCompletedHHMembers[i].new_tin ?? ""
                    
                    let newTin = self.arrayCompletedHHMembers[i].sloMember?.memberTin(hhNumber: self.arrayCompletedHHMembers[i].hh_Number ?? "")
                    residentDic.setValue(newTin, forKey: "tin")
                    
                    let strMemberSerialNumber = self.arrayCompletedHHMembers[i].sloMember ?? ""
                    residentDic.setValue(strMemberSerialNumber.memberSrNumberForUpload(), forKey: "slnoMember") //"001"
                    residentDic.setValue(self.arrayCompletedHHMembers[i].staying_since_birthdate ?? "", forKey: "stayingSinceBirth")
                    //"872211008000400000019189001"
                    //residentDic.setValue("", forKey: "slnoMember")
                   
                    //residentDic.setValue("001", forKey: "slnoMember")
                    let memberStatus = MemberLivingStatusCode.init(rawValue: self.arrayCompletedHHMembers[i].memberStatus ?? "")
                   
                    switch memberStatus {
                    case .available,.newMember:
                   
                        
                    //    residentDic.setValue("1", forKey: "occuCode")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].rel_code ?? "", forKey: "relCode")
                        
                        residentDic.setValue(self.arrayCompletedHHMembers[i].birthCountryCode ?? "", forKey: "birthCountry")//"083"
                        residentDic.setValue(self.arrayCompletedHHMembers[i].birthStateCode ?? "", forKey: "birthStateCode")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].birthDistrictCode ?? "", forKey: "birthDistrictCode")
                        
                      //  let strDictCode = DBManager_CountryStateDistrict().getDistrictCode(stateCode: self.arrayCompletedHHMembers[i].birthStateCode, districtName:self.arrayCompletedHHMembers[i].birthDistrictName )
                        
                        residentDic.setValue(self.arrayCompletedHHMembers[i].motherToungeode ?? "", forKey: "motherTongue")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].otherMotherTounge ?? "", forKey: "otherMotherTongue")
                        
                        residentDic.setValue(self.arrayCompletedHHMembers[i].edu_code ?? "", forKey: "eduCode") //"14"
                    //    residentDic.setValue("14", forKey: "eduCode")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].occu_code ?? "", forKey: "occuCode")//"1"
                        // Parent Detail
                        
                        
                        
                        
//                        residentDic.setValue(self.arrayCompletedHHMembers[i].father_code, forKey: "fatherCode")
                        
                       
                        
                        residentDic.setValue(self.arrayCompletedHHMembers[i].nationality ?? "", forKey: "nationality")
                        
                        residentDic.setValue(self.arrayCompletedHHMembers[i].paddress_countryCode ?? "", forKey: "paddressCountry")//"083"
                        residentDic.setValue(self.arrayCompletedHHMembers[i].paddre_districtCode ?? "", forKey: "paddressDistrict")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].paddress_stateCode ?? "", forKey: "paddressState")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].paddre_tahsilCode ?? "", forKey: "paddressTehsil")
                        
                        
                        residentDic.setValue(self.arrayCompletedHHMembers[i].motherToungeode, forKey: "motherTongue") //"068"
                        
                        
                        residentDic.setValue(singleton().selectEBListModel.ebTahsil_code ?? "", forKey: "addressTehsilcode")
                        residentDic.setValue(singleton().selectEBListModel.ebState_code ?? "", forKey: "addressState")
                        residentDic.setValue(singleton().selectEBListModel.ebDistrict_code ?? "", forKey: "addressDistrict")
                        
                        
                        // Last Residency
                        residentDic.setValue(self.arrayCompletedHHMembers[i].duration_inYear ?? "", forKey: "durationInyear")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].lastResidencyCountry ?? "", forKey: "lastResidencyCountry")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].lastResidencyState ?? "", forKey: "lastResidencyState")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].lastResidencyDistrict ?? "", forKey: "lastResidencyDistrict")
                        
                      
                        
                        
                        break
                        
                    case .dead ,.lockedMember,.migratedOut,.notAvailable:
                      
                        residentDic.setValue(self.arrayCompletedHHMembers[i].occuName ?? "", forKey: "oefOccuName")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].occuName_sl, forKey: "oefOccuNamesl")
                        
                        residentDic.setValue(self.arrayCompletedHHMembers[i].eduName ?? "", forKey: "oefEduName")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].eduName_sl ?? "", forKey: "oefEduNamesl")
                       
                        if (self.arrayCompletedHHMembers[i].rel_code == "") {
                            
                            residentDic.setValue("12", forKey: "relCode")
                            
                        }
                        else{
                            residentDic.setValue(self.arrayCompletedHHMembers[i].rel_code ?? "", forKey: "relCode")
                        }
                        
                        residentDic.setValue(self.arrayCompletedHHMembers[i].relName ?? "", forKey: "oefRelName")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].relNameSL ?? "", forKey: "oefRelNamesl")
                        
                        residentDic.setValue(self.arrayCompletedHHMembers[i].birthCountryName ?? "", forKey: "oefBirthCountryName")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].birth_country_sl ?? "", forKey: "oefBirthCountryNamesl")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].birthStateName ?? "", forKey: "oefBirthStateName")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].birth_state_sl ?? "", forKey: "oefBirthStateNamesl")
                        
                        residentDic.setValue(self.arrayCompletedHHMembers[i].birthDistrictName ?? "", forKey: "oefBirthDistrictName")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].birth_district_sl ?? "", forKey: "oefBirthDistrictNamesl")
                        
                        residentDic.setValue(self.arrayCompletedHHMembers[i].nationality ?? "", forKey: "oefNationality")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].nationality_sl ?? "", forKey: "oefNationalitysl")
                        
                        residentDic.setValue(self.arrayCompletedHHMembers[i].paddress_country ?? "", forKey: "oefPermanentCountry")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].paddress_country, forKey: "oefPermanentCountrysl")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].stateName_sl ?? "", forKey: "oefPermanentStatesl")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].paddress_state ?? "", forKey: "oefPermanentState")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].paddre_district ?? "", forKey: "oefPermanentDistrict")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].paddre_tahsil ?? "", forKey: "oefPermanentTehsil")
                        residentDic.setValue("", forKey: "oefPermanentTehsilsl")
                        
                        residentDic.setValue(self.arrayCompletedHHMembers[i].districtName ?? "", forKey: "oefPresentDistrict")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].districtName_sl ?? "", forKey: "oefPresentDistrictsl")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].address_state ?? "", forKey: "oefPresentState")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].stateName_sl ?? "", forKey: "oefPresentStatesl")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].paddre_tahsil ?? "", forKey: "oefPresentTehsil")
                        residentDic.setValue(self.arrayCompletedHHMembers[i].paddre_tahsil, forKey: "oefPresentTehsilsl")
                        
                        residentDic.setValue(self.arrayCompletedHHMembers[i].relNameSL ?? "", forKey: "oefRelNamesl")
                        
                       
                        
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
                residentDic.setValue(self.arrayCompletedHH[i].superVisor_remrkOn, forKey: "superRemarksOn")
                residentDic.setValue(singleton().getCredentials().userId, forKey: "supervisor")
                residentDic.setValue(self.arrayCompletedHH[i].tahsil_code, forKey: "tehsilcode")
                residentDic.setValue(self.arrayCompletedHH[i].townCode, forKey: "towncode")
                residentDic.setValue(self.arrayCompletedHH[i].wardID, forKey: "wardid")
               // residentDic.object(forKey: <#T##Any#>)
                
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
                        //self.requestForUpload()
                    }
                }
           }
           else{
                if error?.localizedDescription == AppMessages.Not_Connected_To_Internet {
                  
                    
                    let alert = AlertView()
                    alert.alertWithoutButton( message: LanguageModal.langObj.not_connected_to_internet, time: 2.0)
                    
               }
                if error?.localizedDescription == AppMessages.Server_Response {
                   //let serverMessage = responseData.object(forKey:"message") as? String ?? ""
                    let alert = AlertView()
                    alert.alertWithoutButton( message: LanguageModal.langObj.unauthorized_access, time: 2.0)
                    
                   
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
           
           if success {
            self.requestForUpload()
           }
           else{
                if error?.localizedDescription == AppMessages.Not_Connected_To_Internet {
                 
                    let alert = AlertView()
                    alert.alertWithoutButton( message: LanguageModal.langObj.not_connected_to_internet, time: 2.0)
                    
                    
               }
                if error?.localizedDescription == AppMessages.Server_Response {
                   //let serverMessage = responseData.object(forKey:"message") as? String ?? ""
                   
                    let alert = AlertView()
                    alert.alertWithoutButton( message: LanguageModal.langObj.unauthorized_access, time: 2.0)
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
       
         
         APIManager().postExpectedHouseHold(params: dictParam) { (success, responseData, error) in
            //DispatchQueue.main.async {self.view.removeLoaderView()}
           if success {
           // self.requestForEBStartDate()
            
                self.requestForUpload()
            
           
           }
           else{
                if error?.localizedDescription == AppMessages.Not_Connected_To_Internet {
                    DispatchQueue.main.async {
                        self.view.showLoader()
                    
                   
                        let alert = AlertView()
                        alert.alertWithoutButton( message: LanguageModal.langObj.not_connected_to_internet, time: 2.0)
                    }
               }
                if error?.localizedDescription == AppMessages.Server_Response {
                   //let serverMessage = responseData.object(forKey:"message") as? String ?? ""
                    
                    DispatchQueue.main.async {
                        self.view.showLoader()
                    
                   
                        
                        let alert = AlertView()
                        alert.alertWithoutButton( message: LanguageModal.langObj.unauthorized_access, time: 2.0)
               }
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
        
       // let timeStamp = Int((NSDate().timeIntervalSince1970)*1000)
        let timeStamp = singleton().getCurrentDateAndTime()//"20210303T150827675Z"
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
                
                
                DispatchQueue.main.async {
                  //  recordData.removeAllObjects()
                    self.view.removeLoaderView()
                    DBManagerHousehold().updateHHMemberAfterUpoadData()
                    let alertView = AlertView()
                    alertView.delegate = self
                  //  alertView.showAlertWithSingleButton( title: "", message: "Data Uploaded Successfully")
                    alertView.alertWithoutButton( message: LanguageModal.langObj.success)
                    
                       
                    
                }
                
                
               }
               else{
                    if error?.localizedDescription == AppMessages.Not_Connected_To_Internet {
                      
                       
                        DispatchQueue.main.async { self.view.removeLoaderView()
                            
                            let alertView = AlertView()
                             alertView.delegate = self
                             alertView.alertWithoutButton( message: AppMessages.Not_Connected_To_Internet)
                        }
                        
                       // DispatchQueue.main.async { self.view.removeLoaderView()}
                   }
                    if error?.localizedDescription == AppMessages.Server_Response {
                        
                        DispatchQueue.main.async {self.view.removeLoaderView()
                            let alertView = AlertView()
                             alertView.delegate = self
                             alertView.alertWithoutButton( message: AppMessages.UnAuthorized_Access)
                        }
                        
                       //let serverMessage = responseData.object(forKey:"message") as? String ?? ""
                       
                       
                        DispatchQueue.main.async {
                        self.view.removeLoaderView()
                        }
                    }else {
                        
                       
                        DispatchQueue.main.async {
                        self.view.removeLoaderView()
                            
                            let alertView = AlertView()
                             alertView.delegate = self
                            alertView.alertWithoutButton( message: error?.localizedDescription ?? "")
                        }
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
            self.requestForUpload()
           }
           else{
                if error?.localizedDescription == AppMessages.Not_Connected_To_Internet {
                    DispatchQueue.main.async {
                    let alert =  AlertView()
                    alert.alertWithoutButton( message: LanguageModal.langObj.not_connected_to_internet, time: 3.0)
               }
                }
                if error?.localizedDescription == AppMessages.Server_Response {
                   //let serverMessage = responseData.object(forKey:"message") as? String ?? ""
                  
                    
                    let alert =  AlertView()
                    alert.alertWithoutButton( message: LanguageModal.langObj.unauthorized_access, time: 3.0)
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
        let nameSloMember = component.components(separatedBy: "_")
        if nameSloMember.count > 1 {
            strSelectedRespondent = nameSloMember[0]
            strSloRespondent = nameSloMember[1]
        }else{
            
            strSloRespondent = nameSloMember[0]
        }
        
        btnRespondentName.setTitle(strSelectedRespondent, for: .normal)
        updateSignBelowLable()
        strRespondentName = strSelectedRespondent
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
                strAlertMessage = LanguageModal.langObj.please_tick_the_consent
            }else{
                strAlertMessage = LanguageModal.langObj.choose_respondent
            }
            
            AlertView().alertWithoutButton( message: strAlertMessage)
        }
      return false
    }
    func respondentSignatureSave()  {
        
        for viewcontroller in self.navigationController!.viewControllers {
            if viewcontroller is HouseholdMemberDetail_ViewController  {
                modelHHRespondent.respondentName = strRespondentName
                modelHHRespondent.slnoRespondent = strSloRespondent
                modelHHRespondent.signByEnumBehalfRespondant = btnUnableSignConsentRespondent.isSelected == true ?"1": "0"
                modelHHRespondent.signRespondet = singleton().convertToBase64(image: self.signatureImage)
                do {
                    try context.save()
                } catch  {
                    
                }
              
                
                //viewcontroller.navigationController?.popViewController(animated: true)
            }
        }
        let alertView = AlertView()
        alertView.delegate = self
        alertView.alertWithoutButton( message: LanguageModal.langObj.signature_captured_successfull)
        
    }
    
    
}






