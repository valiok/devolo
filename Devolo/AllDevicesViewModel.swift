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


class AllDevicesViewModel : BaseViewModel {
    
    private let disposeBag = DisposeBag()
    
    private var devices: BehaviorRelay<[Device]> = BehaviorRelay(value: [])
    private var lanScanner : MMLANScanner!
    
    override init() {
        super.init()
        self.lanScanner = MMLANScanner(delegate:self)
    }
}

// MARK: View setup
extension AllDevicesViewModel {
    public func setupViewModelWith(tableView: UITableView) {
        setupCellConfigTo(tableView: tableView)
        setupCellSelectingTo(tableView: tableView)
    }
}

// MARK: Rx setup
extension AllDevicesViewModel {
    private func setupCellConfigTo(tableView: UITableView) {
      devices
        .bind(to: tableView
          .rx
          .items(cellIdentifier: "cellIdentifier",
                 cellType: UITableViewCell.self)) {
                  row, device, cell in
                    cell.textLabel?.text = device.name
        }
        .disposed(by: disposeBag)
    }
    
    private func setupCellSelectingTo(tableView: UITableView) {
      tableView
        .rx
        .modelSelected(Device.self)
        .subscribe(onNext: { device in
            
          if let selectedRowIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedRowIndexPath, animated: true)
          }
        })
        .disposed(by: disposeBag)
    }
    
    func setupRightBarButtonItem(button: UIBarButtonItem) {
        button.rx.tap.subscribe(onNext: { [weak self] _ in
           self?.lanScanner.start()
            })
            .disposed(by: disposeBag)
    }
    
    func setupLeftBarButtonItem(button: UIBarButtonItem) {
        button.rx.tap.subscribe(onNext: { [weak self] _ in
            self?.lanScanner.stop()
            self?.devices.accept([])
            })
            .disposed(by: disposeBag)
    }
}


// MARK: Scanner delegate
extension AllDevicesViewModel: MMLANScannerDelegate {
    
    public func lanScanDidFindNewDevice(_ device: MMDevice!) {
        let newDevice = Device(name: device.ipAddress, id: "e")
        if !devices.value.contains(newDevice){
            let newValue = devices.value + [newDevice]
            devices.accept(newValue)
        }
    }
    
    public func lanScanDidFinishScanning(with status: MMLanScannerStatus) {
        switch(status){
        case MMLanScannerStatusFinished :
            print("Scan complete")
        case MMLanScannerStatusCancelled :
            print("Scan cancelled")
        default:
            break
        }
        
    }
    
    public func lanScanDidFailedToScan() {
        print("Error: Failed to scan")
    }
}
