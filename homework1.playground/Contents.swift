import Foundation

var isErr = false

//Квадратное уравнение
var a : Double = 4
var b : Double = 9
var c : Double = 3

if (a == 0) {
    print("Параметр а не может быть равен 0")
    isErr = true
}

if (!isErr)
{
    print("Задание 1 \"Решить квадратное уравнение вида " + (a > 0 ? "" : "-")+String(a)+"x2 "+(b > 0 ? "+ " : "")+String(b)+"x"+(c > 0 ? " + " : "")+String(c)+" = 0\"")

    let dis : Double = (b*b) - (4*a*c)
    
    var x1 : Double = 0
    var x2 : Double = 0
    
    //2 корня
    if dis > 0 {
        x1 = (-b+sqrt(dis))/(2*a)
        x2 = (-b-sqrt(dis))/(2*a)
        print("Результат - 2 корня: x1 = " + String(format: "%.2f", x1) + " и x2 = " + String(format: "%.2f", x2))
    }
    //1 корень
    else if dis == 0 {
        x1 = -b/(2 * a)
        x2 = x1
        print("Результат - 1 корень: x1 = x2 = " + String(format: "%.2f", x1) + ".")
    }
    //корней нет
    else {
        print("Корней нет!")
    }
}

isErr = false

print("\n")

//Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника

print("Задание 2 \"Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника\"")
var katet1 : Double = 7
var katet2 : Double = 5

var gipotenuza: Double?
var perimetr : Double?
var square : Double?

gipotenuza = sqrt(katet1*katet1 + katet2*katet2)
perimetr = katet1 + katet2 + (gipotenuza ?? 0)
square = 0.5 * katet1 * katet2

print("Результат: гипотенуза = " + String(format: "%.2f", gipotenuza ?? 0) + ". Периметр = " + String(format: "%.2f", perimetr ?? 0) + ". Площадь = " + String(format: "%.2f", square ?? 0) + ".")

print("\n")

// Рассчитать сумму вклада через N лет

print("Задание 3 \"Пользователь вводит сумму вклада в банке и годовой процент. Найти сумму вклада через N лет\"")

//первоначальная сумма вклада
let startSum : Double = 40000
//годовая процентная ставка
let percentOfYear: Double = 12
//кол-во лет на которые нужно рассчитать вклад
let yearsCount : Double = 1

//кол-во дней в году
let daysinYear : Double = 365

//сумма процентов в конце срока
var finalSumProcent : Double?

if (startSum > 0 && percentOfYear > 0 && yearsCount > 0) {
    finalSumProcent = ((startSum * percentOfYear * yearsCount * daysinYear) / daysinYear) / 100
    print("Результат: Сумма вклада в размере " + String(startSum) + " сроком на " + String(yearsCount) + " год/лет с процентной ставкой равной " + String(percentOfYear) + "% в конце срока составит " + String(startSum + (finalSumProcent ?? 0)) + " условных единиц")
} else {
    print("Любой из параметров должен быть больше 0")
}

print("пожалуйста, проверьте, решение задач вышеы")
