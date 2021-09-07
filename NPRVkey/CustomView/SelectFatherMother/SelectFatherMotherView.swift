//
//  SelectFatherMotherView.swift
//  NPR-2020
//
//  Created by Dileep on 19/01/21.
//  Copyright © 2021 admin. All rights reserved.
//

import UIKit


protocol SelectFatherMotherDelegate {
    func didSelectFatherMother(modelParent:NPR2021MemberDetails ,genderType:gender)
    func cancelPicker()
    
}
class SelectFatherMotherView: UIView {

    @IBOutlet weak var searchField: UISearchBar!
    
    @IBOutlet weak var tableViewList: UITableView!
   // @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var viewContener: UIView!
     @IBOutlet weak var lblPickerTitle: UILabel!
    var arayInPut = [NPR2021MemberDetails]()
    var arayInPutMain = [NPR2021MemberDetails]()
    var delegate:SelectFatherMotherDelegate?
    var selectedComponent = ""
    var selectedGender = gender.male
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    override func awakeFromNib() {
        //pickerView.delegate = self
        //pickerView.dataSource = self
        tableViewList.dataSource = self
        tableViewList.delegate = self
        self.tableViewList.register(UINib(nibName: "SelectFatherMotherCell", bundle: nil), forCellReuseIdentifier:"SelectFatherMotherCell")
        //self.frame.size = CGSize.init
    }
    
    
    
    
    func loadMotherFatherList(aray:[NPR2021MemberDetails],gender:gender,view:UIView)  {
        //self.listType = listType
        self.selectedGender = gender
        arayInPut = aray
        arayInPutMain = aray
        //pickerView.reloadAllComponents()
        tableViewList.reloadData()
        if selectedGender == .male {
            lblPickerTitle.text = English.AddNewMemberFormAlert.selectFatherName
        }else{
            lblPickerTitle.text = English.AddNewMemberFormAlert.selectMotherName
        }
       
        
        searchField.text = ""
        
        
       
        self.frame = view.frame
        prepareView()
    }
    
    func prepareView()  {
        
        //self.frame = windows?.frame as! CGRect
        
        
        self.backgroundColor = UIColor.init(white: 0.3, alpha: 0.5)
        windows?.addSubview(self)
    }
    
    
    @IBAction func btnCancel_action(_ sender: Any) {
        
        delegate?.cancelPicker()
        self.removeFromSuperview()
    }

}


extension SelectFatherMotherView:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return arayInPut.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectFatherMotherCell") as? SelectFatherMotherCell
        let model = arayInPut[indexPath.row] 
        cell?.lblName.text = model.name
      return cell ?? PickerViewCommonCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.removeFromSuperview()
        let model =  arayInPut[indexPath.row]
        delegate?.didSelectFatherMother(modelParent: model, genderType: selectedGender)
        
        self.removeFromSuperview()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 40
    }
    
}
