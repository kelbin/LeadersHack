# Лидеры Цифровой Трансформации

Трек 5. Интерактивная карта для размещения спортивной инфраструктуры





##  Архитектура

Используется упрощенная версия VIP с единным глобальным интерактором. Каждый модуль состоит из DataSource, Presenter, ViewController

### View

Используется UIKit. Верстка построенна на собственном решении RPCEngine, верстающем интерфейсы вертикальными ячейками по входящим моделькам. Преврашением моделек в ячейки -- ответвенность DataSource. Ячейки верстаются с помощью Snapkit.

 Пример такой верстки можно увидеть на примере `WorkZonesDataSource`

 ```swift
    // Элемент соответвующий модели
    override func cellView(for rpc: RPC, _ tableView: UITableView) -> UITableViewCell {
        switch rpc {
        /// Ячейка  с карточкой геозоны
        case let model as WorkGeoZone:
            let cell = tableView.dequeueReusableCell(withIdentifier: WorkGeoZoneCell.reuseIdentifier) as! WorkGeoZoneCell
            /// Конфигурируем юайные элементы ячейки модулью
            cell.configure(model)
            return cell
        default:
            return super.cellView(for: rpc, tableView)
        }
    }
    
    // Высота элементы
    override func height(for rpc: RPC) -> CGFloat {
        switch rpc {
            /// Ячейка  с карточкой геозоны
        case is WorkGeoZone:
            return 150.0
        default:
            return super.height(for: rpc)
        }
    }

 ```

 Для каждого модуля свой набор таких ячеек, которые используются при верстке. Каждый модуль должен предоставить свою имплементацию настройки и высоты для ячейки. Также он может выступать в качестве делегат ячейки. Движок для верстки предоставлен ниже:

 ```swift
 protocol RPCEngineBaseProtocol {
    
    /// Таблица, на которой будет осуществлена верстка
    ///
    /// Необязательный параметр
    /// Нужен для дополнительной и единобразной настройки таблицы
    
    var tableView: UITableView? { get set }
    
    /// Делегат таблицы и ячеек
    ///
    /// Необязательный параметр
    
    var delegate: ROCEngineProtocol? { get set }
    
    ///  Обновление интерфейса
    ///
    ///  Основной метод переотрисовки интерфейса
    
    func reloadModel(_ model: [RPC])
    
}
 ```

 Более подробно можно посмотреть в классе `RPCEngineBase`

 ### Presenter

Для связыванния интерфейса с данными, использовался реактивный движок Combine. Роль презентера -- подписываться на изменения данных в интеракторе и транслировать их во вью. Это можно увидеть на следующем примере:

 ```swift

    @Published var geoZones: [GeoZoneEntity] = []
    
    func viewDidLoad() {
        bindigs()
    }
    
    
    private func bindigs() {
        globalInteractor.$workZones.sink { [weak self] _model in
            self?.geoZones = _model
        }.store(in: &cancellable)
    }

 ```

На этапе инициализации модуля, происходит связвание на данные из интерактора. Переменная `geoZones` определяет, как будет отображен интерфейс во вью контролере. Сам вью контроллер подписывается на эту переменную следующим образом:

 ```swift  
    private func bindings() {
        presenter.$geoZones.sink { [weak self] model in
            self?.RPCController.reloadModel(model.map({ apiModel in
                WorkGeoZone(title: apiModel.name, text: nil, key: apiModel._id) }))
        }.store(in: &cancellable)
            
    }
 ```

### Interactor

Роль интерактора -- иметь входные параметры и следить за актуальностью данных в модулях, обновляя их через бекенд сервисы. Входные параметры интерактора выглядят следующим образом:

 ```swift  

    @Published var sportPoints: [SportPointEntity] = []
    @Published var serachString: String = ""
    @Published var currentSpace: GeoZoneEntity!
    @Published var currentFrame: BoxCoordintate = .zero
    @Published var workZones: [GeoZoneEntity] = [] 
    
 ```

Обновляя любой параметр, из приложения запускается процесс обновления интерфейсов

### Network

Методы для апи в МП задаются через ендпоинты

 ```swift  

/// Основная асбтракция для доступа до удаленных ручек:

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

 ```

Под каждый набор ручек сущесвует свой таргет, который опеределяет как именно будет сделан запрос

Сами запросы делаются через сервисы. Пример такого сервиса приведен ниже

 ```swift  

final class SportPointsSericeImp: BasicService<SportPointsTarget> {
    
    func fetchSposrtPoints(with box: BoxCoordintate) -> AnyPublisher<GetSportPointsModel, Error> {
        let token: SportPointsTarget = .getPoints(box: box)
        return publisher(for: token)
    }
}

 ```

 Такие сервисы используют общий базовый класс по созданию паблишеров для Combine фреймворка. Для работы с сетью использовался дефолтный URLSession

  ```swift  
  
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

 ```

# Backend

## Инструкция по запуску.

1. Склонировать репозиторий. В папке utils/excel_parser расположить excel-файл, расположенный по ссылке:
```
https://docs.google.com/spreadsheets/d/1N7g5uZhYwrcxIMebDYnUpe8SfFUZPigF/edit?usp=sharing&ouid=109004736220186011475&rtpof=true&sd=true
```
2. Если репозиторий склонирован на сервер, перейти к п.6.
3. Если репозиторий склонирован на локальную машину - один из способов получить доступный из вне url - воспользоваться утилитой ngrok, прокинув 8080 порт.
4. Скачать ngrok если не установлен.
5. Запустить ngrok командой: 
```
ngrok http 8080
```
6. Установить (если отсутствует) и запустить базу данных MongoDB.
7. Перейти в корневую папку проекта и запустить сервер командой:
```
python main.py
```
8. Отправить пустой GET запрос на url-адрес /generateData для заполнения базы данных данными из файла п.1.

### ROUTES:

### 1) .../get/sportpoints

  ```
  GET /get/sportpoints?minLat&minLong&maxLat&maxLong
  ```
  
Возвращает все спортивные объекты внутри прямоугольного полигона. В запросе через параметры передаются координаты верхней левой и правой нижней точек полигона.

### Response Body
  ```
  {
    "sport_points": [
        {
            "_id": "61718d1832ee9f470fbb49cb",
            "name": "Спортивный комплекс высшего учебного заведения «Московский автомобильно-дорожный государственный технический университет»",
            "category": null,
            "size": 497.0,
            "location": {
                "latitude": 55.80248047413373,
                "longitude": 37.5292134118028,
                "fullAdressString": "Ленинградский проспект, дом 64"
            },
            "owner": "Минобрнауки России",
            "phone": null,
            "sports": [
                "Бадминтон",
                "Баскетбол",
                "Бокс",
                "Волейбол",
                ...
            ],
            "rating": "Окружное"
        },
        {
            "_id": "61718d1832ee9f470fbb49e1",
            "name": "Дворец спортивных единоборств ЦСКА",
            "category": null,
            "size": 237.6,
            "location": {
                "latitude": 55.793708,
                "longitude": 37.536832,
                "fullAdressString": "Ленинградский проспект, дом 39, строение 27"
            },
            "owner": "Министерство обороны Российской Федерации",
            "phone": null,
            "sports": [
                "Спортивная борьба",
                "Бокс",
                "Фехтование",
                "Спортивная борьба",
                ...
            ],
            "rating": "Районное"
        },
        ...
    ]
  }
  ```
### 2) .../geoZones
  ```
  GET, POST /geoZones
  ```
  Позволяет добавить гео-зону, или же получить список всех имеющихся гео-зон. 
  
  POST
  
### Request Bode
  ```
  {
    "name": "Щукино",
    "minLocation": {
        "latitude": 55.812778,
        "longitude": 37.449667
    },
    "maxLocation": {
        "latitude": 55.789838,
        "longitude": 37.502025
    },
    "population": 109684
}
  ```
GET

### Response Body
  ```
  {
    "geo_zones": [
        "geo_zones": [
        {
            "_id": "61741b8d4071b677af6ebb3b",
            "name": "Южное Тушино",
            "minLocation": {
                "latitude": 55.862222,
                "longitude": 37.410472
            },
            "maxLocation": {
                "latitude": 55.849528,
                "longitude": 37.456417
            },
            "population": 109684,
            "sport_points_count": 12,
            "sport_points_size": 2907.8,
            "sports_count": 99
        },
        {
            "_id": "61741b8d4071b677af6ebb3a",
            "name": "Щукино",
            "minLocation": {
                "latitude": 55.812778,
                "longitude": 37.449667
            },
            "maxLocation": {
                "latitude": 55.789838,
                "longitude": 37.502025
            },
            "population": 111207,
            "sport_points_count": 12,
            "sport_points_size": 5537.9,
            "sports_count": 40
        },
        ...
    ]
}
  ```
### 3) .../prediction
  ```
  GET /prediction
  ```
  В теле запроса передаются координаты места на карте и параметры по предсказанию, такие как: тип спортзоны, доступность и виды спорта. В ответ модель возвращает предсказание по необходимой площади застройки при строительстве спортивного объекта с указанными параметрами.
  
  GET 
### Request Body 
  
  ```
  {
    "Тип спортзоны": ["универсальная спортивная площадка"],
    "Доступность": ["Шаговая доступность"],
    "Вид спорта": ["Футбол, Катание на лыжах, Баскетбол"],
    "Широта": [55.741227],
    "Долгота": [37.705778]
}
  
  ```
  ### Response Body
  ```
  {
    "prediction": "3149.9323421008885"
}
  ```
  




