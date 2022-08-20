//
//  EmployeeDirectoryController.swift
//  brian_weissberg_squareproject
//
//  Created by Brian Weissberg on 8/19/22.
//

import UIKit

final class EmployeeDirectoryController: UIViewController {
    let tableView: UITableView
    let coordinator: MainCoordinating
    let viewModel: EmployeesViewModel
    
    override func viewDidLoad() {
        setupTableView()
        configureRefreshControl()
        setupNavigation(viewModel.state)
    }

    init(viewModel: EmployeesViewModel, coordinator: MainCoordinating) {
        self.tableView = UITableView()
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError(TableViewConstants.initFatalError.rawValue)
    }
}

// - MARK: Setup TableView

extension EmployeeDirectoryController {
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EmployeeTableViewCell.self, forCellReuseIdentifier: TableViewConstants.cell.rawValue)
        setupTableViewConstraints()
    }

    private func setupTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }

    private func configureRefreshControl () {
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
        
    @objc func handleRefreshControl() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.tableView.refreshControl?.endRefreshing()
        }
    }
}

// - MARK: TableView DataSource and Delegate

extension EmployeeDirectoryController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.dataProvider.employees.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewConstants.cell.rawValue, for: indexPath) as? EmployeeTableViewCell ?? EmployeeTableViewCell()
        let employee = viewModel.dataProvider.employees[indexPath.row]
        cell.configure(employee, dataProvider: viewModel.dataProvider)
        return cell
    }
}

// - MARK: EmployeeViewModelDelegate

extension EmployeeDirectoryController: EmployeeViewModelDelegate {
    func parseEmployeesFailure(_ error: Error, state: UrlState) {
        DispatchQueue.main.async {
            let message = "\(error.localizedDescription)\(TableViewConstants.newLines.rawValue)\(state.rawValue)"
            let controller = UIAlertController(title: TableViewConstants.error.rawValue, message: message, preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: TableViewConstants.dismiss.rawValue, style: .cancel))
            self.present(controller, animated: true)
        }
    }
}

// MARK: - Navigation Items

extension EmployeeDirectoryController {
    private func setupNavigation(_ state: UrlState) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: TableViewConstants.test.rawValue, style: .plain, target: self, action: #selector(testTapped))
        setupNavigationTitle(state)
    }

    private func setupNavigationTitle(_ state: UrlState) {
        var title = TableViewConstants.emptyString.rawValue
        switch state {
        case .success:
            title = TableViewConstants.success.rawValue
        case .malformed:
            title = TableViewConstants.malformed.rawValue
        case .empty:
            title = TableViewConstants.empty.rawValue
        }
        self.title = title
    }
}

// MARK: - Test

extension EmployeeDirectoryController {
    @objc func testTapped() {
        let controller = UIAlertController(title: TableViewConstants.testAlertTitle.rawValue, message: nil, preferredStyle: .actionSheet)
        controller.addAction(UIAlertAction(title: TableViewConstants.success.rawValue, style: .default, handler: loadSuccessUrl))
        controller.addAction(UIAlertAction(title: TableViewConstants.malformed.rawValue, style: .default, handler:  loadSuccessUrl))
        controller.addAction(UIAlertAction(title: TableViewConstants.empty.rawValue, style: .default, handler:  loadSuccessUrl))
        controller.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(controller, animated: true)
    }

    private func loadSuccessUrl(action: UIAlertAction) {
        var state: UrlState = .success
        switch action.title {
        case TableViewConstants.malformed.rawValue:
            state = .malformed
        case TableViewConstants.empty.rawValue:
            state = .empty
        default:
            break
        }
        coordinator.showEmployeeDirectory(state: state)
    }
}
