//
//  ViewController.swift
//  BirthdayTracker
//
//  Created by roman Khilchenko on 06.06.2022.
//

import UIKit

protocol NewBirthdayViewControllerDelegate {
    func add(_ birthday: Birthday)
}

final class BirthdayViewController: UIViewController {
    
    //MARK: - Private properties
    
    private var birthdays: [Birthday] = []
    private var filteredBirthday: [Birthday] = []
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorInset = .zero
        tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
        return tableView
    }()
    
    //MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupNavigationController()
        makeBarButton()
        fetchData()
        setupSearchBar()
    }
    
    //MARK: - Private methods
    
    private func setupLayout() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // Made button + в NavigationBar
    private func makeBarButton() {
        let buttonBar = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(actionTap))
        navigationItem.rightBarButtonItem = buttonBar
    }
    
    @objc private func actionTap() {
        let birthdayController = NewBirthdayController()
        birthdayController.delegate = self
        let navigation = UINavigationController(rootViewController: birthdayController)
        present(navigation, animated: true)
    }
    
    private func fetchData() {
        StorageManager.shared.fetchData { [unowned self] result in
            switch result {
            case .success(let birthday):
                birthdays = birthday
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.barTintColor = .white
        definesPresentationContext = true
        
    }
}

// MARK: - TableViewDataSource

extension BirthdayViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltering ? filteredBirthday.count : birthdays.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        let birthday = isFiltering ? filteredBirthday[indexPath.row] : birthdays[indexPath.row]
        cell.setupСell(birthday)
        tableView.rowHeight = 80
        return cell
    }
}

// MARK: - TableViewDelegate

extension BirthdayViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let birthday = birthdays.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            StorageManager.shared.delete(birthday)
        }
    }
}


//MARK: - NewBirthdayViewControllerDelegate

extension BirthdayViewController: NewBirthdayViewControllerDelegate {
    func add(_ birthday: Birthday) {
        birthdays.append(birthday)
        tableView.reloadData()
    }
}

//MARK: - UINavigationController

extension BirthdayViewController {
    private func setupNavigationController() {
        title = "Birthdays"
        navigationController?.navigationBar.prefersLargeTitles = true
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.tintColor = .black
    }
}

//MARK: - UiSearchResultsUptading

extension BirthdayViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContent(searchText: searchController.searchBar.text ?? "")
    }
    
    func filterContent(searchText: String) {
        filteredBirthday = birthdays.filter { birthay in
            birthay.firstName?.lowercased().contains(searchText.lowercased()) ?? false
        }
        tableView.reloadData()
    }
}
