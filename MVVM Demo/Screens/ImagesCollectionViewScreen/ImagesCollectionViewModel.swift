//
//  ImageCollectionViewModel.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 28/11/2021.
//

import UIKit

protocol ImagesCollectionViewModelDelegate: AnyObject {
    func didUpdateData()
}

class ImagesCollectionViewModel {
    
    private var selectedNumber: Int
    weak var delegate: ImagesCollectionViewModelDelegate?
    
    var cellViewModels: [ImageCellViewModel] = [] {
        didSet {
            delegate?.didUpdateData()
        }
    }
    
    init(selectedNumber: Int) {
        self.selectedNumber = selectedNumber
        makeCellViewModels()
    }
    
    private func makeCellViewModels() {
        for _ in 0...selectedNumber {
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
    func didLongPress(imageCellViewModel: ImageCellViewModel) {
        guard let index = cellViewModels.firstIndex(where: {$0 == imageCellViewModel}) else { return }
        print("index: \(index)")
        cellViewModels.remove(at: index)
        delegate?.didUpdateData()
    }
}
