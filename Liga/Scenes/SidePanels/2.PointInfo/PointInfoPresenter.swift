//
//  PointInfoPresenter.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 20.10.2021.
//

import Foundation

struct SportCategoryConfig {
    var football: Bool
    var volleyball: Bool
    
    // ????
    
}


final class PointInfoPresenter: ViewState {
    
    @Published var pointName: String = ""
    @Published var square: Int = 0
    
    @Published var location: Location = Location.zero
    
}
