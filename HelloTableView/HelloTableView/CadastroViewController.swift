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

    var kbHeight: CGFloat!
    
    let imagePicker = UIImagePickerController()
    var player: PlayerModel?
    
    var delegate: CadastroViewControllerDelegate?
    
    var pickOption = ["Atacante", "Goleiro", "Lateral", "Meia", "Técnico", "Zagueiro"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
        
        setupFuncaoPickerView()
        
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
        innerView.endEditing(true)
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

extension CadastroViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickOption.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickOption[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        edtFuncao.text = pickOption[row]
    }
    
    func setupFuncaoPickerView() {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        
        edtFuncao.inputView = pickerView
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: self.view.frame.size.height/6, width: self.view.frame.size.width, height: 40.0))
        
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.barStyle = UIBarStyle.blackTranslucent
        toolBar.tintColor = UIColor.white
        toolBar.backgroundColor = UIColor.black
        
        let cancelarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: self, action: #selector(cancelaFuncaoClick))
        
        let confirmarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(selecionaFuncaoClick))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        label.font = UIFont(name: "Helvetica", size: 12)
        label.backgroundColor = UIColor.clear
        label.textColor = UIColor.white
        label.text = "Selecione a função"        
        label.textAlignment = NSTextAlignment.center
        
        let textBtn = UIBarButtonItem(customView: label)
        
        toolBar.setItems([cancelarButton,flexSpace,textBtn,flexSpace,confirmarButton], animated: true)
        
        edtFuncao.inputAccessoryView = toolBar
    }
    
    func selecionaFuncaoClick(sender: UIBarButtonItem) {
        edtFuncao.resignFirstResponder()
    }
    
    func cancelaFuncaoClick(sender: UIBarButtonItem) {
        edtFuncao.resignFirstResponder()
    }
}
