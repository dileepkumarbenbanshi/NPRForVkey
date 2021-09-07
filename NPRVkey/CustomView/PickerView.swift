//
//  PickerView.swift
//  NPR Screen
//
//  Created by mac on 07/08/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

protocol PickerViewDelegate{
    func getLangauge(language: String) ->Void
}

class PickerView: UIView {
    var delegate: PickerViewDelegate?
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    var languageArr = [[String:Any]]()
    var selectedRow = String()
    
    override func awakeFromNib() {
        self.getLanguageData()
    }
    
    func getLanguageData(){
        if let path = Bundle.main.path(forResource: "Language", ofType: "plist") {
            if let array = NSArray(contentsOfFile: path) as? [[String: Any]] {
                self.languageArr = array
                self.selectedRow = self.languageArr[0]["name"] as! String
                self.delegate?.getLangauge(language: self.selectedRow)
            }
        }
    }
    
    @IBAction func onTapCancel(_ sender: Any) {
        singleton().NPRRect.removeSubviewFromParentWidnow()
    }
    
    @IBAction func onTapDone(_ sender: Any) {
        singleton().NPRRect.removeSubviewFromParentWidnow()
        self.delegate?.getLangauge(language: self.selectedRow)
    }
}

extension PickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    
   func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.languageArr.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.languageArr[row]["name"] as? String
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedRow = self.languageArr[row]["name"] as! String
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat{
        return 45
    }
}

