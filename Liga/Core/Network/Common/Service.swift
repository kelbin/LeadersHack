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
        /// 1.  Формируем параметры запроса
        let request = URLRequest(url: target.URLPath)
        
        BasicService.logSent(request)
        

        return URLSession.shared.dataTaskPublisher(for: request)
            /// 2.  Открываем данные
            .map({
                
                BasicService.logRecieved($0.response)
                BasicService.logRecieved($0.data)
                
                return $0.data
            })
            /// 3.  Декодируем ответ с помощью `decodable`
            .decode(
                type: T.self, decoder: target.decoder)
            /// 4.  Ловим ошибки с бекенда или от парсинга
            .mapError({ error in
                NSLog(error.localizedDescription)
                return error
            })
            /// 5.  Выбираем поток передачи. Это юай поток
            .receive(on: DispatchQueue.main)
            /// 6.  Освобождаем паблишеры
            .eraseToAnyPublisher()
    }
    
    // MARK: - Logs
    
    class fileprivate func logSent(_ request: URLRequest) {
        NSLog("REQUEST:\n\(request.httpMethod ?? "") \(request.url?.absoluteString ?? "")")
    }
    
    class fileprivate func logRecieved(_ response: URLResponse) {
        if let response = response as? HTTPURLResponse {
            let urlString = response.url?.absoluteString ?? "Unknown"
            
            NSLog("COMPLETE: \(response.statusCode) - \(urlString)")
        } else {
            NSLog("Did failed to log a response")
        }
    }
    
    class fileprivate func logRecieved(_ data: Data) {
            if let decodedString = String(data: data, encoding: .utf8) {
                NSLog("RESPONSE:\n\(decodedString)")
            } else {
                NSLog("Service did recieved broken data")
        }
    }
    
}
