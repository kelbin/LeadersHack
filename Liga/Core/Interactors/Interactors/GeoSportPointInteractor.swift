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

let globalInteractor = GeoInteractor(workingFrame: BoxCoordintate.zero)

final class GeoInteractor {
    
    var service: SportPointsSerice = SportPointsSerice()
    var workService: WorkZoneService = WorkZoneService()
    
    @Published var sportPoints: [SportPointEntity] = []
    
    @Published var serachString: String = ""
    @Published var currentFrame: BoxCoordintate
    
    //@Published var currentFrame: BoxCoordintate!
    @Published var workZones: [GeoZoneEntity] = []
    
    init(workingFrame: BoxCoordintate) {
        self.currentFrame = workingFrame
    }
    
    func setup(workingFrame: BoxCoordintate) {
        f()
    }
    
    func f() {
        Publishers.CombineLatest($serachString, $currentFrame)
            .flatMap { (searchEntry, currentFrame) in
                return self.service.fetchSposrtPoints(with: currentFrame)
            }.assign(to: \.sportPoints, on: self).store(in: &cancellable)
        
        workService.fetchGeozones().sink { _model in
            self.workZones = _model
        }.store(in: &cancellable)
    }
    
    private var cancellable: Set<AnyCancellable> = []
    
}
