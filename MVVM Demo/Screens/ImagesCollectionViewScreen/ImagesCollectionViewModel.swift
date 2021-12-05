//
//  ImageCollectionViewModel.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 28/11/2021.
//

import UIKit

class ImagesCollectionViewModel {
    
    private var selectedNumber: Int
    var updateCellViewModels: (()->())?
    var didTapImageCell: (()->Void)?
    var cellViewModels: [ImageCellViewModel] = []
    
    init(selectedNumber: Int) {
        self.selectedNumber = selectedNumber
        makeCellViewModels()
    }
    
    private func makeCellViewModels() {
        for _ in 0...selectedNumber - 1 {
            let newViewModel = ImageCellViewModel()
            newViewModel.parentViewModelDelegate = self
            cellViewModels.append(newViewModel)
        }
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> ImageCellViewModel? {
        guard cellViewModels.indices.contains(indexPath.row) else { return nil }
        return cellViewModels[indexPath.row]
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        return cellViewModels.count
    }
}

extension ImagesCollectionViewModel: ImagesCellParentViewModelDelegate {
    func didTap(imageCellViewModel: ImageCellViewModel) {
        didTapImageCell?()
    }
    
    func didLongPress(imageCellViewModel: ImageCellViewModel) {
        cellViewModels.removeAll(where: { $0 == imageCellViewModel })
        updateCellViewModels?()
    }
}
