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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(viewModel: GenericCellViewModel, at indexPath: IndexPath) {
        self.viewModel = viewModel
        viewModel.delegate = self
        viewModel.loadValidNumber(indexPath.row)
    }
}

extension GenericCell: GenericCellViewModelDelegate {
    
    func didEnterValidNumber(_ number: Int) {
        numberCellLabel.text = number.description
    }
}
