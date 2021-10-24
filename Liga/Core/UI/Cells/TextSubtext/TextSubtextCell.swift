//
//  TextSubtextCell.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 24.10.2021.
//

import Foundation
import UIKit


final class TaxtSubtextCell: UITableViewCell {
    
    // MARK: - Views
    
    lazy private var cellTitleLabel: UILabel = {
        return $0.appereance(.secondary)
    }(UILabel())
    
    lazy private var cellsubTitleLabel: UILabel = {
        return $0.appereance(.primary)
    }(UILabel())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        cellsubTitleLabel.numberOfLines = 0
        
        contentView.addSubview(cellTitleLabel)
        cellTitleLabel.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(32.0)
            maker.trailing.equalToSuperview().offset(-4.0)
            maker.top.equalToSuperview().offset(18.0)
        }
        
        contentView.addSubview(cellsubTitleLabel)
        cellsubTitleLabel.snp.makeConstraints { maker in
            maker.leading.equalToSuperview().offset(32.0)
            maker.trailing.equalToSuperview().offset(-4.0)
            maker.top.equalTo(cellTitleLabel.snp.bottom).offset(4.0)
            maker.bottom.equalToSuperview()
        }
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Setupable
    
    func configure(_ model: alphaRPC) {
        cellTitleLabel.text = model.title
        cellsubTitleLabel.text = model.text ?? ""
    }
    
    
}
