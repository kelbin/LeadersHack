//
//  Endpoint.swift
//  Liga
//
//  Created by Ванурин Алексей Максимович on 23.10.2021.
//

import Foundation

/// Основная асбтракция для доступа до удаленных ручек

protocol EndPoint {
    
    /// Основной адресс для апи
    ///
    /// К этому адрессу будет добавляться путь того метода, который необходим, в виде стринги
    
    var baseURL: String { get }
    
    /// Путь конкретной ручки для вызова
    ///
    /// Этот адресс должен быть переконвертировать в `URL`
    /// Важно, что все параметры должны формироваться здесь
    
    var URLPath: URL { get }
    
    /// Метод конкретного ручки
    
    var method: String { get }
    
    /// Декодер, который будет использоватьс для декодирования и енкодирования ответа
    
    var decoder: JSONDecoder { get }
    
}
