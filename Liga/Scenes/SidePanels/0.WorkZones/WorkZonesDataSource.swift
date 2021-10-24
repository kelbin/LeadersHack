//
//  WorkZonesDataSource.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 19.10.2021.
//

import Foundation
import UIKit

final class WorkZonesDataSource: RPCEngineBase {
    
    // Элемент соответвующий модели
    override func cellView(for rpc: RPC, _ tableView: UITableView) -> UITableViewCell {
        switch rpc {
        /// Ячейка  с карточкой геозоны
        case let model as WorkGeoZone:
            let cell = tableView.dequeueReusableCell(withIdentifier: WorkGeoZoneCell.reuseIdentifier) as! WorkGeoZoneCell
            /// Конфигурируем юайные элементы ячейки модулью
            cell.configure(model)
            return cell
        default:
            return super.cellView(for: rpc, tableView)
        }
    }
    
    // Высота элементы
    override func height(for rpc: RPC) -> CGFloat {
        switch rpc {
            /// Ячейка  с карточкой геозоны
        case is WorkGeoZone:
            return 350
        default:
            return super.height(for: rpc)
        }
    }
    
}
