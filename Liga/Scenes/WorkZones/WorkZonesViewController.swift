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
    
    weak var serchBarHeader: SimpleSearchBarHeaderView?
    
    var presenter: WorkZonesPresenter!
    
    override func viewDidLoad() {
        
        let seacrhBarHeader = SimpleSearchBarHeaderView()
        seacrhBarHeader.headerTitle = "Районы"
        header = seacrhBarHeader
        headerHeight = 154.0
        
        self.serchBarHeader = seacrhBarHeader
        
        RPCController = WorkZonesDataSource()
        presenter = WorkZonesPresenter()
        
        RPCController.delegate = presenter
        
        bindings()
        super.viewDidLoad()
        presenter.viewDidLoad()
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
                                                
                let position = Position(latitude: apiModel.minLocation.latitude,
                                        longitude: apiModel.minLocation.longitude)
                
                return WorkGeoZone(position: position, title: apiModel.name, text: nil, key: String(""), sport_points_count: apiModel.sport_points_count, sport_points_size: apiModel.sport_points_size)
                
                
            }))
        }.store(in: &cancellable)
            
    }
    
    private var cancellable = Set<AnyCancellable>()
    
}
