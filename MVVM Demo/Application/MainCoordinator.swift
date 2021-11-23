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
        viewModel.didPressStart = { [weak self] in
            self?.goToNumbersList()
            print("in number list")
        }
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToNumbersList() {
        let viewController = NumbersListViewController()
        let viewModel = NumbersListViewModel()
        viewController.viewModel = viewModel
        navigationController.present(viewController, animated: true)
        
    }
}
