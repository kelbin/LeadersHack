//
//  PredictionService.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 24.10.2021.
//

import Combine

protocol PredictionService {
    func predict() -> AnyPublisher<Int, Error>
}
