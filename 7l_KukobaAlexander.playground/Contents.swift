import Foundation
import PlaygroundSupport

struct Product {
    var name: String
}

struct Item {
    var count: Int
    var price: Double
    var product: Product
    
}
class VendingMachine {
    
    var invetory = [
        "Lays": Item(count: 2, price: 20.0, product: Product(name: "Lays")),
        "Water": Item(count: 3, price: 10.0, product: Product(name: "Water")),
        "Snickers": Item(count: 0, price: 2.0, product: Product(name: "Snickers"))
    ]
    
    var sumCash: Double = 0
    
    func printSumCash() {
        print("\n🤑 💵 Текущая выручка составляет: \(sumCash)")
    }
    
    func printAllProducts() {
        guard invetory.values.filter({(p) -> Bool in
            p.count > 0
        }).count > 0 else {
            print("\n❌ Автомат с продуктами пустой!")
            return
        }
        
        print("\n✅ Список продуктов в автомате:")
        for i in invetory.values {
            print("Продукта \(i.product.name) осталось в кол-ве: \(i.count)")
        }
    }
}

enum VendingMachineError: Error {
    case unknownItem
    case outOfStocks(productName: String)
    case insufficientFunds(coinsNeeded: Double)
    
    var localozedDescription: String {
        switch self {
            case .unknownItem:
                return "товара нет в ассортименте."
            case .outOfStocks(productName: let productName):
                return "товара \(productName) нет в наличии."
            case .insufficientFunds(coinsNeeded: let coinsNeeded):
                return "нехватает средств: \(coinsNeeded)"
        }
    }
}

extension VendingMachine {
    
    // В данном случае, при использовании throws, мы можем быть точно уверены, что вернется какой-то продукт, или мы выкинем исключение.
    // Исключение выбрасывается в guard, с помощью команды throw. В данном случае, мы выбрасываем конкретную ошибку.
    
    func vendWithThrowError(itemName name: String, coinsDeposite: Double) throws -> (product: Product, cashBack: Double) {
        guard let item = invetory[name] else { throw VendingMachineError.unknownItem }
        guard coinsDeposite >= item.price else { throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - coinsDeposite) }
        guard item.count > 0 else { throw VendingMachineError.outOfStocks(productName: name) }
        
        sumCash += item.price
        
        var newItem = item
        newItem.count -= 1
        invetory[name] = newItem
        
        return (item.product, coinsDeposite > item.price ? coinsDeposite - item.price : 0)
    }
    
    func printProduct(_ item: Product, _ cashBack: Double) {
        print("\n✅ Покупка прошла успешно. Получите: \(item.name)\(cashBack > 0 ? ". Ваша сдача: \(cashBack)" : "")")
    }
}


let vend = VendingMachine()

do {

    vend.printAllProducts()
    
    var obj = try vend.vendWithThrowError(itemName: "Water", coinsDeposite: 20.0)
    vend.printProduct(obj.product, obj.cashBack)

    vend.printAllProducts()
    
    obj = try vend.vendWithThrowError(itemName: "Water", coinsDeposite: 10.0)
    vend.printProduct(obj.product, obj.cashBack)

    vend.printAllProducts()
    
    obj = try vend.vendWithThrowError(itemName: "Water", coinsDeposite: 10.0)
    vend.printProduct(obj.product, obj.cashBack)

    vend.printAllProducts()
    
    obj = try vend.vendWithThrowError(itemName: "Snickers", coinsDeposite: 2.0)
    vend.printProduct(obj.product, obj.cashBack)
    
} catch {
    if let error = error as? VendingMachineError {
        print("\n❌ Произошла ошибка:", error.localozedDescription, "\n")
    } else {
        print("\n❌ Произошла непредвиденная ошибка:", error.localizedDescription)
    }
}

vend.printSumCash()
