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

// MARK: - Codable

extension SportPointEntity: Codable {}

