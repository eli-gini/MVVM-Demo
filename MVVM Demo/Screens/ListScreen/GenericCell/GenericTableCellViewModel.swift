//
//  NumberCellViewModel.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 28/11/2021.
//

import Foundation

protocol GenericTableCellsParentViewModelDelegate: AnyObject {
    func didTapCell(viewModel: GenericTableCellViewModel)
}

protocol GenericTableCellViewModelDelegate: AnyObject {
    func didEnterValidInput(_ input: Any)
}

class GenericTableCellViewModel {
    
    weak var parentViewModelDelegate: GenericTableCellsParentViewModelDelegate?
    weak var delegate: GenericTableCellViewModelDelegate?
    private let uuid = UUID()
    var data: Any?
    
    func loadData(_ data: Any) {
        delegate?.didEnterValidInput(data)
    }
    
    func userDidSelectCell() {
        parentViewModelDelegate?.didTapCell(viewModel: self)
    }
}

extension GenericTableCellViewModel: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
    static func == (lhs: GenericTableCellViewModel, rhs: GenericTableCellViewModel) -> Bool {
        return rhs.uuid == lhs.uuid
    }
}
