//
//  StorageBirthday.swift
//  BirthdayTracker
//
//  Created by roman Khilchenko on 15.06.2022.
//

import Foundation

class Birthday {
    
    var firstName: String
    var lastName: String
    var birthDate: Date
    
    init(firstName: String, lastName: String, birthDate: Date) {
        self.firstName = firstName
        self.lastName = lastName
        self.birthDate = birthDate
        
    }
}
