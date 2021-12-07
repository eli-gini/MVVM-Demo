//
//  ImageCell.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 28/11/2021.
//

import UIKit
import Reusable

class ImageCollectionCell: UICollectionViewCell, NibReusable {
    
    @IBOutlet private weak var cellImageView: UIImageView!
    private var viewModel: ImageCollectionCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpGestures()
    }
    
    func configure(viewModel: ImageCollectionCellViewModel) {
        self.viewModel = viewModel
        viewModel.delegate = self
        viewModel.load()
    }
    
    private func setUpGestures() {
        setUpTapGesture()
        setUpLongPressGesture()
    }
    
    //MARK: - Gestures configuration
    
    private func setUpTapGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(userDidTap))
        addGestureRecognizer(gesture)
    }
    
    @objc private func userDidTap() {
        viewModel?.userDidTap()
    }
    
    private func setUpLongPressGesture() {
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(userDidLongPress))
        addGestureRecognizer(gesture)
    }
    
    @objc private func userDidLongPress(sender: UILongPressGestureRecognizer) {
        if sender.state == .ended {
            viewModel?.userDidLongPress()
        }
    }
}

extension ImageCollectionCell: ImageCollectionCellViewModelDelegate {
    func didLoadImage(_ image: UIImage) {
        cellImageView.image = image
    }
    
    func didFailWithError() {
        contentView.backgroundColor = .systemRed
    }
}
