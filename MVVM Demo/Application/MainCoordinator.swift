//
//  MainCoordinator.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 23/11/2021.
//

import UIKit

protocol MainCoordinatorDelegate: AnyObject {
    func didPerformAction<T: Any>(with data: T)
}

class MainCoordinator: Coordinator {
    
    private var navigationController: UINavigationController
    weak var mainCoordinatorDelegate: MainCoordinatorDelegate?
    
    init(navigator: UINavigationController) {
        self.navigationController = navigator
    }
    
    func start() {
        let viewModel = MainViewModel(mainCoordinator: self)
        let viewController = MainViewController(viewModel: viewModel)
        viewModel.didPressStart = { [weak self] in
            self?.goToNumbersList()
        }
        viewModel.didPressDataAdded = { [weak self] (number) in
            self?.goToImagesCollectionView(selectedNumber: number)
        }
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func goToNumbersList() {
        let viewModel = NumbersListViewModel()
        let viewController = ListViewController(viewModel: viewModel)
        viewModel.userDidSelectCell = { [weak self] (selectedNumber) in
            self?.mainCoordinatorDelegate?.didPerformAction(with: selectedNumber)
            self?.navigationController.popToRootViewController(animated: true)
        }
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func goToImagesCollectionView(selectedNumber: Int) {
        let viewModel = ImagesCollectionViewModel(selectedNumber: selectedNumber)
        let viewController = ImagesCollectionViewController(viewModel: viewModel)
        viewModel.didTapImageCell = { [weak self] in
            self?.goToCitiesList()
        }
        navigationController.pushViewController(viewController, animated: true)
    }
    
    private func goToCitiesList() {
        let viewModel = CitiesListViewModel()
        let viewController = ListViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
}
