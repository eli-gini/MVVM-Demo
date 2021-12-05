//
//  NumbersListViewController.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 23/11/2021.
//

import UIKit
import Reusable

protocol ListViewControllerDelegate: AnyObject {
    func didSelectNumber(number: Int)
}

class ListViewController: UIViewController {
    
    @IBOutlet private weak var numbersTableView: UITableView!
    @IBOutlet private weak var numbersTextField: UITextField!
    private var numberOfRows = 0
    
    var viewModel: ListViewModel
    weak var delegate: ListViewControllerDelegate?
    
    //MARK: - VIewController Set Up Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewController()
    }
    
    init (viewModel: ListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpViewController() {
        viewModel.delegate = self
        numbersTextField.delegate = self
        numbersTableView.dataSource = self
        numbersTableView.register(cellType: GenericCell.self)
    }
    
    @IBAction private func goButtonTapped(_ sender: UIButton) {
        viewModel.userDidTapGoButton()
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
            view.backgroundColor = viewModel.errorMode ? .systemRed : .systemBackground
    }
    
    private func errorModeSwitch() {
        toggleErrorMode()
        showAlert(message: TextFieldError.invalidCharacter.description)
    }
    
    private func toggleErrorMode() {
            viewModel.errorMode = !viewModel.errorMode
            manageBackgroundColor()
    }
}

//MARK: - UITableViewDataSource

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: GenericCell = numbersTableView.dequeueReusableCell(for: indexPath)
        guard let cellVM = self.viewModel.getCellViewModel(at: indexPath) else { return UITableViewCell() }
        cell.configure(viewModel: cellVM, indexPath: indexPath)
        return cell
    }
}

//MARK: - UITextFieldDelegate

extension ListViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel.userDidEnterText(numbersTextField.text)
    }
}

//MARK: NumbersListViewModelDelegate

extension ListViewController: ListViewModelDelegate {
    func willSwitchToErrorMode() {
        errorModeSwitch()
    }
}

