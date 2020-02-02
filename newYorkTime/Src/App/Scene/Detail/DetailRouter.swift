//
//  DetailRouter.swift
//  newYorkTime
//
//  Created by javi on 02/02/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//

import Foundation
import UIKit

protocol DetailRouter: Router {
    
}

class DetailRouterImplementation: DetailRouter {
    
    // MARK: - Properties
    
    fileprivate weak var view: DetailViewController?
    
    // MARK: - Setup
    
    init(withView view:DetailViewController) {
        
        self.view = view
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
