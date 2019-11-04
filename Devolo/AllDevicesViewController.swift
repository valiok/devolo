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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupViewModel()
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        view = tableView
    }
    
    private func setupViewModel() {
         viewModel.setupViewModelWith(tableView: self.tableView)
    }
    


}

