//
//  WorkGeoZone.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 19.10.2021.
//

struct WorkGeoZone: alphaRPC {
    var position: Position
    let title: String
    let text: String?
    let key: String
    let sport_points_count: Int
    let sport_points_size: Double
    let population: Int
    let sports_count: Int
}
