//
//  RadioButtonView.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 21.10.2021.
//

import Foundation
import UIKit


protocol RadioButtonViewDelegate: AnyObject {
    func radioWasSelected(title: String, selected: Bool)
}

final class RadioButtonView: UIView {
    
    private let selectedImage =  #imageLiteral(resourceName: "radioOn")
    private let notSelectedImage =  #imageLiteral(resourceName: "radioOff")
    
    weak var delegate: RadioButtonViewDelegate?
    
    var value: String! {
        didSet { valueLabelView.text = value }
    }
    
    var selected: Bool! {
        didSet {  radioImageView.image = selected ? selectedImage : notSelectedImage  }
    }
    
    lazy private var valueLabelView: UILabel = {
        return $0.appereance(.primary)
    }(UILabel())
    
    lazy private var radioImageView: UIImageView = {
        return $0
    }(UIImageView())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not supported")
    }
    
    private func commonInit() {
        layout()
        
        let tap = UITapGestureRecognizer()
        tap.addTarget(self, action: #selector(didTapped))
        addGestureRecognizer(tap)
        
        value = ""
        selected = false
    }
    
    func setup(name: String) {
        value = name
    }
    
    @objc func didTapped() {
        delegate?.radioWasSelected(title: value, selected: !selected)
    }
    
    private func layout() {
        addSubview(valueLabelView)
        addSubview(radioImageView)
        
        radioImageView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(8.0)
            maker.width.equalTo(16.0)
            maker.height.equalTo(16.0)
            maker.centerY.equalToSuperview()
        }
        
        valueLabelView.snp.makeConstraints { maker in
            maker.leading.equalTo(radioImageView.snp.trailing).offset(12.0)
            maker.trailing.equalToSuperview().offset(-4.0)
            maker.top.bottom.equalToSuperview()
        }
        
    }
    
}
