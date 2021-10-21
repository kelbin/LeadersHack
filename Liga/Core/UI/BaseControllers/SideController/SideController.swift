//
//  SideController.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 19.10.2021.
//

import Foundation
import UIKit

class SideController: UIViewController {
    
    var header: UIView = UIView()
    var footer: UIView = UIView()
    
    private lazy var tableView: UITableView = {
        return $0
    }(UITableView())
    
    var headerHeight: CGFloat = 0.0
    var footerHeight: CGFloat = 0.0
    
    var RPCController: RPCEngineBase!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(WorkGeoZoneCell.self, forCellReuseIdentifier: WorkGeoZoneCell.reuseIdentifier)
        tableView.register(SportPointCell.self, forCellReuseIdentifier: SportPointCell.reuseIdentifier)
        
        tableView.dataSource = RPCController
        tableView.delegate = RPCController
        
        RPCController.tableView = tableView
        
        view.addSubview(tableView)
        view.addSubview(header)
        view.addSubview(footer)
        
        header.snp.makeConstraints { maker in
            maker.height.equalTo(headerHeight)
            maker.top.trailing.equalToSuperview()
            maker.leading.equalToSuperview().offset(100)
        }
        
        tableView.snp.makeConstraints { maker in
            maker.top.equalTo(header.snp.bottom)
            maker.trailing.equalToSuperview()
            maker.leading.equalToSuperview().offset(100)
        }
        
        footer.snp.makeConstraints { maker in
            maker.height.equalTo(footerHeight)
            maker.top.equalTo(tableView.snp.bottom)
            maker.bottom.trailing.equalToSuperview()
            maker.leading.equalToSuperview().offset(100)
        }
        
    }
    
}
