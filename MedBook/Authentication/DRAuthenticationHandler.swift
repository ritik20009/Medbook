//
//  LeftRightButtonView.swift
//  MedBook
//
//  Created by Ritik Raj on 13/08/23.
//

import Foundation

final class DRAuthenticationHandler: DRAuthenticationProtocol {
    var dbManager: (DRDatabaseManager & UserSessionStorage)
    
    init(dbManager: (DRDatabaseManager & UserSessionStorage)) {
        self.dbManager = dbManager
    }
    // Signup
    func registerUser(user: User, success: (() -> ()), failure: (CustomError) -> ()) {
        var usr = user
        usr.password = DRHasher.hash(usr.password)
        
        let dbUser: User? = dbManager.getKey(key: user.email)
        
        // If the user exists already with current entered email Id then this failure message will be presented.
        if dbUser != nil  {
            failure(.duplicateEmail)
        }
        else if dbManager.setKey(key: user.email, object: usr) == .failure {
            failure(.genericError)
        }
        else {
            success()
        }
    }
    
    // Login
    func validateUser(user: User, success: ((User) -> ()), failure: (CustomError) -> ()) {
        guard let dbUser: User = dbManager.getKey(key: user.email) else {
            failure(.userNotFound)
            return
        }
        
        // Encrypting the password for security Reasons with by hashing.
        if dbUser.password != DRHasher.hash(user.password) {
            failure(.incorrectPassword)
        }
        else {
            dbManager.loggedInUserEmail = dbUser.email
            success(dbUser)
        }
    }
    // removing the current logged in user to show the launch screen
    func logoutUser(success: (() -> ()), failure: (CustomError) -> ()) {
        dbManager.loggedInUserEmail = nil
        success()
    }
    
    // If User logged in then Home screen will be shown and if not then launch screen.
    var isUserLoggedIn: Bool {
        return dbManager.loggedInUserEmail != nil
    }
}
