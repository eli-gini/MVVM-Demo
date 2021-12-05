//
//  NumberTableViewCell.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 24/11/2021.
//

import UIKit

class GenericCell: UITableViewCell {
    
    @IBOutlet weak var numberCellLabel: UILabel!
    var viewModel: GenericCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpTapGesture()
    }
    
    func configure(viewModel: GenericCellViewModel, indexPath: IndexPath) {
        self.viewModel = viewModel
        viewModel.delegate = self
        viewModel.loadNumbers(indexPath.row)
        
    }
    
    private func setUpTapGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(userDidTapCell))
        addGestureRecognizer(gesture)
    }
    
    @objc private func userDidTapCell() {
        viewModel?.userDidSelectCell()
    }
}

extension GenericCell: GenericCellViewModelDelegate {
    
    func didEnterValidNumber(_ number: Int) {
        numberCellLabel.text = number.description
    }
}
