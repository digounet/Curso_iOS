//
//  PlayerModel.swift
//  HelloTableView
//
//  Created by Treinamento on 02/08/17.
//  Copyright © 2017 Treinamento. All rights reserved.
//

import Foundation

class PlayerModel {
    var id: String?
    var nome: String?
    var funcao: String?
    var numero: Int?
    var foto: Data?
    
    init(id: String = "", nome: String = "", funcao: String = "", numero: Int = 0, foto: Data? = nil) {
        self.id = id
        self.nome = nome
        self.funcao = funcao
        self.numero = numero
        self.foto = foto
    }
}
