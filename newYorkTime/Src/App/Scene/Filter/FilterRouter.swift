//
//  FilterRouter.swift
//  newYorkTime
//
//  Created by javi on 31/01/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//

import Foundation
import UIKit


protocol FilterRouter: Router {
    
    func navigateToResults(with:PublicationType)
}

class FilterRouterImplementation: FilterRouter {
    
    
    // MARK: - Properties
    
    fileprivate weak var view: FilterViewController?
    
    
    // MARK: - Setup
    
    init(withView view:FilterViewController) {
        
        self.view = view
    }
    
    // MARK: - Protocol implementation
    
    func navigateToResults(with type:PublicationType) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailView:ResultViewController = storyboard.instantiateViewController(withIdentifier: "ResultViewController") as? ResultViewController {
            detailView.configurator = ResultConfiguratorImplementation(withType: type)
            self.navigate(to: detailView)
        }
    }
}
