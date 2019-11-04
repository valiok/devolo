//
//  ViewController.swift
//  Devolo
//
//  Created by Valiok Khutornenko on 03.11.2019.
//  Copyright © 2019 Valentine Khutornenko. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class AllDevicesViewController: BaseViewController {
        
    let viewModel : AllDevicesViewModel
    let tableView = UITableView()

    init(withViewModel viewModel: AllDevicesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: Controller life cycle
extension AllDevicesViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupViewModel()
    }

}
//MARK: Setup view
extension AllDevicesViewController {
    
    private func setupView() {
        setupTableView()
        setupNavigationBar()
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellIdentifier")
        view = tableView
    }
    
    private func setupNavigationBar() {
        let rightButton = UIBarButtonItem(title: "scan", style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItem = rightButton
        viewModel.setupRightBarButtonItem(button: rightButton)
        
        let leftButton = UIBarButtonItem(title: "reset", style: .done, target: self, action: nil)
        navigationItem.leftBarButtonItem = leftButton
        viewModel.setupLeftBarButtonItem(button: leftButton)
    }

}

// MARK: Setup ViewModel
extension AllDevicesViewController {
    
    private func setupViewModel() {
         viewModel.setupViewModelWith(tableView: self.tableView)
    }
    
}

