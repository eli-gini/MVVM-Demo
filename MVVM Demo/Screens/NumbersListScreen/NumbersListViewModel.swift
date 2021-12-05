//
//  NumbersListViewModel.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 23/11/2021.
//

import Foundation
import UIKit

protocol NumbersListViewModelDelegate: AnyObject {
    func willSwitchToErrorMode()
}

class NumbersListViewModel {
    
    var userDidSelectCellWithNumber: ((Int)-> Void)?
    private var validatedNumber: Int?
    var errorMode: Bool = false
    private var cellViewModels: [GenericCellViewModel] = []
    weak var delegate: NumbersListViewModelDelegate?
    
    func userDidEnterText(text: String?) {
        if let number = validateNumericText(text: text) {
            validatedNumber = number
        } else {
            validatedNumber = nil
        }
    }
    
    func userDidTapGoButton() {
        if validatedNumber == nil {
            delegate?.willSwitchToErrorMode()
        } else {
            makeCellViewModels()
        }
    }
    
    private func validateNumericText(text: String?)-> Int? {
        guard let text = text, let number = Int(text), number >= 0 else { return nil }
        return number
    }
    
    private func makeCellViewModels() {
        for _ in 0...(validatedNumber! - 1) {
            let newViewModel = GenericCellViewModel()
            newViewModel.parentViewModelDelegate = self
            cellViewModels.append(newViewModel)
        }
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> GenericCellViewModel? {
        guard cellViewModels.indices.contains(indexPath.row) else { return nil }
        return cellViewModels[indexPath.row]
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        return cellViewModels.count
    }
}

extension NumbersListViewModel: GenericCellsParentViewModelDelegate {
    func didTapCell(viewModel: GenericCellViewModel) {
        guard let index = cellViewModels.firstIndex(where: { $0 == viewModel }) else { return }
        userDidSelectCellWithNumber?(index)
    }
}
