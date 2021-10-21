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
}

final class GeoInteractor {
    
    var service: SportPointsSerice = SportPointsSerice()
    
    @Published var sportPoints: [SportPointEntity] = []
    
    @Published var serachString: String = ""
    @Published var currentFrame: BoxCoordintate
    
    //@Published var currentFrame: BoxCoordintate!
    
    
    init(workingFrame: BoxCoordintate) {
        self.currentFrame = workingFrame
        f()
    }
    
    func f() {
        Publishers.CombineLatest($serachString, $currentFrame)
            .flatMap { (searchEntry, currentFrame) in
                return self.service.fetchSposrtPoints(with: currentFrame)
            }.assign(to: \.sportPoints, on: self).store(in: &cancellable)
    }
    
    private var cancellable: Set<AnyCancellable> = []
    
}
