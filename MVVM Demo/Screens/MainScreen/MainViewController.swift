//
//  MainViewController.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 23/11/2021.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet private weak var startButton: UIButton!
    @IBOutlet private weak var dataPassedButton: UIButton!
    private let viewModel: MainViewModel
    
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
        dataPassedButton.layer.cornerRadius = 20.0
        dataPassedButton.layer.shadowColor = UIColor.gray.cgColor
        dataPassedButton.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        dataPassedButton.layer.shadowOpacity = 0.8
        configureTapGesture()
    }
    
    private func updateButtonTitle(_ button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
    }
    
    private func unhideDataPassedButton() {
        dataPassedButton.isHidden = false
        dataPassedButton.titleLabel?.flash()
        configureDataPassedButton()
    }
        
    @IBAction private func startButtonTapped(sender: UIButton) {
        viewModel.userDidTapStartButton()
    }
    
    @IBAction private func dataPassedButtonTapped(_ sender: UIButton) {
        viewModel.userDidTapDataPassedButton()
    }
}

extension MainViewController: MainViewModelDelegate {
    func buttonWillUpdate<T>(using data: T) {
        if let number = data as? Int {
            updateButtonTitle(startButton, title: number.description)
            unhideDataPassedButton()
        } else if let title = data as? String {
            updateButtonTitle(dataPassedButton, title: title)
        }
    }
}
