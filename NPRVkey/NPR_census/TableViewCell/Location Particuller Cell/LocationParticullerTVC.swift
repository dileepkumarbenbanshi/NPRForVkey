//
//  LocationParticullerTVC.swift
//  NPR-2021
//
//  Created by Dileep on 27/08/21.
//  Copyright © 2021 admin. All rights reserved.
//

import UIKit

class LocationParticullerTVC: UITableViewCell {
    @IBOutlet var totalHoseholdsLeftLabel: UILabel!
    @IBOutlet var totalOriginalLeftLabel: UILabel!
    @IBOutlet var totalNewLeftLabel: UILabel!
    
    @IBOutlet var lblStateTitle: UILabel!
    @IBOutlet var lblDistrictTitle: UILabel!
    @IBOutlet var lblSubDistrictTitle: UILabel!
    @IBOutlet var lblTownVillageTitle: UILabel!
    @IBOutlet var lblWardTitle: UILabel!
    @IBOutlet var lblBlockTitle: UILabel!
    
    
    
    @IBOutlet weak var labelState: UILabel!
    @IBOutlet weak var labelDistrict: UILabel!
    @IBOutlet weak var labelSubdistrict: UILabel!
    @IBOutlet weak var labelTownVillage: UILabel!
    @IBOutlet weak var labelWard: UILabel!
    @IBOutlet weak var labelBlock: UILabel!
    
    
    @IBOutlet weak var labelTotalHouseHold: UILabel!
    @IBOutlet weak var labelOldHouseHold: UILabel!
    @IBOutlet weak var labelNewHouseHold: UILabel!
    
    @IBOutlet weak var labelHHCountByLangTitle: UILabel!
    @IBOutlet weak var labelHHCountByLang: UILabel!
    
    let lpVM = LocationParticularVM()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setValueForAdress()  {
       setTagLabel()
        setCellAdress()
        getHouseHoldList()
    }
    
   private func setCellAdress() {
        
        labelWard.text = singleton().selectEBListModel.ebWard_code
        labelBlock.text = singleton().selectEBListModel.eb_block_number
        labelState.text = singleton().selectEBListModel.ebState_name
        labelDistrict.text = singleton().selectEBListModel.ebDistrict_name
        labelSubdistrict.text = singleton().selectEBListModel.ebTahsil_name
        labelTownVillage.text = singleton().selectEBListModel.ebTown_name
    }
   private func getHouseHoldList()  {
// memberStatus
        
        let predicateHH = NSPredicate(format: "ebNumber = %@",singleton().selectEBListModel.eb_number!)
        guard let arayTotalHouseHoldINEB = DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicateHH) as? [NPR_2021hh_Details] else {
            return
        }
        
        let  arayNewHouseHold =  arayTotalHouseHoldINEB.filter({$0.hh_status == HHStatusCode.new })
        
        let totalHHCount = arayTotalHouseHoldINEB.count
        let newHHcount = arayNewHouseHold.count
        let oldHHCount = totalHHCount-newHHcount
        
        
        self.labelTotalHouseHold.text = "\(totalHHCount)"
        self.labelNewHouseHold.text = "\(newHHcount)"
        self.labelOldHouseHold.text = "\(oldHHCount)"
        
    
}
    
   private func setTagLabel()  {
        
        totalHoseholdsLeftLabel.text = LanguageModal.langObj.total_households
        totalOriginalLeftLabel.text = LanguageModal.langObj.total_original_household
        totalNewLeftLabel.text = LanguageModal.langObj.total_new_hh
        lblStateTitle.text = LanguageModal.langObj.state
        lblDistrictTitle.text = LanguageModal.langObj.district
        lblSubDistrictTitle.text = LanguageModal.langObj.sub_district
        lblTownVillageTitle.text = LanguageModal.langObj.town_village
        lblWardTitle.text = LanguageModal.langObj.ward
        lblBlockTitle.text = LanguageModal.langObj.block
        
    }

    func setHHCountByLang(lang:String)  {
        labelHHCountByLang.text = lpVM.hhCountinLanguage(lang: lang)
        
        let strLang = lpVM.langaugeByCode(langCode: lang)
        
        labelHHCountByLangTitle.text = LanguageModal.langObj.total_households + " \(strLang)"
        
        
    }
    
}
