//
//  NumbersListViewModel.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 23/11/2021.
//

import Foundation
import UIKit

class NumbersListViewModel {
    
    func checkTextFieldInput(viewController: UIViewController, textField: UITextField)-> Int {
        guard let text = textField.text, let number = Int(text) else {
            showAlert(viewController: viewController, message: TextFieldError.invalidCharacter.description)
            return 0
        }
        if number > 0 {
            return number
        } else {
            showAlert(viewController: viewController, message: TextFieldError.invalidCharacter.description)
            return 0
        }
    }
    
    func showAlert(viewController: UIViewController, message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(action)
        viewController.present(alert, animated: true, completion: nil)
    }
}
