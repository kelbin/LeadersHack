//
//  Appereance+UITextField.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 21.10.2021.
//

import UIKit


extension AppTextField {
    
    func standart() -> AppTextField {
        let textField = self
        textField.borderStyle = .roundedRect
        textField.placeholder = "Поиск"
        textField.font = AppFonts.golos(style: .regular, size: 16.0)
        textField.textColor = ColorPallete.Text.secondary
        return textField
    }
    
}
