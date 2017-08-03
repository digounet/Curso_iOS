//
//  ColorViewController.swift
//  HelloNavigation
//
//  Created by Treinamento on 28/07/17.
//  Copyright © 2017 Treinamento. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController {
    
    var currentColor: UIColor?
    @IBOutlet weak var lblColorName: UILabel!
    var delegate:ColorVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showColorName()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnSaveClick(_ sender: Any) {
        delegate!.chosen(color: currentColor, by: self)
    }
    
    @IBAction func selectColorClick(_ sender: UIButton) {
        
        switch sender.currentTitle! {
        case "Black":
            currentColor = UIColor.black
        case "Green":
            currentColor = UIColor.green
        case "Red":
            currentColor = UIColor.red
        default:
            currentColor = nil
        }

        showColorName()
    }
    
    func showColorName() {
        lblColorName.text = "Cor atual: "
        
        guard let color = currentColor else {
            lblColorName.text = lblColorName.text! + "Sem cor!"
            return
        }
        
        lblColorName.text = lblColorName.text! + color.descricao
    }

}
