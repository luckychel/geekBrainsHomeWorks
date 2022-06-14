import Foundation

//1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
//2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
//3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.

//Игра русская рулетка

//тип патрона
enum BulletType : String, CaseIterable {
    case Boevoi = "Боевой"
    case Holostoi = "Холостой"
}

// в обойме может быть патроны разного типа поэтому необходим протокол.
protocol PistolClipProtocol {
    var type: BulletType {get set}
}

struct PistolClip<T : PistolClipProtocol> {
    private var bullets: [T] = []
    
    //кол-во патронов в обойме
    var maxCount: Int
    init(maxCount: Int){
        self.maxCount = maxCount
    }
    
    mutating func add(_ bullet: T) {
        guard (bullets.count + 1 <= self.maxCount) else {
            print("\n❌ Обойма полна патронами, добавить больше нельзя")
            return
        }
        print("\n✅ Добивили \(bullet.type.rawValue) патрон")
        bullets.append(bullet)
    }
    
    mutating func shot(_ index : Int? = nil) -> T?{
        guard (bullets.count > 0) else {
            print("\n❌ Обойма пустая, добавить патронов")
            return nil
        }
        let obj = index != nil ? (index! < bullets.count ? bullets.remove(at: index!) : nil) : bullets.removeFirst()
        
        if (obj != nil)
        {
            print("\n💥🔫 Выстрел \(obj!.type.rawValue.replacingOccurrences(of: "ой", with: "ым")) патроном")
            count()
        }
        else {
            print("\n❌ Пистолет не выстрелил, в индексе \(index!) патрона нет")
        }
        return obj
    }
    
    func count() {
        guard bullets.count > 0 else {
            print("\n⚠️ В обойме не осталось патронов")
            return
        }
        print("\n✅ В обойме находится \(bullets.count) патронов")
    }
    
    func filterBulletType(type: BulletType) {
        guard bullets.count > 0 else {
            print("\n⚠️ В обойме нет патронов")
            return
        }
        print("\n✅ В обойме \(bullets.filter{$0.type == type}.count) \(type.rawValue.replacingOccurrences(of: "ой", with: "ых")) патронов")
    }
}

// расширение с Subscript
extension PistolClip {
    
    subscript(index: Int) -> Void {
        mutating get {
            guard index >= 0 && index < bullets.count else { return } // здесь можно было возврашать и nil, но тогда в чем игра)))
            
            if (bullets[index].type == BulletType.Boevoi)
            {
                print("\n☠️ В \(index) ячейке находится \(bullets[index].type.rawValue) патрон")
                shot(index)
            }
            else
            {

                print("\n😎 В \(index) ячейке находится \(bullets[index].type.rawValue) патрон")
                shot(index)
            }
        }
    }
    
    subscript(indexes: Int...) -> Void {
        var dict : [String: Int] = [:]
        
        for bt in BulletType.allCases {
            dict[bt.rawValue] = 0
        }
        for index in indexes where index < bullets.count {
            dict[bullets[index].type.rawValue]! += 1
        }
        
        for i in dict {
            print("\n‼️ В переданных индексах \(i.value) \(i.key) патронов")
        }
    }
}

class TulskiiTokarev : PistolClipProtocol {
    var type: BulletType
    init(type: BulletType) {
       self.type = type
    }
}

class DesertEagle : PistolClipProtocol {
    var type: BulletType
    init(type: BulletType) {
       self.type = type
    }
}

var ttGame = PistolClip<TulskiiTokarev>(maxCount: 8)
var deGame = PistolClip<DesertEagle>(maxCount: 9)

ttGame.add(TulskiiTokarev(type: BulletType.Boevoi))
ttGame.add(TulskiiTokarev(type: BulletType.Boevoi))
ttGame.add(TulskiiTokarev(type: BulletType.Holostoi))
ttGame.add(TulskiiTokarev(type: BulletType.Holostoi))
ttGame.add(TulskiiTokarev(type: BulletType.Boevoi))
ttGame.add(TulskiiTokarev(type: BulletType.Holostoi))
ttGame.add(TulskiiTokarev(type: BulletType.Boevoi))
ttGame.add(TulskiiTokarev(type: BulletType.Holostoi))
ttGame.add(TulskiiTokarev(type: BulletType.Boevoi))

ttGame.count()

//просто пострелять
ttGame.shot()
ttGame[2,4,5]

ttGame.filterBulletType(type: BulletType.Boevoi)
ttGame.filterBulletType(type: BulletType.Holostoi)

//сама игра
ttGame[0]
ttGame[0]
ttGame[3]
