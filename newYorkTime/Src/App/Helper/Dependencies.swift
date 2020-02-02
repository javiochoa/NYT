//
//  Dependencies.swift
//  newYorkTime
//
//  Created by javi on 02/02/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//

import Foundation

public class Dependencies {

    static let shared = Dependencies()
    // MARK: -
    lazy var downloader: Downloader = DownloadHelper()
    lazy var client: Client = Client(withDownloader: Dependencies.shared.downloader)
    
    // MARK: - UseCases

    lazy var getPublicationsuseCase: GetPublicationsUseCase = GetPublicationsUseCase(withProvider: Dependencies.shared.publicationsProvider)
    
    // MARK: - Providers

    lazy var publicationsProvider: PublicationProvider = PublicationProvider(withMemory: Dependencies.shared.publicationMemoryRepository, network: Dependencies.shared.publicationNetworkRepository)
    
    // MARK: - Repository

    lazy var publicationMemoryRepository: PublicationMemoryRepository = PublicationMemoryRepository()
    lazy var publicationNetworkRepository: PublicationNetworkRepository = PublicationNetworkRepository(withClient: Dependencies.shared.client)
   

}
