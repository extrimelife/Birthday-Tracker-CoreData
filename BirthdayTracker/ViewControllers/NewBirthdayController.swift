//
//  AddBirthdayController.swift
//  BirthdayTracker
//
//  Created by roman Khilchenko on 07.06.2022.
//

import UIKit

class NewBirthdayController: UIViewController {
    
    //MARK: - Public properties
    
    var delegate: NewBirthdayViewControllerDelegate!
    
    //MARK: - Private properties
    
    private lazy var nameLabel: UILabel = {
        setupLabel(playceholder: "Имя")
    }()
    
    private lazy var lastNameLabel: UILabel = {
        setupLabel(playceholder: "Фамилия")
    }()
    
    private lazy var BirthdLabel: UILabel = {
        setupLabel(playceholder: "Дата Рождения")
    }()
    
    private lazy var textName: UITextField = {
        setupTextField(playceholder: "Введите имя")
    }()
    
    private lazy var textLastName: UITextField = {
        setupTextField(playceholder: "Введите фамилию")
    }()
    
    private let date: UIDatePicker = {
        let dateOfBirthday = UIDatePicker()
        dateOfBirthday.translatesAutoresizingMaskIntoConstraints = false
        dateOfBirthday.datePickerMode = .date
        dateOfBirthday.preferredDatePickerStyle = UIDatePickerStyle.wheels
        dateOfBirthday.maximumDate = Date()
        return dateOfBirthday
    }()
    
    //MARK: - Override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        cancelButton()
        saveButton()
        setupNavigationBar()
    }
    
    //MARK: - Private methods
    
    private func setupLabel(playceholder: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.text = playceholder
        return label
    }
    
    private func setupTextField(playceholder: String) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 12
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.systemGray5.cgColor
        textField.placeholder = playceholder
        textField.clearButtonMode = .whileEditing
        textField.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.font = UIFont.systemFont(ofSize: 15)
        textField.autocorrectionType = .no
        return textField
    }
    
    private func saveButton() {
        let buttonSave = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(actionSave))
        self.navigationItem.rightBarButtonItem = buttonSave
        
    }
    
    @objc private func actionSave() {
        if textName.text != "" && textLastName.text != "" {
            guard let firstName = textName.text else { return }
            guard let secondName = textLastName.text else { return }
            let date = date.date
            StorageManager.shared.create(firstName, secondName, date) { birthday in
                delegate?.add(birthday)
                dismiss(animated: true)
            }
        }
    }
    
    private func cancelButton() {
        let buttonCancel = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(actionCancel))
        self.navigationItem.leftBarButtonItem = buttonCancel
        
    }
    
    @objc private func actionCancel() {
        if textName.text == "" && textLastName.text == "" {
            self.dismiss(animated: true)
        }
        
        let alert = UIAlertController(title: "", message: "Вы действительно хотите отказаться от сохранения?", preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: "Отменить изменения", style: .destructive) { _ in
            self.dismiss(animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Продолжить редактирование", style: .destructive)
        alert.addAction(cancelAction)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        [nameLabel, lastNameLabel, BirthdLabel, textName, textLastName, date].forEach { view.addSubview($0) }
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nameLabel.heightAnchor.constraint(equalToConstant: 21),
            nameLabel.widthAnchor.constraint(equalToConstant: 100),
            
            lastNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 50),
            lastNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            lastNameLabel.heightAnchor.constraint(equalToConstant: 21),
            lastNameLabel.widthAnchor.constraint(equalToConstant: 100),
            
            BirthdLabel.topAnchor.constraint(equalTo: lastNameLabel.bottomAnchor, constant: 50),
            BirthdLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            BirthdLabel.heightAnchor.constraint(equalToConstant: 21),
            BirthdLabel.widthAnchor.constraint(equalToConstant: 200),
            
            textName.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            textName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textName.bottomAnchor.constraint(equalTo: lastNameLabel.topAnchor, constant: -5),
            textName.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            textLastName.topAnchor.constraint(equalTo: lastNameLabel.bottomAnchor, constant: 5),
            textLastName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textLastName.bottomAnchor.constraint(equalTo: BirthdLabel.topAnchor, constant: -5),
            textLastName.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            date.topAnchor.constraint(equalTo: BirthdLabel.bottomAnchor, constant: 10),
            date.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            date.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
}


//MARK: - Extension NavigationBar
extension NewBirthdayController {
    private func setupNavigationBar() {
        title = "Add Birthday"
        navigationController?.navigationBar.backgroundColor = .systemGray6
    }
}
