//
//  CadastroViewControllerDelegate.swift
//  HelloTableView
//
//  Created by Treinamento on 02/08/17.
//  Copyright © 2017 Treinamento. All rights reserved.
//

import Foundation

protocol CadastroViewControllerDelegate {
    func refresh(model: PlayerModel, controller: CadastroViewController)
}
