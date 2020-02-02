//
//  FilterViewController.swift
//  newYorkTime
//
//  Created by javi on 31/01/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//
import UIKit
import Foundation
import RxSwift

class FilterViewController: ViewController , FilterView, ReactiveView {
    
    // MARK: - Outlets
    
    @IBOutlet weak var sourceViewHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var sourceView: UIView!
    @IBOutlet weak var articleTypeSelector: UISegmentedControl!
    @IBOutlet weak var articleTimeSelector: UISegmentedControl!
    @IBOutlet weak var facebookSwitch: UISwitch!
    @IBOutlet weak var twitterSwitch: UISwitch!
    
    // MARK: - Properties
    
    var presenter: FilterPresenter!
    var configurator: FilterConfigurator! = FilterConfiguratorImplementation()
    var continueActionSubject :PublishSubject<Any> = PublishSubject<Any>()
    var didSelectFilterTypeActionSubject :PublishSubject<Int> = PublishSubject<Int>()
    var didSelectFilterTimeActionSubject :PublishSubject<Int> = PublishSubject<Int>()
    var didSelectFacebookActionSubject :PublishSubject<Bool> = PublishSubject<Bool>()
    var didSelectTwitterActionSubject :PublishSubject<Bool> = PublishSubject<Bool>()
    
    let detailViewHeight:CGFloat = 127.0
    
    // MARK: - Lifecicle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configurator.configure(withView: self)
        configureView()
    }
    
    // MARK: - Setup
    
    private func configureView() {
        //Setup UI elements
        self.articleTypeSelectorChangeAction(self.articleTypeSelector)
        self.publicationTimeChangeAction(self.articleTimeSelector)
        self.facebookSelectorChangeAction(self.facebookSwitch)
        self.twitterSelectorChangeAction(self.twitterSwitch)
    }
    
    @IBAction func articleTypeSelectorChangeAction(_ sender: UISegmentedControl) {
        
        self.didSelectFilterTypeActionSubject.onNext(sender.selectedSegmentIndex)
    }
    
    @IBAction func publicationTimeChangeAction(_ sender: UISegmentedControl) {
        
        self.didSelectFilterTimeActionSubject.onNext(sender.selectedSegmentIndex)
    }
    
    @IBAction func facebookSelectorChangeAction(_ sender: UISwitch) {
        
        self.didSelectFacebookActionSubject.onNext(sender.isOn)
    }
    
    @IBAction func twitterSelectorChangeAction(_ sender: UISwitch) {
        
        self.didSelectTwitterActionSubject.onNext(sender.isOn)
    }
    
    @IBAction func doContinueAction(_ sender: Any) {
        
        self.continueActionSubject.onNext(sender)
    }
    
    func hideSourceSelector() {
        
        self.setSourceView(height: 0)
    }
    
    func showSourceSelector() {
        
        self.setSourceView(height: self.detailViewHeight)
    }
    
    fileprivate func setSourceView(height:CGFloat) {
        
        UIView.animate(withDuration: 0.2) {
            self.sourceViewHeightContraint.constant = height
            self.view.layoutIfNeeded()
        }
    }
}
