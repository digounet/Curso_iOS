//
//  ViewController.swift
//  HelloDelegate
//
//  Created by Treinamento on 27/07/17.
//  Copyright © 2017 Treinamento. All rights reserved.
//

import UIKit
class ViewController: UIViewController, UITextFieldDelegate, View  {

    var presenter: Presenter?
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var btnCheckColor: UIButton!
    @IBOutlet weak var edtColorName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = MainPresenter(self)
        edtColorName.delegate = self
        
    }

    @IBAction func btnCheckColorClick(_ sender: Any) {
        presenter!.checkColor(edtColorName.text!)
    }
    
    func enableDistableButton(_ status: Bool) {
        btnCheckColor.isEnabled = status
    }
    
    func changeBackgroundColor(_ color: UIColor) {
        mainView.backgroundColor = color
    }
    
    func showErrorMessage() {
        let alertController = UIAlertController(title: "Curso iOS", message:
            "Cor inválida", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Fechar", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func edtColorNameChanged(_ sender: UITextField) {
        presenter!.checkColor(sender.text!)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        
        if text != "" {
            enableDistableButton(true)
        }
        
        return true
    }
}

