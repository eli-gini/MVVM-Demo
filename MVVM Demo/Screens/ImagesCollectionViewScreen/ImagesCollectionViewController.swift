//
//  ImagesCollectionViewController.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 28/11/2021.
//

import UIKit

class DiffableDataSource: UICollectionViewDiffableDataSource<Int, ImageCellViewModel> {}

class ImagesCollectionViewController: UIViewController {
    
    @IBOutlet private weak var imagesCollectionView: UICollectionView!
    var viewModel: ImagesCollectionViewModel?
    
    private lazy var dataSource = DiffableDataSource(collectionView: imagesCollectionView) { collectionView, indexPath, itemIdentifier in
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCell,
              let cellVM = self.viewModel?.getCellViewModel(at: indexPath)
        else { return UICollectionViewCell() }
        cell.configure(viewModel: cellVM)
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func setUpView() {
        applySnapshot()
        imagesCollectionView.register(UINib(nibName: "ImageCell", bundle: nil), forCellWithReuseIdentifier: "imageCell")
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Int, ImageCellViewModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(viewModel!.cellViewModels, toSection: 0)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}



