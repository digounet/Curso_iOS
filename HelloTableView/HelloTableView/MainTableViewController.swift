//
//  MainTableViewController.swift
//  HelloTableView
//
//  Created by Treinamento on 31/07/17.
//  Copyright © 2017 Treinamento. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var players : [PlayerModel] = []
    let dataSource = PlayerDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "mainCell", for: indexPath) as? MainTableViewCell else {
            fatalError("Deu merda")
        }
        
        let player = players[indexPath.row]

        cell.nome.text = player.nome
        cell.funcao.text = player.funcao
        cell.posicao.text = "#\(String(describing: player.numero!))"
        
        if let foto = player.foto {
            cell.foto.image  = UIImage(data: foto)
        } else {
            cell.foto.image = #imageLiteral(resourceName: "team-placeholder")
        }

        return cell
    }
    
    override func viewDidAppear(_ animated: Bool) {
        atualizarLista()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let controller = segue.destination as? DetailViewController else {
                return
            }            
            
            controller.player = players[(tableView.indexPathForSelectedRow?.row)!]
        } else if segue.identifier == "addPlayer" {
            guard let controller = segue.destination as? CadastroViewController else {
                return
            }
            
            controller.player = sender as? PlayerModel
            controller.delegate = self
        }
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let editAction = UITableViewRowAction(style: .normal, title: "Editar") { (action, indexPath) in
            self.performSegue(withIdentifier: "addPlayer", sender: self.players[indexPath.row])
        }
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Excluir") { (action, indexPath) in
            
            self.dataSource.excluir(playerId: self.players[indexPath.row].id!)
            self.players.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        
        editAction.backgroundColor = UIColor.blue
        
        return [deleteAction, editAction]
    }
    
    func atualizarLista() {
        players = dataSource.listar()
        tableView.reloadData()
    }

}

extension MainTableViewController : CadastroViewControllerDelegate {
    func refresh(model: PlayerModel, controller: CadastroViewController) {
        atualizarLista()
        controller.navigationController?.popViewController(animated: true)
    }
}
