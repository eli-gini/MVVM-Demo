//
//  MainCoordinator.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 23/11/2021.
//

import UIKit

class MainCoordinator: Coordinator {
    
    private var navigationController: UINavigationController
    
    init(navigator: UINavigationController) {
        self.navigationController = navigator
    }
    
    func start() {
        let viewController = MainViewController()
        let viewModel = MainViewModel()
        viewController.viewModel = viewModel
        viewModel.didPressStart = {
            self.goToNumbersList(delegate: viewModel)
        }
        viewModel.didPressDataAdded = { (number) in
            self.goToImagesCollectionView(numberOfCells: number)
        }
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func goToNumbersList(delegate: NumberListViewControllerDelegate) {
        let viewController = NumbersListViewController()
        let viewModel = NumbersListViewModel()
        viewController.viewModel = viewModel
        viewController.delegate = delegate
        viewModel.willDismissController = {
            self.navigationController.popToRootViewController(animated: true)
        }
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func goToImagesCollectionView(numberOfCells: Int) {
        let viewController = ImagesCollectionViewController()
        let viewModel = ImagesCollectionViewModel(numberOfCells: numberOfCells)
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
}
