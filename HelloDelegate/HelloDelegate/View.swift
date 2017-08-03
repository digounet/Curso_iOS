//
//  View.swift
//  HelloDelegate
//
//  Created by Treinamento on 27/07/17.
//  Copyright © 2017 Treinamento. All rights reserved.
//

import UIKit

protocol View {
    func enableDistableButton(_ status: Bool)
    func changeBackgroundColor(_ color: UIColor)
    func showErrorMessage()
}
