//
//  ListViewModel.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 05/12/2021.
//

import Foundation

protocol ListViewModelProtocol: AnyObject {
    var userDidSelectCell: ((Any) -> Void)? {get set}
    var delegate: ListViewModelDelegate? {get set}
    func prepareData()
    func userDidEnterText(_ text: String?)
    func userDidTapGoButton()
    func userDidDismissAlert()
    func numberOfItemsInSection(section: Int) -> Int
    func getCellViewModel(at indexPath: IndexPath) -> GenericTableCellViewModel?
}

protocol ListViewModelDelegate: AnyObject {
    func updateErrorMode(_ isErrorMode: Bool)
    func willUpdateScreen()
    func didFinishRequestWithError()
}
