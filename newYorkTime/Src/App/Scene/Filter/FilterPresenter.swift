//
//  FilterPresenter.swift
//  newYorkTime
//
//  Created by javi on 31/01/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//

import Foundation
import SVProgressHUD
import RxSwift

fileprivate enum FilterSelectorType: Int {
    
    case emailed = 0
    case shared
    case viewed
}

fileprivate enum FilterSelectorTime: Int {
    
    case day = 0
    case week
    case month
}

fileprivate enum FilterSelectorSource {
    
    case facebook
    case twitter
}

protocol FilterView: ReactiveView {
    
    var presenter:FilterPresenter! { get set }
    func hideSourceSelector()
    func showSourceSelector()
    var continueActionSubject :PublishSubject<Any> { get set }
    var didSelectFilterTypeActionSubject :PublishSubject<Int> { get set }
    var didSelectFilterTimeActionSubject :PublishSubject<Int> { get set }
    var didSelectFacebookActionSubject :PublishSubject<Bool> { get set }
    var didSelectTwitterActionSubject :PublishSubject<Bool> { get set }
}

protocol FilterPresenter {
    
    var router: FilterRouter { get }
}

class FilterPresenterImplementation:Presenter, FilterPresenter {
    
    // MARK: - Properties
    
    fileprivate weak var view: FilterView?
    fileprivate var filterTypeSelected:FilterSelectorType? {
        didSet {
            switch filterTypeSelected {
            case .shared:
                self.view?.showSourceSelector()
            default:
                self.view?.hideSourceSelector()
            }
        }
    }
    fileprivate var filterTimeSelected:FilterSelectorTime?
    fileprivate var filterSourceSelected:Set<FilterSelectorSource> = Set<FilterSelectorSource>()
    var router: FilterRouter
    var disposeBag:DisposeBag = DisposeBag()
    

    // MARK: - Setup
    
    init(withView view: FilterView, router: FilterRouter) {
        
        self.view = view
        self.router = router
        super.init()
        self.addObservers(toView: view)
    }
    
    fileprivate func addObservers(toView view: FilterView) {
        
        view.lifecicleEvent().subscribe(onNext: { (state) in
            switch state {
            case .created:
                break
            case .appear:
                
                break
            case .disappear:
                break
            case .none:
                break
            }
        }).disposed(by: self.disposeBag)
        view.continueActionSubject.subscribe(onNext: { (_) in
            self.doContinue()
        }).disposed(by: self.disposeBag)
        view.didSelectFilterTypeActionSubject.subscribe(onNext: { (filterType) in
            self.filterTypeSelected = FilterSelectorType(rawValue: filterType)
        }).disposed(by: self.disposeBag)
        view.didSelectFilterTimeActionSubject.subscribe(onNext: { (filterTime) in
            self.filterTimeSelected = FilterSelectorTime(rawValue: filterTime)
        }).disposed(by: self.disposeBag)
        view.didSelectTwitterActionSubject.subscribe(onNext: { (isOn) in
            switch isOn {
            case true:
                self.filterSourceSelected.insert(.twitter)
            default:
                self.filterSourceSelected.remove(.twitter)
            }
        }).disposed(by: self.disposeBag)
    
        view.didSelectFacebookActionSubject.subscribe(onNext: { (isOn) in
            switch isOn {
            case true:
                self.filterSourceSelected.insert(.facebook)
            default:
                self.filterSourceSelected.remove(.facebook)
            }
        }).disposed(by: self.disposeBag)
    }
    
    func doContinue() {
        
        let time:PublicationTime
        switch self.filterTimeSelected {
        case .day:
            time = .day
        case .week:
            time = .week
        case .month:
            time = .month
        case .none:
            time = .day
        }
        let type: PublicationType
        switch self.filterTypeSelected {
        case .emailed:
            type = .emailed(publicationTime: time)
        case .viewed:
            type = .viewed(publicationTime: time)
        case .shared:
            
            var sources:[SharedSource] = [SharedSource]()
            for source in Array(self.filterSourceSelected) {
                switch source {
                case .facebook:
                    sources.append(.facebook)
                case .twitter:
                    sources.append(.twitter)
                }
            }
            if sources.count == 0 {
                SVProgressHUD.showError(withStatus: "Debe elegir al menos una fuente de información")
                return
            }
            type = .shared(publicationTime: time, source: sources)
            
        case .none:
            return
        }
        self.router.navigateToResults(with:type)
    }
}
