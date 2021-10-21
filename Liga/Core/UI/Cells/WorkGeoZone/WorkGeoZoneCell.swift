//
//  WorkGeoZoneCell.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 19.10.2021.
//

import Foundation
import UIKit
import GoogleMaps

final class WorkGeoZoneCell: UITableViewCell {
    
    // MARK: - Views
    
    lazy private var cellTitleView: UILabel = {
        return $0.appereance(.medium)
    }(UILabel())
    
    private lazy var mapView: GMSMapView = {
        return $0
    }(GMSMapView())
    
    // MARK: - View lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        prepareLayout()
        self.selectionStyle = .none
    }
    
    private func prepareLayout() {
        
        contentView.addSubview(cellTitleView)
        cellTitleView.snp.makeConstraints { maker in
            maker.leading.trailing.top.equalToSuperview()
        }
        
        contentView.addSubview(mapView)
        mapView.snp.makeConstraints { make in
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
        
        let camera = GMSCameraPosition.camera(withLatitude: model.position.longitude,
                                              longitude: model.position.latitude,
                                              zoom: 12)
        mapView.camera = camera
        mapView.isUserInteractionEnabled = false
    }
    
}
