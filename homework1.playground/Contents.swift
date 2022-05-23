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
    print("Решить квадратное уравнение вида: " + (a > 0 ? "" : "-")+String(a)+"x2 "+(b > 0 ? "+ " : "")+String(b)+"x"+(c > 0 ? " + " : "")+String(c)+" = 0")

    let dis : Double = (b*b) - (4*a*c)
    
    var x1 : Double = 0
    var x2 : Double = 0
    
    //2 корня
    if dis > 0 {
        x1 = (-b+sqrt(dis))/(2*a)
        x2 = (-b-sqrt(dis))/(2*a)
        print("Результат - 2 корня: x1 = " + String(x1) + " и x2 = " + String(x2))
    }
    //1 корень
    else if dis == 0 {
        x1 = -b/(2 * a)
        x2 = x1
        print("Результат - 1 корень: x1 = x2 = " + String(x1) + ".")
    }
    //корней нет
    else {
        print("Корней нет!")
    }
}

isErr = false

//Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника







