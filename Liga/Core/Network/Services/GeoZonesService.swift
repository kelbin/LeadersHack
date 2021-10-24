//
//  GeoZonesService.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 24.10.2021.
//

import Combine

protocol GeoZoneService {
    func fetchGeozones() -> AnyPublisher<GetGeoZonesPointsModel, Error>
}
