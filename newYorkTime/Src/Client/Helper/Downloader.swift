//
//  Downloader.swift
//  newYorkTime
//
//  Created by javi on 31/01/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//
import Foundation

protocol Downloader {
    
    func send<T,E: Codable>(requestData: Request, adapter:RequestAdapter?, onSuccess: @escaping (_ response: Response<T>) -> Void, onError: @escaping ( _ error: ServerError<E> ) -> Void) -> Void
}
