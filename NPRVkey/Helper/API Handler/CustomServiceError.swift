//
//  CustomServiceError.swift
//  NPR_census
//
//  Created by mac on 28/08/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation

import Foundation

protocol ServiceErrorProtocol: Error {
    var localizedTitle: String { get }
    var localizedDescription: String { get }
    var code: Int { get }
}

struct CustomServiceError: ServiceErrorProtocol {
    
    var localizedTitle: String
    var localizedDescription: String
    var code: Int
    
    init(localizedTitle: String?, localizedDescription: String, code: Int) {
        self.localizedTitle = localizedTitle ?? "Error"
        self.localizedDescription = localizedDescription
        self.code = code
    }

}
