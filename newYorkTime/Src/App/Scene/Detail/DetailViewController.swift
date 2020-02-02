//
//  DetailViewController.swift
//  newYorkTime
//
//  Created by javi on 02/02/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//
import UIKit
import Foundation
import WebKit
import SVProgressHUD
import RxSwift

class DetailViewController: ViewController , DetailView {
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.uiDelegate = self
            webView.navigationDelegate = self
        }
    }
    // MARK: - Properties
    
    var presenter: DetailPresenter!
    var configurator: DetailConfigurator! //Initialize on caller or here if is first view controller
    var failActionSubject :PublishSubject<Any?> = PublishSubject<Any?>()
    // MARK: - Lifecicle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configurator.configure(withView: self)
        configureView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        presenter.router.prepare(for: segue, sender: sender)
    }
    
    func load(url: URL) {
        
        let request:URLRequest = URLRequest(url: url)
        self.webView.load(request)
    }
    
    private func configureView() {
        //Setup UI elements
    }
    
    func fill(title: String) {
        
        self.title = title
    }
    
}
extension DetailViewController: WKUIDelegate {
    
    func webView(_ webView: WKWebView,didFinish navigation: WKNavigation!) {
        
        SVProgressHUD.dismiss()
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
        SVProgressHUD.show(withStatus: "LOADING".localized)
    }
}

extension DetailViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView,
                 didFail navigation: WKNavigation!,
                 withError error: Error) {
        
        SVProgressHUD.showError(withStatus: error.localizedDescription)
        self.failActionSubject.onNext(nil)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
        SVProgressHUD.showError(withStatus: error.localizedDescription)
        self.failActionSubject.onNext(nil)
    }
}
