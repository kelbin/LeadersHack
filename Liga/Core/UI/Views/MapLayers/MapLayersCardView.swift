//
//  MapLayersCardView.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 23.10.2021.
//

import Foundation
import UIKit


protocol MapLayersCardViewDelegate: AnyObject {
    func didTapedStyleButton()
    func didTapedLayerButton()
}

final class MapLayersCardView: UIView {
    
    weak var delegate: MapLayersCardViewDelegate?
    
    private lazy var stylerButtonView: UIButton = {
        $0.addTarget(self, action: #selector(didTappedStyle), for: .touchUpInside)
        $0.setImage( #imageLiteral(resourceName: "styleNotSelected"), for: .normal)
        return $0
    }(UIButton())
    
    private lazy var layerButtonView: UIButton = {
        $0.addTarget(self, action: #selector(didTappedLayer), for: .touchUpInside)
        $0.setImage( #imageLiteral(resourceName: "layersNotSelected"), for: .normal)
        return $0
    }(UIButton())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not supported")
    }
    
    private func commonInit() {
        addSubview(stylerButtonView)
        addSubview(layerButtonView)
        
        backgroundColor = .white
        layer.cornerRadius = 12.0
        
        stylerButtonView.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.leading.equalToSuperview().offset(17.0)
        }
        
        layerButtonView.snp.makeConstraints { maker in
            maker.centerY.equalToSuperview()
            maker.trailing.equalToSuperview().offset(-17.0)
        }
    }
    
    func setStyleSelected(value: Bool) {
        if value {
            stylerButtonView.setImage(#imageLiteral(resourceName: "styleSelected"), for: .normal)
        } else {
            stylerButtonView.setImage(#imageLiteral(resourceName: "styleNotSelected"), for: .normal)
        }
    }
    
    func setLayerSelected(value: Bool) {
        if value {
            layerButtonView.setImage(#imageLiteral(resourceName: "layersSelected"), for: .normal)
        } else {
            layerButtonView.setImage(#imageLiteral(resourceName: "layersNotSelected"), for: .normal)
        }
    }
    
    @objc func didTappedStyle() {
        delegate?.didTapedStyleButton()
    }
    
    @objc func didTappedLayer() {
        delegate?.didTapedLayerButton()
    }
    
}
