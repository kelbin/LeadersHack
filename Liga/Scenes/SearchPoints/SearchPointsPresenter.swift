//
//  SearchPointsPresenter.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 21.10.2021.
//

import Foundation
import Combine

final class SearchPointsPresenter {
    @Published var sportPoints: [SportPointEntity] = []
    
    var interactor: GeoInteractor = globalInteractor
    
    func viewDidLoad() {
        self.interactor = globalInteractor
    }
    
    func viewWillAppear() {
        interactor.$sportPoints.sink { [weak self] model in
            self?.sportPoints = model
        }.store(in: &cancellable)
        
    }
    
    private var cancellable = Set<AnyCancellable>()
    
}
