//
//  SportPoint.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 21.10.2021.
//

import Foundation


struct SportPointEntity {
    var _id: String
    var name: String
    
    var category: String?
    var size: Double
    
    var location: Location
    
    var owner: String?
    var phone: String?
    
    var sports: [String]
}

struct Location {
    var longitude: Double
    var latitude: Double
    var fullAdressString: String?
    
    static var zero: Location {
        return Location(longitude: 0, latitude: 0, fullAdressString: nil)
    }
}


extension SportPointEntity: Codable {}

extension Location: Codable {}


