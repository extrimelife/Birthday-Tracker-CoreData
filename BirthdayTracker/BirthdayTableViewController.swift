//
//  ViewController.swift
//  BirthdayTracker
//
//  Created by roman Khilchenko on 06.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var birthday = [StorageBirthday]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupNavigationController()
        makeBarButton()
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
    
    private func setupLayout() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
            
        ])
    }
    
    private func setupNavigationController() {
        let navigationBar = UINavigationBarAppearance()
        navigationBar.backgroundColor = .systemGray6
        self.navigationController?.navigationBar.standardAppearance =  navigationBar
        self.navigationController?.navigationBar.scrollEdgeAppearance = navigationBar
        self.navigationItem.title = "Дни Рождения"
        
    }
    
    // Создаю кнопку + в NavigationBar
    private func makeBarButton() {
        let buttonBar = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(actionTap))
        navigationItem.rightBarButtonItem = buttonBar
    }
    
    @objc private func actionTap() {
        let birthdayController = AddBirthdayController()
        let navigation = UINavigationController(rootViewController: birthdayController)
        present(navigation, animated: true)
    }
    
}

// MARK: - TableViewDataSource
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
       cell.setupSell(birthday)
        
        return cell
        
    }
}

// MARK: - TableViewDelegate
extension ViewController: UITableViewDelegate {
    
}
