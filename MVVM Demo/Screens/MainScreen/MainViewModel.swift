//
//  MainViewModel.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 23/11/2021.
//

import UIKit

protocol MainViewModelDelegate: AnyObject {
    func titleWillChange(to title: String)
}

class MainViewModel {
    
    var delegate: MainViewModelDelegate?
    var didPressStart: (()->Void)?
    var didPressDataAdded: ((Int)->Void)?
    private var numberReceived: Int?
    
    func presentNumbersListVC() {
        didPressStart?()
    }
    
    func presentImagesCollectionVC() {
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
            print(number)
        }
    }
}
//extension MainViewModel: NumberListViewControllerDelegate {
//    func didSelectNumber(number: Int) {
//        numberToPass = number
//        let title = getStringNumber(number)
//        delegate?.titleWillChange(to: title)
//    }
//}
