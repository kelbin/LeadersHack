//
//  Endpoint.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 23.10.2021.
//

import Foundation


protocol EndPoint {
    var baseURL: String { get }
    var URLPath: URL { get }
    var method: String { get }
    var decoder: JSONDecoder { get }
    
}
