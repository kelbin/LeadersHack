//
//  SearchPointsViewControllers.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 21.10.2021.
//

import Foundation
import UIKit
import Combine

final class SearchPointsViewController: SideController {
    
    weak var serchBarHeader: SearchBarHeaderView?
    
    var presenter: SearchPointsPresenter!
    
    override func viewDidLoad() {
        let seacrhBarHeader = SearchBarHeaderView()
        seacrhBarHeader.headerTitle = "Спортивный объект"
        header = seacrhBarHeader
        headerHeight = 154.0
        
        self.serchBarHeader = seacrhBarHeader
        
        RPCController = SearchForPointDataSource()
        super.viewDidLoad()
        view.backgroundColor = .red
        presenter = SearchPointsPresenter()
        bindings()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.viewWillAppear()
    }
    
    private func bindings() {
        presenter.$sportPoints.sink { [weak self] _points in
            (self?.parent as? MapViewController)
            self?.RPCController.reloadModel(_points.map({ _apiModel in
                SportPoint(position: Position(latitude: 0, longitude: 0), title: _apiModel.name, text: _apiModel.location.fullAdressString ?? "", key: _apiModel._id)
            }))
        }.store(in: &cancellable)
    }

    private var cancellable = Set<AnyCancellable>()
    
}
