//
//  PublicationProvider.swift
//  newYorkTime
//
//  Created by javi on 01/02/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//

import Foundation
import RxSwift

class PublicationProvider {
    
    fileprivate var memory: PublicationMemoryRepository!
    fileprivate var network: PublicationNetworkRepository!
    
    init(withMemory memory: PublicationMemoryRepository, network: PublicationNetworkRepository) {
        
        self.memory = memory
        self.network = network
    }
    
    func get(fromPublicationType publicationType: PublicationType, invalidating:Bool) -> Single<Transaction<[Publication]>> {
        
        if invalidating == true {
            self.memory.clear(fromPublicationType: publicationType)
        }
        return self.memory.get(fromPublicationType: publicationType).ifEmpty(switchTo: self.network.get(fromPublicationType: publicationType).do (
            
            onSuccess: { [weak self] (transaction) in
                if transaction.isSuccess() {
                    _ = self?.memory.set(elements: transaction.data()!, fromPublicationType: publicationType).subscribe()
                }
        }))
    }
}
