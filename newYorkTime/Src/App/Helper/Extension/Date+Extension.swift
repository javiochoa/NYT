//
//  Date+Extension.swift
//  newYorkTime
//
//  Created by javi on 02/02/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//

import Foundation

extension Date {
    
    func asScripted() -> String  {
        
        return self.with(format: "dd-MM-yyyy HH:mm")
    }
    
    func with(format:String) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func seconds(from date: Date) -> Int {
        
        return Calendar.current.dateComponents([.second], from: date, to: self).second!
    }
}
