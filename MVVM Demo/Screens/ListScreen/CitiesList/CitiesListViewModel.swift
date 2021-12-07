//
//  CitiesListViewModel.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 05/12/2021.
//

import Foundation

class CitiesListViewModel: ListViewModelProtocol {
    func userDidDismissAlert() {
        
    }
    
    
    var userDidSelectCell: ((Any) -> Void)?
    var delegate: ListViewModelDelegate?
    private var isErrorMode: Bool = false
    private var cellViewModels: [GenericTableCellViewModel] = []
    
    private let networkManager: NetworkManager
    private var filteredNSArray = NSArray()
    private var filteredCellViewModels: [GenericTableCellViewModel] = []
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
    
    private func makeCellViewModels() {
        let cellVM = GenericTableCellViewModel()
        cellVM.parentViewModelDelegate = self
        cellVM.data = citiesArray.last?.name
        cellViewModels.append(cellVM)
    }
    
    //MARK: - User Interaction Methods
    
    func userDidEnterText(_ text: String?) {
        if validateText(text) {
            let keypath = #keyPath(City.name)
            filteredNSArray = citiesAsNSArray.filtered(using: NSPredicate(format: "%K CONTAINS %@", keypath, text!)) as NSArray
        } else { isErrorMode = !validateText(text) }
    }
    
    private func validateText(_ text: String?) -> Bool {
        guard let text = text , citiesArray.contains(where: { $0.name.contains(text)}) else { return false }
        return true
    }
    
    
    func userDidTapGoButton(handler: (() -> Void)?) {
        filterCellViewModels(withContentsOf: filteredNSArray)
        handler?()
    }
    
    //MARK: - Filtering Methods
    
    private func convertNSArray(_ array: NSArray) -> [City]? {
        guard let array = array as? [City] else { return nil }
        return array
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
    
    //MARK: - Network Requests
    
    func prepareData() {
        fetchCities()
    }
    
    private func fetchCities() {
        let stringURL = "https://data.gov.il/api/3/action/datastore_search?resource_id=5c78e9fa-c2e2-4771-93ff-7f400a12f7ba&limit=1266"
        networkManager.getRequest(url: stringURL) { [weak self] (response: ResultsData?, error) in
            response?.result?.records?.forEach({ [weak self] (city) in
                let newCity = City(cityName: city.cityName)
                self?.citiesArray.append(newCity)
            })
            self?.delegate?.didFinishSuccessfullRequest()
        }
    }
    
    // MARK: - Datasource Methods
    
    func numberOfItemsInSection(section: Int) -> Int {
        return filteredCellViewModels.count
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> GenericTableCellViewModel? {
        guard filteredCellViewModels.indices.contains(indexPath.row) else { return nil }
        return filteredCellViewModels[indexPath.row]
    }
}

extension CitiesListViewModel: GenericTableCellsParentViewModelDelegate {
    
    func didTapCell(viewModel: GenericTableCellViewModel) {
        if let cityName = viewModel.data as? String {
            userDidSelectCell?(cityName)
        }
    }
}
