//
//  DRLandingPageView.swift
//  DRAsignment
//
//  Created by Ritik Raj on 12/08/23.
//

import UIKit
import SnapKit

final class DRLandingPageView: UIView {
    // MARK: Internal properties
    var loginTapHandler: (()->())?
    var signupTapHandler: (()->())?
    
    //MARK: Private properties
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = .init(.p32, style: .bold)
        return label
    }()
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let landingPageImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.alignment = .center
        view.spacing = CGFloat.p16
        view.axis = .horizontal
        view.distribution = .fillEqually
        return view
    }()
    
    init(frame: CGRect = .zero,
         loginTapHandler: (()->())?,
         signupTapHandler: (()->())?) {
        super.init(frame: frame)
        self.backgroundColor = .BG.bgDefault
        self.loginTapHandler = loginTapHandler
        self.signupTapHandler = signupTapHandler
        setupViews()
        setupData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupData() {
        headerLabel.text = DRStringConstants.medBook
        imageView.image = UIImage(named: IconCodeUtils.shapeIcon.rawValue)
        landingPageImageView.image = UIImage(named: IconCodeUtils.landingIcon.rawValue)
        self.setLeftButton()
        self.setRightButton()
    }
    
    private func setLeftButton() {
        let leftButton = DRButton()
        leftButton.isUserInteractionEnabled = true
        leftButton.layer.borderWidth = 2
        leftButton.layer.cornerRadius = CGFloat.p12
        leftButton.layer.borderColor = UIColor.black.cgColor
        leftButton.setupViews(title: DRStringConstants.signup,
                              tapHandler: signupTapHandler)
        stackView.addArrangedSubview(leftButton)
    }
    
    private func setRightButton() {
        let rightButton = DRButton()
        rightButton.isUserInteractionEnabled = true
        rightButton.layer.borderColor = UIColor.black.cgColor
        rightButton.layer.borderWidth = CGFloat.p2
        rightButton.layer.cornerRadius = CGFloat.p12
        rightButton.setupViews(title: DRStringConstants.login,
                               tapHandler: loginTapHandler)
        stackView.addArrangedSubview(rightButton)
    }
}


private extension DRLandingPageView {
    
    func setupViews() {
        addSubview(imageView)
        addSubview(landingPageImageView)
        addSubview(headerLabel)
        addSubview(stackView)
        
        imageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.height / 2.5)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.leading.equalTo(CGFloat.p16)
            make.trailing.equalTo(-CGFloat.p16)
        }
                
        landingPageImageView.snp.makeConstraints { make in
            make.top.equalTo(headerLabel.snp.bottom).offset(CGFloat.p12)
            make.leading.trailing.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(CGFloat.p48)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-CGFloat.p48)
            make.height.equalTo(CGFloat.p48)
        }
    }
}
