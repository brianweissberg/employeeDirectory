//
//  EmployeeViewModel.swift
//  brian_weissberg_squareproject
//
//  Created by Brian Weissberg on 8/19/22.
//

import UIKit

class EmployeeViewModel {
    private(set) var largePhoto = UIImage(named: "royaltyFreePlaceholder")
    private(set) var biography: String = ""
    let uuid: String
    let fullName: String
    let phoneNumber: String
    let emailAddress: String
    let team: String
    let employeeType: String
    let largePhotoUrl: String
    
    init(employee: Employee) {
        self.uuid = employee.uuid
        self.fullName = employee.fullName
        self.phoneNumber = employee.phoneNumber
        self.emailAddress = employee.emailAddress
        self.biography = employee.biography
        self.team = employee.team
        self.employeeType = employee.employeeType
        self.largePhotoUrl = employee.largePhotoUrl
        self.biography = configureBiography()
    }

    func updateLargePhoto(_ image: UIImage) {
        self.largePhoto = image
    }

    private func configureBiography() -> String {
        let type = configureEmployeeType(self.employeeType)
        return "\(type) \(TableViewConstants.pipeSymbol.rawValue) \(biography)"
    }

    private func configureEmployeeType(_ str: String) -> String {
        str.replacingOccurrences(of: TableViewConstants.underscoreSymbol.rawValue, with: TableViewConstants.blankSpace.rawValue).capitalized
    }
}
