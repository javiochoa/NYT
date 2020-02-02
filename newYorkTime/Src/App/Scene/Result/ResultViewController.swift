//
//  ResultViewController.swift
//  newYorkTime
//
//  Created by javi on 02/02/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//
import UIKit
import Foundation
import RxSwift

class ResultViewController: ViewController , ResultView, ReactiveView {
    
    // MARK: - Outlets
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    // MARK: - Properties
    
    var presenter: ResultPresenter!
    var configurator: ResultConfigurator! //Initialize on caller or here if is first view controller
    var cellActionSubject :PublishSubject<IndexPath> = PublishSubject<IndexPath>()
    var refreshActionSubject :PublishSubject<Any?> = PublishSubject<Any?>()
    var refreshControl = UIRefreshControl()
    
    // MARK: - Lifecicle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configurator.configure(withView: self)
        configureView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        presenter.router.prepare(for: segue, sender: sender)
    }
    
    // MARK: - Setup
    
    private func configureView() {
        //Setup UI elements
        self.refreshControl.addTarget(self, action: #selector(notifyReloadRequest(sender:)), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl) // not required when using UITableViewControl
    }
    
    func reloadData() {
        
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }
    
    func fill(updatedAt:String) {
        
        self.refreshControl.attributedTitle = NSAttributedString(string: "\("UPDATED_AT".localized) \(updatedAt)")
    }
    
    @objc fileprivate func notifyReloadRequest(sender:Any) {
        
        refreshActionSubject.onNext(nil)
    }
    
}

extension ResultViewController:UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.cellActionSubject.onNext(indexPath)
    }
    
}

extension ResultViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.presenter != nil {
            return self.presenter.numberOfElements
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell:ResultTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ResultTableViewCell") as? ResultTableViewCell else {
            return UITableViewCell()
        }
        self.presenter.fill(cell: cell, atIndex: indexPath.row)
        return cell
    }
}
