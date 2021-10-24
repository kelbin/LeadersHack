
# Лидеры Цифровой Трансформации Трек 5. Интерактивная карта для размещения спортивной инфраструктуры



Для жителей города Москвы развернута обширная спортивная инфраструктура, которая позволяет увеличить рост регулярно занимающихся спортом горожан. Массовое увлечение спортом и здоровым образом жизни давно уже стало устойчивой тенденцией. Количество москвичей, регулярно занимающихся спортом, по сравнению с 2010 годом выросло почти в 2 раза, спортом занимаются не только профессионалы, но и любители. В рамках задач по развитию спортивной инфраструктуры есть необходимость предоставления верифицированной информации для формирования корректного направления развития спортивной отрасли, которое позволит обеспечить горожанам предоставление качественных спортивных услуг во всех районах города Москвы.
Создание инструмента, позволяющего обеспечить комплексный анализ спортивной инфраструктуры и помочь принять правильное решение по развитию спортивных объектов, является востребованной и актуальной задачей.

# Команда - Dungeon master

- Всеволод Данилин - Разработка бекенда
- Алексей Никитин - Разработка бекенда/Работа с данными/Машинное обучени
- Ванурин Алексей - Разработка IOs/ Продукт менеджмент
- Савченко Максим - Разработка IOs
- Савченко Алексендра - Дизайн/Проект менеджмент

# Описание решения

В рамках работы над решением задачи было разработано следующее решение. Решение команды - приложение под айпад с отображением аналитики и информации по спортивным объектам.

Решение включает в себя

- Отображение спортивных объектов на карте из предоставленных источников с собственной обработкой
- Отображение радиусов доступности объекта на карте в зависимости от площади
- Отображение тепловой карты распредленности объектов по карте
- Отображение списка спортивной инфрастуктуры в виде списка
- Отображение рабочих геозон в виде списка с возможностью смены активной зоны
- Отображение карточки спортивной точки, которая включаяет в себя: название, адресс, общая площадь, ведомственная принадлежность, список доступных спортивных кружков
- Отображение разных геозон со статистикой: суммарная площадь всех объектов, суммарное количество объектов, площадь и количество объектов на 100 000 населения, количество уникальных спортивных кружков
- Смена стили карты на черно-белую
- Линзы по доступности определенных геозон (в прототипе зашиты только четыри фиксированных вида)
- Добавление новой плейсмарки на карту
- Предсказания необходимой площади для нового спортивного объекта (Реализованно на бекенде но не на мобильной платформе)

Кроме того нереализованный функционал

- Фильтрация спортивных точек по определенным критериям
- Задания начальных новых точек
- Дополнительная тепловая карта по степени доступности спорта
- Заметки на картах
- Загрузка и сохранения проекта
- Конвертация проекта в пдф формат
- Настройки проекта в том числе набора линз стилей карты и тд
- Создание собственных кастомных геозон

Приложение способно демонстрировать состояние спорта на каждом выбранном районе. Плейсмарки с зелеными кругами, показывают какие площади района охватываются спортивной инфрастуктура в "шаговой доступности". Тепловая карта демонстрирует степень распредленности спортивных зон по району. Линзы используются для отображение доступности каждого выбранного спорта в виде радиальных зон.


Также приложение имеет фичу с геозонами. Приложение дает возможность работать с каждой геозоной по отдельности для удобства использования. Так рабочей зоной может быть целый округ СЗАО или район, например, Щукино. Карта отображает информацию только по выбранной геозоне

Перетаскивая точку с тулбара на карту, приложение дает возможность спроектировать будущую точку для спортивной инфрастуктуры.

# Дисклеймер

 

# Техническое решение

# Frontend

## Инструкция по запуску приложения

Для запуска приложения необходимы следующие требования к системе:
1. iOS 13+. 
2. Установка CocoaPods через терминал. https://guides.cocoapods.org/using/getting-started.html
3. Запуск приложения через симулятор или устройство iPad.

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
  
### Request Body
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
  
# ML

На основании полученных данных была разработана модель машинного обучения для предсказания целевой площади спортивной зоны. В основе модели лежит алгоритм градиентного бустинга. Алгоритм учитывает тип спортивной зоны , виды спорта, доступность и географические координаты будущего спортивного объекта. Результат предсказания модели - целевая площадь

Градиентный бустинг является сильным алгоритмом машинного обучения. Суть метода заключается в построении ансамбля слабых моделей (например, деревьев принятия решений), в которых модели строятся не независимо, а последовательно. Говоря простым языком, это означает, что следующее дерево учится на ошибках предыдущего, затем этот процесс повторяется, наращивая количество слабых моделей. Таким образом, получается сильная модель, способная к обобщению на разнородных данных.

