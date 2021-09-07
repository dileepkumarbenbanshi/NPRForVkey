//
//  LocationParticularViewController.swift
//  NPR Screen
//
//  Created by mac on 05/08/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class LocationParticularViewController: UIViewController {

    //@IBOutlet weak var tableViewJurisdiction: UITableView!
    
    @IBOutlet var jurisdictionTopLabel: UILabel!
    
   // @IBOutlet weak var containerView: UIView!
  
    @IBOutlet weak var btnSwitchEB: UIButton!
    
    

    
    let inHavitedView = Bundle.main.loadNibNamed("InhavitedView", owner: self, options: nil)?.first as? InhavitedView
    var isFromHlbList = false
    var lpVM = LocationParticularVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.containerView.cornerRadiusV = 5
        
        //Utils().vKeySetup(enable: false)
        
        checkInhavitedEB()
        
        jurisdictionTopLabel.text = LanguageModal.langObj.lp_headline
        btnSwitchEB.setTitle(LanguageModal.langObj.switch_eb, for: .normal)
        
    }
    
    func checkInhavitedEB()  {
        inHavitedView?.delegate = self
        if UnHabitedVM().shouldOpenExpHHPopup  && !singleton().selectEBListModel.is_eb_uploaded && isFromHlbList  {
            inHavitedView?.lodInhavitedView()
        }
        

        }
    
    func  checkConditionForInhavited()->Bool  {
     
        if !singleton().selectEBListModel.is_eb_uploaded && isFromHlbList {
           return true
        }

      return false
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        viewPrepare()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
    }
    override func viewDidLayoutSubviews() {
        
    }
    @IBAction func onTapSwitchHLB(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func viewPrepare()  {
        //getHouseHoldList()
        
        var selectedeBDataList = DataBaseManager().fetchDBData(entityName: EntityName.eb) as? [EB]
        
        if selectedeBDataList?.count ?? 0 < 2 {
            btnSwitchEB.isHidden = true
        }
        selectedeBDataList = selectedeBDataList?.filter({$0.eb_block_number == singleton().activeEB})
        guard let ebListModel = selectedeBDataList?[0] else {
            return
        }
        
      // let ebListModel = SharedClass.shared.selectEBListModel
       
        singleton().activeEB  = ebListModel.eb_block_number ?? ""
       
        
        
    }
    
   
        
        
    }



extension LocationParticularViewController:InhavitedViewDelegate {
    func saveExpectedHH_number() {
        
    }
    
    func saveExpectedHHNumberZero() {
        
        self.navigateToController(identifier:ClassID.uploadData , storyBoardName: storyBoardName.main)
        
    }
    
    func popUpHaveToShowAgain() {
        checkInhavitedEB()
    }
    
    
}


extension LocationParticularViewController:UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return lpVM.arayLanguage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let strID  = indexPath.section == 0 ? CellIdentifier.locationParticularAddress : CellIdentifier.locationParticularHHCountbyLang
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: strID, for: indexPath) as? LocationParticullerTVC else {
            return UITableViewCell()
        }
        indexPath.section == 0 ? cell.setValueForAdress() : cell.setHHCountByLang(lang: lpVM.arayLanguage[indexPath.row])
        return cell
        
    }
    
    
}
