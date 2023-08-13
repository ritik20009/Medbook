//
//  DRHomePageView.swift
//  DRAsignment
//
//  Created by Ritik Raj on 12/08/23.
//

import UIKit

final class DRHomePageView: UIView {
    //MARK: Private properties
    private let imageView = UIImageView()
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.font = .init(.p32, style: .bold)
        label.textColor = UIColor.black
        return label
    }()
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .init(.p32, style: .bold)
        label.numberOfLines = 0
        label.textColor = UIColor.black
        return label
    }()
    private let logoutButton: UILabel = {
        let label = UILabel()
        label.font = .init(.p16, style: .bold)
        label.textColor = UIColor.red
        return label
    }()
    
    var logoutObserver: (()->())? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpData()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpData() {
        imageView.image = UIImage(systemName: DRKeyConstants.bookFill)?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal)
        headerLabel.text = DRStringConstants.medBook
        subtitleLabel.text = DRStringConstants.whichTopicIntrestYouToday
        logoutButton.text = DRStringConstants.logout
    }
    
    @objc
    private func logoutTapHandle() {
        logoutObserver?()
    }
}

private extension DRHomePageView {
    
    func setUpView() {
        addSubview(imageView)
        addSubview(headerLabel)
        addSubview(subtitleLabel)
        addSubview(logoutButton)
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(100)
            make.leading.equalTo(CGFloat.p16)
            make.height.width.equalTo(CGFloat.p32)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.centerY.equalTo(imageView.snp.centerY)
            make.leading.equalTo(imageView.snp.trailing).offset(CGFloat.p8)
            make.trailing.equalTo(-CGFloat.p16)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(CGFloat.p32)
            make.leading.equalTo(CGFloat.p16)
            make.trailing.equalTo(-CGFloat.p16)
            make.bottom.lessThanOrEqualTo(-CGFloat.p32)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(-CGFloat.p48)
            make.leading.greaterThanOrEqualTo(CGFloat.p16)
            make.trailing.lessThanOrEqualTo(-CGFloat.p16)
        }
        logoutButton.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(logoutTapHandle))
        logoutButton.addGestureRecognizer(tap)
    }
}

