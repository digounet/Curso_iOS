//
//  Extensions.swift
//  HelloNavigation
//
//  Created by Treinamento on 28/07/17.
//  Copyright © 2017 Treinamento. All rights reserved.
//

import UIKit

extension UIColor {
    var descricao: String {
        switch self {
        case UIColor.red:
            return "Red"
        case UIColor.green:
            return "Green"
        case UIColor.black:
            return "Black"
        default:
            return ""
        }
    }
    
    var cor: UIColor? {
        switch descricao {
        case "Red":
            return UIColor.red
        case "Green":
            return UIColor.green
        case "Black":
            return UIColor.black
        default:
            return nil
        }
    }

}
