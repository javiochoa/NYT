//
//  Config.swift
//  newYorkTime
//
//  Created by javi on 31/01/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//

import Foundation

enum PublicationTime: Int {
    
    case day = 1
    case week = 7
    case month = 30
}

enum SharedSource:String {
    
    case facebook
    case twitter
}

enum PublicationType: Hashable {
    
    case emailed(publicationTime:PublicationTime)
    case shared(publicationTime:PublicationTime, source:[SharedSource])
    case viewed(publicationTime: PublicationTime)
}

class Config {
    
    static var baseURL:String {
        get {
            return Environment().configuration(Plist.baseURL)
        }
    }
    static var apiKey:String {
        get {
            return Environment().configuration(Plist.apiKey)
        }
    }
}
