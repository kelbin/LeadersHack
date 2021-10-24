//
//  GeoZoneTarget.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 23.10.2021.
//

import Foundation

enum GeoZoneTarget: EndPoint {
    case getGeozones
    
    var baseURL: String {
        "http://167.71.143.191:8080/"
    }
    
    var URLPath: URL {
        switch self {
        case .getGeozones:
            return "\(baseURL)geoZones".asURL
        }
    }
    
    var method: String {
        switch self {
        case .getGeozones:
            return "GET"
        }
    }
    
    var decoder: JSONDecoder {
        return JSONDecoder()
    }
    
}
