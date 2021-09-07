//
//  PickerViewRespondentList.swift
//  NPR-2020
//
//  Created by Dileep on 11/12/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class PickerViewRespondentList: UIView {
    var arayRespondentList = [NPR2021MemberDetails]()
    var selectedComponent = ""
    let windows =  UIApplication.shared.keyWindow
    @IBOutlet weak var lblPickerTitle: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    var delegate : PickerViewCommonDelegate?
    
    
    override func awakeFromNib() {
        
        
        //self.frame.size = CGSize.init
    }
    
    func loadPicker(arayMemberList:[NPR2021MemberDetails],view:UIView)  {
        self.frame = view.frame
        arayRespondentList = arayMemberList
        pickerView.reloadAllComponents()
        prepareView()
        
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    func prepareView()  {
        
        self.backgroundColor = UIColor.init(white: 0.3, alpha: 0.5)
        windows?.addSubview(self)
    }
    
    @IBAction func btnDone_action(_ sender: UIButton) {
         self.removeFromSuperview()
        delegate?.didPickComponent(component: selectedComponent)
       
    }
    
    @IBAction func btnCancel_action(_ sender: Any) {
        
        //delegate?.cancelPicker()
        self.removeFromSuperview()
    }
    
    
    
   
    

}

extension PickerViewRespondentList :UIPickerViewDataSource ,UIPickerViewDelegate{
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return arayRespondentList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        let model = arayRespondentList[row]
        return model.name
    }
    
    func selectRow(_ row: Int, inComponent component: Int, animated: Bool) {
        let model = arayRespondentList[row]
         
        selectedComponent = model.name ?? ""
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if arayRespondentList.count > 0 {
            
        
        let model = arayRespondentList[row]
            
         
        selectedComponent = model.name ?? ""        }
    }
}
