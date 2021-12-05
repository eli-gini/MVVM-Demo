//
//  NumberCellViewModel.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 28/11/2021.
//

import Foundation

protocol GenericCellsParentViewModelDelegate: AnyObject {
    func didTapCell(viewModel: GenericCellViewModel)
}

protocol GenericCellViewModelDelegate: AnyObject {
    func didEnterValidNumber(_ number: Int)
}

class GenericCellViewModel {
    
    weak var parentViewModelDelegate: GenericCellsParentViewModelDelegate?
    weak var delegate: GenericCellViewModelDelegate?
    private let uuid = UUID()
    
    func loadNumbers(_ number: Int) {
        delegate?.didEnterValidNumber(number)
    }
    
    func userDidSelectCell() {
        parentViewModelDelegate?.didTapCell(viewModel: self)
    }
    
    func getIntNumberFromString(string: String) -> Int? {
        guard let number = Int(string) else { return nil }
        return number
    }
}

extension GenericCellViewModel: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
    static func == (lhs: GenericCellViewModel, rhs: GenericCellViewModel) -> Bool {
        return rhs.uuid == lhs.uuid
    }
}
