//
//  MainViewModel.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 23/11/2021.
//

import UIKit

protocol MainViewModelDelegate: AnyObject {
    func viewWillUpdate(title: String)
}

class MainViewModel {
    
    weak var delegate: MainViewModelDelegate?
    var didPressStart: (()->Void)?
    var didPressDataAdded: ((Int)->Void)?
    private var numberReceived: Int?
    // keep reference to mainCoordinator?
    private var mainCoordinator: MainCoordinator
    
    init(mainCoordinator: MainCoordinator) {
        self.mainCoordinator = mainCoordinator
        mainCoordinator.mainCoordinatorDelegate = self
    }
    
    func userDidTapStartButton() {
        didPressStart?()
    }
    
    func userDidTapDataPassedButton() {
        guard let number = numberReceived else {
            return
        }
        didPressDataAdded?(number)
    }
    
    private func getStringNumber(_ number: Int)-> String {
        return String(number)
    }
}

extension MainViewModel: MainCoordinatorDelegate {
    func didPerformAction<T>(with data: T) {
        if let number = data as? Int {
            numberReceived = number
            delegate?.viewWillUpdate(title: number.description)
        }
    }
}
