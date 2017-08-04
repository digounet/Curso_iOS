//
//  RankingViewController.swift
//  FizzBuzz
//
//  Created by Pablo Rodrigo Alves da Silva on 04/08/17.
//  Copyright © 2017 Pablo Rodrigo Alves da Silva. All rights reserved.
//

import UIKit

class RankingViewController: BaseViewController {
    
    var players: [PlayerMO]?

    @IBOutlet weak var lblNoRanking: UILabel!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        players = PlayerDataSource.shared.listAllOrderedByScore()
        
        setupView()
    }
    
    @IBAction func btnBackClick(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToMenu", sender: self)
    }


    func setupView() {
        if players?.count == 0 {
            tableView.isHidden = true
            lblNoRanking.isHidden = false
        } else {
            tableView.isHidden = false
            lblNoRanking.isHidden = true
        }
    }

}

extension RankingViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players!.count
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerTableViewCell
        let player = players?[indexPath.row]
        
        if let foto = player?.photo {
            cell.imgPlayerPhoto.image  = UIImage(data: foto as Data)
        } else {
            cell.imgPlayerPhoto.image = #imageLiteral(resourceName: "smallTeamPlaceHolder")
        }
        
        cell.lblPlayerName.text = player?.name
        cell.lblPlayerScore.text = "\(player?.score ?? 0) pontos"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let player = players?[indexPath.row]
            players?.remove(at: indexPath.row)
            
            PlayerDataSource.shared.delete(player: player!)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            setupView()
        }
    }
}
