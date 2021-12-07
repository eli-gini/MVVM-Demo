//
//  CitiesListViewModel.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 05/12/2021.
//

import Foundation

class CitiesListViewModel: ListViewModel {
    
    var userDidSelectCell: ((Any) -> Void)?
    var delegate: ListViewModelDelegate?
    var isErrorMode: Bool = false
    var cellViewModels: [GenericCellViewModel] = []
    
    private let networkManager: NetworkManager
    private var filteredNSArray = NSArray()
    private var filteredCellViewModels: [GenericCellViewModel] = []
    private var citiesArray: [City] = [] {
        didSet {
            makeCellViewModels()
            filteredCellViewModels = cellViewModels
        }
    }
    private var citiesAsNSArray: NSArray {
        citiesArray as NSArray
    }
    
    init(networkManager: NetworkManager) {
        self.networkManager = networkManager
    }

    func userDidEnterText(_ text: String?) {
        if validateText(text) {
            filteredNSArray = citiesAsNSArray.filtered(using: NSPredicate(format: "name CONTAINS %@", text!)) as NSArray
        } else { isErrorMode = !validateText(text) }
    }
    
    private func convertNSArray(_ array: NSArray) -> [City]? {
        guard let array = array as? [City] else { return nil }
        return array
    }
    
    private func validateText(_ text: String?) -> Bool {
        guard let text = text , citiesArray.contains(where: { $0.name.contains(text)}) else { return false }
        return true
    }
    
    func userDidTapGoButton(handler: (() -> Void)?) {
        filterCellViewModels(withContentsOf: filteredNSArray)
        handler?()
    }
    
    private func filterCellViewModels(withContentsOf array: NSArray) {
        guard let filteredCitiesArray = convertNSArray(array) else {return}
        filteredCellViewModels = cellViewModels.filter{ cellVM in
            guard let data = cellVM.data as? String else {return false}
            return filteredCitiesArray.contains(where: { city in
                data == city.name
            })
        }
    }
    
    func makeCellViewModels() {
        let cellVM = GenericCellViewModel()
        cellVM.data = citiesArray.last?.name
        cellViewModels.append(cellVM)
    }
    
    func prepareData() {
        fetchCities()
    }
    
    private func fetchCities() {
        let stringURL = "https://data.gov.il/api/3/action/datastore_search?resource_id=5c78e9fa-c2e2-4771-93ff-7f400a12f7ba"
        networkManager.getRequest(url: stringURL) { [weak self] (response: ResultsData?, error) in
            response?.result?.records?.forEach({ [weak self] (city) in
                let newCity = City(cityName: city.cityName)
                self?.citiesArray.append(newCity)
            })
            self?.delegate?.didFinishSuccessfullRequest()
        }
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        return filteredCellViewModels.count
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> GenericCellViewModel? {
        guard filteredCellViewModels.indices.contains(indexPath.row) else { return nil }
        return filteredCellViewModels[indexPath.row]
    }
}
