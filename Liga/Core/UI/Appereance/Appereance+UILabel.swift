//
//  Appereance+UILabel.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 19.10.2021.
//

import UIKit

enum LabelAppereance {
    case medium // Для крупных тайтлов
    case primary
    case secondary
}

extension UILabel {
    
    func appereance(_ appereance: LabelAppereance) -> UILabel {
        let label = self
        switch appereance {
        case .medium:
            label.textColor = ColorPallete.Text.primary
            label.font = AppFonts.golos(style: .medium, size: 22.0)
        case .primary:
            label.textColor = ColorPallete.Text.primary
            label.font = AppFonts.golos(style: .regular, size: 14.0)
        case .secondary:
            label.textColor = ColorPallete.Text.secondary
            label.font = AppFonts.golos(style: .regular, size: 14.0)
        }
        return label
    }
    
}
