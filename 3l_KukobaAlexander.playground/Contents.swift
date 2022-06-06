import Foundation

// 1. Описать несколько структур – любой легковой автомобиль SportCar и любой грузовик TrunkCar.

// 2. Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника.

// 3. Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема.

//4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.

//5. Инициализировать несколько экземпляров структур. Применить к ним различные действия.

//6. Вывести значения свойств экземпляров в консоль.

enum startStopStatus: String {
    case start = "включен"
    case stop = "выключен"
}

enum openCloseStatus : String {
    case open = "открыто"
    case close = "закрыто"
}

struct Car {

    enum typeOfCar: String {
        case sedan = "седан"
        case cupe = "купе"
        case sport = "спорт"
        case krosover = "кросовер"
        case offroad = "внедорожник"
        case trunk = "грузовик"
        case other = "не известный тип"
    }

    var brand: String
    var year: Int
    var type: typeOfCar
    var currentVolumeTrunk: Double
    let maxVolumeTrunk: Double
    var engineStatus: startStopStatus
    var windowStatus: openCloseStatus
    
    func description(){
        print("Автомобиль марки \(self.brand) в кузове \(self.type.rawValue), \(self.year) года выпуска, текущий объем багажника \(self.maxVolumeTrunk)")
    }
    
    mutating func setEngine(status: startStopStatus) -> Bool {
        guard self.engineStatus != status else {
            self.description()
            print("Предупреждение! Статус двигателя не поменялся - \(status.rawValue)")
            print("=================================")
            return false
        }
        self.engineStatus = status
        self.description()
        print("ОК! Двигатель - \(status.rawValue)")
        print("=================================")
        return true
    }
    
    mutating func setWindow(status: openCloseStatus) -> Bool {
        guard self.windowStatus != status else {
            self.description()
            print("Предупреждение! Статус окна водителя не поменялся - \(status.rawValue)")
            print("=================================")
            return false
        }
        self.windowStatus = status
        self.description()
        print("ОК! Окно водителя - \(status.rawValue)")
        print("=================================")
        return true
    }
    
    mutating func setVolumeTrunk(value: Double) -> Bool {
        self.description()
        guard self.currentVolumeTrunk + value <= self.maxVolumeTrunk else {
            print("Ошибка! Допустимый объем багажника - \(self.maxVolumeTrunk). Перегруз составляет \((self.currentVolumeTrunk + value) - self.maxVolumeTrunk)")
            print("=================================")
            return false
        }
        self.currentVolumeTrunk += value
        print("ОК! Текущий объем багажника - \(self.currentVolumeTrunk), свободного места осталось \(self.maxVolumeTrunk - self.currentVolumeTrunk)")
        print("=================================")
        return true
    }
    
    init(brand: String, year: Int, type: typeOfCar, currentVolumeTrunk: Double, maxVolumeTrunk: Double, engineStatus: startStopStatus, windowStatus: openCloseStatus) {
        guard currentVolumeTrunk >= 0 else { fatalError("Ошибка! Текущее значение объема багажника не может быть меньше 0") }
        guard maxVolumeTrunk > 0 else { fatalError("Ошибка! Максимальный объем багажника не может быть меньше или равно 0") }
        self.brand = brand
        self.year = year
        self.type = type
        self.currentVolumeTrunk = currentVolumeTrunk
        self.maxVolumeTrunk = maxVolumeTrunk
        self.engineStatus = engineStatus
        self.windowStatus = windowStatus

    }
    
    init() {
        self.brand = "no brand"
        self.year = 0
        self.type = typeOfCar.sedan
        self.currentVolumeTrunk = 0
        self.maxVolumeTrunk = 0
        self.engineStatus = startStopStatus.stop
        self.windowStatus = openCloseStatus.close
    }
}

var carSkoda = Car(brand: "Skoda", year: 2019, type: .krosover, currentVolumeTrunk: 10, maxVolumeTrunk: 400, engineStatus: .stop, windowStatus: .close)
carSkoda.setEngine(status: .stop)
carSkoda.setEngine(status: .start)

carSkoda.setWindow(status: .close)
carSkoda.setWindow(status: .open)


var carMan = Car(brand: "Man", year: 2000, type: .trunk, currentVolumeTrunk: 200, maxVolumeTrunk: 50000, engineStatus: .stop, windowStatus: .close)
carMan.setEngine(status: .stop)
carMan.setEngine(status: .start)

carMan.setWindow(status: .close)
carMan.setWindow(status: .open)

carMan.setVolumeTrunk(value: 500)
carMan.setVolumeTrunk(value: 49400)


// все тоже самое для грузового
struct TrunkCar {
    
}
