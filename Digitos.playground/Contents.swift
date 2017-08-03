//: Playground - noun: a place where people can play

import UIKit


print(digitos(123456))


func digitos(_ numero: Int) -> [Int] {
    var result: [Int] = []
    var numeroStr = String(numero)
    let n = Int(String(numeroStr.characters.removeFirst()))!
    result.append(n)
        
    if (!numeroStr.characters.isEmpty) {
        result = result + digitos(Int(numeroStr)!)
    }
    
    return result
}