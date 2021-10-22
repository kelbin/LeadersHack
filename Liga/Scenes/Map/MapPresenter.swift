//
//  MapViewPresenter.swift
//  Liga
//
//  Created by Maxim Savchenko on 22.10.2021.
//

import Combine

protocol MapPresenterInput: ViewState {
    func fetchPlaceMarks(boxCoordinate: BoxCoordintate)
}

final class MapPresenter: MapPresenterInput {
    
    weak var view: MapViewInput!
    
    private var cancellable = Set<AnyCancellable>()
    
    init(view: MapViewInput) {
        self.view = view
    }
    
    func fetchPlaceMarks(boxCoordinate: BoxCoordintate) {
        let closure: () -> Void = {
            globalInteractor.currentFrame = boxCoordinate
            globalInteractor.$sportPoints.sink { model in
                model.forEach({ self.view.updateMarkers(position: $0.location) })
            }.store(in: &self.cancellable)
        }
        
        Throttler.go {
            closure()
        }
    }
}
