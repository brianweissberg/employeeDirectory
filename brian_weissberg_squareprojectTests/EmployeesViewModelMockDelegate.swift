//
//  EmployeesViewModelMockDelegate.swift
//  brian_weissberg_squareproject
//
//  Created by Brian Weissberg on 8/20/22.
//

@testable import brian_weissberg_squareproject
import XCTest

class EmployeesViewModelMockDelegate: EmployeeViewModelDelegate {
    let expectation = XCTestExpectation(description: "Expect parse employees failure")
    func parseEmployeesFailure(_ error: Error, state: UrlState) {
        expectation.fulfill()
    }
}
