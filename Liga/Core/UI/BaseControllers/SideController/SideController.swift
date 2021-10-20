//
//  SideController.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 19.10.2021.
//

import Foundation
import UIKit

class SideController: UIViewController {
    
    private lazy var tableView: UITableView = {
        return $0
    }(UITableView())
    
    var RPCController: RPCEngineBase!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(WorkGeoZoneCell.self, forCellReuseIdentifier: WorkGeoZoneCell.reuseIdentifier)
        
        tableView.dataSource = RPCController
        tableView.delegate = RPCController
        
        RPCController.tableView = tableView
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
}
