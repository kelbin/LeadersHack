//
//  SportPointCell.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 21.10.2021.
//

import Foundation
import UIKit


final class SportPointCell: UITableViewCell {
    
    // MARK: - Views
    
    lazy private var backView: UIView = {
        $0.layer.cornerRadius = 4.0
        return $0
    }(UIView())
    
    lazy private var pointTitleLabel: UILabel = {
        return $0.appereance(.primary)
    }(UILabel())
    
    lazy private var pointAdressLabel: UILabel = {
        return $0.appereance(.secondary)
    }(UILabel())
    
    // MARK: - View lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(backView)
        backView.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(8.0)
            maker.trailing.equalToSuperview().offset(-8.0)
            maker.top.bottom.equalToSuperview()
        }
        
        backView.addSubview(pointTitleLabel)
        pointTitleLabel.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(32.0)
            maker.trailing.equalToSuperview().offset(-4.0)
            maker.top.equalToSuperview().offset(8.0)
        }
        
        backView.addSubview(pointAdressLabel)
        pointAdressLabel.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(32.0)
            maker.trailing.equalToSuperview().offset(-4.0)
            maker.top.equalTo(pointTitleLabel.snp.bottom).offset(2.0)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backView.backgroundColor = .white
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            backView.backgroundColor = ColorPallete.Back.selected
        } else {
            backView.backgroundColor = .white
        }
    }
    
    // MARK: - Setupable
    
    func configure(_ model: alphaRPC) {
        pointTitleLabel.text = model.title
        pointAdressLabel.text = model.text ?? ""
    }
    
}
