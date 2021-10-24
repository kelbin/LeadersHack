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
        $0.numberOfLines = 0
        return $0.appereance(.primary)
    }(UILabel())
    
    lazy private var sumSquareTitleView: UILabel = {
        $0.text = "3"
        return $0.appereance(.primary)
    }(UILabel())
    
    lazy private var sumSquareLotTitleView: UILabel = {
        $0.text = "4"
        $0.numberOfLines = 0
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
            maker.trailing.equalToSuperview()
            maker.leading.equalToSuperview().inset(10)
            maker.top.equalToSuperview().offset(12)
        }
        
        sportZonesTitleView.snp.makeConstraints { maker in
            maker.top.equalTo(cellTitleView.snp.bottom).offset(12)
            maker.trailing.equalToSuperview()
            maker.leading.equalToSuperview().inset(10)
        }
        
        sportZonesLotView.snp.makeConstraints { maker in
            maker.top.equalTo(sportZonesTitleView.snp.bottom).offset(6)
            maker.trailing.equalToSuperview()
            maker.leading.equalToSuperview().inset(10)
        }
        
        sumSquareTitleView.snp.makeConstraints { maker in
            maker.top.equalTo(sportZonesLotView.snp.bottom).offset(6)
            maker.trailing.equalToSuperview()
            maker.leading.equalToSuperview().inset(10)
        }
        
        sumSquareLotTitleView.snp.makeConstraints { maker in
            maker.top.equalTo(sumSquareTitleView.snp.bottom).offset(6)
            maker.trailing.equalToSuperview()
            maker.leading.equalToSuperview().inset(10)
        }
        
        sportsKindTitleView.snp.makeConstraints { maker in
            maker.top.equalTo(sumSquareLotTitleView.snp.bottom).offset(6)
            maker.trailing.equalToSuperview()
            maker.leading.equalToSuperview().inset(10)
        }
        
        contentView.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.top.equalTo(sportsKindTitleView.snp.bottom).offset(10)
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
        
        guard let model = model as? WorkGeoZone else { return }
        
        cellTitleView.text = model.title
        
        sportZonesTitleView.text = "Количество спорт зон - \(model.sports_count)"
        sportZonesLotView.text = "Количество спорт зон на 100 000 населения - \(model.sport_points_count)"
        
        sumSquareTitleView.text = "Суммарная площадь - \(round(model.sport_points_size))"
        sumSquareLotTitleView.text = "Сумарная площадь на количество населения - \(round(model.sport_points_size + Double(model.population)))"
        
        sportsKindTitleView.text = "Количество видов спорта - \(model.sports_count)"
        
        let camera = GMSCameraPosition.camera(withLatitude: model.position.latitude,
                                              longitude: model.position.longitude,
                                              zoom: 12)
        mapView.camera = camera
        mapView.isUserInteractionEnabled = false
    }
    
}
