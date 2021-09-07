//
//  RespondentSignature_vc.swift
//  NPR-2020
//
//  Created by Dileep on 21/10/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class RespondentSignature_vc: UIViewController {

    @IBOutlet weak var lblSignBellow: UILabel!
    @IBOutlet weak var lblHHNumber: UILabel!
    @IBOutlet weak var lblCensusHN: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnSignConsentRespondent: UIButton!
    @IBOutlet weak var btnUnableSignConsentRespondent: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
    }
    
    @IBAction func btnBack(_ sender: UIButton) {
        
        
    }
    
    @IBAction func btnSignConsent_click(_ sender: UIButton) {
    }
    
    
    @IBAction func btn_unableCnsentRespondent(_ sender: UIButton) {
    }
    
}
