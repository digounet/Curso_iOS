//
//  DetailViewController.swift
//  HelloTableView
//
//  Created by Treinamento on 31/07/17.
//  Copyright © 2017 Treinamento. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var player: PlayerModel?
    
    @IBOutlet weak var foto: UIImageView!
    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var funcao: UILabel!
    @IBOutlet weak var posicao: UILabel!
    @IBOutlet weak var scrool: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()

        scrool.maximumZoomScale = 1.0
        scrool.maximumZoomScale = 6.0
        scrool.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let p = player {
            foto.image = UIImage(data: p.foto!)
            nome.text = p.nome
            posicao.text = String(describing: p.numero!)
            funcao.text = p.funcao
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editPlayer" {
            guard let controller = segue.destination as? CadastroViewController else {
                return
            }
            
            controller.player = player
            controller.delegate = self
        }
    }

}

extension DetailViewController : UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return foto
    }
}

extension DetailViewController : CadastroViewControllerDelegate {
    func refresh(model: PlayerModel, controller: CadastroViewController) {
        self.player = model
        controller.navigationController?.popViewController(animated: true)
    }
}
