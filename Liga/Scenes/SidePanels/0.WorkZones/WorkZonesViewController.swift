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
    
    // MARK: - Views
    
    weak var serchBarHeader: SimpleSearchBarHeaderView?
    
    // MARK: - Arch
    
    var presenter: WorkZonesPresenter!
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        /// 2. Формируем модуль
        presenter = WorkZonesPresenter()
        
        
        /// 1.  Формируем UI
        setupHeaderBar()
        setupRPC()
        
        /// 3.  Формируем combine
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
    
    // MARK: - Private
    
    private func setupHeaderBar() {
        let seacrhBarHeader = SimpleSearchBarHeaderView()
        seacrhBarHeader.headerTitle = "Районы"
        header = seacrhBarHeader
        headerHeight = 154.0
        
        self.serchBarHeader = seacrhBarHeader
        
    }
    
    private func setupRPC() {
        RPCController = WorkZonesDataSource()
        RPCController.delegate = presenter
    }
    
    // MARK: - Combine
    
    private func bindings() {
        presenter.$geoZones.sink { [weak self] model in
            self?.RPCController.reloadModel(model.map({ apiModel in
                                                
                let position = Position(latitude: apiModel.minLocation.latitude,
                                        longitude: apiModel.maxLocation.longitude)

                return WorkGeoZone(position: position,
                                   title: apiModel.name,
                                   text: nil,
                                   key: String(""),
                                   sport_points_count: apiModel.sport_points_count,
                                   sport_points_size: apiModel.sport_points_size,
                                   population: apiModel.population,
                                   sports_count: apiModel.sports_count)
                
                
            }))
        }.store(in: &cancellable)
            
    }
    
    private var cancellable = Set<AnyCancellable>()
    
}
