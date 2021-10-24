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
    
    lazy private var sportZonesTitleView: UILabel = {
        $0.text = "1"
        return $0.appereance(.primary)
    }(UILabel())
    
    lazy private var sportZonesLotView: UILabel = {
        $0.text = "2"
        return $0.appereance(.primary)
    }(UILabel())
    
    lazy private var sumSquareTitleView: UILabel = {
        $0.text = "3"
        return $0.appereance(.primary)
    }(UILabel())
    
    lazy private var sumSquareLotTitleView: UILabel = {
        $0.text = "4"
        return $0.appereance(.primary)
    }(UILabel())
    
    lazy private var sportsKindTitleView: UILabel = {
        $0.text = "5"
        return $0.appereance(.primary)
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
        contentView.addSubview(sportZonesTitleView)
        contentView.addSubview(sportZonesLotView)
        contentView.addSubview(sumSquareTitleView)
        contentView.addSubview(sumSquareLotTitleView)
        contentView.addSubview(sportsKindTitleView)
        
        
        cellTitleView.snp.makeConstraints { maker in
            maker.leading.trailing.top.equalToSuperview()
        }
        
        sportZonesTitleView.snp.makeConstraints { maker in
            maker.top.equalTo(cellTitleView.snp.bottom).offset(6)
            maker.leading.trailing.equalToSuperview()
        }
        
        sportZonesLotView.snp.makeConstraints { maker in
            maker.top.equalTo(sportZonesTitleView.snp.bottom).offset(6)
            maker.leading.trailing.equalToSuperview()
        }
        
        sumSquareTitleView.snp.makeConstraints { maker in
            maker.top.equalTo(sportZonesLotView.snp.bottom).offset(6)
            maker.leading.trailing.equalToSuperview()
        }
        
        sumSquareLotTitleView.snp.makeConstraints { maker in
            maker.top.equalTo(sumSquareTitleView.snp.bottom).offset(6)
            maker.leading.trailing.equalToSuperview()
        }
        
        sportsKindTitleView.snp.makeConstraints { maker in
            maker.top.equalTo(sumSquareLotTitleView.snp.bottom).offset(6)
            maker.leading.trailing.equalToSuperview()
        }
        
        contentView.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.top.equalTo(sportsKindTitleView.snp.bottom).offset(4.0)
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
        
        let camera = GMSCameraPosition.camera(withLatitude: model.position.latitude,
                                              longitude: model.position.longitude,
                                              zoom: 12)
        mapView.camera = camera
        mapView.isUserInteractionEnabled = false
    }
    
}
