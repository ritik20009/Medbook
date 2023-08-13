//
//  DRLoginView.swift
//  MedBook
//
//  Created by Ritik Raj on 12/08/23.
//

import UIKit

final class DRLoginView: UIView {
    //MARK: Internal property
    let pickerView = UIPickerView()
    var dataPickerData: [String]?
    var handleTapCompletion: ((User)->())?
    
    //MARK: Private properties
    private var emailValidated = false
    private var passwordValidated = false
    private let backGroundImageView: UIImageView = {
        let imageView = UIImageView()
        let imageName = IconCodeUtils.shapeIcon.getImageId
        imageView.image = UIImage(named: imageName)
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .init(.p28, style: .bold)
        label.textColor = .black
        label.text = DRStringConstants.welcome
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .init(.p28, style: .bold)
        label.textColor = .gray
        label.text = DRStringConstants.loginMessage
        return label
    }()
    
    private let validationErrorStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = CGFloat.p32
        stackView.alignment = .fill
        return stackView
    }()
    
    private let emailInputField: DRCustomTextField = {
        let textField = DRCustomTextField()
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(10, style: .bold),
            .foregroundColor: UIColor.gray
        ]
        textField.inputField.attributedPlaceholder =  NSAttributedString(string: DRStringConstants.email, attributes: placeholderAttributes)
        textField.inputField.textColor = .gray
        return textField
    }()
    
    private let passwordInputField: DRCustomTextField = {
        let textField = DRCustomTextField()
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont(10, style: .bold),
            .foregroundColor: UIColor.gray
        ]
        textField.inputField.isSecureTextEntry = true
        textField.inputField.attributedPlaceholder =  NSAttributedString(string: DRStringConstants.password, attributes: placeholderAttributes)
        textField.inputField.textColor = .gray
        return textField
    }()
    
    private let loginButton: DRButton = {
        let button = DRButton()
        button.layer.cornerRadius = .p4
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = .p2
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: NSCoder) not implemented")
    }
    
    func config(_ data: DRContentViewData) {
        loginButton.setupViews(title: data.buttonTitle, isRightIcon: true, tapHandler: { [weak self] in
            self?.submitData()
        })
        titleLabel.text = data.headerTitle
        subTitleLabel.text = data.headerSubtile
        
        emailInputField.inputField.placeholder = data.emailInputFieldData?.placeHolder
        if let validators = data.emailInputFieldData?.validators {
            emailInputField.setValidators(validators)
        }
        
        passwordInputField.inputField.placeholder = data.passwordFieldInputData?.placeHolder
        if let validators = data.passwordFieldInputData?.validators {
            passwordInputField.setValidators(validators)
        }
        
        if let validationFields = data.passwordValidationErrorFields {
            for validationField in validationFields {
                if let validationType = validationField.validationErrorType,
                   let titleText = validationField.titleText {
                    let checkbox = CheckboxWithTitleView(validationType: validationType)
                    checkbox.config(text: titleText)
                    checkbox.tag = validationType.rawValue
                    checkbox.changeState(isTicked: false)
                    validationErrorStackView.addArrangedSubview(checkbox)
                }
            }
        } else {
            validationErrorStackView.isHidden = true
        }
        
        if let dataPickerData = data.countryPickerData {
            self.dataPickerData = dataPickerData
            pickerView.reloadAllComponents()
        } else {
            pickerView.isHidden = true
        }
    }
    
    func updateCountriesData(_ countries: [String]) {
        self.dataPickerData = countries
        pickerView.reloadAllComponents()
    }
    
    private func submitData() {
        let email = emailInputField.getText()
        let password = passwordInputField.getText()
        let country = dataPickerData?[pickerView.selectedRow(inComponent: 0)]
        
        if (email.isEmpty) {
            emailInputField.updateBorderColor(.red)
        }
        
        if (password.isEmpty) {
            passwordInputField.updateBorderColor(.red)
        }
        
        if (password.isEmpty || email.isEmpty) {
            return
        }
        
        let user = User(email: email, password: password, country: country)
        handleTapCompletion?(user)
    }
}


private extension DRLoginView {
    func setupViews() {
        addSubview(backGroundImageView)
        backGroundImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(400)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.leading.equalTo(CGFloat.p16)
            make.trailing.equalTo(-CGFloat.p16)
        }
        
        addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.leading.equalTo(CGFloat.p16)
            make.trailing.equalTo(-CGFloat.p16)
        }
        
        addSubview(emailInputField)
        emailInputField.snp.makeConstraints { make in
            make.leading.equalTo(CGFloat.p16)
            make.trailing.equalTo(-CGFloat.p16)
            make.top.equalTo(subTitleLabel.snp.bottom).offset(CGFloat.p48)
        }
        emailInputField.validationObserver = { [weak self] validations in
            guard let self else { return }
            switch validations {
            case .validated:
                self.emailValidated = true
            default:
                self.emailValidated = false
            }
            self.toggleButtonStateIfNeeded()
        }
        
        
        addSubview(passwordInputField)
        passwordInputField.snp.makeConstraints { make in
            make.leading.equalTo(CGFloat.p16)
            make.trailing.equalTo(-CGFloat.p16)
            make.top.equalTo(emailInputField.snp.bottom).offset(CGFloat.p32)
        }
        passwordInputField.validationObserver = { [weak self] validation in
            guard let self else { return }
            switch validation {
            case .validated:
                self.setErrorStatesForPassword(errors: [])
                self.passwordValidated = true
            case .failed(let errors):
                self.passwordValidated = false
                self.setErrorStatesForPassword(errors: errors)
            default:
                self.passwordValidated = false
            }
            self.toggleButtonStateIfNeeded()
        }
        
        addSubview(validationErrorStackView)
        validationErrorStackView.snp.makeConstraints { make in
            make.leading.equalTo(CGFloat.p16)
            make.trailing.equalTo(-CGFloat.p16)
            make.top.equalTo(passwordInputField.snp.bottom).offset(CGFloat.p32)
        }
                
        addSubview(pickerView)
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.snp.makeConstraints { make in
            make.leading.equalTo(CGFloat.p16)
            make.trailing.equalTo(-CGFloat.p16)
            make.height.equalTo(140)
            make.top.equalTo(validationErrorStackView.snp.bottom).offset(CGFloat.p32)
        }
        
        addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.bottom.equalTo(-30)
            make.centerX.equalToSuperview()
        }
    }
    
    func toggleButtonStateIfNeeded() {
        loginButton.enableButton(emailValidated && passwordValidated)
    }
    
    func setErrorStatesForPassword(errors: [ValidationErrorType]) {
        for arrangedSubview in validationErrorStackView.arrangedSubviews {
            if let view = (arrangedSubview as? CheckboxWithTitleView) {
                view.changeState(isTicked: true)
            }
        }
        for error in errors {
            for arrangedSubview in validationErrorStackView.arrangedSubviews where arrangedSubview.tag == CheckBoxAssociatedValidation(errorType: error)?.rawValue {
                if let view = (arrangedSubview as? CheckboxWithTitleView) {
                    view.changeState(isTicked: false)
                }
            }
        }
    }
}


extension DRLoginView: UIPickerViewDelegate, UIPickerViewDataSource {
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return dataPickerData?.count ?? 0
        }
                
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return dataPickerData?[row]
        }
}
