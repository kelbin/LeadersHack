//
//  RPCEngine.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 19.10.2021.
//

import Foundation

protocol RPC {}

protocol alphaRPC: RPC {
    var title: String { get }
    var text: String? { get }
    var key: String { get }
}
