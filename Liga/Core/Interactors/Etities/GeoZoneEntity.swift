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
}

extension GeoZoneEntity: Codable {}
