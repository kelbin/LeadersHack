//
//  SearchForPointDataSource.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 21.10.2021.
//

import Foundation
import UIKit

final class SearchForPointDataSource: RPCEngineBase {
    
    override func cellView(for rpc: RPC, _ tableView: UITableView) -> UITableViewCell {
        switch rpc {
        case let model as SportPoint:
            let cell = tableView.dequeueReusableCell(withIdentifier: SportPointCell.reuseIdentifier) as! SportPointCell
            cell.configure(model)
            return cell
        default:
            return super.cellView(for: rpc, tableView)
        }
    }
    
    override func height(for rpc: RPC) -> CGFloat {
        switch rpc {
        case is SportPoint:
            return 66.0
        default:
            return super.height(for: rpc)
        }
    }
    
}

