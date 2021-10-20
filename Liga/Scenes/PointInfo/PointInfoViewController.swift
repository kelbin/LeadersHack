//
//  PointInfoViewController.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 20.10.2021.
//

import Foundation
import UIKit


final class PointInfoViewController: UIViewController {
    
    var presenter: PointInfoPresenter!
    
    lazy private var pointTitleView: UILabel = {
        return $0.appereance(.medium)
    }(UILabel())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = PointInfoPresenter()
    }
    
    private func bindings() {
        //pointTitleView.publisher(for: \.text)
            //.assign(to: &presenter.$pointName)
            
            //presenter.$pointName.sink(receiveValue: <#T##((String) -> Void)##((String) -> Void)##(String) -> Void#>)
    }
    
    
    //lazy private var
    
    
    
}
