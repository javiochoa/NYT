//
//  DetailConfigurator.swift
//  newYorkTime
//
//  Created by javi on 02/02/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//

import Foundation

protocol DetailConfigurator {
    
    func configure(withView: DetailViewController) -> Void
}

class DetailConfiguratorImplementation: DetailConfigurator {
    
    // MARK: - Properties
    
    fileprivate var publication:Publication
    
    // MARK: - Setup
    
    init(withPublication publication:Publication) {
        
        self.publication = publication
    }
    
    // MARK: - Protocol implementation
    
    func configure(withView view: DetailViewController) -> Void {
        
        let router = DetailRouterImplementation(withView: view)
        let presenter = DetailPresenterImplementation(withView: view, router: router, publication: self.publication)
        view.presenter = presenter
    }
    
}
