//
//  Fonts.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 21.10.2021.
//

import Foundation
import UIKit

enum AppFonts {
    
    enum Style: String {
        case regular = "Regular"
        case medium = "Medium"
        case demiBold = "DemiBold"
        case black = "Black"
    }
    
    static func golos(style: Style, size: CGFloat) -> UIFont {
        return UIFont(name: "GolosText-\(style.rawValue)", size: size)!
    }
}
