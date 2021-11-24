//
//  TextFieldError.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 24/11/2021.
//

import Foundation

enum TextFieldError: Error {
    case invalidCharacter
}

extension TextFieldError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .invalidCharacter:
            return "Invalid Input! Only positive whole numbers allowed!"
        }
    }
}
