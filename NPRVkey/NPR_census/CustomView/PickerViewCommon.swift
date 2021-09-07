//
//  PickerViewCommon.swift
//  NPR_census
//
//  Created by Dileep on 10/09/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import CoreData
protocol PickerViewCommonDelegate {
    func didPickComponent(component:String)
    func cancelPicker()
    
}
class PickerViewCommon:UIView {
    
    
    enum PickerType {
        case langaugeList
        case nationality
        case countryList
         case stateList
         case districtList
         case subDistrictList
        case relationList
        case occopationList
        case educationList
        case motherTongueList
        case motherSelectionList
        case fatherSelectionList
    }
    
    @IBOutlet weak var searchField: UISearchBar!
    
    @IBOutlet weak var tableViewList: UITableView!
   // @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var viewContener: UIView!
     @IBOutlet weak var lblPickerTitle: UILabel!
    var arayInPut = [PickerViewCommon_model]()
    var arayInPutMain = [PickerViewCommon_model]()
    var delegate:PickerViewCommonDelegate?
    var selectedComponent = ""
    let windows =  UIApplication.shared.keyWindow
    //var picketType : PickerType?
    var shouldShowID = false
    
    override func awakeFromNib() {
        //pickerView.delegate = self
        //pickerView.dataSource = self
        tableViewList.dataSource = self
        tableViewList.delegate = self
        self.tableViewList.register(UINib(nibName: "PickerViewCommonCell", bundle: nil), forCellReuseIdentifier:"PickerViewCommonCell")
        //self.frame.size = CGSize.init
    }
    
    
    
    func loadPicker<T>(aray:[T],pickerType:PickerType)  {
        
        prepareInputAray(arayInput: aray)
        //pickerView.reloadAllComponents()
        tableViewList.reloadData()
        
        lblPickerTitle.text = " \(pickeritile(picketType: pickerType)) "
        shouldShowID = checkItmIDShouldShow(pickerType: pickerType)
        self.frame = windows!.frame
        prepareView()
    }
    
    func prepareView()  {
        
        //self.frame = windows?.frame as! CGRect
        
        
        self.backgroundColor = UIColor.init(white: 0.3, alpha: 0.5)
        windows?.addSubview(self)
    }
    
    func prepareInputAray(arayInput:[Any])  {
        self.arayInPut.removeAll()
        arayInPutMain.removeAll()
        for arayItem in arayInput {
            let model = PickerViewCommon_model.init(model: arayItem )
            arayInPutMain.append(model)
            self.arayInPut.append(model)
        }
    }
    
    func pickeritile(picketType:PickerType)->String  {
        var strPickerTitle = ""
       // let pickerType = self.picketType
        
        
        switch picketType {
        case .langaugeList:
            strPickerTitle = LanguageModal.langObj.select_ur_language
            break
        case .nationality:
            strPickerTitle = LanguageModal.langObj.choose_Nationality
            break
        case .countryList:
            strPickerTitle = LanguageModal.langObj.choose_country
            break
        case .stateList:
            
            strPickerTitle = LanguageModal.langObj.choose_state
            break
        case .districtList:
            strPickerTitle = LanguageModal.langObj.choose_district
            break
        case .subDistrictList:
            strPickerTitle = LanguageModal.langObj.choose_tehsil
            break
        case .relationList:
            strPickerTitle = LanguageModal.langObj.relationship_with_head
            break
        case .occopationList:
            strPickerTitle = LanguageModal.langObj.occupation
            break
            
        case .educationList:
            strPickerTitle = LanguageModal.langObj.education
            break
        case .motherTongueList:
            strPickerTitle = LanguageModal.langObj.mother_tounge
            break
        case .motherSelectionList:
            strPickerTitle = LanguageModal.langObj.select_mother_name
            break
        case .fatherSelectionList:
            strPickerTitle = LanguageModal.langObj.select_father_name
            break
        
            
        }
      return strPickerTitle
    }
    
    
    func checkItmIDShouldShow(pickerType:PickerType) -> Bool {
       
        return pickerType == .educationList || pickerType == .occopationList  || pickerType == .relationList
    }
    
    @IBAction func btnDone_action(_ sender: UIButton) {
         self.removeFromSuperview()
        delegate?.didPickComponent(component: selectedComponent)
       
    }
    
    @IBAction func btnCancel_action(_ sender: Any) {
        
        delegate?.cancelPicker()
        self.removeFromSuperview()
    }
    
    
}

extension PickerViewCommon:UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return arayInPut.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PickerViewCommonCell") as? PickerViewCommonCell
        let model = arayInPut[indexPath.row]
        cell?.lblName.text = shouldShowID ? "\(model.id) -   \(model.name)" : model.name//model.name
        
        
        
      return cell ?? PickerViewCommonCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.removeFromSuperview()
        let model =  arayInPut[indexPath.row]
        let strComponent = shouldShowID ? "\(model.id) - \(model.name)" : model.name
        
        delegate?.didPickComponent(component: strComponent)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 40
    }
    
}

extension PickerViewCommon:UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String){
        if searchText.isEmpty {
            arayInPut = arayInPutMain
        }else{
       
            arayInPut = arayInPutMain.filter({$0.name.contains(searchText)})
      
        
        print("names = ,\(arayInPut)");
        
    }
        tableViewList.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        arayInPut = arayInPutMain
        tableViewList.reloadData()
        searchBar.resignFirstResponder()
    }
}
