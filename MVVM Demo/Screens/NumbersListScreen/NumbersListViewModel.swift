//
//  NumbersListViewModel.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 23/11/2021.
//

import Foundation
import UIKit

class NumbersListViewModel {
    
    var willDismissController: (()-> Void)?
    var validatedNumber: Int?
    private var errorMode: Bool = false
    
    func userDidEnterText(text: String?) {
        if let number = validateNumericText(text: text) {
            validatedNumber = number
        } else {
            validatedNumber = nil
        }
    }
    
    func userDidTapGoButton(viewController: UIViewController) {
        if validatedNumber == nil {
            errorModeSwitch(in: viewController)
        }
    }
    
    private func validateNumericText(text: String?)-> Int? {
        guard let text = text, let number = Int(text), number >= 0 else {
            return nil
        }
        return number
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
