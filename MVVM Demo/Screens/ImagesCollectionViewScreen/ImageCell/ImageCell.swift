//
//  ImageCell.swift
//  MVVM Demor
//
//  Created by Eli Mehaudy on 28/11/2021.
//

import UIKit

class ImageCell: UICollectionViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    var viewModel: ImageCellViewModel?
    
    weak var delegate: ImageCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    func setUpViewModel(viewModel: ImageCellViewModel) {
        self.viewModel = viewModel
        delegate?.didLoadImage(in: self)
    }
    
}

protocol ImageCellDelegate: AnyObject {
    func didLoadImage(in cell: ImageCell)
}
