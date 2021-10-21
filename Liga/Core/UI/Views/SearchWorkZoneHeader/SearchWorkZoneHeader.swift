//
//  SearchWorkZoneHeader.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 21.10.2021.
//

import Foundation
import UIKit


final class SimpleSearchBarHeaderView: UIView {
    
    lazy private var headerTitleLabelView: UILabel = {
        return $0.appereance(.medium)
    }(UILabel())
    
    lazy private var searchTextFieldView: AppTextField = {
        return $0.standart()
    }(AppTextField())
    
    lazy private var separatorView: UIView = {
        $0.backgroundColor = ColorPallete.borderColor
        return $0
    }(UIView())
    
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
        addSubview(searchTextFieldView)
        addSubview(separatorView)
        
        headerTitleLabelView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(32.0)
            maker.trailing.equalToSuperview().offset(-32.0)
            maker.top.equalToSuperview().offset(32.0)
        }
        
        searchTextFieldView.snp.makeConstraints { maker in
            maker.top.equalTo(headerTitleLabelView.snp.bottom).offset(24.0)
            maker.leading.equalToSuperview().offset(32.0)
            maker.trailing.equalToSuperview().offset(-32.0)
            maker.height.equalTo(48.0)
        }
        
        separatorView.snp.makeConstraints { maker in
            maker.leading.trailing.bottom.equalToSuperview()
            maker.height.equalTo(1.0)
        }
        
    }
    
}
