//
//  MainViewModelDelegate.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 24/11/2021.
//

import Foundation

protocol MainViewModelDelegate: AnyObject {
    func titleWillChange(to title: String)
}
