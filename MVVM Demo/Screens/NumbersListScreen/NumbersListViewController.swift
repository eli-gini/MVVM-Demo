//
//  NumbersListViewController.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 23/11/2021.
//

import UIKit

class NumbersListViewController: UIViewController {

    @IBOutlet private weak var numbersTableView: UITableView!
    @IBOutlet private weak var numbersTextField: UITextField!
    private var numberOfRows = 0
    
    var viewModel: NumbersListViewModel?
    weak var delegate: NumberListViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewController()
    }
    
    private func setUpViewController() {
        numbersTextField.delegate = self
        numbersTableView.dataSource = self
        numbersTableView.delegate = self
        numbersTableView.register(UINib(nibName: "NumberTableViewCell", bundle: nil), forCellReuseIdentifier: "numberCell")
    }
    
    @IBAction private func goButtonTapped(_ sender: UIButton) {
        viewModel?.userDidTapGoButton(viewController: self)
        numbersTableView.reloadData()
    }
}

extension NumbersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.validatedNumber ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = numbersTableView.dequeueReusableCell(withIdentifier: "numberCell", for: indexPath) as? NumberTableViewCell {
            cell.numberCellLabel.text = String(indexPath.row)
            return cell
        } else { return UITableViewCell() }
    }
}

extension NumbersListViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        viewModel?.userDidEnterText(text: numbersTextField.text)
    }
}

extension NumbersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectNumber(indexPath.row)
        viewModel?.willDismissController?()
    }
}
