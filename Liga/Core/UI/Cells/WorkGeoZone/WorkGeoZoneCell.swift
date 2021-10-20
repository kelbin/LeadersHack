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
    
    // MARK: - View lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(cellTitleView)
        cellTitleView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
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
