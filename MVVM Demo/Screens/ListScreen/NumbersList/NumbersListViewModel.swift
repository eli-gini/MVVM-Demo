//
//  NumbersListViewModel.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 23/11/2021.
//

import Foundation
import UIKit

class NumbersListViewModel: ListViewModel {
    
    var userDidSelectCell: ((Any)-> Void)?
    var cellViewModels: [GenericCellViewModel] = []
    var delegate: ListViewModelDelegate?
    var isErrorMode: Bool = false
    private var validatedNumber: Int?
    
    func userDidEnterText(_ text: String?) {
        if let number = validateNumericText(text: text) {
            validatedNumber = number
        } else {
            validatedNumber = nil
        }
    }
    
    func userDidTapGoButton(handler: (() -> Void)?) {
        if validatedNumber == nil {
            delegate?.willSwitchToErrorMode()
        } else {
            makeCellViewModels()
            handler?()
        }
    }
    
    private func validateNumericText(text: String?)-> Int? {
        guard let text = text, let number = Int(text), number >= 0 else { return nil }
        return number
    }
    
    func makeCellViewModels() {
        if let numberOfCells = validatedNumber {
            for i in 0..<numberOfCells {
                let newCellViewModel = GenericCellViewModel()
                newCellViewModel.parentViewModelDelegate = self
                newCellViewModel.data = i
                cellViewModels.append(newCellViewModel)
            }
        }
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        return cellViewModels.count
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> GenericCellViewModel? {
        guard cellViewModels.indices.contains(indexPath.row) else { return nil }
        return cellViewModels[indexPath.row]
    }
    
    func prepareData() {}
}

extension NumbersListViewModel: GenericCellsParentViewModelDelegate {
    func didTapCell(viewModel: GenericCellViewModel) {
        guard let index = cellViewModels.firstIndex(where: { $0 == viewModel }) else { return }
        userDidSelectCell?(index)
    }
}
