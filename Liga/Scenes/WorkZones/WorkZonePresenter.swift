//
//  WorkZonePresenter.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 19.10.2021.
//

import Foundation


final class WorkZonesPresenter: ViewState {
    
    @Published var geoZones: [GeoZoneEntity] = []
    
    func viewDidLoad() {
        geoZones = stub()
    }
    
    func stub() -> [GeoZoneEntity]  {
        return [
            .init(name: "Щукино", minLocation: Location(longitude: 55.812778, latitude: 37.449667, fullAdressString: nil), maxLocation: Location(longitude: 55.789838, latitude: 37.502025, fullAdressString: nil)),
            .init(name: "Южное Тушино", minLocation: Location(longitude: 55.862222, latitude: 37.410472, fullAdressString: nil), maxLocation: Location(longitude: 55.849528, latitude: 37.456417, fullAdressString: nil)),
            .init(name: "СЗАО", minLocation: Location(longitude: 55.911546, latitude: 37.310623, fullAdressString: nil), maxLocation: Location(longitude: 55.746482, latitude: 37.543053, fullAdressString: nil))
            
        ]
    }
    
}
