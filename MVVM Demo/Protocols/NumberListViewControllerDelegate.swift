//
//  NumberListViewControllerDelegate.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 24/11/2021.
//

import Foundation

protocol NumberListViewControllerDelegate: AnyObject {
    func didSelectNumber(_ number: Int)
}
