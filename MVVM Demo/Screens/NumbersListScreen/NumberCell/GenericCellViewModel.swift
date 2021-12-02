//
//  NumberCellViewModel.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 28/11/2021.
//

import Foundation

protocol GenericCellsParentViewModelDelegate: AnyObject {
    
}

protocol GenericCellViewModelDelegate: AnyObject {
    func didEnterValidNumber(_ number: Int)
}

class GenericCellViewModel {
    
    weak var parentViewModelDelegate: GenericCellsParentViewModelDelegate?
    weak var delegate: GenericCellViewModelDelegate?
    
    func loadValidNumber(_ number: Int) {
        delegate?.didEnterValidNumber(number)
    }
}
