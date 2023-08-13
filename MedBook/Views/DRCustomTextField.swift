//
//  DRCustominputField.swift
//  MedBook
//
//  Created by Ritik Raj on 12/08/23.
//

import UIKit


final class DRCustomTextField: UIView {
    //MARK: Internal property
    let inputField: UITextField = {
        let inputField = UITextField()
        inputField.autocapitalizationType = .none
        return inputField
    }()
    
    var validationObserver: ((ValidationStatus)->())?
    
    //MARK: Private properties
    
    private let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    private var validators: [ValidationType]?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }
    
    func updateBorderColor(_ color: UIColor) {
        borderView.backgroundColor = color
    }
    
    func setValidators(_ validators: [ValidationType]) {
        self.validators = validators
    }
    
    func getText() -> String {
        return inputField.text ?? ""
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: NSCoder) is not implemented")
    }
}

private extension DRCustomTextField {
    func setUpViews() {
        addSubview(inputField)
        inputField.addTarget(self, action: #selector(inputFieldDidChange(_:)), for: .editingChanged)
        inputField.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
        }
        
        addSubview(borderView)
        borderView.snp.makeConstraints { make in
            make.top.equalTo(inputField.snp.bottom).offset(CGFloat.p4)
            make.height.equalTo(1)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    @objc func inputFieldDidChange(_ textField: UITextField) {
        guard let currentText = textField.text,
              !currentText.isEmpty else {
            // Changing border color if textfield is Empty
            updateBorderColor(.gray)
            validationObserver?(.empty)
            return
        }
        
        if let validators, !validators.isEmpty {
            var validationErrors = [ValidationErrorType]()
            for validator in validators {
                if let currValidationStatus = currentText.validateFor(validationType: validator) {
                    validationErrors.append(currValidationStatus)
                }
            }
            if validationErrors.isEmpty {
                // If Validation successfull then green color border will be shown.
                updateBorderColor(.green)
                validationObserver?(.validated)
            } else {
                // If validation fails red color border will be shown to notify that there is an Error.
                updateBorderColor(.red)
                validationObserver?(.failed(validationErrors))
            }
        } else {
            updateBorderColor(.gray)
            self.validationObserver?(.validated)
        }
    }
}

extension DRCustomTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

enum ValidationType {
    case regex(String)
    case minLength(Int)
    case uppperCase
    case specialCharacter
}

enum ValidationStatus {
    case empty
    case validated
    case failed([ValidationErrorType])
}

enum ValidationErrorType {
    case regexFailed
    case minLengthFailed
    case upperCaseCharacterNotPresent
    case specialCharcterNotPresent
}

extension String {
    func validateFor(validationType: ValidationType) -> ValidationErrorType? {
        switch validationType {
        case .regex(let pattern):
            let regexTest = NSPredicate(format: "SELF MATCHES %@", pattern)
            if !regexTest.evaluate(with: self) {
                return .regexFailed
            }
            
        case .minLength(let minLength):
            if self.count < minLength {
                return .minLengthFailed
            }
        case .uppperCase:
            if !self.contains(where: { $0.isUppercase }) {
                return .upperCaseCharacterNotPresent
            }
        case .specialCharacter:
            let characterSet = CharacterSet.alphanumerics.inverted
            if self.rangeOfCharacter(from: characterSet) == nil {
                return .specialCharcterNotPresent
            }
        }
        return nil
    }
}

