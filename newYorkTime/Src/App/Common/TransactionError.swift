//
//  TransactionError.swift
//  newYorkTime
//
//  Created by javi on 31/01/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//

import Foundation

enum TransactionError {
    
    case Error400(message:String?)
    case Error500(message:String?)
    case ErrorSerialization
    case ErrorInternet
    case ErrorUnautorized
    case ErrorNoData
    case ErrorUnknown(message:String?)
}
