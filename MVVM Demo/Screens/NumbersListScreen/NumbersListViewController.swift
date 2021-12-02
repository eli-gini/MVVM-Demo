//
//  NumbersListViewController.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 23/11/2021.
//

import UIKit


protocol NumberListViewControllerDelegate: AnyObject {
    func didSelectNumber(number: Int)
}

class NumbersListViewController: UIViewController {
    
    @IBOutlet private weak var numbersTableView: UITableView!
    @IBOutlet private weak var numbersTextField: UITextField!
    private var numberOfRows = 0
    
    var viewModel: NumbersListViewModel?
    weak var delegate: NumberListViewControllerDelegate?
    
    //MARK: - VIewController Set Up Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewController()
    }
    
    private func setUpViewController() {
        viewModel?.delegate = self
        numbersTextField.delegate = self
        numbersTableView.dataSource = self
        numbersTableView.delegate = self
        numbersTableView.register(UINib(nibName: "NumberTableViewCell", bundle: nil), forCellReuseIdentifier: "numberCell")
    }
    
    @IBAction private func goButtonTapped(_ sender: UIButton) {
        viewModel?.userDidTapGoButton(viewController: self)
        numbersTableView.reloadData()
    }
    
    //MARK: - UIAlertController Methods
    
    private func showAlert(message: String) {
        let alert = createAlert(message: message)
        present(alert, animated: true, completion: nil)
    }
    
    private func createAlert(message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            self.toggleErrorMode()
        })
        alert.addAction(action)
        return alert
    }
    
    //MARK: - Error Mode Methods
    
    private func manageBackgroundColor() {
        if let viewModel = viewModel {
            view.backgroundColor = viewModel.errorMode ? .systemRed : .systemBackground
        }
    }
    
    private func errorModeSwitch() {
        toggleErrorMode()
        showAlert(message: TextFieldError.invalidCharacter.description)
    }
    
    private func toggleErrorMode() {
        if let viewModel = viewModel {
            viewModel.errorMode = !viewModel.errorMode
            manageBackgroundColor()
        }
    }
}

//MARK: - UITableViewDataSource

extension NumbersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfItemsInSection(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = numbersTableView.dequeueReusableCell(withIdentifier: "numberCell", for: indexPath) as? GenericCell,
              let cellVM = self.viewModel?.getCellViewModel(at: indexPath) else { return UITableViewCell() }
        cell.configure(viewModel: cellVM, at: indexPath)
//        cell.numberCellLabel.text = String(indexPath.row)
        return cell
    }
}

//MARK: - UITableViewDelegate

extension NumbersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectNumber(number: indexPath.row)
        viewModel?.willDismissController?()
    }
}

//MARK: - UITextFieldDelegate

extension NumbersListViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel?.userDidEnterText(text: numbersTextField.text)
    }
}

//MARK: NumberListViewModelDelegate

extension NumbersListViewController: NumberListViewModelDelegate {
    func willSwitchToErrorMode() {
        errorModeSwitch()
    }
    

}

