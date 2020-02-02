//
//  PublicationRequest.swift
//  newYorkTime
//
//  Created by javi on 01/02/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//

import Foundation

class PublicationRequest: Request {
    
    let type:PublicationType
    
    init(withType type: PublicationType) {
        
        self.type = type
    }
    
    var endpoint: String {
        
        return self.apiURL(forSourceType: self.type)
    }
    
    var method: RequestMethod {
        return .get
    }
    
    fileprivate func apiURL(forSourceType type: PublicationType) -> String {
        
        switch type {
        case .emailed(publicationTime: let time):
            return Config.baseURL + "/emailed/\(time.rawValue).json?api-key=" + Config.apiKey
        case .shared(publicationTime: let time, source: let source):
            
            let sources:String = source.map({ (source) -> String in
                return source.rawValue
                }).joined(separator: ",")
            
            return Config.baseURL + "/shared/\(time.rawValue)/\(sources).json?api-key=" + Config.apiKey
        case .viewed(publicationTime: let time):
            return Config.baseURL + "/viewed/\(time.rawValue).json?api-key=" + Config.apiKey
        }
    }
}
