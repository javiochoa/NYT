//
//  Error.swift
//  newYorkTime
//
//  Created by javi on 31/01/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//

import Foundation

enum ServerError<T:Codable>: Error {
    
    case Error400(message:ServerErrorObject<T>?)
    case Error500(message:ServerErrorObject<T>?)
    case ErrorSerialization
    case ErrorInternet
    case ErrorUnautorized
    case ErrorUnknown(message:String?)
}

struct ServerErrorObject<T:Codable> {
    
    var model: T
    let httpUrlResponse: HTTPURLResponse
    let data: Data
    let message:String?
    
    init(data: Data?, httpUrlResponse: HTTPURLResponse) throws {
        
        self.httpUrlResponse = httpUrlResponse
        
        if data?.count == 0 {
            self.data = "{}".data(using: .utf8) ?? Data() //Forzamos que exista un JSON mínimo para parsear
        }else {
            self.data = data!
        }
        do {
            self.model = try JSONDecoder().decode(T.self, from: self.data)
        } catch let error {
            throw error
        }
        self.message = nil
    }
}
