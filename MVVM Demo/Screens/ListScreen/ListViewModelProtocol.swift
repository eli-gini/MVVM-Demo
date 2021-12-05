//
//  ListViewModel.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 05/12/2021.
//

import Foundation

protocol ListViewModel: AnyObject {
    var cellViewModels: [GenericCellViewModel] { get set }
    var errorMode: Bool { get set }
    var delegate: ListViewModelDelegate? { get set }
    func userDidEnterText(_ text: String?)
    func userDidTapGoButton()
    func numberOfItemsInSection(section: Int) -> Int
    func getCellViewModel(at indexPath: IndexPath) -> GenericCellViewModel?
}

extension ListViewModel {
    func numberOfItemsInSection(section: Int) -> Int {
        return cellViewModels.count
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> GenericCellViewModel? {
        guard cellViewModels.indices.contains(indexPath.row) else { return nil }
        return cellViewModels[indexPath.row]
    }
}
protocol ListViewModelDelegate: AnyObject {
    func willSwitchToErrorMode()
}
