//
//  WorkZonesDataSource.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 19.10.2021.
//

import Foundation
import UIKit

final class WorkZonesDataSource: RPCEngineBase {
    
    override func cellView(for rpc: RPC, _ tableView: UITableView) -> UITableViewCell {
        switch rpc {
        case let model as WorkGeoZone:
            let cell = tableView.dequeueReusableCell(withIdentifier: WorkGeoZoneCell.reuseIdentifier) as! WorkGeoZoneCell
            cell.configure(model)
            return cell
        default:
            return super.cellView(for: rpc, tableView)
        }
    }
    
    override func height(for rpc: RPC) -> CGFloat {
        switch rpc {
        case is WorkGeoZone:
            return 250
        default:
            return super.height(for: rpc)
        }
    }
    
}
