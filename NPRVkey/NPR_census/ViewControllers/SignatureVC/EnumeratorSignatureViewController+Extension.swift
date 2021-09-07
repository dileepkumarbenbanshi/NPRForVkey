//
//  EnumeratorSignatureViewController+Extension.swift
//  NPR-2020
//
//  Created by Dileep on 19/01/21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation

extension EnumeratorSignatureViewController {
    func hhSignatureAttributeUpdate()  {
        modelHHRespondent.respondentName = ""
    }
}
extension EnumeratorSignatureViewController:AlertViewDelegate {
    
    
    func alertTapedYes() {
        
    }
  
    func alertViewWithoutButtonDissMiss() {
        DispatchQueue.main.async {self.view.removeLoaderView()}
        if isRespondentSign{
            if !isFromFormPage {
                self.navigationController?.popViewController(animated: true)
            }
            delegate?.respondentSignatureCpatered?()
            
            return
        }else if isFromUpload {
            self.navigationController?.popViewController(animated: true)
            uploadDelegate?.DataUploadedSuccessfuly?()
        }
        else{
        self.popTwoView()
        }
    }
    
    
}
