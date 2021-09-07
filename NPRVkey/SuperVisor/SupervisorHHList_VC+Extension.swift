//
//  SupervisorHHList_VC+Extension.swift
//  NPR-2020
//
//  Created by Dileep on 21/11/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation


extension SupervisorHHList_VC {
    
    @objc func onTapArrow(_ sender: UIButton){
//        self.navigateToController(identifier: "HouseholdMemberDetail_ViewController", storyBoardName: "NPR")
        
        let storyBoard = UIStoryboard.init(name: storyBoardName.superVisor, bundle: nil)
      let objController = storyBoard.instantiateViewController(withIdentifier:"SV_HHMemberDetail_VC") as? SV_HHMemberDetail_VC
       // objController?.arayMembersModel = arayMemberDetail
        objController?.hhModel = arayHHList[sender.tag]
       self.navigationController?.pushViewController(objController!, animated: true)
        
    }
    
}
