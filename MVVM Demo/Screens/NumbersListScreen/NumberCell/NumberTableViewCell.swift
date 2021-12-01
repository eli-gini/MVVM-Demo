//
//  NumberTableViewCell.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 24/11/2021.
//

import UIKit

class NumberTableViewCell: UITableViewCell {

    @IBOutlet weak var numberCellLabel: UILabel!
    var viewModel: NumberCellViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
