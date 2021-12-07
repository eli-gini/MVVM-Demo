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
    func didTap(imageCellViewModel: ImageCellViewModel)
    func didLongPress(imageCellViewModel: ImageCellViewModel)
}

class ImageCellViewModel {
    
    weak var parentViewModelDelegate: ImagesCellParentViewModelDelegate?
    weak var delegate: ImageCellViewModelDelegate?
    private let imageLoader: ImageDownloadService
    private let uuid = UUID()
    private var isLoadedImage = false
    
    init(imageLoader: ImageDownloadService) {
        self.imageLoader = imageLoader
    }
    
    func load() {
        if !isLoadedImage {
            imageLoader.fetchImage { [weak self] image in
                if let image = image {
                    self?.isLoadedImage = true
                    self?.delegate?.didLoadImage(image)
                } else {
                    self?.delegate?.didFailWithError()
                }
            }
        }
    }
    
    func userDidTap() {
        parentViewModelDelegate?.didTap(imageCellViewModel: self)
    }
    
    func userDidLongPress() {
        parentViewModelDelegate?.didLongPress(imageCellViewModel: self)
    }
}

extension ImageCellViewModel: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
    static func == (lhs: ImageCellViewModel, rhs: ImageCellViewModel) -> Bool {
        return rhs.uuid == lhs.uuid
    }
    
    
}
