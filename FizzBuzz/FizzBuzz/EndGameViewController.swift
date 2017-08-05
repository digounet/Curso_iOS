//
//  EndGameViewController.swift
//  FizzBuzz
//
//  Created by Pablo Rodrigo Alves da Silva on 04/08/17.
//  Copyright © 2017 Pablo Rodrigo Alves da Silva. All rights reserved.
//

import UIKit

class EndGameViewController: BaseViewController {
    var score = 0
    
    var gameViewDeletage: GameDelegate?
    
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var imgPlayerPhoto: UIImageView!
    @IBOutlet weak var edtPlayerName: UITextField!
    
    var hasNoPlaceHolder = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        lblScore.text = "\(score) pontos"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnBackClick(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToMenu", sender: self)
    }
    
    @IBAction func btnPlayAgainClick(_ sender: Any) {
        
        if let gameViewDeletage = gameViewDeletage {
            gameViewDeletage.play()
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func btnRankingClick(_ sender: Any) {
        let name = edtPlayerName.text
        let photo = imgPlayerPhoto.image
        
        if ((name == "") && (hasNoPlaceHolder)) || ((name != "") && (!hasNoPlaceHolder)) {
            showAlert(title: "Informe o nome e a foto do jogador")
            return
        } else if (name != "") {
            if !PlayerDataSource.shared.save(name: name!, photo: UIImageJPEGRepresentation(photo!, 1)!, score: score) {
                showAlert(title: "Não foi possível salvar suas informações")
                return
            }
        }
        
        self.performSegue(withIdentifier: "showRankingFromEnd", sender: self)
    }
    
    @IBAction func btnGetImageFromGalleryClick(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func btnGetImageFromCameraClick(_ sender: Any) {
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.allowsEditing = false
            imagePicker.sourceType = .camera
            
            present(imagePicker, animated: true, completion: nil)
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
}

extension EndGameViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imgPlayerPhoto.image = pickedImage
            hasNoPlaceHolder = true
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}

