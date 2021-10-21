//
//  WorkGeoZoneCell.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 19.10.2021.
//

import Foundation
import UIKit


final class WorkGeoZoneCell: UITableViewCell {
    
    // MARK: - Views
    
    lazy private var cellTitleView: UILabel = {
        return $0.appereance(.medium)
    }(UILabel())
    
    lazy private var mapImageView: UIImageView = {
        $0.image = #imageLiteral(resourceName: "stubMao")
        $0.isUserInteractionEnabled = true
        $0.backgroundColor = .clear
        $0.tintColor = .clear
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIImageView())
    
    // MARK: - View lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cellTitleView)
        cellTitleView.snp.makeConstraints { maker in
            maker.leading.trailing.top.equalToSuperview()
        }
        contentView.addSubview(mapImageView)
        mapImageView.snp.makeConstraints { make in
            make.top.equalTo(cellTitleView.snp.bottom).offset(4.0)
            make.leading.equalToSuperview().offset(8.0)
            make.trailing.equalToSuperview().offset(-8.0)
            make.bottom.equalToSuperview().offset(-4.0)
        }
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - RPC cell
    
    func configure(_ model: alphaRPC) {
        cellTitleView.text = model.title
    }
    
}
