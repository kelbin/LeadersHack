//
//  GeoSportPointInteractor.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 21.10.2021.
//

import Foundation
import Combine


struct BoxCoordintate: Equatable {
    var topLeftLongitude: Double
    var topLeftLatitude: Double
    
    var bottomRightLongitude: Double
    var bottomRightLatitude: Double
    
    static var zero: BoxCoordintate {
        return .init(topLeftLongitude: 0, topLeftLatitude: 0, bottomRightLongitude: 0, bottomRightLatitude: 0)
    }
    
    static func == (lhs: BoxCoordintate, rhs: BoxCoordintate) -> Bool {
        return (lhs.topLeftLatitude == rhs.topLeftLatitude) && (lhs.topLeftLongitude == rhs.topLeftLongitude) && (lhs.bottomRightLatitude == rhs.bottomRightLatitude) && (lhs.bottomRightLongitude == rhs.bottomRightLongitude)
    }
}

let globalInteractor = GeoInteractor()

final class GeoInteractor {
    
    var service: SportPointsSerice = SportPointsSerice()
    var workService: GeoZoneServiceImp = GeoZoneServiceImp()
    
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
        currentFrame = wokGeoSpace.mapFrame()
        //currentFrame = BoxCoordintate(topLeftLongitude: wokGeoSpace.minLocation.longitude, topLeftLatitude: wokGeoSpace.minLocation.latitude, bottomRightLongitude: wokGeoSpace.maxLocation.longitude, bottomRightLatitude: wokGeoSpace.maxLocation.latitude)
        sportsBindings()
    }
    
    func sportsBindings() {
        Publishers.CombineLatest($serachString, $currentFrame).flatMap {
            (searchntry, currentFrame) in
            return self.service.fetchSposrtPoints(with: currentFrame)
        }.mapError({ error -> Error in
            print(error)
            return AppError.Network
        }).replaceError(with: GetSportPointsModel.init(sport_points: []))
            .map({ $0.sport_points }).assign(to: \.sportPoints, on: self).store(in: &cancellable)
        
    }
    
    func geoBindings() {
        workService.fetchGeozones().sink(receiveCompletion: { _ in
                print("Completion")
        }, receiveValue: { _model in
                self.workZones = _model.geo_zones
        }).store(in: &cancellable)
    }
    
    private var cancellable: Set<AnyCancellable> = []
    
}

enum AppError: Error {
    case Network
}
