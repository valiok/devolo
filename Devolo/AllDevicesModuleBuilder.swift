//
//  AllDevicesModuleBuilder.swift
//  Devolo
//
//  Created by Valiok Khutornenko on 04.11.2019.
//  Copyright © 2019 Valentine Khutornenko. All rights reserved.
//

import Foundation
import UIKit

class AllDevicesModuleBuilder {
    class func initRootModule() -> UINavigationController{
        let viewModel = AllDevicesViewModel()
        let viewController = AllDevicesViewController(withViewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)

        return navigationController
    }
}
