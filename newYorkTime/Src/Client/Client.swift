//
//  Client.swift
//  newYorkTime
//
//  Created by javi on 01/02/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//

import Foundation
import RxSwift

class Client {
    
    var downloader:Downloader
    
    init(withDownloader downloader:Downloader) {
        self.downloader = downloader
    }
    
    func get(fromPublicationType publicationType:PublicationType) -> Single<Transaction<PublicationDataRaw>> {
        
        return Single.create { single in
            
            self.downloader.send(requestData: PublicationRequest(withType: publicationType), adapter: nil, onSuccess: { (element:Response<PublicationDataRaw>) in
                single(.success(Transaction.success(element.model) ))
            }) { (error:ServerError<GenericServerError>) in
                single(.success(Transaction.fail(TransactionHelper.convert(serverError: error))))
            }
            return Disposables.create {}
        }
    }
}
