//
//  RPCEngineBase.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 19.10.2021.
//

import Foundation
import UIKit

class RPCEngineBase: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    private var model: [RPC] = []
    
    weak var tableView: UITableView?
    
    func reloadModel(_ model: [RPC]) {
        willSetModel()
        self.model = model
        didSetModel()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let index = indexPath.row
        let cellModel = self.model[index]
        return height(for: cellModel)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        let cellModel = self.model[index]
        
        return cellView(for: cellModel, tableView)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let index = indexPath.row
        let cellModel = self.model[index]
        
        return height(for: cellModel)
    }
    
    func willSetModel() {
        
    }
    
    func didSetModel() {
        tableView?.reloadData()
    }
    
    // MARK: - To override
    
    func height(for rpc: RPC) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func cellView(for rpc: RPC, _ tableView: UITableView) -> UITableViewCell {
        fatalError("A class should implement cell for model: \(rpc)")
    }
    
}
