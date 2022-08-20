//
//  ServiceManagerTests.swift
//  brian_weissberg_squareproject
//
//  Created by Brian Weissberg on 8/20/22.
//

import XCTest
@testable import brian_weissberg_squareproject

class ServiceManagerTests: XCTestCase {
    /// Using valid JSON, test `ServiceManager` to ensure it will serialize employee data successfully
    func testServiceManagerSuccessJson() {
        guard let jsonString = TestHelper.fetchMockJson(.success) else {
            XCTFail("JSON not found")
            return
        }
        let expectation = XCTestExpectation(description: "Expect success parse of data")
        let data = Data(jsonString.utf8)
        ServiceManager().parseEmployees(data: data) { result in
            switch result {
            case .success(_):
                expectation.fulfill()
            case .failure(_):
                XCTFail("Expected valid json to be serialized")
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }

    /// Using malformed JSON, test `ServiceManager` to ensure that malformed JSON cannot be serialized
    func testServiceManagerMalformedJson() {
        guard let jsonString = TestHelper.fetchMockJson(.malformed) else {
            XCTFail("JSON not found")
            return
        }
        let expectation = XCTestExpectation(description: "Expect failure when parsing data")
        let data = Data(jsonString.utf8)
        ServiceManager().parseEmployees(data: data) { result in
            switch result {
            case .success(_):
                XCTFail("Expect to not serialize malformed JSON")
            case .failure(let error):
                XCTAssertEqual(error.localizedDescription, "Successfully fetched data but unable to serialize data")
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }

    /// Using valid but **empty** JSON, test `ServiceManager` to ensure it will serialize
    func testServiceManagerEmptyJson() {
        guard let jsonString = TestHelper.fetchMockJson(.empty) else {
            XCTFail("JSON not found")
            return
        }
        let expectation = XCTestExpectation(description: "Expect to be able to serialize json")
        let data = Data(jsonString.utf8)
        ServiceManager().parseEmployees(data: data) { result in
            switch result {
            case .success(_):
                expectation.fulfill()
            case .failure(_):
                XCTFail("Even though JSON does not contain any employees, it is valid JSON and should be serialized")
            }
        }
        wait(for: [expectation], timeout: 2.0)
    }
}
