//
//  EmployeeTableViewCell.swift
//  brian_weissberg_squareproject
//
//  Created by Brian Weissberg on 8/19/22.
//

import UIKit
import Foundation

final class EmployeeTableViewCell: UITableViewCell {

    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    public func configure(_ employee: EmployeeViewModel, dataProvider: EmployeesDataProviding) {
        resetCellProperties()
        employeeImage.image = employee.largePhoto
        dataProvider.fetchLargePhoto(employee) { image in
            DispatchQueue.main.async {
                self.employeeImage.image = image
            }
        }
        nameLabel.text = employee.fullName
        emailLabel.text = employee.emailAddress
        phoneLabel.text = employee.phoneNumber
        biographyLabel.text = employee.biography
    }

    private lazy var labelContainer: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 5
        stack.alignment = .leading
        return stack
    }()

    private lazy var employeeImage: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 50
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        return view
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = .preferredFont(forTextStyle: .title1)
        return label
    }()

    private lazy var biographyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()

    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = .preferredFont(forTextStyle: .caption1)
        return label
    }()

    private lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        label.font = .preferredFont(forTextStyle: .caption1)
        return label
    }()

    private func resetCellProperties() {
        employeeImage.image = nil
        nameLabel.text = TableViewConstants.emptyString.rawValue
        emailLabel.text = TableViewConstants.emptyString.rawValue
        phoneLabel.text = TableViewConstants.emptyString.rawValue
        biographyLabel.text = TableViewConstants.emptyString.rawValue
    }

    private func setup() {
        contentView.addSubview(labelContainer)
        labelContainer.addArrangedSubview(employeeImage)
        labelContainer.addArrangedSubview(nameLabel)
        labelContainer.addArrangedSubview(biographyLabel)
        labelContainer.addArrangedSubview(emailLabel)
        labelContainer.addArrangedSubview(phoneLabel)
        
        NSLayoutConstraint.activate([
            labelContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            labelContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            labelContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            labelContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            employeeImage.heightAnchor.constraint(equalToConstant: 100),
            employeeImage.widthAnchor.constraint(equalToConstant: 100),
        ])

    }
}
