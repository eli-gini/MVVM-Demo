//
//  NumbersListViewController.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 23/11/2021.
//

import UIKit

class NumbersListViewController: UIViewController {

    @IBOutlet weak var numbersTableView: UITableView!
    @IBOutlet weak var numbersTextField: UITextField!
    var numberOfRows = 0
    
    var viewModel: NumbersListViewModel?
    weak var delegate: NumberListViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewController()
    }
    
    private func setUpViewController() {
        numbersTableView.dataSource = self
        numbersTableView.delegate = self
        numbersTableView.register(UINib(nibName: "NumberTableViewCell", bundle: nil), forCellReuseIdentifier: "numberCell")
    }
    
    @IBAction func goButtonTapped(_ sender: UIButton) {
        let numberTyped = viewModel?.checkTextFieldInput(viewController: self, textField: numbersTextField)
        if numberTyped != nil {
            numberOfRows = numberTyped!
            numbersTableView.reloadData()
        }
    }
}

extension NumbersListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = numbersTableView.dequeueReusableCell(withIdentifier: "numberCell", for: indexPath) as? NumberTableViewCell {
            cell.numberCellLabel.text = String(indexPath.row)
            return cell
        } else { return UITableViewCell() }
    }
}

extension NumbersListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectNumber(indexPath.row)
        viewModel?.returnToMain()
    }
}

protocol NumberListViewControllerDelegate: AnyObject {
    func didSelectNumber(_ number: Int)
}
