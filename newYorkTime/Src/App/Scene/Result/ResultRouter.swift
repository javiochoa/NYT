//
//  ResultRouter.swift
//  newYorkTime
//
//  Created by javi on 02/02/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//

import Foundation
import UIKit

protocol ResultRouter: Router {
    
    func navigateToDetail(withPublication:Publication)
}

class ResultRouterImplementation: ResultRouter {
    
    // MARK: - Properties
    
    fileprivate weak var view: ResultViewController?
    
    // MARK: - Setup
    
    init(withView view:ResultViewController) {
        
        self.view = view
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    // MARK: - Protocol implementation
    
    func navigateToDetail(withPublication publication:Publication) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailView:DetailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController {
            detailView.configurator = DetailConfiguratorImplementation(withPublication: publication)
            self.navigate(to: detailView)
        }
    }
}
