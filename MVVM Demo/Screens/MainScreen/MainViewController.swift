//
//  MainViewController.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 23/11/2021.
//

import UIKit

class MainViewController: UIViewController {
    
    var viewModel: MainViewModel?
    @IBOutlet private weak var buttonLabel: UILabel!
    @IBOutlet private weak var dataPassedButton: UIButton!
    
    private var tapCount = 0 {
        didSet {
            if tapCount % 6 == 0 {
                self.view.backgroundColor = .random
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    @objc private func countTaps() {
        tapCount += 1
    }
    
    private func setUpView() {
        viewModel?.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(countTaps))
        view.addGestureRecognizer(tapGesture)
        buttonLabel.text = "Start!"
        dataPassedButton.backgroundColor = .systemGreen
        dataPassedButton.layer.cornerRadius = 20
        dataPassedButton.layer.shadowColor = UIColor.gray.cgColor
        dataPassedButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        dataPassedButton.layer.shadowOpacity = 0.8
    }
        
    @IBAction private func startButtonPressed(sender: UIButton) {
        viewModel?.presentNumbersListVC()
    }
}

extension MainViewController: MainViewModelDelegate {
    func titleWillChange(to title: String) {
        buttonLabel.text = title
        
        dataPassedButton.isHidden = false
        dataPassedButton.titleLabel?.flash()
    }
}
