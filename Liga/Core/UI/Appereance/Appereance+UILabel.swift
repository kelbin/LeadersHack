//
//  Appereance+UILabel.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 19.10.2021.
//

import UIKit

enum LabelAppereance {
    case medium // Для крупных тайтлов
}

extension UILabel {
    
    func appereance(_ appereance: LabelAppereance) -> UILabel {
        let label = self
        switch appereance {
        case .medium:
            label.textColor = .red
            //label.font =
        }
        return label
    }
    
}
