//
//  MapLensCardView.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 22.10.2021.
//

import Foundation
import UIKit

protocol MapLensCardViewDelegate: AnyObject {
    func didTapToRadioButton(title: String, selected: Bool)
}

final class MapLensCardView: UIView, RadioButtonViewDelegate {
    
    private var stackView: UIStackView = {
        $0.alignment = .leading
        $0.distribution = .fillEqually
        $0.axis = .vertical
        return $0
    }(UIStackView())
    
    lazy private var radio1: RadioButtonView = {
        $0.setup(name: "Баскетбол")
        $0.delegate = self
        return $0
    }(RadioButtonView())
    
    lazy private var radio2: RadioButtonView = {
        $0.setup(name: "Волейбол")
        $0.delegate = self
        return $0
    }(RadioButtonView())
    
    
    lazy private var radio3: RadioButtonView = {
        $0.setup(name: "Футбол")
        $0.delegate = self
        return $0
    }(RadioButtonView())
    
    
    lazy private var radio4: RadioButtonView = {
        $0.setup(name: "Плавание")
        $0.delegate = self
        return $0
    }(RadioButtonView())
    
    weak var delegate: MapLensCardViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not supported")
    }
    
    private func commonInit() {
        self.layer.cornerRadius = 12.0
        self.backgroundColor = .white
        addSubview(stackView)
        
        stackView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview().inset(UIEdgeInsets(top: 4.0, left: 16.0, bottom: 4.0, right: 16.0))
        }
        radioButtons.forEach { stackView.addArrangedSubview($0) }
    }
    
    func radioWasSelected(title: String, selected: Bool) {
        radioButtons.forEach { _radio in
            if _radio.value == title {
                delegate?.didTapToRadioButton(title: _radio.value, selected: selected)
                _radio.selected = selected
            } else {
                _radio.selected = false
            }
        }
        
    }
    
    private var radioButtons: [RadioButtonView] {
        return [radio1, radio2, radio3, radio4]
    }
    
}
