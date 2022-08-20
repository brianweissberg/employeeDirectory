//
//  MockNetworkManager.swift
//  brian_weissberg_squareproject
//
//  Created by Brian Weissberg on 8/20/22.
//

@testable import brian_weissberg_squareproject
import Foundation

class MockNetworkManager: NetworkManaging {
    func fetchData(_ url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        var mockJson = ""
        switch url.absoluteString {
        case UrlState.success.rawValue:
            mockJson = TestHelper.fetchMockJson(.success) ?? ""
        case UrlState.malformed.rawValue:
            mockJson = TestHelper.fetchMockJson(.malformed) ?? ""
        case UrlState.empty.rawValue:
            mockJson = TestHelper.fetchMockJson(.empty) ?? ""
        default:
            return
        }
        guard !mockJson.isEmpty else { return }
        let data = Data(mockJson.utf8)
        completion(.success(data))
    }
}
