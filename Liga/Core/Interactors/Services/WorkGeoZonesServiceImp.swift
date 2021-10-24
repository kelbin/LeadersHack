//
//  WorkGeoZonesService.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 19.10.2021.
//

import Foundation
import Combine


final class GeoZoneServiceImp: BasicService<GeoZoneTarget>, GeoZoneService {
    
    func fetchGeozones() -> AnyPublisher<GetGeoZonesPointsModel, Error> {
        let target: GeoZoneTarget = .getGeozones
        return publisher(for: target)
    }
    
}
