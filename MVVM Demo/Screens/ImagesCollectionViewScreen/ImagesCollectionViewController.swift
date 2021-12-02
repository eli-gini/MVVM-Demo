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
        imagesCollectionView.delegate = self
        imagesCollectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "imageCell")
        viewModel?.delegate = self
    }
}

extension ImagesCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.numberOfItemsInSection(section: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = imagesCollectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCell,
           let cellVM = viewModel?.getCellViewModel(at: indexPath) {
            cell.configure(viewModel: cellVM)
            return cell
        } else { return UICollectionViewCell() }
    }
}

extension ImagesCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //viewModel.didSelectItemAt
        
//        viewModel?.cellViewModels.remove(at: indexPath.row)
    }
}

extension ImagesCollectionViewController: ImagesCollectionViewModelDelegate {
    func didUpdateData() {
        DispatchQueue.main.async {
            self.imagesCollectionView.reloadData()
        }
    }
}



