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
    
    var interactor: GeoInteractor!
    
    func viewDidLoad() {
        self.interactor = GeoInteractor(workingFrame: BoxCoordintate(topLeftLongitude: 37.410472, topLeftLatitude: 55.849528, bottomRightLongitude: 37.543053, bottomRightLatitude: 55.911546))
    }
    
    func viewWillAppear() {
        interactor.$sportPoints.sink { [weak self] model in
            self?.sportPoints = model
        }.store(in: &cancellable)
        
    }
    
    private var cancellable = Set<AnyCancellable>()
    
}
