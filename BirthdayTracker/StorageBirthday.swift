//
//  StorageBirthday.swift
//  BirthdayTracker
//
//  Created by roman Khilchenko on 15.06.2022.
//

import Foundation

class StorageBirthday {
    
    let firstName: String
    let lastName: String
    let birthDate: Date
    
    init(firstName: String, lastName: String, birthDate: Date) {
        self.firstName = firstName
        self.lastName = lastName
        self.birthDate = birthDate
        
    }
}
