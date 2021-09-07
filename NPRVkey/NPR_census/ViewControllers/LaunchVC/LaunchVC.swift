//
//  LaunchVC.swift
//  NPR_census
//
//  Created by Dileep on 09/01/21.
//  Copyright © 2021 admin. All rights reserved.
//

import UIKit

class LaunchVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    dataSet()
        // Do any additional setup after loading the view.
    }
    

    func dataSet()  {
        
        let objAssignEBDelegate = LaunchView_ViewModel()
        
        objAssignEBDelegate.delegate = self
        
        objAssignEBDelegate.checkCountryStateDistrictAndDownload()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if #available(iOS 13.0, *) {
                    let statusBar = UIView(frame: UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
            statusBar.backgroundColor = ProjectColor.colorPrimaryDark
                     UIApplication.shared.keyWindow?.addSubview(statusBar)
                } else {
                     //UIApplication.shared.statusBarView?.backgroundColor = UIColor.init(red: 237.0/255.0, green: 85.0/255.0, blue: 61.0/255.0, alpha: 1.0)
                }
    }
}

extension LaunchVC : LaunchView_ViewModelDelegte {
    func countryStateDistrictSaved() {
        self.navigateToController(identifier: "LoginVC", storyBoardName: storyBoardName.main)
    }
    
    
    
}
