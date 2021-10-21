//
//  WorkZonePresenter.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 19.10.2021.
//

import Foundation
import Combine

final class WorkZonesPresenter: ViewState {
    
    @Published var geoZones: [GeoZoneEntity] = []
    
    func viewDidLoad() {
        globalInteractor.$workZones.sink { [weak self] _model in
            self?.geoZones = _model
        }.store(in: &cancellable)
    }
    
    private var cancellable = Set<AnyCancellable>()
    
}
