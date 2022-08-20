//
//  ServiceManager.swift
//  brian_weissberg_squareproject
//
//  Created by Brian Weissberg on 8/19/22.
//

import Foundation

enum ServiceError: Error {
    case invalidData
}

extension ServiceError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidData:
            return "Successfully fetched data but unable to serialize data"
        }
    }
}

protocol ServiceManaging {
    func parseEmployees(data: Data, completion: @escaping (Result<[Employee], ServiceError>) -> Void )
}

class ServiceManager: ServiceManaging {
    func parseEmployees(data: Data, completion: @escaping (Result<[Employee], ServiceError>) -> Void ) {
        let decoder = JSONDecoder()
        do {
            let response = try decoder.decode(Response.self, from: data)
            let employees = response.employees
            completion(.success(employees))
        } catch {
            completion(.failure(ServiceError.invalidData))
        }
    }
}
