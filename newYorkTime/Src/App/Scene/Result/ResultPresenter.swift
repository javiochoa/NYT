//
//  ResultPresenter.swift
//  newYorkTime
//
//  Created by javi on 02/02/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//

import Foundation
import SVProgressHUD
import RxSwift

protocol ResultView: ReactiveView {
    
    var presenter:ResultPresenter! { get set }
    var cellActionSubject :PublishSubject<IndexPath> { get set }
    var refreshActionSubject :PublishSubject<Any?> { get set }
    func reloadData()
    func fill(updatedAt:String)
}

protocol ResultPresenter {
    
    var router: ResultRouter { get }
    var numberOfElements: Int { get }
    func fill(cell: ResultTableViewCell, atIndex:Int)
}

class ResultPresenterImplementation: Presenter, ResultPresenter {
    
    // MARK: - Properties
    
    fileprivate weak var view: ResultView?
    var type:PublicationType
    var router: ResultRouter
    var useCase: GetPublicationsUseCase
    var numberOfElements: Int {
        return self.publications.count
    }
    fileprivate var publications:[Publication] = [Publication]() {
        didSet {
            self.view?.reloadData()
            self.view?.fill(updatedAt: Date().asScripted())
        }
    }
    var disposeBag:DisposeBag = DisposeBag()
    
    // MARK: - Setup
    
    init(withView view: ResultView, router: ResultRouter, type:PublicationType, getPublicationsUseCase: GetPublicationsUseCase) {
        
        self.view = view
        self.router = router
        self.type = type
        self.useCase = getPublicationsUseCase
        super.init()
        self.addObservers(toView: view)
    }
    
    func fill(cell: ResultTableViewCell, atIndex:Int) {
        
        let elementData:Publication = self.publications[atIndex]
        cell.fill(withImageURL: elementData.imageURL,
                  title: elementData.title,
                  author: elementData.author,
                  section: elementData.section,
                  date: elementData.publishedDate)
    }
    
    fileprivate func addObservers(toView view: ResultView) {
        
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
        self.view?.cellActionSubject.subscribe(onNext: { (indexPath) in
            self.didSelect(atIndex:indexPath.row)
        }).disposed(by: self.disposeBag)
        
        self.view?.refreshActionSubject.subscribe(onNext: { (_) in
            self.loadData(invalidating: true)
        }).disposed(by: self.disposeBag)
    }
    
    fileprivate func loadData(invalidating:Bool = false) {
        
        SVProgressHUD.show()
        _ = self.useCase.execute(withPublicationType: self.type, invalidating: invalidating).do(onSuccess: { (transaction) in
            SVProgressHUD.dismiss()
            switch transaction {
            case .success(let publications):
                self.publications = publications
            case .fail(let error):
                self.process(error: error)
                self.router.popToParentView()
            }
        }).subscribe()
    }
    
    fileprivate func didSelect(atIndex:Int) {
        
        self.router.navigateToDetail(withPublication: self.publications[atIndex])
    }
}
