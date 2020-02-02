//
//  ViewController.swift
//  newYorkTime
//
//  Created by javi on 02/02/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//

import UIKit
import SVProgressHUD
import RxSwift

enum LifecicleState {
    case none
    case created
    case appear
    case disappear
}

protocol ReactiveView: class {

    func lifecicleEvent() -> Observable<LifecicleState>
}

class ViewController: UIViewController {

    fileprivate var lifecicleEmitter: BehaviorSubject<LifecicleState> = BehaviorSubject<LifecicleState>(value: .none)

    func lifecicleEvent() -> Observable<LifecicleState> {
        
        return lifecicleEmitter
    }

    override func viewDidLoad() {
        
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        SVProgressHUD.setCornerRadius(10.0)
        super.viewDidLoad()
        lifecicleEmitter.onNext(.created)
    }

    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        lifecicleEmitter.onNext(.appear)
    }

    override func viewDidDisappear(_ animated: Bool) {
        
        lifecicleEmitter.onNext(.disappear)
        super.viewDidDisappear(animated)
    }
    
    override var title: String? {
        didSet {
            super.title = title
        }
    }
}
