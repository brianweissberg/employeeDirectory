//
//  NetworkManager.swift
//  brian_weissberg_squareproject
//
//  Created by Brian Weissberg on 8/19/22.
//

import Foundation

/// Each URL returns different qualities of data.
/// - success: Returns valid data
/// - malformed: Returns invalid data that isn't formed correctly. Use this for testing
/// - empty: Does not return any employee data
enum UrlState: String {
    case success = "https://s3.amazonaws.com/sq-mobile-interview/employees.json"
    case malformed = "https://s3.amazonaws.com/sq-mobile-interview/employees_malformed.json"
    case empty = "https://s3.amazonaws.com/sq-mobile-interview/employees_empty.json"
}

enum HTTPStatusCode: Int {
    case ok = 200
}

protocol NetworkManaging {
    func fetchData(_ url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}

class NetworkManager: NetworkManaging {
    func fetchData(_ url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == HTTPStatusCode.ok.rawValue  {
                completion(.success(data))
            }
        }
        task.resume()
    }
}
