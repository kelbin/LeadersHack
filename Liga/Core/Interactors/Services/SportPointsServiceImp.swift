//
//  SportPointsService.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 21.10.2021.
//

import Foundation
import Combine

struct GetSportPointsModel: Codable {
    let sport_points: [SportPointEntity]
}

final class SportPointsSerice: BasicService<SportPointsTarget> {
    
    func fetchSposrtPoints(with box: BoxCoordintate) -> AnyPublisher<GetSportPointsModel, Error> {
        let token: SportPointsTarget = .getPoints(box: box)
        return publisher(for: token)
    }
}
