//
//  ViewController.swift
//  HelloNavigation
//
//  Created by Treinamento on 28/07/17.
//  Copyright © 2017 Treinamento. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblColorName: UILabel!
    var currentColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lblColorName.text = "Cor atual: "
        
        guard let color = currentColor else {
            lblColorName.text = lblColorName.text! + "Sem cor!"
            return
        }
        
        if color == UIColor.black {
            lblColorName.textColor = UIColor.white
        } else {
            lblColorName.textColor = UIColor.black
        }
        
        lblColorName.text = lblColorName.text! + color.descricao
        
        self.view.backgroundColor = color
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showColorVC") {
            let viewController:ColorViewController = segue.destination as! ColorViewController
            viewController.delegate = self
            viewController.currentColor = currentColor
        }
    }


}

extension ViewController: ColorVCDelegate {
    func chosen(color: UIColor?, by colorVC: ColorViewController) {
        currentColor = color
        colorVC.navigationController?.popViewController(animated: true)
    }
}
