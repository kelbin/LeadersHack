//
//  MapViewPresenter.swift
//  Liga
//
//  Created by Maxim Savchenko on 22.10.2021.
//

import Combine

protocol MapPresenterInput: ViewState {
    func fetchPlaceMarks()
}

final class MapPresenter: MapPresenterInput {
    
    var service: SportPointsService!
    var interactor: GeoInteractor!
    
    init(service: SportPointsService, interactor: GeoInteractor) {
        self.service = service
        self.interactor = interactor
    }
    
    init() {
        
    }
    
    func fetchPlaceMarks() {
        
    }
}
