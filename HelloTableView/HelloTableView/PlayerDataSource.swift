//
//  PlayerDataSource.swift
//  HelloTableView
//
//  Created by Treinamento on 01/08/17.
//  Copyright © 2017 Treinamento. All rights reserved.
//

import UIKit
import CoreData

class PlayerDataSource {
    
    var appDelegate: AppDelegate?
    var managedContext: NSManagedObjectContext?
    
    let TABLE = "Player"
    let COLUMN_ID = "id"
    let COLUMN_NOME = "nome"
    let COLUMN_FUNCAO = "funcao"
    let COLUMN_POSICAO = "posicao"
    let COLUMN_FOTO = "foto"
    
    
    init() {
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate?.persistentContainer.viewContext
    }

    func inserir(_ player: PlayerModel) {
        let entityDescription = NSEntityDescription.entity(forEntityName: TABLE, in: managedContext!)
        let data = NSManagedObject(entity: entityDescription!, insertInto: managedContext)
        
        data.setValue(UUID().uuidString, forKey: COLUMN_ID)
        data.setValue(player.nome, forKey: COLUMN_NOME)
        data.setValue(player.funcao, forKey: COLUMN_FUNCAO)
        data.setValue(player.numero, forKey: COLUMN_POSICAO)
        data.setValue(player.foto, forKey: COLUMN_FOTO)
        
        do {
            try managedContext?.save()
        } catch let error as NSError {
            print("erro na hora de salvar. \(error), \(error.userInfo)")
        }
        
    }
    
    func editar(_ player: PlayerModel) {
        let entityDescription = NSEntityDescription.entity(forEntityName: TABLE, in: managedContext!)
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        
        fetchRequest.entity = entityDescription
        fetchRequest.predicate = NSPredicate(format: "\(COLUMN_ID) = %@", player.id!)
        
        do {
            
            let data = try managedContext?.fetch(fetchRequest) as! [NSManagedObject]
            if let playerMO = data.first {
                playerMO.setValue(player.nome, forKey: COLUMN_NOME)
                playerMO.setValue(player.funcao, forKey: COLUMN_FUNCAO)
                playerMO.setValue(player.numero, forKey: COLUMN_POSICAO)
                playerMO.setValue(player.foto, forKey: COLUMN_FOTO)
                
                do {
                    try managedContext?.save()
                } catch let error as NSError {
                    print("erro na hora de salvar. \(error), \(error.userInfo)")
                }
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }
    }
    
    func excluir(index: Int) {

    }
    
    func listar() -> [PlayerModel] {
        
        var result: [PlayerModel] = []
        
        var playerArray = [NSManagedObject]()
        
        let entityDescription = NSEntityDescription.entity(forEntityName: TABLE, in: managedContext!)
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>()
        fetchRequest.entity = entityDescription
        
        do {
            playerArray = try managedContext!.fetch(fetchRequest) as! [NSManagedObject]
            
            for p in playerArray {
                let model = PlayerModel()
                
                model.id = p.value(forKey: COLUMN_ID) as? String
                model.nome = p.value(forKey: COLUMN_NOME) as? String
                model.funcao = p.value(forKey: COLUMN_FUNCAO) as? String
                model.numero = p.value(forKey: COLUMN_POSICAO) as? Int
                model.foto = p.value(forKey: COLUMN_FOTO) as? Data
                
                result.append(model)
            }
            
        } catch {
            let fetchError = error as NSError
            print(fetchError)
        }

        return result
    }
    
}
