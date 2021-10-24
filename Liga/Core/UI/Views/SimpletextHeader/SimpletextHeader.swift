//
//  SimpletextHeader.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 24.10.2021.
//

import Foundation
import UIKit


final class SimpleTextBarHeaderView: UIView {
    
    lazy private var headerTitleLabelView: UILabel = {
        return $0.appereance(.medium)
    }(UILabel())
    
    var headerTitle: String! {
        didSet { headerTitleLabelView.text = headerTitle }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Mot supported")
    }
    
    private func commonInit() {
        layout()
        backgroundColor = .white
    }
    
    private func layout() {
        addSubview(headerTitleLabelView)
        
        headerTitleLabelView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(32.0)
            maker.trailing.equalToSuperview().offset(-32.0)
            maker.top.equalToSuperview().offset(32.0)
            maker.bottom.equalToSuperview()
        }
    }
}
