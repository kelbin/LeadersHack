//
//  WorkGeoZonesService.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 19.10.2021.
//

import Foundation
import Combine

struct GetGeoZonesPointsModel: Codable {
    let geo_zones: [GeoZoneEntity]
}

protocol GeoZoneService {
    func fetchGeozones() -> AnyPublisher<GetGeoZonesPointsModel, Error>
}

final class GeoZoneServiceImp: BasicService<GeoZoneTarget>, GeoZoneService {
    var url: URL = URL(string: "https://2240-2a00-1370-8131-67ea-bf29-ac6e-c3ff-d9c5.ngrok.io/geoZones")!
    
    func fetchGeozones() -> AnyPublisher<GetGeoZonesPointsModel, Error> {
        let target: GeoZoneTarget = .getGeozones
        return publisher(for: target)
    }
    
}
