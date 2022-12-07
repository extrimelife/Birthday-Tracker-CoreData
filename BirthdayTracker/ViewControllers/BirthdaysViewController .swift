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
    
    private var birthdays = [Birthday]()
    
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
    
    // Создаю кнопку + в NavigationBar
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
}

// MARK: - TableViewDataSource

extension BirthdayViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        birthdays.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        let birthday = birthdays[indexPath.row]
        cell.setupSell(birthday)
        tableView.rowHeight = 80
        return cell
    }
}

// MARK: - TableViewDelegate

extension BirthdayViewController: UITableViewDelegate {
    
}


//MARK: - NewBirthdayViewControllerDelegate

extension BirthdayViewController: NewBirthdayViewControllerDelegate {
    func add(_ birthday:Birthday) {
        birthdays.append(birthday)
        tableView.reloadData()
    }
}

//MARK: - UINavigationController

extension BirthdayViewController {
    private func setupNavigationController() {
        title = "Birthday days"
        navigationController?.navigationBar.prefersLargeTitles = true
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        
        navigationController?.navigationBar.tintColor = .black
        
    }
}
