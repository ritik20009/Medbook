//
//  IconCodeUtils.swift
//  DRAsignment
//
//  Created by Ritik Raj on 12/08/23.
//

import Foundation
import UIKit

enum IconCodeUtils: String {
    case shapeIcon = "shape"
    case landingIcon = "landing"
    
    var getImageId: String {
        switch self {
        case .landingIcon:
            return "landing"
        case .shapeIcon:
            return "shape"
        default:
            self.rawValue
        }
    }
}
