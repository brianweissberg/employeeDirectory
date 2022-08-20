//
//  EmployeesViewModelTests.swift
//  brian_weissberg_squareproject
//
//  Created by Brian Weissberg on 8/20/22.
//

import XCTest
@testable import brian_weissberg_squareproject

class EmployeesViewModelTests: XCTestCase {
    /// EmployeesViewModel has one function and that is to `fetchData`. Once that data is fetched, it is stored in the `dataSource` if the fetch is successful
    func testDataProviderSuccessJson() {
        let mockNetworkManager = MockNetworkManager()
        let dataProvider = EmployeesDataProvider(networkManager: mockNetworkManager)
        let viewModel = EmployeesViewModel(dataProvider: dataProvider, networkManager: mockNetworkManager, serviceManager: ServiceManager())
        XCTAssertEqual(viewModel.dataProvider.employees.count, 11)
    }

    /// EmployeesViewModel has one function and that is to `fetchData`. Once that data is fetched, if it cannot be serialized, then we need to call delegate method that serialization failed and also ensure than number of employees == 0 since data couldn't be serialized.
    func testDataProviderMalformedJson() {
        let mockNetworkManager = MockNetworkManager()
        let mockDelegate = EmployeesViewModelMockDelegate()
        let dataProvider = EmployeesDataProvider(networkManager: mockNetworkManager)
        let viewModel = EmployeesViewModel(dataProvider: dataProvider, state: .malformed, networkManager: mockNetworkManager, serviceManager: ServiceManager(), delegate: mockDelegate)
        viewModel.delegate = mockDelegate
        wait(for: [mockDelegate.expectation], timeout: 2.0)
        XCTAssertEqual(viewModel.dataProvider.employees.count, 0)
    }

    /// EmployeesViewModel has one function and that is to `fetchData`. Once that data is fetched, if it cannot be serialized, then we need to call delegate method that serialization failed and also ensure than number of employees == 0 since data couldn't be serialized.
    func testDataProviderEmptyJson() {
        let mockNetworkManager = MockNetworkManager()
        let mockDelegate = EmployeesViewModelMockDelegate()
        let dataProvider = EmployeesDataProvider(networkManager: mockNetworkManager)
        let viewModel = EmployeesViewModel(dataProvider: dataProvider, state: .empty, networkManager: mockNetworkManager, serviceManager: ServiceManager(), delegate: mockDelegate)
        wait(for: [mockDelegate.expectation], timeout: 2.0)
        XCTAssertEqual(viewModel.dataProvider.employees.count, 0)
    }
}
