//
//  Request.swift
//  newYorkTime
//
//  Created by javi on 31/01/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//

import Foundation

protocol Request {
    
    var urlRequest: URLRequest { get }
    var endpoint: String { get }
    var method: RequestMethod { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String] { get }
}

