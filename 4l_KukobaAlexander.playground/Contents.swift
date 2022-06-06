import Foundation
import PlaygroundSupport

//1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.
//2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.
//3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.
//4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
//5. Создать несколько объектов каждого класса. Применить к ним различные действия.
//6. Вывести значения свойств экземпляров в консоль.

class Car {
    
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
    
    static var countCar: Int = 0
    static func printCountCar() {
        print("✅ Всего активных машин: \(Car.countCar).\n")
    }
    
    var brand: String
    var year: Int
    var transmission: CarTransmission
    var engine: TypeEngine
    var mileage: Double
    
    var currentVolumeTrunk: Double = 0
    let maxVolumeTrunk: Double
    var engineStatus: startStopStatus? = .stop
    var windowStatus: openCloseStatus? = .close
    
    var freeVolume: Double {
        get {
            return maxVolumeTrunk - currentVolumeTrunk
        }
    }
    
    func setEngine(status: startStopStatus) -> Bool {
        guard self.engineStatus != status else {
            self.description()
            print("⚠️ Статус двигателя не поменялся - \(status.rawValue)\n")
            return false
        }
        self.engineStatus = status
        self.description()
        print("✅ Двигатель - \(status.rawValue)\n")
        return true
    }
    
    func setWindow(status: openCloseStatus) -> Bool {
        guard self.windowStatus != status else {
            self.description()
            print("⚠️ Статус окна водителя не поменялся - \(status.rawValue)\n")
            return false
        }
        self.windowStatus = status
        self.description()
        print("✅ Окно водителя - \(status.rawValue)\n")
        return true
    }
 
    func description(){
        print("- Автомобиль марки \(self.brand)\n- \(self.year) года выпуска\n- Коробка передач \(self.transmission.rawValue)\n- Двигатель \(self.engine.rawValue) ")
    }
    
    init(brand : String, year: Int, transmission: CarTransmission, engine: TypeEngine, mileage: Double, currentVolumeTrunk: Double, maxVolumeTrunk: Double, engineStatus: startStopStatus, windowStatus: openCloseStatus){
        guard mileage >= 0 else {
            fatalError("❌ Текущее значение объема багажника не может быть меньше 0\n")
        }
        guard currentVolumeTrunk >= 0 else {
            fatalError("❌ Текущее значение объема багажника не может быть меньше 0\n")
        }
        guard maxVolumeTrunk > 0 else {
            fatalError("❌ Максимальный объем багажника не может быть меньше или равно 0\n")
        }
        guard currentVolumeTrunk <= maxVolumeTrunk else {
            fatalError("❌ Текущий объем багажника не может быть больше максимального объема багажника\n")
        }
        guard mileage >= 0 else {
            fatalError("❌ Пробег не может быть меньше 0\n")
        }
        self.brand = brand
        self.year = year
        self.transmission = transmission
        self.engine = engine
        self.mileage = mileage
        self.currentVolumeTrunk = currentVolumeTrunk
        self.maxVolumeTrunk = maxVolumeTrunk
        self.engineStatus = engineStatus
        self.windowStatus = windowStatus
        
        print("🛞 Инициализация \(self.brand)")
        Car.countCar += 1
        Car.printCountCar()
    }
    
    deinit {
        print("🗑 Деинициализация \(self.brand)")
        Car.countCar -= 1
        Car.printCountCar()
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

    var type: TypeOfPassengerCar
    private var isTunning: Bool

    func changeTunning() {
        self.isTunning = self.isTunning ? false : true
        print(self.isTunning ? "✅ На машину добавлен тюнинг.\n" : "✅ С машины убран тюнинг\n")
        self.description()
    }

    func setVolume(value: Double) -> Bool {
        self.description()
        guard self.currentVolumeTrunk + value <= self.maxVolumeTrunk else {
            print("❌ Допустимый объем багажника - \(self.maxVolumeTrunk) кг, перегруз составляет \((self.currentVolumeTrunk + value) - self.maxVolumeTrunk) кг\n")
            return false
        }
        self.currentVolumeTrunk += value
        print("✅ Вы положили в кузов груз весом \(value) кг, текущий объем багажника - \(self.currentVolumeTrunk) кг, свободного места осталось \(self.freeVolume) кг\n")
        return true
    }
    
    init(brand: String, type: TypeOfPassengerCar, isTunning: Bool, year: Int, transmission: CarTransmission, engine: TypeEngine, mileage: Double, currentVolumeTrunk: Double, maxVolumeTrunk: Double, engineStatus: startStopStatus, windowStatus: openCloseStatus) {
            self.type = type
            self.isTunning = isTunning
        super.init(brand: brand, year: year, transmission: transmission, engine: engine, mileage: mileage, currentVolumeTrunk: currentVolumeTrunk, maxVolumeTrunk: maxVolumeTrunk, engineStatus: engineStatus, windowStatus: windowStatus)
        }

    override func description() {
        print("🚙 Легковая машина")
        super.description()
        print("- Тип \(self.type.rawValue)\n- Подвергалась тюнингу \(self.isTunning ? "Да" : "Нет")\n")
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
       
    var type: TypeOfTrunkCar
    var numAxies: NumberOfAxies
    
    func loadingAndUnloading(action: ActionWithTheTrunk, value: Double) {
        description()
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
            self.type = type
            self.numAxies = numAxies
        super.init(brand: brand, year: year, transmission: transmission, engine: engine, mileage: mileage, currentVolumeTrunk: currentVolumeTrunk, maxVolumeTrunk: maxVolumeTrunk, engineStatus: engineStatus, windowStatus: windowStatus)
        }

    override func description() {
        print("🚚 грузовая машина")
        super.description()
        print("- Тип \(self.type.rawValue)\n- Кол-во осей \(self.numAxies.rawValue)\n")
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
