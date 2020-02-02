//
//  ResultConfigurator.swift
//  newYorkTime
//
//  Created by javi on 02/02/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//

import Foundation

protocol ResultConfigurator {
    
    func configure(withView: ResultViewController) -> Void
}

class ResultConfiguratorImplementation: ResultConfigurator {
    
    // MARK: - Properties
    var type:PublicationType
    
    // MARK: - Setup
   
    init(withType type:PublicationType) {
        
        self.type = type
    }
    
    // MARK: - Protocol implementation
    
    func configure(withView view: ResultViewController) -> Void {

        let useCase: GetPublicationsUseCase = Dependencies.shared.getPublicationsuseCase
        let router = ResultRouterImplementation(withView: view)
        let presenter = ResultPresenterImplementation(withView: view, router: router, type: self.type, getPublicationsUseCase:useCase)
        view.presenter = presenter
    }
    
}
