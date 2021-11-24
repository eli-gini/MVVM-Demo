//
//  MainViewModel.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 23/11/2021.
//

import UIKit



class MainViewModel {
    
    var delegate: MainViewModelDelegate?
    var didPressStart: (()->Void)?
    
    
    func presentNumbersListVC() {
        didPressStart?()
    }
    
    private func getStringNumber(_ number: Int)-> String {
        return String(number)
    }
}

extension MainViewModel: NumberListViewControllerDelegate {
    func didSelectNumber(_ number: Int) {
        let title = getStringNumber(number)
        delegate?.titleWillChange(to: title)
    }
}
