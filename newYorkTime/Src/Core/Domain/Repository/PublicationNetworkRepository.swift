//
//  PublicationNetworkRepository.swift
//  newYorkTime
//
//  Created by javi on 01/02/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//

import Foundation
import RxSwift

class PublicationNetworkRepository {
    
    fileprivate var client:Client
    
    init(withClient client:Client) {
        self.client = client
    }
    
    func get(fromPublicationType publicationType: PublicationType) -> Single<Transaction<[Publication]>> {
        
        self.client.get(fromPublicationType: publicationType).map { (transaction) -> Transaction<[Publication]> in
            switch transaction {
            case .success(let rawData):
                var publications:[Publication] = [Publication]()
                for raw in rawData.results {
                    if let rawUnwrapped:ResultDataRaw = raw {
                        publications.append(Publication(withRawData: rawUnwrapped))
                    }
                }
                return Transaction.success(publications)
            case .fail(let error):
                return Transaction.fail(error)
            }
        }
    }
}
