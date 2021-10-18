//
//  Core.swift
//  Liga
//
//  Created by Maxim Savchenko on 16.10.2021.
//

import CoreGraphics

protocol Setupable: AnyObject {
    func setup(_ object: Any)
}

protocol Delegatable: AnyObject {
    var delegate: AnyObject? { get set }
}

protocol CommonEntity {
    var identifier: String { get }
    var height: CGFloat { get set }
}
