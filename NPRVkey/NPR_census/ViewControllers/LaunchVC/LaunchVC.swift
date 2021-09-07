//
//  LaunchVC.swift
//  NPR_census
//
//  Created by Dileep on 09/01/21.
//  Copyright © 2021 admin. All rights reserved.
//

import UIKit

class LaunchVC: UIViewController {
    @IBOutlet weak var lblVersion: UILabel!
    @IBOutlet weak var lblOrgi: UILabel!
    @IBOutlet weak var lblDevelope: UILabel!
    @IBOutlet weak var lblNPRFullForm: UILabel!
    
    @IBOutlet weak var lblAppName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    dataSet()
        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setLangauge()
        
        setTagLabel()
        
        guard let baseURL = UserDefaults().getUserDefaultValue(key: .baseUrlProd) as? String else {
            UserDefaults().saveUserDefauldValue(key: .baseUrlProd, value: BaseUrl.urlProdDefault)
            return
        }
        if baseURL.count == 0  {
            UserDefaults().saveUserDefauldValue(key: .baseUrlProd, value: BaseUrl.urlProdDefault)
        }
        print("base Url",baseURL)
    }

    func setLangauge()  {
        
        let languageExtension = LanguageExtension()
        
        languageExtension.getModal(language:UserDefaults().getCurrentLanguage() )
        ChanageLangaugeString().setString_keyAllreadyUsed()
        
    }
    
    func dataSet()  {
        
        let objAssignEBDelegate = LaunchView_ViewModel()
        
        objAssignEBDelegate.delegate = self
        
        objAssignEBDelegate.checkCountryStateDistrictAndDownload()
        
        
    }
    
    func setTagLabel()  {
        
       // lblAppName.text = LanguageModal.langObj.app_name
        lblNPRFullForm.text = LanguageModal.langObj.national_population_register
        lblDevelope.text = LanguageModal.langObj.developer_by
        lblOrgi.text = LanguageModal.langObj.indian_gov
        lblVersion.text = LanguageModal.langObj.version + " 2.0.0"
        
    }
    
//    override var shouldAutorotate: Bool {
//        return false
//    }
//
//    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
//        return UIInterfaceOrientationMask.portrait
//    }
//
//    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation {
//        return UIInterfaceOrientation.portrait
//    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation") 
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
