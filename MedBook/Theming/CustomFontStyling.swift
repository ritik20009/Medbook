//
//  LeftRightButtonView.swift
//  MedBook
//
//  Created by Ritik Raj on 12/08/23.
//

import Foundation
import UIKit

public enum CustomFontStyle: String {
    case regular = "Degular-Regular"
    case bold = "Degular-Bold"
    case medium = "Degular-Medium"
    case semibold = "Degular-Semibold"
}

public extension UIFont {
    convenience init(_ size: CGFloat, style: CustomFontStyle) {
        self.init(name: style.rawValue, size: size)!
    }
}
