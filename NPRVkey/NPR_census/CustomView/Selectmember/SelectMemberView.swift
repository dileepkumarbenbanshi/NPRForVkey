//
//  SelectMember.swift
//  NPR-2021
//
//  Created by Dileep on 03/09/21.
//  Copyright © 2021 admin. All rights reserved.
//

import UIKit
protocol SelectMemberDelegate {
    func didSelectMember(memberModel:NPR2021MemberDetails)
    func cancelPicker()
    
}

class SelectMemberView: UIView {

    @IBOutlet weak var searchField: UISearchBar!
    
    @IBOutlet weak var tableViewList: UITableView!
   // @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var viewContener: UIView!
     @IBOutlet weak var lblPickerTitle: UILabel!
    @IBOutlet weak var btnCancel: UIButton!
    var arayInPut = [NPR2021MemberDetails]()
    var arayInPutMain = [NPR2021MemberDetails]()
    var delegate:SelectMemberDelegate?
    var selectedComponent = ""
    
    
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
    
    
    
    
    func loadMemberList(aray:[NPR2021MemberDetails],view:UIView)  {
        //self.listType = listType
        
        arayInPut = aray
        arayInPutMain = aray
        //pickerView.reloadAllComponents()
        tableViewList.reloadData()
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


extension SelectMemberView:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return arayInPut.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectFatherMotherCell") as? SelectFatherMotherCell
        let model = arayInPut[indexPath.row]
        
        var headName = ""
        
        if model.language?.IsSelectedLangauge_nonEnglish ?? false {
            headName = ((model.nameSL?.count != 0) ? model.nameSL ?? "" : model.name) ?? ""
        }else{
            headName = ((model.name?.count != 0) ? model.name ?? "" : model.nameSL) ?? ""
        }
       
        
        cell?.lblName.text = headName
      return cell ?? PickerViewCommonCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.removeFromSuperview()
        let model =  arayInPut[indexPath.row]
        delegate?.didSelectMember(memberModel: model)
        
        self.removeFromSuperview()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 40
    }
    
}
