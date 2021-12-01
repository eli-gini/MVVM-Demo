//
//  ImagesCollectionViewController.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 28/11/2021.
//

import UIKit

class ImagesCollectionViewController: UIViewController {
    
    @IBOutlet private weak var imagesCollectionView: UICollectionView!
    var viewModel: ImagesCollectionViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func setUpView() {
        imagesCollectionView.dataSource = self
        imagesCollectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "imageCell")
        
        viewModel?.reloadTableViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.imagesCollectionView.reloadData()
            }
        }
    }
}

extension ImagesCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfCells ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = imagesCollectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCell,
           let cellVM = viewModel?.getCellViewModel(at: indexPath) {
            cell.delegate = self
            cell.setUpViewModel(viewModel: cellVM)
            return cell
        } else { return UICollectionViewCell() }
    }
}

extension ImagesCollectionViewController: ImageCellDelegate {
    func didLoadImage(in cell: ImageCell) {
        cell.cellImageView.image = cell.viewModel?.cellImage
    }
}



