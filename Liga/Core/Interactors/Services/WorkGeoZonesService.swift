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

final class WorkZoneService {
    var url: URL = URL(string: "https://2240-2a00-1370-8131-67ea-bf29-ac6e-c3ff-d9c5.ngrok.io/geoZones")!
    
    func fetchGeozones() -> AnyPublisher<[GeoZoneEntity], Never> {
        return URLSession.shared.dataTaskPublisher(for: url).map({
            return $0.data
        }).decode(type: GetGeoZonesPointsModel.self, decoder: JSONDecoder())
            .map({
                print($0)
                return $0.geo_zones })
            .replaceError(with: [])
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
