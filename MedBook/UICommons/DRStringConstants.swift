//
//  DRStringConstants.swift
//  DRAsignment
//
//  Created by Ritik Raj on 12/08/23.
//

import Foundation

struct DRStringConstants {
    static let medBook = "MedBook"
    static let signup = "Signup"
    static let login = "Login"
    static let whichTopicIntrestYouToday = "Which Topic Intrests you today?"
    static let logout = "Logout"
    static let welcome = "Welcome"
    static let loginMessage = "log in to Continue"
    static let email = "Email"
    static let password = "Password"
    static let error = "Error"
    static let signUpMessage = "Sign Up to Continue"
    static let minLengthMessage = "At least 8 Characters"
    static let upperCaseMessage = "Must contain an uppercase letter"
    static let specialCharacterMessage = "Contains a special character"
    static let loggedOutMessage = "Logged Out Successfully"
    static let letsGo = "Let's Go"
    static let rightArrow = "arrow.right"
    static let checkmark = "checkmark"
}

struct DRIntConstants {
    static let passwordMinLength = 8
}

struct DRRegexPatternConstant {
    static let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
}

struct DRKeyConstants {
    static let bookFill = "book.fill"
    static let loggenInUserKey = "loggedInUserKey"
}
