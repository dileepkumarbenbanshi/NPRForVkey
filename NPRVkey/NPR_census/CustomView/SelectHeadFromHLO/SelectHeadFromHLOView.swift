//
//  SelectMember.swift
//  NPR-2021
//
//  Created by Dileep on 03/09/21.
//  Copyright © 2021 admin. All rights reserved.
//

import UIKit
protocol SelectHeadHLODataDelegate {
    func didSelectMember(memberModel:HLOData)
    func cancelPicker()
    
}

class SelectHeadFromHLOView: UIView {

    @IBOutlet weak var searchField: UISearchBar!
    
    @IBOutlet weak var tableViewList: UITableView!
   // @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var viewContener: UIView!
     @IBOutlet weak var lblPickerTitle: UILabel!
    @IBOutlet weak var btnCancel: UIButton!
    var arayInPut = [HLOData]()
    var arayInPutMain = [HLOData]()
    var delegate:SelectHeadHLODataDelegate?
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
    
    
    
    
    func loadMemberList()  {
        
        
        guard let aray  = DataBaseManager().fetchDBData(entityName: EntityName.hloData) as? [HLOData] else {
            return
        }
        arayInPutMain = aray
        arayInPut = aray
        if aray.count == 0 {
            AlertView().alertWithoutButton(message: LanguageModal.langObj.no_data)
        }
        tableViewList.reloadData()
        searchField.text = ""
        self.frame = windows!.frame
        prepareView()
    }
    
    func prepareView()  {
        
        //self.frame = windows?.frame as! CGRect
        tableViewList.reloadData()
        lblPickerTitle.text = "\(LanguageModal.langObj.searchHeading) \(arayInPut.count)"
        btnCancel.setTitle(LanguageModal.langObj.cancel, for: .normal)
        searchField.becomeFirstResponder()
        searchField.placeholder = LanguageModal.langObj.search_head_name_from_hlo
        self.backgroundColor = UIColor.init(white: 0.3, alpha: 0.5)
        windows?.addSubview(self)
    }
    
    
    @IBAction func btnCancel_action(_ sender: Any) {
        
        delegate?.cancelPicker()
        self.removeFromSuperview()
        searchField.resignFirstResponder()
    }

}


extension SelectHeadFromHLOView:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return arayInPut.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SelectFatherMotherCell") as? SelectFatherMotherCell
        let model = arayInPut[indexPath.row]
        
        var headName = ""

        if util.isSelectedLang_english(){
            headName = ((model.head_name_sl?.count != 0) ? model.head_name_sl ?? "" : model.head_name) ?? ""
        }else{
            headName = ((model.head_name?.count != 0) ? model.head_name ?? "" : model.head_name_sl) ?? ""
        }
       
        
        cell?.lblName.text = headName
      return cell ?? PickerViewCommonCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.removeFromSuperview()
       
        delegate?.didSelectMember(memberModel: arayInPut[indexPath.row])
        self.removeFromSuperview()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 40
    }
    
}

extension SelectHeadFromHLOView:UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String){
        if searchText.isEmpty {
            arayInPut = arayInPutMain
        }else{
            
      
        
            arayInPut = util.isSelectedLang_english() ? arayInPutMain.filter({$0.head_name?.contains(searchText) ?? false}) : arayInPutMain.filter({$0.head_name_sl?.contains(searchText) ?? false})
            
            
            
            
        print("names = ,\(arayInPut)");
            lblPickerTitle.text = "\(LanguageModal.langObj.searchHeading) \(arayInPut.count)"
        
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
