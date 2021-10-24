//
//  MapViewController+GeoZones.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 19.10.2021.
//

import Foundation
import SnapKit

extension MapViewController {
    
    func showGeozones() {
        let vc = WorkZonesViewController()
        
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.view.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(400.0)
        }
        geoView = vc.view
    }
    
    func showSearchForPoint() {
        let vc = SearchPointsViewController()
        
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.view.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(400.0)
        }
        searchForPointView = vc.view
        
        vc.coordinator = self
    }
    
    func showInfo() {
        let vc = PointInfoViewController()
        
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.view.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(400.0)
        }
        infoViewController = vc
        infoView = vc.view
    }
    
}
