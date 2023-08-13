//
//  DRButton.swift
//  DRAsignment
//
//  Created by Ritik Raj on 12/08/23.
//

import UIKit
import SnapKit

final class DRButton: UIView {
    private let button = UIButton()
    private var tapHandler: (()->())?
    private var buttonLeadingConstraint: Constraint?
    private var buttonTraillingConstraint: Constraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(title: String?, isRightIcon: Bool = false, tapHandler: (()->())?) {
        button.titleLabel?.font = UIFont(CGFloat.p16, style: .bold)
        button.setTitle(title, for: .normal)
        if isRightIcon {
            updateButtonOffsets()
            let image = UIImage(systemName: DRStringConstants.rightArrow)?.withTintColor(.gray) ?? .checkmark
            let title = AttributedTextwithImageSuffix(AttributeImage: image, AttributedText: title ?? "", buttonBound: button)
            button.setAttributedTitle(title, for: .normal)
        } else {
            button.setTitle(title, for: .normal)
        }
        button.setTitleColor(UIColor.gray, for: .normal)
        self.tapHandler = tapHandler
    }
    
    func updateTitleColor(_ color: UIColor) {
        button.titleLabel?.textColor = color
    }
    
    func enableButton(_ enable: Bool) {
        // Changing button state based on email and password validation
        if enable {
            self.backgroundColor = .clear
            updateTitleColor(.black)
        } else {
            self.backgroundColor = .gray
            updateTitleColor(.darkGray)
        }
        self.isUserInteractionEnabled = enable
    }
    
    @objc
    private func buttonTapped() {
        tapHandler?()
    }
}

private extension DRButton {
    func setUpViews() {
        addSubview(button)
        button.snp.makeConstraints { make in
            make.top.equalTo(CGFloat.p8)
            buttonLeadingConstraint = make.leading.equalTo(CGFloat.p16).constraint
            buttonTraillingConstraint = make.trailing.equalTo(-CGFloat.p16).constraint
            make.bottom.equalTo(-CGFloat.p8)
        }
        self.isUserInteractionEnabled = true
        button.isUserInteractionEnabled = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(buttonTapped))
        self.addGestureRecognizer(tap)
    }
    
    func updateButtonOffsets() {
        buttonLeadingConstraint?.update(offset: CGFloat.p32)
        buttonTraillingConstraint?.update(offset: -CGFloat.p32)
    }
    
    // To append image into title to set the title with suffix image as button title.
    
    func AttributedTextwithImageSuffix(AttributeImage : UIImage , AttributedText : String , buttonBound : UIButton) -> NSMutableAttributedString
        {
            let fullString = NSMutableAttributedString(string: AttributedText + "  ")
            let image1Attachment = NSTextAttachment()
            image1Attachment.bounds = CGRect(x: 0, y: ((buttonBound.titleLabel?.font.capHeight)! - AttributeImage.size.height).rounded() / 2, width: AttributeImage.size.width, height: AttributeImage.size.height)
            image1Attachment.image = AttributeImage
            let image1String = NSAttributedString(attachment: image1Attachment)
            fullString.append(image1String)
            fullString.append(NSAttributedString(string: ""))
            return fullString
        }
}
