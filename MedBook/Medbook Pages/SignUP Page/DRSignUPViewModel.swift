//
//  SignUPViewModel.swift
//  MedBook
//
//  Created by Ritik Raj on 13/08/23.
//

import Foundation

final class SignUpViewModel {
    var updateCountries: (([String])->())?
    
    func apiCall() {
        DRNetworkManager.shared.fetchResponse(api: CountriesAPI()) { [weak self] (data: CountriesData?) in
            var countries = [String]()
            if let countriesData = data?.data?.values {
                for countryData in countriesData where countryData.country != nil {
                    countries.append(countryData.country ?? "")
                }
            }
            self?.updateCountries?(countries.sorted())
        }
    }
    
    
    func getData() -> DRContentViewData {
        return DRContentViewData(
            headerTitle: DRStringConstants.welcome,
            headerSubtile: DRStringConstants.signUpMessage,
            emailInputFieldData: TextFieldData(placeHolder: DRStringConstants.email, validators: [.regex(DRRegexPatternConstant.emailRegex)]),
            passwordFieldInputData: TextFieldData(placeHolder: DRStringConstants.password, validators: [.minLength(DRIntConstants.passwordMinLength), .uppperCase, .specialCharacter]),
            passwordValidationErrorFields: [
                PasswordValidationFields(validationErrorType: .minLength, titleText: DRStringConstants.minLengthMessage),
                PasswordValidationFields(validationErrorType: .upperCase, titleText: DRStringConstants.upperCaseMessage),
                PasswordValidationFields(validationErrorType: .specialCharacter, titleText: DRStringConstants.specialCharacterMessage)
            ],
            countryPickerData: [],
            buttonTitle: DRStringConstants.letsGo)
    }
}
