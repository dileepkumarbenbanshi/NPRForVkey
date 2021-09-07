//
//  SkipHHView.swift
//  NPR-2020
//
//  Created by Dileep on 16/10/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

protocol SkipHHDelegate{
    func onTapOK(statusSelectedCode:String,skipSelectedStatus:String) ->Void
}
class SkipHHView:UIView {
    var delegate: SkipHHDelegate?
    var instance : SkipHHView!
    @IBOutlet weak var btnLocked: UIButton!
    @IBOutlet weak var btnMigrated: UIButton!
    @IBOutlet weak var btnNotAvailable: UIButton!
    var modelHH = NPR_2021hh_Details ()
    var skipStatus = ""
    
    var isRadioButtonSelected = false
    
    var staus = ""
    
//    override func awakeFromNib() {
//
//    }
    
    override func awakeFromNib() {
        comonInit()
    }
    
    
    
    
    
    @IBAction func btnTypeHousehold_action(_ sender: UIButton) {
       
       self.isRadioButtonSelected = true
        switch sender.tag {
        case 10:
            btnMigrated.isSelected = false
            btnNotAvailable.isSelected = false
            staus = HHStatusCode.locked
            skipStatus = "Locked"
            break
            
            case 11:
            btnLocked.isSelected = false
            btnNotAvailable.isSelected = false
            staus = HHStatusCode.migratedOut
                skipStatus = "Migrated Out"
            break
        default:
            btnLocked.isSelected = false
            btnMigrated.isSelected = false
            staus = HHStatusCode.notAvailable
            skipStatus = "Not Available"
        }
        sender.isSelected =   !sender.isSelected
    }
    
    private func comonInit (){
        
        self.backgroundColor = UIColor.init(white: 0.5, alpha: 0.5)
    }
    
    @IBAction func btnCancel_click(_ sender: UIButton) {
        
        self.removeFromSuperview()
        
    }
    
    @IBAction func btnOk_click(_ sender: UIButton) {
        if staus.count > 0 {
            delegate?.onTapOK(statusSelectedCode: staus, skipSelectedStatus: skipStatus)
        self.removeFromSuperview()
        }
        delegate?.onTapOK(statusSelectedCode: staus, skipSelectedStatus: skipStatus)
    }
    
    func loadSKipView()  {
        
        self.backgroundColor = UIColor.init(white: 0.3, alpha: 0.5)
        self.frame = windows!.frame
        windows?.addSubview(self)
        
        
        
        
    }
    
}
