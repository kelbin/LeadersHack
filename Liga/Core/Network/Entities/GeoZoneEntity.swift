//
//  GeoZoneEntity.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 19.10.2021.
//

import Foundation


struct GeoZoneEntity {
    var name: String
    var minLocation: Location
    var maxLocation: Location
    var sport_points_count: Int
    var sport_points_size: Double
    var population: Int
    var sports_count: Int
}

// MARK: - Api wrapped

struct GetGeoZonesPointsModel: Codable {
    let geo_zones: [GeoZoneEntity]
}

// MARK: - Codable

extension GeoZoneEntity: Codable {}

// MARK: - Domain helpers

extension GeoZoneEntity {
    
    func mapFrame() -> BoxCoordintate {
        return BoxCoordintate(topLeftLongitude: self.minLocation.longitude, topLeftLatitude: self.minLocation.latitude, bottomRightLongitude: self.maxLocation.longitude, bottomRightLatitude: self.maxLocation.latitude)
    }
    
}
