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
    var cellViewModels: [ImageCollectionCellViewModel] = []
    
    init(selectedNumber: Int) {
        self.selectedNumber = selectedNumber
        makeCellViewModels()
    }
    
    private func makeCellViewModels() {
        let imageLoader = ImageDownloadService()
        for _ in 0...selectedNumber - 1 {
            let newViewModel = ImageCollectionCellViewModel(imageLoader: imageLoader)
            newViewModel.parentViewModelDelegate = self
            cellViewModels.append(newViewModel)
        }
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> ImageCollectionCellViewModel? {
        guard cellViewModels.indices.contains(indexPath.row) else { return nil }
        return cellViewModels[indexPath.row]
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        return cellViewModels.count
    }
}

extension ImagesCollectionViewModel: ImagesCollectionCellParentViewModelDelegate {
    func didTap(imageCellViewModel: ImageCollectionCellViewModel) {
        didTapImageCell?()
    }
    
    func didLongPress(imageCellViewModel: ImageCollectionCellViewModel) {
        cellViewModels.removeAll(where: { $0 == imageCellViewModel })
        updateCellViewModels?()
    }
}
