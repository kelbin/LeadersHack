//
//  Service.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 23.10.2021.
//

import Foundation
import Combine


class BasicService<Target: EndPoint> {
    
    ///  Общая логика отправления запроса на бекенд
    ///
    ///  Параметры выполняемого процесса хранятся в предоставляемом таргете
    ///  Тарегт опредляет адресс запроса, метод, кодирование параметров запроса, а также какрй использовать декодер
    ///
    /// - parameter target: Параметры ендпоинта запроса
    /// - returns: Возвращает паблишера задекодированного ответа с сервера
    
    func publisher<T: Codable>(for target: Target) -> AnyPublisher<T, Error> {
        let request = URLRequest(url: target.URLPath)
        
        print(request.url ?? "")
        print(request.httpMethod)
        print(request)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map({
                //let decodedString = String(data: $0.data, encoding: String.Encoding.utf8)
                //NSLog( decodedString ?? "Couldnt decoded a basic responce")
                return $0.data
            })
            .decode(
                type: T.self, decoder: target.decoder)
            .mapError({ error in
                print(error)
                return error
            })
            //.replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
