//
//  MainViewModel.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 23/11/2021.
//

import UIKit

protocol MainViewModelDelegate: AnyObject {
    func buttonWillUpdate<T: Any>(using data: T)
}

class MainViewModel {
    
    weak var delegate: MainViewModelDelegate?
    var didPressStart: (()->Void)?
    var didPressDataAdded: ((Int)->Void)?
    private var buttonWillUpdate: ((UIButton, String)->Void)?
    private var numberReceived: Int?
    weak var mainCoordinator: MainCoordinator?
    
    init(mainCoordinator: MainCoordinator) {
        self.mainCoordinator = mainCoordinator
        mainCoordinator.mainCoordinatorDelegate = self
    }
    
    func userDidTapStartButton() {
        didPressStart?()
    }
    
    func userDidTapDataPassedButton() {
        guard let number = numberReceived else { return }
        didPressDataAdded?(number)
    }
    
    private func updateLabel(label: UILabel, title: String) {
        label.text = title
    }
}

extension MainViewModel: MainCoordinatorDelegate {
    func didPerformAction<T>(with data: T) {
        if let number = data as? Int {
            numberReceived = number
            delegate?.buttonWillUpdate(using: number)
        } else if let text = data as? String {
            delegate?.buttonWillUpdate(using: text)
        }
        
    }
}
