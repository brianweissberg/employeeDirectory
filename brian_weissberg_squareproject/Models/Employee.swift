//
//  Employee.swift
//  brian_weissberg_squareproject
//
//  Created by Brian Weissberg on 8/19/22.
//

import Foundation

struct Response: Decodable {
    let employees: [Employee]
}

struct Employee: Decodable {
    let uuid: String
    let fullName: String
    let phoneNumber: String
    let emailAddress: String
    let biography: String
    let smallPhotoUrl: String
    let largePhotoUrl: String
    let team: String
    let employeeType: String

    enum CodingKeys: String, CodingKey {
        case uuid
        case fullName = "full_name"
        case phoneNumber = "phone_number"
        case emailAddress = "email_address"
        case biography
        case smallPhotoUrl = "photo_url_small"
        case largePhotoUrl = "photo_url_large"
        case team
        case employeeType = "employee_type"
    }
}
