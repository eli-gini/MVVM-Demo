//
//  MainViewController.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 23/11/2021.
//

import UIKit

class MainViewController: UIViewController {
    
    var viewModel: MainViewModel?
    @IBOutlet weak var buttonLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel?.delegate = self
        buttonLabel.text = "Start!"
    }
        
    @IBAction func startButtonPressed(sender: UIButton) {
        viewModel?.presentNumbersListVC()
    }
}

extension MainViewController: MainViewModelDelegate {
    func titleWillChange(to title: String) {
        buttonLabel.text = title
    }
}
