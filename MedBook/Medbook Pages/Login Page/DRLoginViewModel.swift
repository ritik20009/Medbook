//
//  DRLoginViewModel.swift
//  MedBook
//
//  Created by Ritik Raj on 13/08/23.
//

import Foundation

final class LoginViewModel {
    func getData() -> DRContentViewData {
        return DRContentViewData(
            headerTitle: DRStringConstants.welcome,
            headerSubtile: DRStringConstants.loginMessage,
            emailInputFieldData: TextFieldData(placeHolder: DRStringConstants.email, validators: [.regex(DRRegexPatternConstant.emailRegex)]),
            passwordFieldInputData: TextFieldData(placeHolder: DRStringConstants.password, validators: nil),
            passwordValidationErrorFields: nil,
            countryPickerData: nil,
            buttonTitle: DRStringConstants.login)
    }
}
