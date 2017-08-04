//
//  PlayerTableViewCell.swift
//  FizzBuzz
//
//  Created by Treinamento on 04/08/17.
//  Copyright © 2017 Pablo Rodrigo Alves da Silva. All rights reserved.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var imgPlayerPhoto: UIImageView!
    @IBOutlet weak var lblPlayerName: UILabel!
    @IBOutlet weak var lblPlayerScore: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
