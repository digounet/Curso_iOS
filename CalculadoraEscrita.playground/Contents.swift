//: Playground - noun: a place where people can play

import UIKit

let soma = "Quanto é 5 mais 13?"
let subtracao = "Quanto é 15 menos 10?"
let multiplicacao = "Quanto é 1 vezes 13?"
let divisao = "Quanto é 15 sobre 5?"


print("A soma é \(calcula(soma))")
print("A subtração é \(calcula(subtracao))")
print("A multiplicação é \(calcula(multiplicacao))")
print("A divisão é \(calcula(divisao))")

func calcula(_ frase: String) -> Int {
    var result = 0
    
    let words = frase
        .replacingOccurrences(of: "?", with: "")
        .lowercased()
        .replacingOccurrences(of: "quanto é ", with: "")
        .components(separatedBy: " ")
    
    let ope: String = String(words[1])
    switch ope {
        case "mais":
            result = Int(words[0])! + Int(words[2])!
        case "menos":
            result = Int(words[0])! - Int(words[2])!
        case "vezes":
            result = Int(words[0])! * Int(words[2])!
        case "sobre":
            result = Int(words[0])! / Int(words[2])!
        default:
            break
    }
    
    return result
}