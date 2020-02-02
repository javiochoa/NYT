//
//  String+Extension.swift
//  newYorkTime
//
//  Created by javi on 02/02/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    /**
     Es el valor del String localizado.
     */
    var localized: String {
        
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}
