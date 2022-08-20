//
//  EmployeeViewModel.swift
//  brian_weissberg_squareproject
//
//  Created by Brian Weissberg on 8/19/22.
//

import UIKit

protocol EmployeeViewModelDelegate: AnyObject {
    func parseEmployeesFailure(_ error: Error, state: UrlState)
}

class EmployeesViewModel {
    let dataProvider: EmployeesDataProviding
    let state: UrlState
    let networkManager: NetworkManaging
    let serviceManager: ServiceManaging
    weak var delegate: EmployeeViewModelDelegate?
    
    init(dataProvider: EmployeesDataProviding, state: UrlState = .success, networkManager: NetworkManaging = NetworkManager(), serviceManager: ServiceManaging = ServiceManager(), delegate: EmployeeViewModelDelegate? = nil) {
        self.dataProvider = dataProvider
        self.state = state
        self.networkManager = networkManager
        self.serviceManager = serviceManager
        self.delegate = delegate
        self.fetchData()
    }
    
    func fetchData() {
        guard let url = formUrl(state) else { return }
        networkManager.fetchData(url) { result in
            switch result {
            case .success(let data):
                self.serviceManager.parseEmployees(data: data) { result in
                    switch result {
                    case .success(let employees):
                        self.dataProvider.handleEmployees(employees)
                    case .failure(let error):
                        self.delegate?.parseEmployeesFailure(error, state: self.state)
                    }
                }
            case .failure(let error):
                self.delegate?.parseEmployeesFailure(error, state: self.state)
            }
        }
    }

    /// Returns URL for specific data state
    private func formUrl(_ state: UrlState) -> URL? {
        var urlStr = ""
        switch state {
        case .success:
            urlStr = UrlState.success.rawValue
        case .malformed:
            urlStr = UrlState.malformed.rawValue
        case .empty:
            urlStr = UrlState.malformed.rawValue
        }
        guard !urlStr.isEmpty, let url = URL(string: urlStr) else { return nil }
        return url
    }
}
