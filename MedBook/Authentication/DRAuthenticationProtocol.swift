//
//  LeftRightButtonView.swift
//  MedBook
//
//  Created by Ritik Raj on 13/08/23.
//

import Foundation

enum CustomError: String {
    case duplicateEmail
    case genericError
    case userNotFound
    case incorrectPassword
}

struct User: Codable {
    let email: String
    var password: String
    let country: String?
}

protocol DRAuthenticationProtocol {
    var dbManager: (DRDatabaseManager & UserSessionStorage) { get }
    var isUserLoggedIn: Bool { get }
    func registerUser(user: User, success: (()->()), failure: (CustomError)->())
    func validateUser(user: User, success: ((User)->()), failure: (CustomError)->())
    func logoutUser(success: (()->()), failure: (CustomError)->())
}
