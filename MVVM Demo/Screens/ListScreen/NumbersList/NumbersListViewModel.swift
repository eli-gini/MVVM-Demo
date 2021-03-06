//
//  NumbersListViewModel.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 23/11/2021.
//

import Foundation
import UIKit

class NumbersListViewModel: ListViewModelProtocol {    
    var userDidSelectCell: ((Any)-> Void)?
    var delegate: ListViewModelDelegate?
    var validatedNumber: Int?
    private var isErrorMode: Bool = false
    private var cellViewModels: [GenericTableCellViewModel] = []
    
    func userDidEnterText(_ text: String?) {
        if let number = validateNumericText(text: text) {
            validatedNumber = number
        } else {
            validatedNumber = nil
        }
    }
    
    func userDidTapGoButton() {
        if validatedNumber == nil {
            isErrorMode = true
            delegate?.updateErrorMode(isErrorMode)
        } else {
            resetCellViewModels()
            makeCellViewModels()
            delegate?.willUpdateScreen()
        }
    }
    
    func userDidDismissAlert() {
        isErrorMode = false
        delegate?.updateErrorMode(isErrorMode)
    }
    
    private func resetCellViewModels() {
        cellViewModels.removeAll()
    }
    
    private func validateNumericText(text: String?)-> Int? {
        guard let text = text, let number = Int(text), number >= 0 else { return nil }
        return number
    }
    
    private func makeCellViewModels() {
        if let numberOfCells = validatedNumber {
            for i in 0..<numberOfCells {
                let newCellViewModel = GenericTableCellViewModel()
                newCellViewModel.parentViewModelDelegate = self
                newCellViewModel.data = i
                cellViewModels.append(newCellViewModel)
            }
        }
    }
    
    
    func numberOfItemsInSection(section: Int) -> Int {
        return cellViewModels.count
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> GenericTableCellViewModel? {
        guard cellViewModels.indices.contains(indexPath.row) else { return nil }
        return cellViewModels[indexPath.row]
    }
    
    func prepareData() {}
}

extension NumbersListViewModel: GenericTableCellsParentViewModelDelegate {
    func didTapCell(viewModel: GenericTableCellViewModel) {
        guard let index = cellViewModels.firstIndex(where: { $0 == viewModel }) else { return }
        userDidSelectCell?(index)
    }
}
