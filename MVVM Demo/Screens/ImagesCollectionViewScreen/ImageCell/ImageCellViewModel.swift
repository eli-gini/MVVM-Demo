//
//  ImageCellViewModel.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 28/11/2021.
//

import UIKit

struct ImageCellViewModel {
    
    var cellImage: UIImage? {
        didSet {
            didLoadImage?()
        }
    }
    var didLoadImage: (()->Void)?

}
