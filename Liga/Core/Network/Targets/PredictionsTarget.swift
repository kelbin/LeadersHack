//
//  PredictionsTarget.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 24.10.2021.
//

import Foundation


enum PredictionsTarget: EndPoint {
    case predict
    
    var baseURL: String {
        "http://167.71.143.191:8080/"
    }
    
    var URLPath: URL {
        switch self {
        case .predict:
            return "\(baseURL)prediction".asURL
        }
    }
    
    var method: String {
        switch self {
        case .predict:
            return "GET"
        }
    }
    
    var decoder: JSONDecoder {
        return JSONDecoder()
    }
    
    
}
