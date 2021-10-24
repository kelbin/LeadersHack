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
    var url: URL = URL(string: "https://2240-2a00-1370-8131-67ea-bf29-ac6e-c3ff-d9c5.ngrok.io/get/sportpoints")!
    
    func fetchSposrtPoints(with box: BoxCoordintate) -> AnyPublisher<GetSportPointsModel, Error> {
        let token: SportPointsTarget = .getPoints(box: box)
        return publisher(for: token)
        
        
//        return URLSession.shared.dataTaskPublisher(for: URL(string: self.stringed(for: box))!)
//            .map({ $0.data })
//            .decode(type: GetSportPointsModel.self, decoder: JSONDecoder())
//            .map({
//                print($0)
//                return $0.sport_points
//            })
//            .replaceError(with: [])
//            .receive(on: RunLoop.main)
//            .eraseToAnyPublisher()
    }
    
    private func stringed(for box: BoxCoordintate) -> String {
        let parameteres = "?minLat=\(box.topLeftLatitude)&minLong=\(box.topLeftLongitude)&maxLat=\(box.bottomRightLatitude)&maxLong=\(box.bottomRightLongitude)"
        print(parameteres)
        return "https://2240-2a00-1370-8131-67ea-bf29-ac6e-c3ff-d9c5.ngrok.io/get/sportpoints\(parameteres)"
    }
}
