//
//  EndGameViewController.swift
//  FizzBuzz
//
//  Created by Pablo Rodrigo Alves da Silva on 04/08/17.
//  Copyright © 2017 Pablo Rodrigo Alves da Silva. All rights reserved.
//

import UIKit
import SAConfettiView

class EndGameViewController: BaseViewController {
    var score = 0
    var winner = false
    var gameViewDeletage: GameDelegate?

    internal  var hasNoPlaceHolder = false
    
    private let imagePicker = UIImagePickerController()
    private var confettiView: SAConfettiView!
    
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var imgPlayerPhoto: UIImageView!
    @IBOutlet weak var edtPlayerName: UITextField!
    @IBOutlet weak var imgTitle: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        lblScore.text = "\(score) pontos"
        
        initWinView()
    }
    
    func initWinView() {
        imgTitle.isHidden = winner
        
        if winner {
            // Create confetti view
            confettiView = SAConfettiView(frame: self.view.bounds)
            
            // Set colors (default colors are red, green and blue)
            confettiView.colors = [UIColor(red:0.95, green:0.40, blue:0.27, alpha:1.0),
                                   UIColor(red:1.00, green:0.78, blue:0.36, alpha:1.0),
                                   UIColor(red:0.48, green:0.78, blue:0.64, alpha:1.0),
                                   UIColor(red:0.30, green:0.76, blue:0.85, alpha:1.0),
                                   UIColor(red:0.58, green:0.39, blue:0.55, alpha:1.0)]
            
            // Set intensity (from 0 - 1, default intensity is 0.5)
            confettiView.intensity = 0.5
            
            // Set type
            confettiView.type = .confetti
            
            
            // Add subview
            view.addSubview(confettiView)
            confettiView.startConfetti()
        }
        
    }
    
    func stopConfetti() {
        if confettiView.isActive() {
            self.confettiView.stopConfetti()
            self.confettiView.removeFromSuperview()
        }
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
        stopConfetti()
        
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

