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
    func didEnterValidInput(_ input: Any)
}

class GenericCellViewModel {
    
    weak var parentViewModelDelegate: GenericCellsParentViewModelDelegate?
    weak var delegate: GenericCellViewModelDelegate?
    private let uuid = UUID()
    var data: Any?
    
    func loadData(_ data: Any) {
        delegate?.didEnterValidInput(data)
    }
    
    func userDidSelectCell() {
        parentViewModelDelegate?.didTapCell(viewModel: self)
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
