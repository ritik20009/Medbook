//
//  CheckBoxWithTitleView.swift
//  MedBook
//
//  Created by Ritik Raj on 13/08/23.
//

import UIKit

final class CheckboxWithTitleView: UIView {
    let validationType: CheckBoxAssociatedValidation
    private let checkbox: UIView = {
        let checkBox = UIView()
        checkBox.layer.cornerRadius = CGFloat.p4
        checkBox.layer.borderWidth = CGFloat.p2
        return checkBox
    }()
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: DRStringConstants.checkmark)?.withTintColor(.black, renderingMode: .alwaysOriginal)
        return imageView
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .init(.p12, style: .bold)
        label.textColor = .black
        return label
    }()
    
    init(validationType: CheckBoxAssociatedValidation) {
        self.validationType = validationType
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init?(coder aDecoder: NSCoder) not implemented")
    }
    
    func config(text: String) {
        titleLabel.text = text
    }
    
    func changeState(isTicked: Bool) {
        imageView.isHidden = !isTicked
    }
    
    private func setupView() {
        addSubview(checkbox)
        addSubview(titleLabel)
        
        checkbox.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.width.equalTo(CGFloat.p16)
            make.leading.equalToSuperview()
        }
        checkbox.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(CGFloat.p2)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(checkbox.snp.trailing).offset(10)
            make.trailing.equalToSuperview()
        }
    }
}


enum CheckBoxAssociatedValidation: Int {
    case minLength
    case upperCase
    case specialCharacter
    case other
    
    // To check validation of entered text(Email and Password)
    
    init?(errorType: ValidationErrorType) {
        switch errorType {
        case .regexFailed:
            self = .other
        case .minLengthFailed:
            self = .minLength
        case .upperCaseCharacterNotPresent:
            self = .upperCase
        case .specialCharcterNotPresent:
            self = .specialCharacter
        }
    }
}
