//
//  AddBirthdayController.swift
//  BirthdayTracker
//
//  Created by roman Khilchenko on 07.06.2022.
//

import UIKit

class AddBirthdayController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = "Добавить ДР"
        self.navigationController?.navigationBar.backgroundColor = .systemGray6
        setupLayout()
        cancelButton()
        saveButton()
        
    }
    
    private let nameLabel: UILabel = {
        let labelName = UILabel()
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        labelName.text = "Имя"
        return labelName
    }()
    
    private let lastNameLabel: UILabel = {
        let labelLastName = UILabel()
        labelLastName.translatesAutoresizingMaskIntoConstraints = false
        labelLastName.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        labelLastName.text = "Фамилия"
        return labelLastName
    }()
    
    private let BirthdLabel: UILabel = {
        let labelBirthdDay = UILabel()
        labelBirthdDay.translatesAutoresizingMaskIntoConstraints = false
        labelBirthdDay.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        labelBirthdDay.text = "Дата Рождения"
        return labelBirthdDay
    }()
    
    private let textName: UITextField = {
        let nameText = UITextField()
        nameText.translatesAutoresizingMaskIntoConstraints = false
        nameText.backgroundColor = .white
        nameText.layer.cornerRadius = 12
        nameText.layer.borderWidth = 1
        nameText.layer.borderColor = UIColor.systemGray5.cgColor
        nameText.placeholder = "Введите имя"
        nameText.clearButtonMode = .whileEditing
        nameText.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: nameText.frame.height))
        nameText.leftViewMode = .always
        nameText.font = UIFont.systemFont(ofSize: 15)
        return nameText
    }()
    
    private let textLastName: UITextField = {
        let lastNameText = UITextField()
        lastNameText.translatesAutoresizingMaskIntoConstraints = false
        lastNameText.backgroundColor = .white
        lastNameText.layer.cornerRadius = 12
        lastNameText.layer.borderWidth = 1
        lastNameText.layer.borderColor = UIColor.systemGray5.cgColor
        lastNameText.placeholder = "Введите фамилию"
        lastNameText.clearButtonMode = .whileEditing
        lastNameText.leftView = UIView(frame: CGRect(x: 0, y: 10, width: 10, height: lastNameText.frame.height))
        lastNameText.leftViewMode = .always
        lastNameText.font = UIFont.systemFont(ofSize: 15)
        return lastNameText
    }()
    
    private let date: UIDatePicker = {
        let dateOfBirthday = UIDatePicker()
        dateOfBirthday.translatesAutoresizingMaskIntoConstraints = false
        dateOfBirthday.datePickerMode = .date
        dateOfBirthday.preferredDatePickerStyle = UIDatePickerStyle.wheels
        dateOfBirthday.maximumDate = Date()
        return dateOfBirthday
    }()
    
    // Функция для кнопки сохранить
    private func saveButton() {
        let buttonSave = UIBarButtonItem(title: "Сохранить", style: .plain, target: self, action: #selector(actionSave))
        self.navigationItem.rightBarButtonItem = buttonSave
    }
    
    @objc private func actionSave() {
        let firstName = textName.text ?? ""
        let secondName = textLastName.text ?? ""
        let birthdate = date.date
        let newBirthday = StorageBirthday(firstName: firstName, lastName: secondName, birthDate: birthdate)
        print("Создана запись о дне рождении")
        print("Имя \(newBirthday.firstName)")
        print("Фамилия \(newBirthday.lastName)")
        print("День Рождения: \(newBirthday.birthDate)")
    }
    
    // Функция для кнопки отмена
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
        [nameLabel, lastNameLabel, BirthdLabel, textName, textLastName, date].forEach { view.addSubview($0) }
        
        NSLayoutConstraint.activate([
            
            // Констрейнты для лейбла с Именем
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nameLabel.heightAnchor.constraint(equalToConstant: 21),
            nameLabel.widthAnchor.constraint(equalToConstant: 100),
            
            // Констрейнты для лейбла с Фамилией
            lastNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 50),
            lastNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            lastNameLabel.heightAnchor.constraint(equalToConstant: 21),
            lastNameLabel.widthAnchor.constraint(equalToConstant: 100),
            
            // Констрейнты для даты рождения
            BirthdLabel.topAnchor.constraint(equalTo: lastNameLabel.bottomAnchor, constant: 50),
            BirthdLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            BirthdLabel.heightAnchor.constraint(equalToConstant: 21),
            BirthdLabel.widthAnchor.constraint(equalToConstant: 200),
            
            // Констрейнты для текстфилда с именем
            textName.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            textName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textName.bottomAnchor.constraint(equalTo: lastNameLabel.topAnchor, constant: -5),
            textName.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            // Констрейнты для текстфилда с фамилией
            textLastName.topAnchor.constraint(equalTo: lastNameLabel.bottomAnchor, constant: 5),
            textLastName.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textLastName.bottomAnchor.constraint(equalTo: BirthdLabel.topAnchor, constant: -5),
            textLastName.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            // Констрейнты для окна с датой
            date.topAnchor.constraint(equalTo: BirthdLabel.bottomAnchor, constant: 10),
            date.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            date.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
            
        ])
    }
}


