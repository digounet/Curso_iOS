//
//  MainTableViewCell.swift
//  HelloTableView
//
//  Created by Treinamento on 31/07/17.
//  Copyright © 2017 Treinamento. All rights reserved.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    @IBOutlet weak var foto: UIImageView!
    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var posicao: UILabel!
    @IBOutlet weak var funcao: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
