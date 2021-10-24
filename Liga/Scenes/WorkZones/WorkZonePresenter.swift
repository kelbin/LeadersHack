//
//  WorkZonePresenter.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 19.10.2021.
//

import Foundation
import Combine

final class WorkZonesPresenter: ViewState, ROCEngineProtocol {
    
    @Published var geoZones: [GeoZoneEntity] = []
    
    func viewDidLoad() {
        globalInteractor.$workZones.sink { [weak self] _model in
            self?.geoZones = _model
        }.store(in: &cancellable)
    }
    
    func didSelected(model: RPC) {
        guard let model = model as? alphaRPC else { return }
        if let newGeoZone = globalInteractor.workZones.first(where: { $0.name == model.title }) {
            if newGeoZone.mapFrame() != globalInteractor.currentFrame {
                globalInteractor.currentFrame = newGeoZone.mapFrame()
            }
        }
    }
    
    private var cancellable = Set<AnyCancellable>()
    
}
