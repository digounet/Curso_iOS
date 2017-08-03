//
//  CadastroViewController.swift
//  HelloTableView
//
//  Created by Treinamento on 01/08/17.
//  Copyright © 2017 Treinamento. All rights reserved.
//

import UIKit

class CadastroViewController: UIViewController {

    @IBOutlet weak var edtNome: UITextField!
    @IBOutlet weak var edtFuncao: UITextField!
    @IBOutlet weak var edtPosicao: UITextField!
    @IBOutlet weak var imgFoto: UIImageView!

    let imagePicker = UIImagePickerController()
    var player: PlayerModel?
    
    var delegate: CadastroViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        if let p = player {
            edtNome.text = p.nome
            edtFuncao.text = p.funcao
            edtPosicao.text = String(describing: p.numero!)
            imgFoto.image = UIImage(data: p.foto!)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func salvarJogador(_ sender: Any) {
        
        guard let pNome = edtNome.text,
            let pFuncao = edtFuncao.text,
            let pPosicao = edtPosicao.text,
            let numrPos = Int(pPosicao),
            let foto = imgFoto.image else {
            fatalError("Erro no guard")
        }
        
        if player == nil {
            let lPlayer = PlayerModel(nome: pNome, funcao: pFuncao, numero: numrPos, foto: UIImageJPEGRepresentation(foto, 1))
            PlayerDataSource().inserir(lPlayer)
            
            edtNome.text = ""
            edtFuncao.text = ""
            edtPosicao.text = ""
            edtNome.becomeFirstResponder()
            imgFoto.image = #imageLiteral(resourceName: "team-placeholder")
        } else {
            player?.nome = pNome
            player?.numero = numrPos
            player?.funcao = pFuncao
            player?.foto = UIImageJPEGRepresentation(foto, 1)
            
            PlayerDataSource().editar(player!)
            
            if let delegate = delegate {
                delegate.refresh(model: player!, controller: self)
            }
        }
    }

    @IBAction func btnSelecionarFoto(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension CadastroViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imgFoto.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}
