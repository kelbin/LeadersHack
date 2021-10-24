//
//  Ext+String.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 23.10.2021.
//

import Foundation

extension String {
    
    var asURL: URL {
        return URL(string: self)!
    }
    
}
