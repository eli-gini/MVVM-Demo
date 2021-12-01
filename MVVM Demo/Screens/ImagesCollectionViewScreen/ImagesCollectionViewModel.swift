//
//  ImageCollectionViewModel.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 28/11/2021.
//

import UIKit
import EzImageLoader
import EzHTTP

class ImagesCollectionViewModel {
    
    private var selectedNumber: Int
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    private var cellViewModels = [ImageCellViewModel]()
    {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var reloadTableViewClosure: (()->())?
    
    init(selectedNumber: Int) {
        self.selectedNumber = selectedNumber
    }
    
    func initChildViewModel() {
        for i in 0...selectedNumber {
            let newViewModel = ImageCellViewModel()
            getImageView { image in
                self.cellViewModels[i].cellImage = image
            }
            self.cellViewModels.append(newViewModel)
        }
    }
    
    func getImageView(completion: @escaping ((UIImage?)-> Void)) {
        let imageView = UIImageView()
        ImageLoader.get("https://picsum.photos/200", nocache: true) {
            imageView.image = $0.image
            completion(imageView.image)
        }
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> ImageCellViewModel? {
        return cellViewModels[indexPath.row]
    }
}
