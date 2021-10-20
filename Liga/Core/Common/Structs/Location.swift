//
//  Location.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 20.10.2021.
//



struct Location {
    
    let longitude: Double
    let lattitude: Double
    
    let adresName: String?
    
    static var zero: Location {
        return Location(longitude: 0, lattitude: 0, adresName: nil)
    }
}
