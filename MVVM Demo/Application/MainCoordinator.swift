//
//  MainCoordinator.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 23/11/2021.
//

import UIKit

class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    
    init(navigator: UINavigationController) {
        self.navigationController = navigator
    }
    
    func start() {
        let viewController = MainViewController()
        let viewModel = MainViewModel()
        viewController.viewModel = viewModel
        viewModel.didPressStart = {
            self.goToNumbersList()
        }
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToNumbersList() {
        let viewController = NumbersListViewController()
        let viewModel = NumbersListViewModel()
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
        
    }
}
