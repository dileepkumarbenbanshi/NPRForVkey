//
//  SharedClass.swift
//  SnapWorkMerchant
//
//  Created by Dileep  on 11/09/19.
//  Copyright © 2019 Dileep. All rights reserved.
//

import Foundation
import UIKit



class SharedClass {
    
  static let shared = SharedClass()
     var userId = ""
    
     var email = ""
    var authToken = singleton().getDeviceIDORAccessToken().accessToken//"zk2W9_j1G63WF9nJctjhmSyzlLEIbCXWeeYvnfRRyhDRd8MsEgIrT7T1s_hx1wgM"
    var userName = singleton().getCredentials().userId
    var logInPassword = singleton().getCredentials().password
    var deviceID = singleton().getDeviceIDORAccessToken().deviceId
    var selectEBListModel = EB()
    
    
    
    
    
    
    
    
    
    
   
    
    
    private init(){
    authToken = singleton().getDeviceIDORAccessToken().accessToken
        
    }
    
    
    func updateSharedClass()  {
        
        
        
    }
    
}
