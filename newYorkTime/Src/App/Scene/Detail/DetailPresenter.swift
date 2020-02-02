//
//  DetailPresenter.swift
//  newYorkTime
//
//  Created by javi on 02/02/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//

import Foundation
import SVProgressHUD
import RxSwift

protocol DetailView: ReactiveView {
    
    var presenter:DetailPresenter! { get set }
    func fill(title:String)
    func load(url: URL)
    var failActionSubject :PublishSubject<Any?> { get set }
}

protocol DetailPresenter {
    
    var router: DetailRouter { get }
}

class DetailPresenterImplementation: Presenter, DetailPresenter {
    
    // MARK: - Properties
    
    fileprivate weak var view: DetailView?
    var router: DetailRouter
    fileprivate var publication:Publication
    var disposeBag:DisposeBag = DisposeBag()
    // MARK: - Setup
    
    init(withView view: DetailView, router: DetailRouter, publication:Publication) {
        
        self.view = view
        self.router = router
        self.publication = publication
        super.init()
        self.addObservers(toView: view)
    }
    
    fileprivate func addObservers(toView view: DetailView) {
        
        view.lifecicleEvent().subscribe(onNext: { (state) in
            switch state {
            case .created:
                self.loadData()
                break
            case .appear:
                break
            case .disappear:
                break
            case .none:
                break
            }
        }).disposed(by: self.disposeBag)
        self.view?.failActionSubject.subscribe(onNext: { (_) in
            self.router.popToParentView()
        }).disposed(by: self.disposeBag)
    }
    
    fileprivate func loadData() {
        
        self.view?.fill(title: self.publication.title)
        if let urlStringUnwrapped:String = publication.url, let urlUnwrapped:URL = URL(string: urlStringUnwrapped) {
            self.view?.load(url: urlUnwrapped)
        } else {
            SVProgressHUD.showError(withStatus: "ERROR_CANT_LOAD_URL".localized)
            self.router.popToParentView()
        }
    }
}
