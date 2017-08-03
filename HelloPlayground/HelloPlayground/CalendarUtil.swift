//
//  CalendarUtil.swift
//  HelloPlayground
//
//  Created by Treinamento on 27/07/17.
//  Copyright © 2017 Treinamento. All rights reserved.
//

import Foundation

class CalendarUtil {
    static func getCurrentDateAsText() -> String {
        let format = DateFormatter()
        format.dateFormat = "dd/MM/yyyy"
        
        return format.string(from: Date())
        
    }
}
