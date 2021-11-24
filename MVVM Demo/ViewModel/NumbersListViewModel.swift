//
//  NumbersListViewModel.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 23/11/2021.
//

import Foundation
import UIKit

class NumbersListViewModel {
    
    private var errorMode: Bool = false
    
    func checkTextFieldInput(viewController: UIViewController, textField: UITextField)-> Int {
        guard let text = textField.text, let number = Int(text) else {
            errorModeSwitch(in: viewController)
            return 0
        }
        if number > 0 {
            return number
        } else {
            errorModeSwitch(in: viewController)
            return 0
        }
    }
    
    private func showAlert(viewController: UIViewController, message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: { _ in
            self.errorMode = false
            self.manageBackground(in: viewController)
        })
        alert.addAction(action)
        viewController.present(alert, animated: true, completion: nil)
    }
    
    private func manageBackground(in viewController: UIViewController) {
        viewController.view.backgroundColor = errorMode ? .systemRed : .systemBackground
    }
    
    private func errorModeSwitch(in viewController: UIViewController) {
        errorMode = true
        showAlert(viewController: viewController, message: TextFieldError.invalidCharacter.description)
        manageBackground(in: viewController)
    }
}
