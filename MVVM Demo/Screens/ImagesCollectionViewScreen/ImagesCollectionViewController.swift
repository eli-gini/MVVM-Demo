//
//  ImagesCollectionViewController.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 28/11/2021.
//

import UIKit
import Reusable

class DiffableDataSource: UICollectionViewDiffableDataSource<Int, ImageCollectionCellViewModel> {}

class ImagesCollectionViewController: UIViewController, Reusable {
    
    @IBOutlet private weak var imagesCollectionView: UICollectionView!
    private let viewModel: ImagesCollectionViewModel
    
    private lazy var dataSource = DiffableDataSource(collectionView: imagesCollectionView) { collectionView, indexPath, itemIdentifier in
        let cell: ImageCollectionCell = collectionView.dequeueReusableCell(for: indexPath)
        guard let cellVM = self.viewModel.getCellViewModel(at: indexPath)
        else { return UICollectionViewCell() }
        cell.configure(viewModel: cellVM)
        return cell
    }
    
    init(viewModel: ImagesCollectionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func setUpView() {
        applySnapshot()
        imagesCollectionView.register(cellType: ImageCollectionCell.self)
        reloadData()
    }
    
    private func applySnapshot() {
            var snapshot = NSDiffableDataSourceSnapshot<Int, ImageCollectionCellViewModel>()
            snapshot.appendSections([0])
            snapshot.appendItems(viewModel.cellViewModels, toSection: 0)
            dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func reloadData() {
        viewModel.updateCellViewModels = { [weak self] in
            self?.applySnapshot()
        }
    }
}



