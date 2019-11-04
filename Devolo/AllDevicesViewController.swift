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
        self.viewModel = AllDevicesViewModel(withTableView: tableView)
        super.init(nibName: nil, bundle: nil)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        view = tableView
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        viewModel.setupTableView()
        // Do any additional setup after loading the view.
    }
    


}

