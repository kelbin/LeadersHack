//
//  WorkZonePresenter.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 19.10.2021.
//

import Foundation


final class WorkZonesPresenter: WorkZonesPresenterProtocol {
    
    @Published var geoZones: [GeoZoneEntity] = []
    
    func viewDidLoad() {
        geoZones = stub()
    }
    
    func stub() -> [GeoZoneEntity]  {
        return [
            .init(name: "Щукино", minLocation: Location(longitude: 55.812778, lattitude: 37.449667, adresName: nil), maxLocation: Location(longitude: 55.789838, lattitude: 37.502025, adresName: nil)),
            .init(name: "Южное Тушино", minLocation: Location(longitude: 55.862222, lattitude: 37.410472, adresName: nil), maxLocation: Location(longitude: 55.849528, lattitude: 37.456417, adresName: nil)),
            .init(name: "Южное Тушино", minLocation: Location(longitude: 55.911546, lattitude: 37.310623, adresName: nil), maxLocation: Location(longitude: 55.746482, lattitude: 37.543053, adresName: nil))
            
        ]
    }
    
}
