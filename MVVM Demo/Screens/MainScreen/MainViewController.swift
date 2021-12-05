//
//  MainViewController.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 23/11/2021.
//

import UIKit

class MainViewController: UIViewController {
    
    var viewModel: MainViewModel
    @IBOutlet private weak var buttonLabel: UILabel!
    @IBOutlet private weak var dataPassedButton: UIButton!
    
    init (viewModel: MainViewModel) {
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
        viewModel.delegate = self
        configureTapGesture()
        configureDataPassedButton()
    }
    
    @objc private func changeToRandomBackGroundColor() {
        view.backgroundColor = .random
    }
    
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(changeToRandomBackGroundColor))
        tapGesture.numberOfTapsRequired = 6
        view.addGestureRecognizer(tapGesture)
    }
    
    private func configureDataPassedButton() {
        dataPassedButton.backgroundColor = .systemGreen
        dataPassedButton.layer.cornerRadius = 20
        dataPassedButton.layer.shadowColor = UIColor.gray.cgColor
        dataPassedButton.layer.shadowOffset = CGSize(width: 5, height: 5)
        dataPassedButton.layer.shadowOpacity = 0.8
    }
        
    @IBAction private func startButtonTapped(sender: UIButton) {
        viewModel.presentNumbersListVC()
    }
    
    @IBAction private func dataPassedButtonTapped(_ sender: UIButton) {
        viewModel.presentImagesCollectionVC()
    }
}

extension MainViewController: MainViewModelDelegate {
    func titleWillChange(to title: String) {
        buttonLabel.text = title
        
        dataPassedButton.isHidden = false
        dataPassedButton.titleLabel?.flash()
    }
}
