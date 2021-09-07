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
class PickerViewCommon:UIView ,UIPickerViewDataSource,UIPickerViewDelegate{
    
    @IBOutlet weak var searchField: UISearchBar!
    
    @IBOutlet weak var tableViewList: UITableView!
   // @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var viewContener: UIView!
     @IBOutlet weak var lblPickerTitle: UILabel!
    var arayInPut = [Any]()
    var arayInPutMain = [Any]()
    var delegate:PickerViewCommonDelegate?
    var selectedComponent = ""
    let windows =  UIApplication.shared.keyWindow
    
    override func awakeFromNib() {
        //pickerView.delegate = self
        //pickerView.dataSource = self
        tableViewList.dataSource = self
        tableViewList.delegate = self
        self.tableViewList.register(UINib(nibName: "PickerViewCommonCell", bundle: nil), forCellReuseIdentifier:"PickerViewCommonCell")
        //self.frame.size = CGSize.init
    }
    
    
    
    func loadPicker<T>(aray:[T],pickerTitle:String,view:UIView)  {
        
        arayInPut = aray
        arayInPutMain = aray
        //pickerView.reloadAllComponents()
        tableViewList.reloadData()
        lblPickerTitle.text = " \(pickerTitle) "
        var index = 0
        searchField.text = ""
        if (pickerTitle == "Choose Country") || (pickerTitle == "Choose Nationality")  {
           index = getIndiaAtIndex()
           
        }
        
       // pickerView.selectRow(index, inComponent: 0, animated: false)
         let indexPath = NSIndexPath.init(row: index, section: 0)
        
        
        tableViewList.scrollToRow(at: indexPath as IndexPath, at: .middle, animated: false)
        self.frame = view.frame
        prepareView()
    }
    
    func prepareView()  {
        
        //self.frame = windows?.frame as! CGRect
        
        
        self.backgroundColor = UIColor.init(white: 0.3, alpha: 0.5)
        windows?.addSubview(self)
    }
    
    func getIndiaAtIndex() -> Int {
        var index = 0
        
        for modelDict in arayInPut {
           
            let model = PickerViewCommon_model.init(model: modelDict )
            
            if model.name == "India" {
                return index
            }
            index = index+1
        }
        return 0
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arayInPut.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        let model = PickerViewCommon_model.init(model: arayInPut[row] )
        return model.name
    }
    
    func selectRow(_ row: Int, inComponent component: Int, animated: Bool) {
        let model = PickerViewCommon_model.init(model: arayInPut[row] )
         
        selectedComponent = model.name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if arayInPut.count > 0 {
            
        
        let model = PickerViewCommon_model.init(model: arayInPut[row] )
            
         
        selectedComponent = model.name
        }
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
        let model = PickerViewCommon_model.init(model: arayInPut[indexPath.row] )
        cell?.lblName.text = model.name
      return cell ?? PickerViewCommonCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.removeFromSuperview()
        let model = PickerViewCommon_model.init(model: arayInPut[indexPath.row] )
        delegate?.didPickComponent(component: model.name)
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
        let pre:NSPredicate = NSPredicate(format: "name CONTAINS[c] %@", searchText)

      arayInPut =  arayInPutMain.filter { pre.evaluate(with: $0) };
        tableViewList.reloadData()
        print("names = ,\(arayInPut)");
        
    }
    }
}
