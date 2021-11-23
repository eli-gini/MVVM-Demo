//
//  MainViewModel.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 23/11/2021.
//

import Foundation

class MainViewModel {
    var didPressStart: (()->Void)?
    
    func presentNumbersListVC() {
        didPressStart?()
    }
}
