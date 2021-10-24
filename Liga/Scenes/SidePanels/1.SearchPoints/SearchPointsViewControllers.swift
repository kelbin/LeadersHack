//
//  SearchPointsViewControllers.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 21.10.2021.
//

import Foundation
import UIKit
import Combine

protocol PointsCoordinator: AnyObject {
    func didGoToPoint(point: alphaRPC)
}


final class SearchPointsViewController: SideController, ROCEngineProtocol {
    
    // MARK: - Views
    
    weak var serchBarHeader: SearchBarHeaderView?
    
    // MARK: - Arch
    
    weak var coordinator: PointsCoordinator?
    var presenter: SearchPointsPresenter!
    
    // MARK: - View lifecycle

    override func viewDidLoad() {
        /// 1.  Формируем UI
        setupHeaderBar()
        setupRPC()
        
        super.viewDidLoad()
        
        /// 2. Формируем модуль
        presenter = SearchPointsPresenter()
        
        /// 3.  Формируем combine
        bindings()
        
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    // MARK: - Private
    
    private func setupHeaderBar() {
        let seacrhBarHeader = SearchBarHeaderView()
        seacrhBarHeader.headerTitle = "Спортивный объект"
        header = seacrhBarHeader
        headerHeight = 154.0
        
        self.serchBarHeader = seacrhBarHeader
    }
    
    private func setupRPC() {
        RPCController = SearchForPointDataSource()
        RPCController.delegate = self
    }
    
    
    // MARK: - ROCEngineProtocol
    
    func didSelected(model: RPC) {
        guard let model = model as? alphaRPC else { return }
        coordinator?.didGoToPoint(point: model)
    }
    
    // MARK: - Combine
    
    private func bindings() {
        ///  При изменении текущих рабочих спортивных точке, мы перезагружаем список спортивных точек
        presenter.$sportPoints.sink { [weak self] _points in
            (self?.parent as? MapViewController)
            self?.RPCController.reloadModel(_points.map({ _apiModel in
                SportPoint(position: Position(latitude: 0, longitude: 0), title: _apiModel.name, text: _apiModel.location.fullAdressString ?? "", key: _apiModel._id)
            }))
        }.store(in: &cancellable)
    }

    private var cancellable = Set<AnyCancellable>()
    
}
