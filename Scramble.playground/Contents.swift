//: Playground - noun: a place where people can play

import UIKit

let one = "AEIOULNRST"
let two = "DG"
let three = "BCMP"
let four = "FHVWY"
let five = "K"
let eight = "JX"
let ten = "QZ"


func pontua(_ palavra: String) -> Int {
    var result = 0
    
    for letter in palavra.characters {
        let c = String(letter)
        
        if (one.contains(c)) {
            result = result + 1
        } else if (two.contains(c)) {
            result = result + 2
        } else if (three.contains(c)) {
            result = result + 3
        } else if (four.contains(c)) {
            result = result + 4
        } else if (five.contains(c)) {
            result = result + 5
        } else if (eight.contains(c)) {
            result = result + 8
        } else if (seven.contains(c)) {
            result = result + 10
        }
        

    }
    
    return result
}

let pontos = pontua("PABLO")
print("SUA PONTUAÇÃO É \(pontos)")
