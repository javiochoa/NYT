//
//  Response.swift
//  newYorkTime
//
//  Created by javi on 31/01/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//

import Foundation

struct Response<T: Decodable> {
    
    var model: T
    let httpUrlResponse: HTTPURLResponse
    let data: Data
    
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
            
            print(error.localizedDescription)
            throw error
        }
    }
}
