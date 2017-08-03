//
//  ColorVCDelegate.swift
//  HelloNavigation
//
//  Created by Treinamento on 28/07/17.
//  Copyright © 2017 Treinamento. All rights reserved.
//

import UIKit

protocol ColorVCDelegate {
    func chosen(color: UIColor?, by colorVC: ColorViewController)
}
