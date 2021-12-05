//
//  CitiesListViewModel.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 05/12/2021.
//

import Foundation

class CitiesListViewModel: ListViewModel {
    
    var userDidSelectCell: ((Any) -> Void)?
    var cellViewModels: [GenericCellViewModel] = []
    var errorMode: Bool = false
    var delegate: ListViewModelDelegate?

    func userDidEnterText(_ text: String?) {
        
    }
    
    func userDidTapGoButton() {
        
    }
    
    func makeCellViewModels() {
        
    }
}
