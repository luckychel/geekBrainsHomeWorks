import Foundation
import PlaygroundSupport

//1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
//2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
//3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
//4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertible.
//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
//6. Вывести сами объекты в консоль.

enum startStopStatus: String {
    case start = "включен"
    case stop = "выключен"
}

enum openCloseStatus : String {
    case open = "открыто"
    case close = "закрыто"
}

enum CarTransmission : String {
    case auto = "Автоматическая"
    case manual = "Ручная"
    case robot = "Робот"
}

enum TypeEngine: String {
    case petrol = "бензиновый"
    case diesel = "дизельный"
    case electrical = "электрический"
    case gas = "газовый"
}

protocol Car {
    
    var brand : String { get  }
    var year: Int { get }
    var transmission: CarTransmission { get }
    var engine: TypeEngine { get }
    
    var mileage: Double { get set }
    var currentVolumeTrunk: Double { get set }
    var maxVolumeTrunk: Double { get set }
    var engineStatus: startStopStatus? { get set }
    var windowStatus: openCloseStatus? { get set }
    
    var freeVolume : Double { get }
    static var countCar: Int {get set}
    
}

extension Car {
    mutating func setEngine(status: startStopStatus) -> Bool {
        guard self.engineStatus != status else {
            //self.description()
            print("⚠️ Статус двигателя не поменялся - \(status.rawValue)\n")
            return false
        }
        self.engineStatus = status
        //self.description()
        print("✅ Двигатель - \(status.rawValue)\n")
        return true
    }
    
    mutating func setWindow(status: openCloseStatus) -> Bool {
        guard self.windowStatus != status else {
            //self.description()
            print("⚠️ Статус окна водителя не поменялся - \(status.rawValue)\n")
            return false
        }
        self.windowStatus = status
        //self.description()
        print("✅ Окно водителя - \(status.rawValue)\n")
        return true
    }
    
    mutating func driveCertainDistance(distance: Double) -> Double {
        guard distance > 0 else {
            print("⚠️ Автомобиль не поехал, т.к. он не может проехать нулевую или отрицательную дистанцию.\n")
            return self.mileage
        }
        self.mileage += distance
        print("✅ Автомобиль проехал \(distance) км., в данный момент пробег состовляет \(self.mileage) км.\n")
        return self.mileage
    }
 
}

class SportCar : Car {

    enum TypeOfPassengerCar: String {
        case sedan = "седан"
        case cupe = "купе"
        case sport = "спорт"
        case krosover = "кросовер"
        case offroad = "внедорожник"
    }
    
    var brand: String
    
    var year: Int
    
    var transmission: CarTransmission
    
    var engine: TypeEngine
    
    var mileage: Double
    
    var currentVolumeTrunk: Double
    
    var maxVolumeTrunk: Double
    
    var engineStatus: startStopStatus?
    
    var windowStatus: openCloseStatus?
    
    var freeVolume: Double {
        get {
            return maxVolumeTrunk - currentVolumeTrunk
        }
    }

    var type: TypeOfPassengerCar
    private var isTunning: Bool

    static var countCar: Int = 0
    
    func changeTunning() {
        self.isTunning = self.isTunning ? false : true
        print(self.isTunning ? "✅ На машину добавлен тюнинг.\n" : "✅ С машины убран тюнинг\n")
        //self.description()
    }

    func setVolume(value: Double) -> Bool {
        //self.description()
        guard self.currentVolumeTrunk + value <= self.maxVolumeTrunk else {
            print("❌ Допустимый объем багажника - \(self.maxVolumeTrunk) кг, перегруз составляет \((self.currentVolumeTrunk + value) - self.maxVolumeTrunk) кг\n")
            return false
        }
        self.currentVolumeTrunk += value
        print("✅ Вы положили в кузов груз весом \(value) кг, текущий объем багажника - \(self.currentVolumeTrunk) кг, свободного места осталось \(self.freeVolume) кг\n")
        return true
    }
    
    init(brand: String, type: TypeOfPassengerCar, isTunning: Bool, year: Int, transmission: CarTransmission, engine: TypeEngine, mileage: Double, currentVolumeTrunk: Double, maxVolumeTrunk: Double, engineStatus: startStopStatus, windowStatus: openCloseStatus) {
        self.brand = brand
        self.year = year
        self.transmission = transmission
        self.engine = engine
        self.mileage = mileage
        self.currentVolumeTrunk = currentVolumeTrunk
        self.maxVolumeTrunk = maxVolumeTrunk
        self.engineStatus = engineStatus
        self.windowStatus = windowStatus
        
        self.type = type
        self.isTunning = isTunning
    
        print("🛞 Инициализация \(self.brand)")
        SportCar.countCar += 1
        //Car.printCountCar()
    }
    
    deinit {
        print("🗑 Деинициализация \(self.brand)")
        SportCar.countCar -= 1
        //Car.printCountCar()
    }

}

extension SportCar: CustomStringConvertible {
    var description: String {
        print("🚙 Легковая машина")
        print("- Тип \(self.type.rawValue)\n- Подвергалась тюнингу \(self.isTunning ? "Да" : "Нет")\n")
        return ""
    }
}


class TrunkCar: Car {
    
    enum TypeOfTrunkCar : String {
        case tank = "цистерна"
        case build = "строительная"
        case special = "спецтехника"
    }
    enum NumberOfAxies : String {
        case Ax2 = "двухосные"
        case Ax3 = "трехосные"
        case Ax4 = "четырехосные"
        case Ax5AndMore = "пятиосные и более"
    }
    enum ActionWithTheTrunk {
        case put, remove
    }
    
    var brand: String
    
    var year: Int
    
    var transmission: CarTransmission
    
    var engine: TypeEngine
    
    var mileage: Double
    
    var currentVolumeTrunk: Double
    
    var maxVolumeTrunk: Double
    
    var engineStatus: startStopStatus?
    
    var windowStatus: openCloseStatus?
    
    var freeVolume: Double {
        get {
            return maxVolumeTrunk - currentVolumeTrunk
        }
    }
    
    static var countCar: Int = 0
       
    var type: TypeOfTrunkCar
    var numAxies: NumberOfAxies
    
    func loadingAndUnloading(action: ActionWithTheTrunk, value: Double) {
        //description()
        switch action {
        case .put:
            switch value {
            case 0:
                print("❌ Вы не можете положить в кузов груз весом = 0 кг\n")
            case ..<0:
                print("❌ Вы не можете положить в кузов груз весом < 0 кг\n")
            case 1...:
                guard (self.currentVolumeTrunk + value) < self.maxVolumeTrunk else {
                    print("❌ Вы не можете положить груз весом \(value) кг, свободного места осталось \(self.freeVolume) кг\n")
                    return
                }
                self.currentVolumeTrunk += value
                print("✅ Вы положили в кузов груз весом \(value) кг, сейчас в кузове \(self.currentVolumeTrunk) кг, свободного места осталось \(self.freeVolume) кг\n")
               
            default:
                fatalError("⚠️ Попало в default [put]")
            }
        case .remove:
            switch value {
            case 0:
                print("❌ Вы не можете убрать из кузова груз весом = 0 кг\n")
            case ..<0:
                print("❌ Вы не можете убрать из кузова груз весом < 0 кг\n")
            case 0.1...:
                guard (self.currentVolumeTrunk - value) >= 0 else {
                    print("❌ Вы не можете убрать груз весом \(value) кг, у вас в кузове всего \(self.currentVolumeTrunk) кг\n")
                    return
                }
                self.currentVolumeTrunk -= value
                print("✅ Вы убрали из кузове груз весом \(value) кг, сейчас в кузове \(self.currentVolumeTrunk), свободного места стало \(self.freeVolume) кг\n")
                
            default:
                fatalError("⚠️ Попало в default [remove]")
            }
        }
    }
    
    init(brand: String, type: TypeOfTrunkCar, numAxies: NumberOfAxies, year: Int, transmission: CarTransmission, engine: TypeEngine, mileage: Double, currentVolumeTrunk: Double, maxVolumeTrunk: Double, engineStatus: startStopStatus, windowStatus: openCloseStatus) {
        self.brand = brand
        self.year = year
        self.transmission = transmission
        self.engine = engine
        self.mileage = mileage
        self.currentVolumeTrunk = currentVolumeTrunk
        self.maxVolumeTrunk = maxVolumeTrunk
        self.engineStatus = engineStatus
        self.windowStatus = windowStatus
        
        self.type = type
            self.numAxies = numAxies
        
        print("🛞 Инициализация \(self.brand)")
        TrunkCar.countCar += 1
        //Car.printCountCar()
    }
    
    deinit {
        print("🗑 Деинициализация \(self.brand)")
        TrunkCar.countCar -= 1
        //Car.printCountCar()
    }

}

extension TrunkCar: CustomStringConvertible {
    var description: String {
        print("🚚 грузовая машина")
        print("- Тип \(self.type.rawValue)\n- Кол-во осей \(self.numAxies.rawValue)\n")
        return ""
    }
}

var volvoXC90 : SportCar? = SportCar(brand: "Volvo", type: .offroad, isTunning: false, year: 2020, transmission: .auto, engine: .petrol, mileage:200, currentVolumeTrunk: 0, maxVolumeTrunk: 600, engineStatus: .stop, windowStatus: .close)
if (volvoXC90 != nil) {
    volvoXC90!.setEngine(status: .start)
    volvoXC90!.setVolume(value: 200)
    volvoXC90!.changeTunning()
}

var manTruck : TrunkCar? = TrunkCar(brand: "Man", type: .special, numAxies: .Ax3, year: 2008, transmission: .manual, engine: .diesel, mileage: 15000, currentVolumeTrunk: 0, maxVolumeTrunk: 50000, engineStatus: .start, windowStatus: .close)

if (manTruck != nil) {
    manTruck!.setEngine(status: .start)
    manTruck!.setWindow(status: .open)
    manTruck!.loadingAndUnloading(action: .put, value: 200)
    manTruck!.loadingAndUnloading(action: .put, value: 600)
    manTruck!.loadingAndUnloading(action: .put, value: 50000)
    manTruck!.loadingAndUnloading(action: .remove, value: 300)
    manTruck!.loadingAndUnloading(action: .remove, value: 500)
}

volvoXC90 = nil
manTruck = nil


