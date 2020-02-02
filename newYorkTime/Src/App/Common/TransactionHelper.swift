//
//  TransactionHelper.swift
//  newYorkTime
//
//  Created by javi on 31/01/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//

import Foundation

class TransactionHelper {
    
    static func convert<T>(serverError:ServerError<T>) -> TransactionError {
        
        switch serverError {
        case .Error400(message: let serverError):
            return .Error400(message: serverError?.message)
        case .Error500(message: let serverError):
            return .Error500(message: serverError?.message)
        case .ErrorInternet:
            return .ErrorInternet
        case .ErrorSerialization:
            return .ErrorSerialization
        case .ErrorUnautorized:
            return .ErrorUnautorized
        case .ErrorUnknown(message: let message):
            return .ErrorUnknown(message: message)
        }
    }
}
