//
//  LaunchVCDefault.swift
//  NPR-2021
//
//  Created by Dileep on 22/07/21.
//  Copyright © 2021 admin. All rights reserved.
//

import UIKit

class LaunchVCDefault: UIViewController {
    @IBOutlet weak var lblVersion: UILabel!
    @IBOutlet weak var lblOrgi: UILabel!
    @IBOutlet weak var lblDevelope: UILabel!
    @IBOutlet weak var lblNPRFullForm: UILabel!
    
    @IBOutlet weak var lblAppName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        setLangauge()
    }

    func setTagLabel()  {
        
       // lblAppName.text = LanguageModal.langObj.app_name
        lblNPRFullForm.text = LanguageModal.langObj.national_population_register
        lblDevelope.text = LanguageModal.langObj.developer_by
        lblOrgi.text = LanguageModal.langObj.indian_gov
        lblVersion.text = LanguageModal.langObj.version + " 1.0.4"
        
    }
    
    func setLangauge()  {
        
        let languageExtension = LanguageExtension()
        
        languageExtension.getModal(language:UserDefaults().getCurrentLanguage() )
        ChanageLangaugeString().setString_keyAllreadyUsed()
        
        setTagLabel()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
