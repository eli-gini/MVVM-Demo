//
//  ImageCell.swift
//  MVVM Demor
//
//  Created by Eli Mehaudy on 28/11/2021.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    @IBOutlet private weak var cellImageView: UIImageView!
    private var viewModel: ImageCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpLongPressGesture()
    }
    
    func configure(viewModel: ImageCellViewModel) {
        self.viewModel = viewModel
        self.viewModel?.delegate = self
        self.viewModel?.load()
    }
    
    private func setUpLongPressGesture() {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        self.addGestureRecognizer(gesture)
    }
    
    @objc private func longPress(sender: UILongPressGestureRecognizer) {
        print(sender.state.rawValue)
        if sender.state == .began {
            viewModel?.userDidLongPress()
        }
    }
}

extension ImageCell: ImageCellViewModelDelegate {
    func didLoadImage(_ image: UIImage) {
        cellImageView.image = image
    }
    
    func didFailWithError() {
        self.contentView.backgroundColor = .systemRed
    }
    
    
}

