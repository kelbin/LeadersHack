//
//  SearchPointsPresenter.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 21.10.2021.
//

import Foundation
import Combine


final class SearchPointsPresenter: ViewState {
    // Те точки которые будут отображаться в списке
    @Published var sportPoints: [SportPointEntity] = []
    
    // Откуда тянутся спортивные объекты
    var interactor: GeoInteractor = globalInteractor
    
    // MARK: - ViewState
    
    func viewDidLoad() {
        self.interactor = globalInteractor
    }
    
    func viewWillAppear() {
        bindings()
    }
    
    // MARK: - Combine
    
    private func bindings() {
        interactor.$sportPoints.sink { [weak self] model in
            self?.sportPoints = model
        }.store(in: &cancellable)
    }
    
    private var cancellable = Set<AnyCancellable>()
    
}
