//
//  File.swift
//  HelloDelegate
//
//  Created by Treinamento on 27/07/17.
//  Copyright © 2017 Treinamento. All rights reserved.
//

import Foundation

protocol Contract {


    
    protocol Presenter {
        func checkColor(_ colorName: String)
        func getColorFromName(_ colorName: String) -> UIColor?
    }
}
