//
//  Plist.swift
//  newYorkTime
//
//  Created by javi on 31/01/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//

public enum Plist {
    
    case baseURL
    case apiKey
    
    func value() -> String {
        switch self {
        case .baseURL:
            return "base_url"
        case .apiKey:
            return "api_key"
        }
    }
}
