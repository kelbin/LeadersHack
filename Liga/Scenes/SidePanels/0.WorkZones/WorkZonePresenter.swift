//
//  WorkZonePresenter.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 19.10.2021.
//

import Foundation
import Combine

final class WorkZonesPresenter: ViewState, ROCEngineProtocol {
    
    // Те зоны в списке, которые будут отображены
    @Published var geoZones: [GeoZoneEntity] = []
    
    // MARK: - ViewState
    
    func viewDidLoad() {
        bindigs()
    }
    
    // MARK: - ROCEngineProtocol
    
    func didSelected(model: RPC) {
        guard let model = model as? alphaRPC else { return }
        switchZoneToZone(named: model.title)
    }
    
    // MARK: - User interactive
    
    func switchZoneToZone(named: String) {
        if let newGeoZone = globalInteractor.workZones.first(where: { $0.name == named }) {
            if newGeoZone.mapFrame() != globalInteractor.currentFrame {
                globalInteractor.currentFrame = newGeoZone.mapFrame()
            }
        }
    }
    
    // MARK: - Combine
    
    private func bindigs() {
        globalInteractor.$workZones.sink { [weak self] _model in
            self?.geoZones = _model
        }.store(in: &cancellable)
    }
    
    private var cancellable = Set<AnyCancellable>()
    
}
