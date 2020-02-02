//
//  Transaction.swift
//  newYorkTime
//
//  Created by javi on 31/01/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//

import Foundation

enum Transaction<T> {
    
    case success(T)
    case fail(TransactionError)
    
    func isSuccess() -> Bool {
        
        return self.data() != nil
    }
    
    func data() -> T? {
        
        switch self {
        case .success(let element):
            return element
        default:
            return nil
        }
    }
}


