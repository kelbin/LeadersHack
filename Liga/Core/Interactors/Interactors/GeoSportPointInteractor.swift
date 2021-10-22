//
//  GeoSportPointInteractor.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 21.10.2021.
//

import Foundation
import Combine


struct BoxCoordintate {
    var topLeftLongitude: Double
    var topLeftLatitude: Double
    
    var bottomRightLongitude: Double
    var bottomRightLatitude: Double
    
    static var zero: BoxCoordintate {
        return .init(topLeftLongitude: 0, topLeftLatitude: 0, bottomRightLongitude: 0, bottomRightLatitude: 0)
    }
}

let globalInteractor = GeoInteractor()

final class GeoInteractor {
    
    var service: SportPointsSerice = SportPointsSerice()
    var workService: WorkZoneService = WorkZoneService()
    
    @Published var sportPoints: [SportPointEntity] = []
    @Published var serachString: String = ""
    @Published var currentSpace: GeoZoneEntity!
    @Published var currentFrame: BoxCoordintate = .zero
    @Published var workZones: [GeoZoneEntity] = []
    
    init() {
        geoBindings()
    }
    
    func setup(wokGeoSpace: GeoZoneEntity) {
        currentSpace = wokGeoSpace
        currentFrame = BoxCoordintate(topLeftLongitude: wokGeoSpace.minLocation.longitude, topLeftLatitude: wokGeoSpace.minLocation.latitude, bottomRightLongitude: wokGeoSpace.maxLocation.longitude, bottomRightLatitude: wokGeoSpace.maxLocation.latitude)
        sportsBindings()
    }
    
    func sportsBindings() {
        Publishers.CombineLatest($serachString, $currentFrame)
            .flatMap { (searchEntry, currentFrame) in
                return self.service.fetchSposrtPoints(with: currentFrame)
            }.assign(to: \.sportPoints, on: self).store(in: &cancellable)
    }
    
    func geoBindings() {
        workService.fetchGeozones().sink { _model in
            self.workZones = _model
        }.store(in: &cancellable)
    }
    
    private var cancellable: Set<AnyCancellable> = []
    
}
