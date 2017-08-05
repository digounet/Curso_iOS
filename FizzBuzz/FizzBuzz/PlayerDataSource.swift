//
//  PlayerDataSource.swift
//  FizzBuzz
//
//  Created by Pablo Rodrigo Alves da Silva on 04/08/17.
//  Copyright © 2017 Pablo Rodrigo Alves da Silva. All rights reserved.
//

import UIKit
import CoreData

class PlayerDataSource {
    var appDelegate: AppDelegate?
    var context: NSManagedObjectContext?
    
    static let shared = PlayerDataSource()
    
    let COLUMN_SCORE = "score"
    
    private init() {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        context = appDelegate?.persistentContainer.viewContext
    }
    
    
    func listAllOrderedByScore() -> [PlayerMO] {
        var players: [PlayerMO] = []
        let request: NSFetchRequest<PlayerMO> = PlayerMO.fetchRequest()
        let orderByScore = NSSortDescriptor(key: COLUMN_SCORE, ascending: false)
        
        request.sortDescriptors = [orderByScore]
        
        do {
            try players = (self.context?.fetch(request))!
        } catch let error as NSError {
            print("Erro ao salvar novo jogador: \(error), \(error.userInfo)")
        }
        
        return players
    }
    
    func save(name: String, photo: Data, score: Int) -> Bool {
    
        let player = PlayerMO(context: self.context!)
        
        player.name = name
        player.photo = NSData(data: photo)
        player.score = Int16(score)
        
        do {
            try context?.save()
            return true
        } catch let error as NSError {
            print("Erro ao salvar novo jogador: \(error), \(error.userInfo)")
        }
        
        return false
    }
    
    func delete(player: PlayerMO) {
        context?.delete(player)
        
        do {
            try context?.save()
        } catch let error as NSError {
            print("Erro ao excluir jogador: \(error), \(error.userInfo)")
        }
    }
}
