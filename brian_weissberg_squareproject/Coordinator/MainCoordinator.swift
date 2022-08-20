//
//  MainCoordinator.swift
//  brian_weissberg_squareproject
//
//  Created by Brian Weissberg on 8/19/22.
//

import Foundation
import UIKit

protocol MainCoordinating {
    var navController: UINavigationController { get set }
    func showEmployeeDirectory(state: UrlState)
}

class MainCoordinator: MainCoordinating {
    var navController: UINavigationController
    
    init(navController: UINavigationController) {
        self.navController = navController
    }

    func showEmployeeDirectory(state: UrlState) {
        let dataProvider = EmployeesDataProvider()
        let viewModel = EmployeesViewModel(dataProvider: dataProvider, state: state)
        let controller = EmployeeDirectoryController(viewModel: viewModel, coordinator: self)
        viewModel.delegate = controller
        viewModel.fetchData()
        navController.pushViewController(controller, animated: true)
    }
}
