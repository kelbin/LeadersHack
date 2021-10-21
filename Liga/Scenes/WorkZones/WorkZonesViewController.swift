//
//  WorkZonesViewController.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 19.10.2021.
//

import Foundation
import UIKit
import Combine


final class WorkZonesViewController: SideController {
    
    var presenter: WorkZonesPresenter!
    
    override func viewDidLoad() {
        RPCController = WorkZonesDataSource()
        presenter = WorkZonesPresenter()
        bindings()
        super.viewDidLoad()
        presenter.viewDidLoad()
        view.backgroundColor = .red
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindings()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presenter.viewWillDisappear()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter.viewDidDisappear()
    }
    
    private func bindings() {
        presenter.$geoZones.sink { [weak self] model in
            self?.RPCController.reloadModel(model.map({ apiModel in
                                                        WorkGeoZone(position: Position(latitude: apiModel.minLocation.latitude, longitude: apiModel.minLocation.longitude), title: apiModel.name, text: nil, key: String("")) }))
        }.store(in: &cancellable)
            
    }
    
    private var cancellable = Set<AnyCancellable>()
    
}
