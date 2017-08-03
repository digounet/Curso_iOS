//
//  Player.swift
//  HelloTableView
//
//  Created by Treinamento on 31/07/17.
//  Copyright © 2017 Treinamento. All rights reserved.
//

import Foundation
import CoreData

class Player : NSObject, NSCoding {
    var nome: String
    var numero: Int
    var foto: Data
    var funcao: String
    var key: String
    
    init(nome: String = "", numero: Int = 0, funcao: String = "", foto: Data?) {
        self.key = NSUUID().uuidString
        self.nome = nome
        self.numero = numero
        self.foto = foto
        self.funcao = funcao
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.key = aDecoder.decodeObject(forKey: "key") as? String ?? ""
        self.nome = aDecoder.decodeObject(forKey: "nome") as? String ?? ""
        self.numero = Int(aDecoder.decodeInt32(forKey: "numero"))
        self.foto = aDecoder.decodeObject(forKey: "foto") as? Data
        self.funcao = aDecoder.decodeObject(forKey: "funcao") as? String ?? ""
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(key, forKey: "key")
        aCoder.encode(nome, forKey: "nome")
        aCoder.encode(numero, forKey: "numero")
        aCoder.encode(foto, forKey: "foto")
        aCoder.encode(funcao, forKey: "funcao")
    }
}
