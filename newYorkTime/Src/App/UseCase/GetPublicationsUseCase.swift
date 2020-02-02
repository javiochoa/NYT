//
//  GetPublicationsUseCase.swift
//  newYorkTime
//
//  Created by javi on 01/02/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//

import Foundation
import RxSwift

struct GetPublicationsUseCase {
    
    fileprivate var provider:PublicationProvider
    
    init(withProvider:PublicationProvider) {
        
        self.provider = withProvider
    }
    
    func execute(withPublicationType publicationType:PublicationType, invalidating:Bool) -> Single<Transaction<[Publication]>> {
        
        self.provider.get(fromPublicationType: publicationType, invalidating: invalidating).observeOn(MainScheduler.instance)
    }
}
