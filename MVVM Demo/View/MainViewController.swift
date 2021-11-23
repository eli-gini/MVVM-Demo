//
//  MainViewController.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 23/11/2021.
//

import UIKit

class MainViewController: UIViewController {
    
    var viewModel: MainViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startButtonPressed(sender: UIButton) {
        viewModel?.presentNumbersListVC()
    }
}
