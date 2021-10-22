//
//  WorkSpaceSettingsViewController.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 21.10.2021.
//

import Foundation
import UIKit
import Combine


final class WorkSpaceViewController: UIViewController {
    
    private lazy var titlePlaceholder: UILabel = {
        $0.text = "Настройки"
        return $0.appereance(.medium)
    }(UILabel())
    
    private lazy var deltaPlaceholder: UILabel = {
        $0.text = "Граница воркзоны в км"
        return $0.appereance(.primary)
    }(UILabel())
    
    private lazy var deltaValueLabel: UILabel = {
        return $0.appereance(.secondary)
    }(UILabel())
    
    private lazy var deltaProgressView: UIProgressView = {
        return $0
    }(UIProgressView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    }
    
    
}
