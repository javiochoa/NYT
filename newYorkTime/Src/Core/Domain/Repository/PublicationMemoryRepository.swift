//
//  PublicationMemoryRepository.swift
//  newYorkTime
//
//  Created by javi on 01/02/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//

import Foundation
import RxSwift

class PublicationMemoryRepository {
    
    let cacheLifeTime:Int = 12 //seconds
    fileprivate var memory:[PublicationType: [Publication]] = [PublicationType: [Publication]]()
    fileprivate var status:[PublicationType: Date] = [PublicationType: Date]()
    
    func set(elements:[Publication], fromPublicationType publicationType: PublicationType) -> Completable {
        
        if memory[publicationType] == nil {
            memory[publicationType] = elements
            status[publicationType] = Date()
        } else {
            memory[publicationType]?.append(contentsOf: elements)
            status[publicationType] = Date()
        }
        return Completable.create { (completable) -> Disposable in
            completable(.completed)
            return Disposables.create()
        }
    }
    
    func get(fromPublicationType publicationType: PublicationType) -> Maybe<Transaction<[Publication]>> {
        
        return Maybe.create { (maybe) -> Disposable in
            if let elementsUnwrapped:[Publication] = self.memory[publicationType], self.mustReturnCacheData(fromPublicationType: publicationType) {
                maybe(.success(Transaction.success(elementsUnwrapped)))
            }
            maybe(.completed)
            return Disposables.create()
        }
    }
    
    fileprivate func mustReturnCacheData(fromPublicationType publicationType: PublicationType) -> Bool {
        
        if let statusUnwrapped = status[publicationType] {
            return abs(statusUnwrapped.seconds(from: Date())) <= self.cacheLifeTime
        }
        return false
    }
    
    func clear(fromPublicationType publicationType: PublicationType) {
        
        self.memory[publicationType] = nil
    }
}


