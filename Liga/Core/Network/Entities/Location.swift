//
//  Location.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 24.10.2021.
//

import Foundation

struct Location {
    
    var longitude: Double
    var latitude: Double
    var fullAdressString: String?
    
}

// MARK: - Codable

extension Location: Codable {}

// MARK: - Domain helpers

extension Location {
    
    static var zero: Location {
        return Location(longitude: 0, latitude: 0, fullAdressString: nil)
    }
    
}
