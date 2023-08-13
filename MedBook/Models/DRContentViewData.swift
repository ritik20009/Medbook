//
//  DRContentViewData.swift
//  MedBook
//
//  Created by Ritik Raj on 12/08/23.
//

import Foundation

struct DRContentViewData {
    let headerTitle: String?
    let headerSubtile: String?
    let emailInputFieldData: TextFieldData?
    let passwordFieldInputData: TextFieldData?
    let passwordValidationErrorFields: [PasswordValidationFields]?
    let countryPickerData: [String]?
    let buttonTitle: String?
}

struct TextFieldData {
    let placeHolder: String?
    let validators: [ValidationType]?
}

struct PasswordValidationFields {
    let validationErrorType: CheckBoxAssociatedValidation?
    let titleText: String?
}
