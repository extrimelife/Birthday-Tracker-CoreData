//
//  TableViewCell.swift
//  BirthdayTracker
//
//  Created by roman Khilchenko on 22.06.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let whiteView: UIView = {
        let viewWhite = UIView()
        viewWhite.translatesAutoresizingMaskIntoConstraints = false
        return viewWhite
    }()
    
    private let nameLabel: UILabel = {
        let labelName = UILabel()
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        labelName.text = ""
        return labelName
    }()
    
    private let lastNameLabel: UILabel = {
        let labelLastName = UILabel()
        labelLastName.translatesAutoresizingMaskIntoConstraints = false
        labelLastName.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        labelLastName.text = ""
        return labelLastName
    }()
    
    private let BirthdLabel: UILabel = {
        let labelBirthdDay = UILabel()
        labelBirthdDay.translatesAutoresizingMaskIntoConstraints = false
        labelBirthdDay.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        labelBirthdDay.text = ""
        return labelBirthdDay
    }()
    
    func setupSell(_ birthday: [StorageBirthday]) {
        nameLabel.text = nameLabel.text
        lastNameLabel.text = lastNameLabel.text
        BirthdLabel.text = BirthdLabel.text
    }
    
    
    private func setupLayout() {
        [whiteView, nameLabel, lastNameLabel, BirthdLabel] .forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
        
            //MARK: Констрейны для ячейки
            whiteView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            whiteView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor),
            whiteView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            whiteView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor),
            
            //MARK: Констрейнты для имени
            nameLabel.topAnchor.constraint(equalTo: whiteView.topAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 16),
            
            //MARK: Констрейнты для фамилии
            lastNameLabel.topAnchor.constraint(equalTo: whiteView.topAnchor),
            lastNameLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 16),
            
            BirthdLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            BirthdLabel.leadingAnchor.constraint(equalTo: whiteView.leadingAnchor, constant: 16)
            
        ])
    }
    
    
    
}

    
