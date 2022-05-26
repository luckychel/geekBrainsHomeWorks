import Foundation

//1. Написать функцию, которая определяет, четное число или нет.

func evenOrOdd(_ number: Int) -> Bool {
    return number % 2 == 0
}

//evenOrOdd(7)

//2. Написать функцию, которая определяет, делится ли число без остатка на 3.

func hasReminderOfDivisionBy3(_ number: Int) -> Bool {
    return (number % 3 == 0)
}

//hasReminderOfDivisionBy3(9)

//3. Создать возрастающий массив из 100 чисел.

func increasingArrOf100() -> [Int] {
    return Array(1...100)
}

//increasingArrOf100()


//4. Удалить из этого массива все четные числа и все числа, которые не делятся на 3.

func deleteEvenAndHasReminderOfDivisionBy3(_ arr: [Int]) -> [Int] {
    return arr.filter({!evenOrOdd($0) && !hasReminderOfDivisionBy3($0)})
}

//deleteEvenAndHasReminderOfDivisionBy3(increasingArrOf100())

//5. * Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи нее 50 элементов.

func addFibonachiNumbers(_ num: Int) -> [Int] {
    switch num {
        case ..<1:
            return []
        case 1:
            return [0]
        case 2:
            return [0, 1]
        default:
            var arr = [0, 1]
            for i in 2...num-1 {
               arr.append((arr[i-1]) + (arr[i-2]))
            }
            return arr
        }
}

//addFibonachiNumbers(50)

//6. * Заполнить массив из 100 элементов различными простыми числами. Натуральное число, большее единицы, называется простым, если оно делится только на себя и на единицу. Для нахождения всех простых чисел не больше заданного числа n, следуя методу Эратосфена, нужно выполнить следующие шаги:
//a. Выписать подряд все целые числа от двух до n (2, 3, 4, ..., n).
//b. Пусть переменная p изначально равна двум — первому простому числу.
//c. Зачеркнуть в списке числа от 2 + p до n, считая шагом p..
//d. Найти первое не зачёркнутое число в списке, большее, чем p, и присвоить значению переменной p это число.
//e. Повторять шаги c и d, пока возможно.

var arr : [Int] = Array(2...100)

var p = 2

for i in arr {
    
    for i in arr {
        // Проверка. Если 'X * P' больше последнего числа массива, то выхожу из цикла.
        guard (p * i) <= arr.last! else {
            break
        }
        // Удаляю элементы массива, соответсвующие 'X * P'
        if let index = arr.firstIndex(of: p * i) {
            arr.remove(at: index)
        }
    }
    
    //Найти первое не зачёркнутое число в списке, большее, чем p, и присвоить значению переменной p это число.
    if p <= arr[i-2] && p < arr.last! {
        p = arr[i-1]
    } else {
        break
    }
}

print(arr)
