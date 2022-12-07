//
//  TableViewCell.swift
//  BirthdayTracker
//
//  Created by roman Khilchenko on 22.06.2022.
//

import UIKit

final class TableViewCell: UITableViewCell {
    
    //MARK: - Private properties
    
    private lazy var nameLabel: UILabel = {
        setupLabel()
    }()
    
    private lazy var lastNameLabel: UILabel = {
        setupLabel()
    }()
    
    private lazy var BirthdLabel: UILabel = {
        setupLabel()
    }()
    
    //MARK: - Override methods
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public methods
    
    func setupSell(_ birthday: Birthday) {
        nameLabel.text = birthday.firstName
        lastNameLabel.text = birthday.lastName
        BirthdLabel.text = "\(birthday.birthDate)"
        
    }
    
    //MARK: - Private methods
    
    private func setupLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return label
    }
    
    private func setupLayout() {
        [nameLabel, lastNameLabel, BirthdLabel] .forEach { contentView.addSubview($0) }
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            
            lastNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            lastNameLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 5),
            
            BirthdLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            BirthdLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16)
        ])
    }
}


