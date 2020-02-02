//
//  Presenter.swift
//  newYorkTime
//
//  Created by javi on 02/02/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//

import Foundation
import SVProgressHUD

class Presenter: NSObject {
    
    func process(error:TransactionError) {
        var alertMessage:String = ""
        switch error {
        case .Error400(message: let message):
            alertMessage = "\("ERROR_400".localized) - \(message ?? "")"
        case .Error500(message: let message):
            alertMessage = "\("ERROR_500".localized) - \(message ?? "")"
        case .ErrorInternet:
            alertMessage = "ERROR_NO_INTERNET".localized
        case .ErrorNoData:
            alertMessage =  "ERROR_NO_DATA".localized
        case .ErrorUnautorized:
            alertMessage = "ERROR_UNAUTHORIZED".localized
        case .ErrorUnknown(message: let message):
            alertMessage = "\(message ?? "")"
        case .ErrorSerialization:
            alertMessage = "ERROR_SERIALIZATION".localized
        }
        SVProgressHUD.showError(withStatus: alertMessage)
    }
}
