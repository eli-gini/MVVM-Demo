//
//  CitiesListViewModel.swift
//  MVVM Demo
//
//  Created by Eli Mehaudy on 05/12/2021.
//

import Foundation

class CitiesListViewModel: ListViewModelProtocol {
    
    var userDidSelectCell: ((Any) -> Void)?
    var delegate: ListViewModelDelegate?
    private var isErrorMode: Bool = false
    private var cellViewModels: [GenericTableCellViewModel] = []
    private let networkManager: NetworkManager
    private var citiesArray: [City] = [] {
        didSet {
            makeCellViewModels()
        }
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
        guard let text = text else {return}
        emptyArrays()
        fetchCities(with: text)
    }
    
    private func validateText(_ text: String?) -> Bool {
        guard let text = text , citiesArray.contains(where: { $0.name.contains(text)}) else { return false }
        return true
    }
    
    
    func userDidTapGoButton() {
        delegate?.willUpdateScreen()
    }
    
    func emptyArrays() {
        citiesArray.removeAll()
        cellViewModels.removeAll()
    }
    
    func userDidDismissAlert() {
        
    }
    
    //MARK: - Network Requests
    
    func prepareData() {
    }
    
    private func fetchCities(with text: String) {
        let stringURL = "https://data.gov.il/api/3/action/datastore_search?resource_id=5c78e9fa-c2e2-4771-93ff-7f400a12f7ba&limit=1266"
        networkManager.getRequest(url: stringURL) { [weak self] (response: ResultsData?, error) in
            response?.result?.records?.forEach({ [weak self] (city) in
                if city.cityName.contains(text) {
                    let newCity = City(cityName: city.cityName)
                    self?.citiesArray.append(newCity)
                }
            })
        }
    }
    
    // MARK: - Datasource Methods
    
    func numberOfItemsInSection(section: Int) -> Int {
        return cellViewModels.count
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> GenericTableCellViewModel? {
        guard cellViewModels.indices.contains(indexPath.row) else { return nil }
        return cellViewModels[indexPath.row]
    }
}

extension CitiesListViewModel: GenericTableCellsParentViewModelDelegate {
    
    func didTapCell(viewModel: GenericTableCellViewModel) {
        if let cityName = viewModel.data as? String {
            userDidSelectCell?(cityName)
        }
    }
}
