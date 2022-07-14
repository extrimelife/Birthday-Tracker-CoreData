//
//  IdentifierForTableView.swift
//  BirthdayTracker
//
//  Created by roman Khilchenko on 16.06.2022.
//

import Foundation
import UIKit

extension UIView {
    static var identifier: String {
        return String(describing: self)
    }
}
