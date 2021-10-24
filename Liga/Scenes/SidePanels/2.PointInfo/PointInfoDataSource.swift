//
//  PointInfoDataSource.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 24.10.2021.
//

import Foundation
import UIKit


final class PointInfoDataSource: RPCEngineBase {
    
    override func cellView(for rpc: RPC, _ tableView: UITableView) -> UITableViewCell {
        switch rpc {
        case let model as TextSubtext:
            let cell = tableView.dequeueReusableCell(withIdentifier: TaxtSubtextCell.reuseIdentifier) as! TaxtSubtextCell
            cell.configure(model)
            return cell
        default:
            return super.cellView(for: rpc, tableView)
        }
    }
    
    override func height(for rpc: RPC) -> CGFloat {
        switch rpc {
        case is TextSubtext:
            return UITableView.automaticDimension
            //return 50.0
        default:
            return super.height(for: rpc)
        }
    }
    
}
