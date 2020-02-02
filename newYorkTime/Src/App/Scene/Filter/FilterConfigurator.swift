//
//  FilterConfigurator.swift
//  newYorkTime
//
//  Created by javi on 31/01/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//

import Foundation

protocol FilterConfigurator {
    
    func configure(withView: FilterViewController) -> Void
}

class FilterConfiguratorImplementation: FilterConfigurator {
    
    
    // MARK: - Setup
   
    init() {}
    
    // MARK: - Protocol implementation
    
    func configure(withView view: FilterViewController) -> Void {
        
        let router = FilterRouterImplementation(withView: view)
        let presenter = FilterPresenterImplementation(withView: view, router: router)
        view.presenter = presenter
    }
    
}
