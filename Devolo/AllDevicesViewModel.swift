//
//  AllDevicesViewModel.swift
//  Devolo
//
//  Created by Valiok Khutornenko on 03.11.2019.
//  Copyright © 2019 Valentine Khutornenko. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift


class AllDevicesViewModel : BaseViewModel, MMLANScannerDelegate {
    
    private let tableView : UITableView
    private var devices: BehaviorRelay<[Device]> = BehaviorRelay(value: [])

    private let disposeBag = DisposeBag()
    private var lanScanner : MMLANScanner!

    init(withTableView tableView: UITableView) {
        self.tableView = tableView
        super.init()
        self.lanScanner = MMLANScanner(delegate:self)

    }
    
    public func setupTableView() {
        setupCellConfiguration()
        setupCellTapHandling()
        self.lanScanner.start()
    }
    
    private func setupCellConfiguration() {
      
      devices
        .bind(to: tableView
          .rx
          .items(cellIdentifier: "UITableViewCell",
                 cellType: UITableViewCell.self)) {
                  row, device, cell in
                    cell.textLabel?.text = device.name
        }
        .disposed(by: disposeBag)
    }
    
    private func setupCellTapHandling() {
      tableView
        .rx
        .modelSelected(Device.self)
        .subscribe(onNext: { [unowned self] device in
            
          if let selectedRowIndexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: selectedRowIndexPath, animated: true)
          }
        })
        .disposed(by: disposeBag)
    }
    
    public func lanScanDidFindNewDevice(_ device: MMDevice!) {
        let newDevice = Device(name: device.ipAddress, id: "e")
        let newValue = devices.value + [newDevice]
        devices.accept(newValue)
    }
    
    public func lanScanDidFinishScanning(with status: MMLanScannerStatus) {
        print(status)
    }
    
    public func lanScanDidFailedToScan() {
        print("Error: Failed to scan")
    }
    
    

    

    
}
