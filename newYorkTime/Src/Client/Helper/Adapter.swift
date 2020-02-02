//
//  Adapter.swift
//  newYorkTime
//
//  Created by javi on 31/01/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//

import Foundation

protocol RequestAdapter {
    
    func adapt( _ request: inout URLRequest) -> Void
}
