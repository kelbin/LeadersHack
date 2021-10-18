//
//  Ext+UITableViewCell.swift
//  Liga
//
//  Created by Maxim Savchenko on 16.10.2021.
//

import UIKit

extension UIView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
     static var nibName: String {
        return String(describing: self)
    }
}
