//
//  ListViewModel.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 05/12/2021.
//

import Foundation

protocol ListViewModel: AnyObject {
    var userDidSelectCell: ((Any) -> Void)? {get set}
    var delegate: ListViewModelDelegate? {get set}
    var isErrorMode: Bool { get set }
    var cellViewModels: [GenericCellViewModel] {get set}
    func userDidEnterText(_ text: String?)
    func userDidTapGoButton(handler: (()->Void)?)
    func makeCellViewModels()
    func numberOfItemsInSection(section: Int) -> Int
    func getCellViewModel(at indexPath: IndexPath) -> GenericCellViewModel?
    func prepareData()
}

//extension ListViewModel {
//    private(set) var cellViewModels: [GenericCellViewModel] {
//        get {
//            return [GenericCellViewModel]()
//            }
//        set {
//            makeCellViewModels()
//        }
//    }
//}

protocol ListViewModelDelegate: AnyObject {
    func willSwitchToErrorMode()
    func didFinishSuccessfullRequest()
    func didFinishRequestWithError()
}
