//
//  UiResponder+Extension.swift
//  NPR_census
//
//  Created by Dileep on 09/01/21.
//  Copyright © 2021 admin. All rights reserved.
//

import Foundation
extension UIResponder {
    
    static weak var responder: UIResponder?
    
    static func currentFirst() -> UIResponder? {
        responder = nil
        UIApplication.shared.sendAction(#selector(trap), to: nil, from: nil, for: nil)
        return responder
    }
    
    @objc private func trap() {
        UIResponder.responder = self
    }
}
