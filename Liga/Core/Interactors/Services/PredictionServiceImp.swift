//
//  PredictionService.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 24.10.2021.
//

import Foundation
import Combine


final class PredictionServiceImp: BasicService<PredictionsTarget>, PredictionService {
    func predict() -> AnyPublisher<Int, Error> {
        let target: PredictionsTarget = .predict
        return publisher(for: target)
    }
}
