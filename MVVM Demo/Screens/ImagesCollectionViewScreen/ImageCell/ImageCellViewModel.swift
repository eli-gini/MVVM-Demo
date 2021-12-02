//
//  ImageCellViewModel.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 28/11/2021.
//

import UIKit

protocol ImageCellViewModelDelegate: AnyObject {
    func didLoadImage(_ image: UIImage)
    func didFailWithError()
}

protocol ImagesCellParentViewModelDelegate: AnyObject {
    func didLongPress(imageCellViewModel: ImageCellViewModel)
}

class ImageCellViewModel {
    
    weak var parentViewModelDelegate: ImagesCellParentViewModelDelegate?
    weak var delegate: ImageCellViewModelDelegate?
    private let uuid = UUID()
    private var hasLoadedImage = false
    
    func load() {
        if !hasLoadedImage {
            let imageLoader = ImageLoaderWrapper()
            imageLoader.fetchImage { [weak self] image in
                if let image = image {
                    self?.hasLoadedImage = true
                    self?.delegate?.didLoadImage(image)
                } else {
                    self?.delegate?.didFailWithError()
                }
            }
        }
    }
    
    func userDidLongPress() {
        parentViewModelDelegate?.didLongPress(imageCellViewModel: self)
    }
}

extension ImageCellViewModel: Equatable {
    static func == (lhs: ImageCellViewModel, rhs: ImageCellViewModel) -> Bool {
        return rhs.uuid == lhs.uuid
    }
    
    
}
