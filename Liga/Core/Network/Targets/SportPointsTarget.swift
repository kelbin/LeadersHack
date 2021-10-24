//
//  SportPointsTarget.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 23.10.2021.
//

import Foundation

enum SportPointsTarget: EndPoint {
    case getPoints(box: BoxCoordintate)
    
    var baseURL: String {
        "http://167.71.143.191:8080/"
    }
    
    var URLPath: URL {
        switch self {
        case .getPoints(let box):
            return "\(baseURL)get/sportpoints?minLat=\(box.topLeftLatitude)&minLong=\(box.topLeftLongitude)&maxLat=\(box.bottomRightLatitude)&maxLong=\(box.bottomRightLongitude)".asURL
        }
    }
    
    var method: String {
        switch self {
        case .getPoints:
            return "GET"
        }
    }
    
    var decoder: JSONDecoder {
        return JSONDecoder()
    }
    
    
}

