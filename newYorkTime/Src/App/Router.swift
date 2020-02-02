//
//  Router.swift
//  newYorkTime
//
//  Created by javi on 31/01/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//

import Foundation
import UIKit

protocol Router {
    
    func navigate(to:UIViewController)
    func popToParentView()
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

extension Router {
    
    func navigate(to:UIViewController) {
        
        if let rootView:UINavigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
            rootView.pushViewController(to, animated: true)
        } else {
            print("---other--- \(String(describing: UIApplication.shared.keyWindow?.rootViewController?.description))")
        }
    }
    
    func popToParentView() {
        
        if let rootView:UINavigationController = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController {
            rootView.popViewController(animated: true)
        }
    }
    
    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}
