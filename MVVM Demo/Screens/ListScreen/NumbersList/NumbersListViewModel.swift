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
    var errorMode: Bool = false
    var delegate: ListViewModelDelegate?
    private var validatedNumber: Int?
    
    func userDidEnterText(_ text: String?) {
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
    
    func makeCellViewModels() {
        if let numberOfCells = validatedNumber {
            for _ in 0...(numberOfCells - 1) {
                let newViewModel = GenericCellViewModel()
                newViewModel.parentViewModelDelegate = self
                cellViewModels.append(newViewModel)
            }
        }
    }
}

extension NumbersListViewModel: GenericCellsParentViewModelDelegate {
    func didTapCell(viewModel: GenericCellViewModel) {
        guard let index = cellViewModels.firstIndex(where: { $0 == viewModel }) else { return }
        userDidSelectCell?(index)
    }
}
