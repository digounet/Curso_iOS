//
//  MainPresenter.swift
//  HelloDelegate
//
//  Created by Treinamento on 27/07/17.
//  Copyright © 2017 Treinamento. All rights reserved.
//

import UIKit

class MainPresenter: Presenter {
    
    let view: View
    
    init (_ view: View) {
        self.view = view
        
        view.enableDistableButton(false)
    }
    
    func checkColor(_ colorName: String) {
        let color = getColorFromName(colorName)
        
        if color != UIColor.clear {
            view.changeBackgroundColor(color)
        } else {
            view.showErrorMessage()
        }
    }
    
    func getColorFromName(_ colorName: String?) -> UIColor {
        guard let color = colorName else { return UIColor.clear }
        
        switch color.lowercased() {
        case "preto":
            return UIColor.black
        case "branco":
            return UIColor.white
        case "azul":
            return UIColor.blue
        case "amarelo":
            return UIColor.yellow
        case "verde":
            return UIColor.green
        default:
            return UIColor.clear
        }
    }
}
