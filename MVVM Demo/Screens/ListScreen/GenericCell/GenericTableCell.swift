//
//  NumberTableViewCell.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 24/11/2021.
//

import UIKit
import Reusable

class GenericTableCell: UITableViewCell, NibReusable {
    
    @IBOutlet weak var genericCellLabel: UILabel!
    var viewModel: GenericTableCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpTapGesture()
    }
    
    func configure(viewModel: GenericTableCellViewModel, data: Any) {
        self.viewModel = viewModel
        viewModel.delegate = self
        viewModel.loadData(data)
        
    }
    
    private func setUpTapGesture() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(userDidTapCell))
        addGestureRecognizer(gesture)
    }
    
    @objc private func userDidTapCell() {
        viewModel?.userDidSelectCell()
    }
}

extension GenericTableCell: GenericTableCellViewModelDelegate {
    
    func didEnterValidInput(_ input: Any) {
        if let numericInput = input as? Int {
            genericCellLabel.text = numericInput.description
        } else if let stringInput = input as? String {
            genericCellLabel.text = stringInput
        }
    }
}
