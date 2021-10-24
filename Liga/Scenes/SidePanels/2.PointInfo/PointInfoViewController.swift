//
//  PointInfoViewController.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 20.10.2021.
//

import Foundation
import UIKit
import Combine

final class PointInfoViewController: SideController {
    
    var inputSportPointModel: SportPointEntity! {
        didSet {
            model = [
                TextSubtext(title: "Название", text: inputSportPointModel.name, key: ""),
                TextSubtext(title: "Адресс", text: inputSportPointModel.location.fullAdressString, key: ""),
                TextSubtext(title: "Категория", text: inputSportPointModel.category, key: ""),
                TextSubtext(title: "Владелец", text: inputSportPointModel.owner, key: ""),
                TextSubtext(title: "Спорт", text:  String(inputSportPointModel.sports.joined(separator: ", ")), key: ""),
            ]
        }
    }
    
    @Published var model: [TextSubtext] = []
    
    weak var headerView: SimpleTextBarHeaderView?
    
    lazy private var pointTitleView: UILabel = {
        return $0.appereance(.medium)
    }(UILabel())
    

    override func viewDidLoad() {
        /// 1.  Формируем UI
        setupHeaderBar()
        setupRPC()
        
        /// 2.  Формируем combine
        bindings()
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - Private
    
    private func setupHeaderBar() {
        let titleHeader = SimpleTextBarHeaderView()
        titleHeader.headerTitle = "Детали"
        header = titleHeader
        headerHeight = 154.0
        
        self.headerView = titleHeader
        
    }
    
    private func setupRPC() {
        RPCController = PointInfoDataSource()
    }
    
    // MARK: - Combine
    
    private func bindings() {
        $model.sink { _ in
        } receiveValue: { [weak self] _model in
            self?.RPCController.reloadModel(_model)
        }.store(in: &cancellable)

    }
    
    private var cancellable = Set<AnyCancellable>()
    
}
