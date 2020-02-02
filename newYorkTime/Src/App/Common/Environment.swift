//
//  Environment.swift
//
//  Created by javi on 06/09/2019.
//  Copyright © 2019 javiochoa. All rights reserved.
//

import Foundation

public struct Environment {
    
    public func configuration(_ key:Plist) -> String {
        if let infoDict = Bundle.main.infoDictionary {
            switch key {
            case .baseURL:
                return infoDict[Plist.baseURL.value()] as? String ?? ""
            case .apiKey:
                return infoDict[Plist.apiKey.value()] as? String ?? ""
            }
        } else {
            fatalError("Unable to locate plist file")
        }
    }
}
