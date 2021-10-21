//
//  Appereance+UIButton.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 22.10.2021.
//

import Foundation
import UIKit

enum ButtonAppereance {
    case primary
    case secondary
}



extension UIButton {
    
    func appereance(_ appereance: ButtonAppereance) -> UIButton {
        let btn = self
        switch appereance {
        case .primary:
            btn.setTitleColor(.blue, for: .normal)
        case .secondary:
            btn.setTitleColor(.blue, for: .normal)
        }
        return btn
    }
    
}
