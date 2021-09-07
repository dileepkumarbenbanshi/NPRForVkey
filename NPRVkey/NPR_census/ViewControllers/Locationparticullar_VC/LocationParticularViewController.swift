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
    
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var labelState: UILabel!
    @IBOutlet weak var labelDistrict: UILabel!
    @IBOutlet weak var labelSubdistrict: UILabel!
    @IBOutlet weak var labelTownVillage: UILabel!
    @IBOutlet weak var labelWard: UILabel!
    @IBOutlet weak var labelBlock: UILabel!
    @IBOutlet weak var btnSwitchEB: UIButton!
    
    @IBOutlet weak var labelTotalHouseHold: UILabel!
    @IBOutlet weak var labelOldHouseHold: UILabel!
    @IBOutlet weak var labelNewHouseHold: UILabel!

    
    let inHavitedView = Bundle.main.loadNibNamed("InhavitedView", owner: self, options: nil)?.first as? InhavitedView
    override func viewDidLoad() {
        super.viewDidLoad()
        self.containerView.cornerRadiusV = 5
        
        Utils().vKeySetup(enable: false)
        
        checkInhavitedEB()
        
    }
    
    
    
    func checkInhavitedEB()  {
        
        print("Load CheckinView")
        let predicateHH = NSPredicate(format: "ebNumber = %@",singleton().selectEBListModel.eb_number!)
        guard let arayTotalHouseHoldINEB = DataBaseManager().fetchDBData(entityName: EntityName.nprHHStats, predicate: predicateHH) as? [NPR_2021hh_Details] else {
            return
        }
        if arayTotalHouseHoldINEB.count == 0 {
            if singleton().selectEBListModel.expectedHH_number == "" || singleton().selectEBListModel.expectedHH_number == nil {
                inHavitedView?.lodInhavitedView()
            }
            
            
            
        }
        
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
        getHouseHoldList()
        
        var selectedeBDataList = DataBaseManager().fetchDBData(entityName: EntityName.eb) as? [EB]
        
        if selectedeBDataList?.count ?? 0 < 2 {
            btnSwitchEB.isHidden = true
        }
        selectedeBDataList = selectedeBDataList?.filter({$0.eb_block_number == singleton().activeEB})
        guard let ebListModel = selectedeBDataList?[0] else {
            return
        }
        
      // let ebListModel = SharedClass.shared.selectEBListModel
        labelWard.text = ebListModel.ebWard_code
        labelBlock.text = ebListModel.eb_block_number
        labelState.text = ebListModel.ebState_name
        labelDistrict.text = ebListModel.ebDistrict_name
        labelSubdistrict.text = ebListModel.ebTahsil_name
        labelTownVillage.text = ebListModel.ebTown_name
        singleton().activeEB  = ebListModel.eb_block_number ?? ""
       
        
        
    }
    
   
    
    
        
        func getHouseHoldList()  {
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
        
    }





